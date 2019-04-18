import 'dart:io';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/FirestoreProvider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();
  final authProvider = AuthProvider();

  Future<String> authenticateUser(String email, String password) =>
      authProvider.authenticateUser(email, password);

  Future<String> registerUser(String email, String password,String name,int treeNumber,File image) =>
      _firestoreProvider.registerUser(email, password,name,treeNumber,image);

  Future<void> resetPasswordEmail(String email) =>
      authProvider.resetPasswordUser(email);


}