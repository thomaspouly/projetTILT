import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/DataTreeForm.dart';
import 'package:flutter_app/models/NoteTreeForm.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/StorageProvider.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;
  AuthProvider auth = AuthProvider();
  StorageProvider storage = StorageProvider();

  Future<User> getUserById(String id) {
    _firestore.collection('users').document('${id}').get().then((result) {
      User u = new User(
          email: result.data['email'],
          name: result.data['name'],
          treeNumber: result.data['treeNumber'],
          reference: null);
      return u;
    });
    return null;
  }

  Future<String> registerUser(
      String email, String password, String name, int treeNumber, File image) {
    return auth.registerUser(email, password).then((userId) {
      storage.setImage(userId, image);
      User user = new User(
          reference: null, treeNumber: treeNumber, email: email, name: name);

      _firestore.collection('user').document(userId).setData(user.toJson());
      _firestore.collection('data').document(userId).setData({"note": 5});
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

  Future<String> getNote() {
    auth.currentUser().then((userID) {
      _firestore.collection('data').document(userID).get().then((noteInDb) {
        return noteInDb.data['note'];
      });
    });
  }
}
