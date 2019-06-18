import 'dart:async';
import 'dart:io';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/services/Repository.dart';

class FriendBloc {
  final _repository = Repository();

  Future<User> addUserInFriendList(String email) {
    return _repository.addUserInFriendList(email);
  }

  Future<List<String>> getAllFriend() {
    return _repository.getAllFriend();
  }

  Future<User> getUserById(String userID) {
    return _repository.getUserById(userID);
  }

}
