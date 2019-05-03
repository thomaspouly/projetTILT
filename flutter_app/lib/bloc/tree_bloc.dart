import 'dart:async';
import 'package:flutter_app/services/Repository.dart';

class TreeBloc {
  final _repository = new Repository();

  Future<String> getNote() async {
    return _repository.getNote();
  }
}
