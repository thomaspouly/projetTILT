import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'StorageProvider.dart';

class AuthProvider {
  FirebaseAuth firebase = FirebaseAuth.instance;
  StorageProvider storage = StorageProvider();

  Future<String> authenticateUser(String email, String password) async {
    FirebaseUser user;

    user = await firebase.signInWithEmailAndPassword(
        email: email, password: password);

    print("Signed in : " + user.uid);
    return user.uid;
  }

  Future<String> authenticateUserWithFb() async {
    FacebookLogin facebookLogin = new FacebookLogin();
    FacebookLoginResult result = await facebookLogin
        .logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        return firebase.signInWithCredential(credential).then((firebaseUser) {
          User user = new User(
            name: firebaseUser.displayName,
            email: firebaseUser.email ?? '',
            nbPomme: 0,
            treeNumber: 1,
            date: DateTime.now().toIso8601String(),
          );
          storage.setImage(firebaseUser.uid, File(firebaseUser.photoUrl));
          return firebaseUser.uid;
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled by User");
        break;
      case FacebookLoginStatus.error:
        print("Error");
        break;
    }
  }

  Future<String> currentUser() {
    return firebase.currentUser().then((userID) {
      return userID.uid;
    });
  }

  Future<String> registerUser(String email, String password) async {
    FirebaseUser user = await firebase.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<void> resetPasswordUser(String email) async {
    return await firebase.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() {
    return firebase.signOut();
  }

  Future<void> login(String userId, DateTime date) {
    return SharedPreferences.getInstance().then((prefs) {
      prefs.setString('id', userId);
      print("PREF =>" + prefs.getString("id"));
    });
  }
}
