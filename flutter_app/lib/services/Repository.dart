import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/FirestoreProvider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();
  final authProvider = AuthProvider();

  Future<String> authenticateUser(String email, String password) =>
      authProvider.authenticateUser(email, password);

  Future<void> registerUser(String email, String password) =>
      _firestoreProvider.registerUser(email, password);

}