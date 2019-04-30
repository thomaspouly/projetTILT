import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthProvider {
  FirebaseAuth firebase = FirebaseAuth.instance;

  Future<String> authenticateUser(String email, String password) async {
    FirebaseUser user;
      user = await firebase.signInWithEmailAndPassword(
          email: email, password: password);
      print("Signed in : " + user.uid);
      return user.uid;
  }

  Future<String> currentUser() {
    return firebase.currentUser().then((userID) {
      return userID.uid;
    });
  }

  Future<String> registerUser(String email,String password) async {
    FirebaseUser user = await firebase.createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  Future<void> resetPasswordUser(String email) async {
    return await firebase.sendPasswordResetEmail(email: email);
  }
}
