import 'dart:async';
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
}
