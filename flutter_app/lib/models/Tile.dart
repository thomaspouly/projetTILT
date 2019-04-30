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
      this.icon,
      this.counter,
      this.increment,
      this.description});

  @override
  String toString() => "Tile<$id:$name:$categorie:$counter:$increment>";


  List<Tile> listTile() {
    List<Tile> list = <Tile>[
      Tile(
          id: 1,
          name: "Ailerons de requins prélevés(en kg)",
          categorie: Categorie(Names.faune),
          icon: Icons.donut_large,
          counter: 0,
          increment: 0.25,
          description:
              "Chaque année 8 000 tonnes d'ailerons de requins sont prélevés, soit 8 000 000 kg d'ailerons par an soit environ 1 kg d'ailerons tourtes les quatre secondes (compteur), une habitude qui contribue au massacre des requins."),
     Tile(
          id: 2,
          name: "Le prélèvement végétal de l'humanité(kg)",
          categorie: Categorie(Names.flore),
          icon: Icons.file_download,
          counter: 0,
          increment: 3500251,
          description:
              "Chaque année, l'homme prélève 25% de la production végétale de planète pour ses besoins. Cela représente plus de 113 milliards de tonnes de biomasse chaque année, soit 16 tonnes par habitant de la planète en moyenne ! Toutes les secondes, 3,5 millions de kilos de matière végétale (compteur) sont prélevés par l'homme. Cela représente 25% de toute la production de biomasse de la planète. Vers 2050, le prélèvement des 9 milliards habitants de la Terre sera d'environ 140 milliards de tonnes."),
      Tile(
          id: 3,
          name: "Emissions mondiales de tetrachlorure de carbone(en kg)",
          categorie: Categorie(Names.rechauffement),
          icon: Icons.nature,
          counter: 0,
          increment: 1.24,
          description:
              "Les émissions de CCI4, tetrachlorure de carbone, continuent à augmenter malgré leur interdiction et atteignent 39 000 tonnes par an soit 1,24 kilo par seconde (compteur) mais on ne sait pas comment."),
      Tile(
          id: 4,
          name: "Coût de la pollution atmosphérique en France(en €)",
          categorie: Categorie(Names.pollution),
          icon: Icons.nature,
          counter: 0,
          increment: 1,
          description:
              "La pollution de l'air intérieur en France a un coût sanitaire et économique élevé, 630 euros chaque seconde (compteur) soit près de 20 milliards d'euros chaque année."),
      Tile(
          id: 5,
          name: "Production mondiale de charbon(en tonnes)",
          categorie: Categorie(Names.energie),
          icon: Icons.nature,
          counter: 0,
          increment: 110,
          description:
              "Après avoir progressé en moyenne de 1,9 % par an entre 2002 et 2015, la production mondiale de charbon a décliné de 6,2 % en 2016, à environ 3,5 milliards de tonnes, l'équivalent de 110 tonnes par seconde : la production américaine de charbon a baissé de 19 % et la production chinoise de 7,9 %, avec la Chine comme premier producteur mondial (46,1 %). "),
      Tile(
          id: 6,
          name: "Recyclage de bouteilles de verre en Europe(en bouteilles)",
          categorie: Categorie(Names.dechet),
          icon: Icons.nature,
          counter: 0,
          increment: 793,
          description:
              "Chaque année ce sont 25 milliards de bouteilles de verre qui sont triées et recyclées en Europe. Cela représente 793 bouteilles et pots de verre collectés et recyclés chaque seconde"),
      Tile(
          id: 7,
          name: "Pêche mondiale de thon rouge(en kg)",
          categorie: Categorie(Names.faune),
          icon: Icons.nature,
          counter: 0,
          increment: 3.2,
          description:
              "La CICTA a annoncé que le quota de la pêche au thon rouge passera de 22 000 tonnes en 2009 à 13 500 tonnes en 2010 mais en réalité on estime les prises mondiales de thon rouge proches de 100 000 tonnes, soit 3,2 kilos de thon rouge chaque seconde (compteur)"),
      Tile(
          id: 8,
          name: "Coût de l'érosion de la biodiversité (en euros)",
          categorie: Categorie(Names.flore),
          icon: Icons.nature,
          counter: 0,
          increment: 100231,
          description:
              "Entre 1 350 et 3 100 milliards d'euros par an, c'est le coût de l'érosion de la biodiversité, selon une étude présentée le 29 mai 2008 à la conférence de l'ONU à Bonn."),
      Tile(
          id: 9,
          name: "Fonte des glaces au Groënland(en L)",
          categorie: Categorie(Names.rechauffement),
          icon: Icons.nature,
          counter: 0,
          increment: 7800321,
          description:
              "Chaque année, la perte de masse de la calotte de glace en Antarctique représente en moyenne 7,8 millions de litres par seconde (compteur) et 247 milliards de tonnes (en moyenne sur 2006 - 2009) . La fonte des glaces était de 104 milliards de tonnes / an de 2002 à 2006."),
      Tile(
          id: 10,
          name:
              "Décès dus à une exposition aux produits chimiques dans l'environnement",
          categorie: Categorie(Names.pollution),
          icon: Icons.nature,
          counter: 0,
          increment: 0.25,
          description: "Hi"),
      Tile(
          id: 11,
          name: "Production mondiale de pétrole(en nombre de barils)",
          categorie: Categorie(Names.energie),
          icon: Icons.nature,
          counter: 0,
          increment: 1107,
          description:
              "La production mondiale de pétrole s'établit à 95,62 millions de barils par jour soit presque 1107 barils par seconde. En 2014, les Etats-Unis sont devenus les premiers producteurs mondiaux grâce au pétrole de schiste. Depuis 2002, la demande mondiale de pétrole augmente plus vite que l'offre, due principalement aux hausses de la demande asiatique (Chine, Inde)."),
      Tile(
          id: 12,
          name: "Coût global du gaspillage en France(en €)",
          categorie: Categorie(Names.dechet),
          icon: Icons.nature,
          counter: 0,
          increment: 4439,
          description:
              "Chaque seconde en France, ce sont 4.439 euros qui sont jetés par les fenêtres du fait de gaspillages administratif ou écologiques. Cela représente un gaspillage annuel de quelque 140 milliards"),
      Tile(
          id: 13,
          name: "Animaux adoptés à la SPA",
          categorie: Categorie(Names.faune),
          icon: Icons.nature,
          counter: 0,
          increment: 0.0018,
          description:
              "Depuis 2008, ce sont en moyenne un peu plus de 30.160 animaux qui sont adoptés dans le réseau SPA français chaque année, (dont 16.000 chiens et 13.000 chats en 2013) soit près de 82 adoptions chaque jour."),
      Tile(
          id: 14,
          name:
              "Nombre de nouvelles espèces classifiées et décrites par les scientifiques",
          categorie: Categorie(Names.flore),
          icon: Icons.nature,
          counter: 0,
          increment: 0.03,
          description:
              "Chaque année, environ 16 000 nouvelles espèces sont découvertes par les scientifiques, ce qui représente environ 2 nouvelles espèces classées par heure."),
      Tile(
          id: 15,
          name:
              "Litres d'eau fondue perdus par le glacier Pine Island en Antarctique(en L)",
          categorie: Categorie(Names.rechauffement),
          icon: Icons.nature,
          counter: 0,
          increment: 2536783,
          description:
              "Chaque seconde, ce sont 2.536.783 litres d'eau ou 2536 m3 d'eau que perd le glacier Pine Island, un des principaux glaciers de la calotte glacière de l'ouest antarctique, soit 80 km3 d'eau perdus par an. Une quantité énorme !"),
      Tile(
          id: 16,
          name: "Ventes de bouteilles en plastique dans le monde",
          categorie: Categorie(Names.pollution),
          icon: Icons.nature,
          counter: 0,
          increment: 15000,
          description:
              "En 2016, 480 milliards de bouteilles en plastique ont été vendues dans le monde, soit plus de 15.000 par seconde (compteur). Et ça continue ! À ce rythme, en 2021, ce seront plus de 583 milliards de bouteilles en plastique qui seront écoulées par an."),
      Tile(
          id: 17,
          name: "Production d'électricité éolienne en France(KiloWatt/heure)",
          categorie: Categorie(Names.energie),
          icon: Icons.nature,
          counter: 0,
          increment: 10,
          description:
              "En 2016 la France a installé 1,6 GW de capacité éolienne supplémentaire, un record (+ 13 %) pour une capacité installée totale de 12.065 MW fin 2016 (10.505 fin 2015). En 2015, la production d'énergie éolienne en France a représenté 21,1 TWh (+ 23,3 %) soit 3,9 % de la production électrique française ; ce qui place la France au quatrième rang européen avec soit 41 MWh toutes les heures (compteur)."),
      Tile(
          id: 18,
          name: "Production de déchets dans le monde(en tonnes)",
          categorie: Categorie(Names.dechet),
          icon: Icons.nature,
          counter: 0,
          increment: 103,
          description:
              "Difficile à estimer, ce chiffre varie de 3.400 à 4.000 milliards de tonnes par an, soit de 80 à 126 tonnes de déchets générés chaque seconde ! Chaque jour, l'activité humaine produit environ plus de 10 milliards de kilos de déchets. Le flou entourant les chiffres des déchets toxiques ou dangereux (solvants, ....) est important. Entre 2008 et 2020 la quantité de déchets devrait augmenter de 40% dans le monde."),
   ];
    return list;
  }
}
