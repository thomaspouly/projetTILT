import 'dart:async';
import 'package:flutter_app/models/NoteForm.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/services/Repository.dart';

class LoginBloc {
  final _repository = Repository();

  Future<String> submit(String email, String password) {
    if (validateFields(email, password)) {
      return _repository.authenticateUser(email, password);
    }
    return null;
  }

  Future<String> authenticateUserWithFb() async {
    return _repository.authenticateUserWithFb();
  }

  Future<void> submitWithEmail(String email) {
    if (validateFieldsEmail(email)) {
      return _repository.resetPasswordEmail(email);
    }
    return null;
  }

  Future<User> getUserById(String id) {
    return _repository.getUserById(id);
  }

  Future<void> enterNbPomme(int nbPomme) =>
      _repository.enterNbPomme(nbPomme);

  Future<NoteForm> getNote() {
    return _repository.getNote();
  }

  Future<void> login(String userId,DateTime date) {
    return _repository.login(userId,date);
  }

  bool validateFields(String email, String password) {
    if (email != null &&
        email.isNotEmpty &&
        password != null &&
        password.isNotEmpty &&
        RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(email) &&
        password.length >= 6) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFieldsEmail(String email) {
    if (email != null &&
        email.isNotEmpty &&
        RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }
}
