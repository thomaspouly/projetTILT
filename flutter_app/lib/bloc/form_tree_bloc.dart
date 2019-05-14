import 'dart:async';
import 'package:flutter_app/models/NoteForm.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/services/Repository.dart';

class FormTreeBloc {
  final _repository = new Repository();

  Future<String> getCurrentUser() {
    return _repository.getCurrentUser();
  }

  Future<String> enterDataFormForm(
      int valueWater,
      int valueElectricity,
      String waste,
      String don,
      String bulk,
      String bio,
      String car,
      String bike,
      String bus) {
    return _repository.enterDataFormForm(
        valueWater, valueElectricity, waste, don, bulk, bio, car, bike, bus);
  }


  Future<String> enterNote(String note) {
    return _repository.enterNote(note);
  }

  Future<User> getUserById(String id) {
    return _repository.getUserById(id);
  }

  Future<NoteForm> getNote() {
    return _repository.getNote();
  }
}
