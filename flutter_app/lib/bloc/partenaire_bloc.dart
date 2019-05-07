import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/models/Association.dart';
import 'package:flutter_app/models/Country.dart';
import 'package:flutter_app/services/Repository.dart';

class PartenaireBloc {
  final _repository = new Repository();


  Future<List<Association>> loadAssociations(int departement) async {
    return _repository.getAssociations(departement);
  }
}
