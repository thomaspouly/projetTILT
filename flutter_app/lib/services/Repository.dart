import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/provider/FirestoreProvider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();

  Future<int> authenticateUser(String email, String password) =>
      _firestoreProvider.authenticateUser(email, password);

  Future<void> registerUser(String email, String password) =>
      _firestoreProvider.registerUser(email, password);

}