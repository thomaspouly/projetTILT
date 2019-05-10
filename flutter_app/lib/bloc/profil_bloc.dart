import 'dart:async';
import 'dart:io';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/services/Repository.dart';

class ProfilBloc {
  final _repository = Repository();

  Future<User> getUserById(String id) {
    return _repository.getUserById(id);
  }

  Future<User> modifyUser(String id,String email, String name, int treeNumber) {
    return _repository.modifyUser(id, email, name, treeNumber);
  }

}
