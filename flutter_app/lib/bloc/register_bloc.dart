import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/provider/repository.dart';

class RegisterBloc {
  final _repository = Repository();
  String _email;
  String _password;

  Future<void> registerUser(String email, String password,String name,int treeNumber) {
 
   
    if(validateFields(email, password) && name.isNotEmpty && treeNumber>-1) {
      return _repository.registerUser(email, password,name,treeNumber);
    }
    return null;
  }

  bool validateFields(String email, String password) {
    if (email != null &&
        email.isNotEmpty &&
        password != null &&
        password.isNotEmpty &&
        email.contains('@') &&
        password.length > 6) {
      return true;
    } else {
      return false;
    }
  }
}
