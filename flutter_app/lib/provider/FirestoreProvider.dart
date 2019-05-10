import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/Association.dart';
import 'package:flutter_app/models/DataTreeForm.dart';
import 'package:flutter_app/models/NoteForm.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/StorageProvider.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;
  AuthProvider auth = AuthProvider();
  StorageProvider storage = StorageProvider();

  Future<User> getUserById(String id) {
    return _firestore
        .collection('user')
        .document(id)
        .get()
        .then((documentSnapshot) {
     User u = new User(
          email: documentSnapshot.data['email'],
          name: documentSnapshot.data['name'],
          treeNumber: documentSnapshot.data['treeNumber'],
          reference: null);
     return u;
    });
  }

  Future<String> registerUser(
      String email, String password, String name, int treeNumber, File image) {
    return auth.registerUser(email, password).then((userId) {
      storage.setImage(userId, image);
      User user = new User(
          reference: null, treeNumber: treeNumber, email: email, name: name);
      NoteForm note = new NoteForm(note:"5");
      _firestore.collection('user').document(userId).setData(user.toJson());
      _firestore.collection('data').document(userId).setData(note.toJson());
      return userId;
    });
  }

  Future<String> enterDataFromFormTree(
      int valueWater,
      int valueElectricity,
      String waste,
      String don,
      String bulk,
      String bio,
      String car,
      String bike,
      String bus) {
    DataTreeForm data = new DataTreeForm(
      reference: null,
      bike: bike,
      bio: bio,
      bulk: bulk,
      bus: bus,
      car: car,
      don: don,
      valueElectricity: valueElectricity,
      valueWater: valueWater,
      waste: waste,
    );
    auth.currentUser().then((userID) {
      _firestore.collection('data').document(userID).setData(data.toJson());
      return userID;
    });
  }

  Future<String> enterNote(String note) {
    auth.currentUser().then((userID) {
      _firestore.collection('data').document(userID).get().then((noteInDb) {
        if (noteInDb.data != null) {
          String noteFinal =
              (double.parse(noteInDb.data['note']) / 2 + double.parse(note) / 2)
                  .toString();
          _firestore
              .collection('data')
              .document(userID)
              .updateData({"note": noteFinal});
        } else {
          _firestore
              .collection('data')
              .document(userID)
              .setData({"note": note});
        }
      });
      return userID;
    });
  }

  Future<NoteForm> getNote() {
    return auth.currentUser().then((userID) {
      return _firestore.collection('data').document(userID).get().then((noteInDb) {
        NoteForm note = NoteForm(note :noteInDb.data['note']);
        return note;
      });
    });
  }

  Future<List<Association>> getAssociations() {
    return _firestore
        .collection('association')
        .getDocuments()
        .then((associations) {
      List<Association> associationsList = new List();
      for (int i = 0; i < associations.documents.length; i++) {
        Association association = new Association(
            department: associations.documents.elementAt(i)['department'],
            association: associations.documents.elementAt(i)['association'],
            link: associations.documents.elementAt(i)['link']);
        associationsList.add(association);
      }
      return associationsList;
    });
  }
}
