import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/provider/AuthProvider.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;
  AuthProvider auth = AuthProvider();

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

  Future<void> registerUser(String email, String password) async {
    return _firestore
        .collection("users")
        .document(email)
        .setData({'email': email, 'password': password, 'goalAdded': false});
  }
}