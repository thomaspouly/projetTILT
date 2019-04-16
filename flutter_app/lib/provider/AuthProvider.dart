import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {

  FirebaseAuth firebase = FirebaseAuth.instance;

  Future<String> authenticateUser(String email, String password) async {
    FirebaseUser user = await firebase.signInWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }
}