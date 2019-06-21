import 'package:flutter/material.dart';

import 'Categorie.dart';

class Tile {
  int id;
  String name;
  Categorie categorie;
  Color color;
  IconData icon;
  String description;

  double counter;
  double increment;

  Tile(
      {this.id,
      this.name,
      this.categorie,
   
      this.counter,
      this.increment,
      this.description});

  @override
  String toString() => "Tile<$id:$name:$categorie:$counter:$increment>";

void setCounter(DateTime date){
 date = DateTime(1967, 10, 12);
 var now = DateTime.now();
 int difference = now.difference(date).inSeconds;
 counter+=increment*difference;

}

}
