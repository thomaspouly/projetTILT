import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/Repository.dart';

class LoginBloc {
  final _repository = Repository();
  String _email;
  String _password;


  Future<int> submit(String email, String password) {
    if(validateFields(email, password)) {
      return _repository.authenticateUser(email, password);
    }
    return null;
  }

  Future<void> registerUser(String email, String password) {
    if(validateFields(email, password)) {
      return _repository.registerUser(email, password);
    }
    return null;
  }

  bool validateFields(String email, String password) {
    if (email != null &&
        email.isNotEmpty &&
        password != null &&
        password.isNotEmpty &&
        email.contains('@') &&
        password.length > 3) {
      return true;
    } else {
      return false;
    }
  }
}