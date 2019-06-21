import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageProvider {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> setImage(String userId, File image) async {
    _firebaseStorage.ref().child('/image/' + userId).putFile(image);
  }
}
