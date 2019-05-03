import 'dart:async';
import 'package:flutter_app/services/Repository.dart';

class LoginBloc {
  final _repository = Repository();

  Future<String> submit(String email, String password) {
    if (validateFields(email, password)) {
      return _repository.authenticateUser(email, password);
    }
    return null;
  }

  Future<void> submitWithEmail(String email) {
    if (validateFieldsEmail(email)) {
      return _repository.resetPasswordEmail(email);
    }
    return null;
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
