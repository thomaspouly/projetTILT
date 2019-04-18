import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
class FirestoreProvider {
  Firestore _firestore = Firestore.instance;
  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  Future<String> registerUser(String email, String password,String name,int treeNumber,File image) async {
    
   FirebaseUser _user = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

FirebaseStorage.instance.ref().child('/image/'+_user.uid).putFile(image);

      Firestore.instance.collection('user').document(_user.uid).setData({
        'name': name,
        'email': email,
        'treeNumber': treeNumber,
         });
         return _user.uid;
   
  }
}
