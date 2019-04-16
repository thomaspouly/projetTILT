import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;
  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  Future<void> registerUser(String email, String password,String name,int treeNumber) async {
    
   FirebaseUser _user = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

     return Firestore.instance.collection('user').document(_user.uid).setData({
        'name': name,
        'email': email,
        'treeNumber': treeNumber,
         });
   
  }
}
