import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/Repository.dart';

class LoginBloc {
  final _repository = Repository();
  String _email;
  String _password;
  final emailFieldController = TextEditingController();
  final passFieldController = TextEditingController();

  LoginBloc() {
    _email = emailFieldController.text;
    _password = passFieldController.text;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Detache le controller quand tout est fini
    emailFieldController.dispose();
    passFieldController.dispose();
  }

  Future<int> submit() {
    if(validateFields()) {
      return _repository.authenticateUser(_email, _password);
    }
    return null;
  }

  Future<void> registerUser() {
    if(validateFields()) {
      return _repository.registerUser(_email, _password);
    }
    return null;
  }

  bool validateFields() {
    if (emailFieldController.text != null &&
        emailFieldController.text.isNotEmpty &&
        passFieldController.text != null &&
        passFieldController.text.isNotEmpty &&
        emailFieldController.text.contains('@') &&
        passFieldController.text.length > 3) {
      return true;
    } else {
      return false;
    }
  }
}