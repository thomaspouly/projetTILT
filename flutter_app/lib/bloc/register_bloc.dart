import 'dart:async';
import 'dart:io';
import 'package:flutter_app/services/Repository.dart';

class RegisterBloc {
  final _repository = Repository();
  String _email;
  String _password;

  Future<String> registerUser(String email, String password,String name,int treeNumber,File image) {
    if(validateFields(email, password) && name.isNotEmpty && treeNumber>-1 && image!=null) {
      return _repository.registerUser(email, password,name,treeNumber,image);
    }else {
      return null;
    }
  }

  bool validateFields(String email, String password) {
    if (email != null &&
        email.isNotEmpty &&
        password != null &&
        password.isNotEmpty &&
        email.contains('@') &&
        password.length >4) {
      return true;
    } else {
      return false;
    }
  }
}