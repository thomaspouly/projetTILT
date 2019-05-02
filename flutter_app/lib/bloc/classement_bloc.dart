import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/models/Country.dart';
import 'package:flutter_app/services/Repository.dart';

class ClassementBloc {
  final _repository = new Repository();
  var currentItemSelected2;
  var currentItemSelected;
  int taille;

  ClassementBloc(
      {this.currentItemSelected, this.currentItemSelected2, this.taille});

  Future<String> _loadCountryAsset(String annee) async {
    if (annee == "2017") {
      return await _repository.loadJsonFile('assets/country2017.json');
    } else if (annee == "2016") {
      return await _repository.loadJsonFile('assets/country2016.json');
    } else if (annee == "2015") {
      return await _repository.loadJsonFile('assets/country2015.json');
    } else if (annee == "2014") {
      return await _repository.loadJsonFile('assets/country2014.json');
    } else {
      return await _repository.loadJsonFile('assets/country2017.json');
    }
  }

  Future<List<Country>> loadCountries(String annee) async {
    String jsonString = await _loadCountryAsset(annee);
    List<dynamic> jsonResponse = json.decode(jsonString);
    List<Country> countries = new List();
    for (int i = 0; i < jsonResponse.length; i++) {
      Country country = Country.fromJson(jsonResponse[i]);
      countries.add(country);
    }
    return countries;
  }
}
