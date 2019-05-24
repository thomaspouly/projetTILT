import 'dart:async';
import 'package:flutter_app/models/Association.dart';
import 'package:flutter_app/services/Repository.dart';

class PartnerBloc {
  final _repository = new Repository();


  Future<List<Association>> loadAssociations() async {
    return _repository.getAssociations();
  }
}
