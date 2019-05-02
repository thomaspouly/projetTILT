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
        conseils = "-Protéger la vie sylvestre.\n-Ne pas appuyer la capture d'animaux.\n-S'engager dans la préservation de l'habitat naturel des animaux.\n-Se manifester contre la déforestation.\n-Essayer de réduire son empreinte carbone.\n-Ne pas laisser les lumières allumées.\n-Faire du volontariat.\n-Éduquer les nouvelles générations.\n-Favoriser les circuits courts pour se nourrir.\n-Acheter sa nourriture de manière consciente.\n-Ne pas jeter sa poubelle dans la nature.\n-N'acheter pas d'animaux.";
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
