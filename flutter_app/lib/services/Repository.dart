import 'dart:io';
import 'package:flutter_app/models/Association.dart';
import 'package:flutter_app/models/NoteForm.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/FirestoreProvider.dart';
import 'package:flutter_app/provider/RootBundleProvider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();
  final authProvider = AuthProvider();
  final rootBundleProvider = RootBundleProvider();

  Future<String> authenticateUser(String email, String password) =>
      authProvider.authenticateUser(email, password);

  Future<String> authenticateUserWithFb() async {
    return _firestoreProvider.authenticateUserWithFb();
  }

  Future<String> registerUser(String email, String password, String name,
          int treeNumber, File image) =>
      _firestoreProvider.registerUser(email, password, name, treeNumber, image);

  Future<void> resetPasswordEmail(String email) =>
      authProvider.resetPasswordUser(email);

  Future<String> getCurrentUser() => authProvider.currentUser();

  Future<String> enterNote(String note) =>
    _firestoreProvider.enterNote(note);

  Future<String> loadJsonFile(String file) =>
      rootBundleProvider.loadJsonFile(file);

  Future<NoteForm> getNote() {
    return _firestoreProvider.getNote();
  }

  Future<void> enterNbPomme(int nbPomme) =>
      _firestoreProvider.enterNbPomme(nbPomme);

  Future<User> modifyUser(String id,String email, String name, int treeNumber,int nbPomme,String date,List<String>friendList) {
    return _firestoreProvider.modifyUser(id, email, name, treeNumber,nbPomme,date,friendList);
  }

  Future<String> modifyImageUser(File image) {
    return _firestoreProvider.modifyImageUser(image);
  }

  Future<User> getUserById(String id) {
    return _firestoreProvider.getUserById(id);
  }

  Future<List<String>>getAllFriend() {
    return _firestoreProvider.getAllFriend();
  }

  Future<List<Association>> getAssociations() {
    return _firestoreProvider.getAssociations();
  }

  Future<void> logout() {
    return authProvider.logout();
  }

  Future<void> login(String userId,DateTime date) {
    return authProvider.login(userId,date);
  }

  Future<User> addUserInFriendList(String email) {
    return _firestoreProvider.addUserInFriendList(email);
  }

}
