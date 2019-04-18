import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;
  AuthProvider auth = AuthProvider();
  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

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

  Future<String> registerUser(String email, String password,String name,int treeNumber,File image) async {

    FirebaseUser _user = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    FirebaseStorage.instance.ref().child('/image/'+_user.uid).putFile(image);

    Firestore.instance.collection('user').document(_user.uid).setData({
      'name': name,
      'email': email,
      'treeNumber': treeNumber,
    });
    return _user.uid;

  }
}