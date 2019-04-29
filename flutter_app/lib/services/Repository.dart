import 'dart:io';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/FirestoreProvider.dart';
import 'package:flutter_app/provider/RootBundleProvider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();
  final authProvider = AuthProvider();
  final rootBundleProvider = RootBundleProvider();

  Future<String> authenticateUser(String email, String password) =>
      authProvider.authenticateUser(email, password);

  Future<String> registerUser(String email, String password,String name,int treeNumber,File image) =>
      _firestoreProvider.registerUser(email, password,name,treeNumber,image);

  Future<void> resetPasswordEmail(String email) =>
      authProvider.resetPasswordUser(email);

  Future<String> getCurrentUser() =>
    authProvider.currentUser();

  Future<String> enterDataFormForm(int valueWater,int valueElectricity,int waste,int don,int bulk,int bio,int car,int bike,int bus) =>
   _firestoreProvider.enterDataFromFormTree( valueWater, valueElectricity, waste, don, bulk, bio, car, bike, bus);

  Future<String> loadJsonFile(String file) =>
      rootBundleProvider.loadJsonFile(file);
}