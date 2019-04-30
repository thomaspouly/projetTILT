import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/provider/AuthProvider.dart';

class StorageProvider {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  AuthProvider auth = AuthProvider();

  Future<String> setImage(String userId, File image) async {
    _firebaseStorage.ref().child('/image/' + userId).putFile(image);
  }
}
