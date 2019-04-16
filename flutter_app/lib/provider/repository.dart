import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();

  Future<void> registerUser(String email, String password,String name,int treeNumber) =>
      _firestoreProvider.registerUser(email, password,name,treeNumber);

}
