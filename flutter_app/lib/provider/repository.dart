import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();

  Future<String> registerUser(String email, String password,String name,int treeNumber,File image) =>
      _firestoreProvider.registerUser(email, password,name,treeNumber,image);

}
