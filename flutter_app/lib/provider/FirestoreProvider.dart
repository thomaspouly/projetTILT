import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/DataTreeForm.dart';
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
      email:result.data['email'],
      name:result.data['name'],
      treeNumber:result.data['treeNumber'] ,
      reference: null
      );
    return u;
    });
    return null;
  }

  Future<String> registerUser(String email, String password,String name,int treeNumber,File image) {
    return auth.registerUser(email, password).then((userId) {
      storage.setImage(userId,image);
      User user = new User(reference: null,
          treeNumber: treeNumber,
          email: email,
          name: name);

      _firestore.collection('user').document(userId).setData(user.toJson());
      return userId;

    });
  }

  Future<String> enterDataFromFormTree(int valueWater,int valueElectricity,int waste,int don,int bulk,int bio,int car,int bike,int bus) {

      DataTreeForm data = new DataTreeForm(
        reference: null,
        bike: bike,bio: bio,bulk: bulk,bus: bus,car: car,don: don,valueElectricity: valueElectricity,valueWater: valueWater,waste: waste,);
      auth.currentUser().then((userID) {
        _firestore.collection('users').document(userID).setData(data.toJson());
        return userID;
      });
  }
}