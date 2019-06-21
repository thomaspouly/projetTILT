import 'package:firebase_auth/firebase_auth.dart';
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

  Future<FirebaseUser> signInWithCredential(AuthCredential credential) {
    return firebase.signInWithCredential(credential);
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
