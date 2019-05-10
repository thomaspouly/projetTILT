import 'dart:async';
import 'dart:io';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/services/Repository.dart';

class ProfilBloc {
  final _repository = Repository();

  Future<User> getUserById(String id) {
    return _repository.getUserById(id);
  }

}
