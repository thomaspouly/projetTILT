import 'package:flutter/material.dart';

class Categorie {
  Names name;
  Color color;
  Color colorLogo;
  String conseils;

  Categorie(Names n) {
    name = n;

    switch (name) {
      case Names.faune:
        color = Colors.orange;
        colorLogo = Colors.orange[900];
        conseils = "blabla faune";
        break;
      case Names.flore:
        color = Colors.green;
        colorLogo = Colors.green[900];
        conseils = "blabla flore";
        break;
      case Names.rechauffement:
        color = Colors.blue;
        colorLogo = Colors.blue[900];
        conseils = "blabla rechauffement";
        break;
      case Names.pollution:
        color = Colors.brown;
        colorLogo = Colors.brown[900];
        conseils = "blabla rechauffement";
        break;
      case Names.energie:
        color = Colors.yellow;
        colorLogo = Colors.yellow[900];
        conseils = "blabla energies";
        break;
      case Names.dechet:
        color = Colors.red;
        colorLogo = Colors.red[900];
        conseils = "blabla dechets";
        break;
    }
  }
}

enum Names { faune, flore, rechauffement, pollution, energie, dechet }
