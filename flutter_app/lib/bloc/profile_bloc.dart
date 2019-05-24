import 'dart:async';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/services/Repository.dart';

class ProfileBloc {
  final _repository = Repository();

  Future<User> getUserById(String id) {
    return _repository.getUserById(id);
  }

  Future<User> modifyUser(String id,String email, String name, int treeNumber,int nbPomme,String date,List<String>friendList) {
    return _repository.modifyUser(id, email, name, treeNumber,nbPomme,date,friendList);
  }

  Future<User> addUserInFriendList(String email) {
    return _repository.addUserInFriendList(email);
  }

}
