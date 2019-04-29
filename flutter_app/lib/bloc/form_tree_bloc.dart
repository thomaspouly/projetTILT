import 'dart:async';
import 'package:flutter_app/services/Repository.dart';

class FormTreeBloc {
  final _repository = new Repository();


  Future<String> getCurrentUser() {
    return _repository.getCurrentUser();
  }

  Future<String> enterDataFormForm(int valueWater,int valueElectricity,int waste,int don,int bulk,int bio,int car,int bike,int bus) {
    return _repository.enterDataFormForm(
        valueWater,
        valueElectricity,
        waste,
        don,
        bulk,
        bio,
        car,
        bike,
        bus);
  }

}