import 'dart:async';
import 'dart:io';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/services/Repository.dart';

class FriendBloc {
  final _repository = Repository();

  Future<User> addUserInFriendList(String email) {
    return _repository.addUserInFriendList(email);
  }

  Future<List<User>> getAllFriend() {
    return _repository.getAllFriend();
  }

}
