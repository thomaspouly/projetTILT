import 'dart:async';
import 'package:flutter_app/services/Repository.dart';

class HomeBloc {
  final _repository = new Repository();

  Future<void> logout() {
    return _repository.logout();
  }
}
