import 'package:flutter/material.dart';

import 'Categorie.dart';
import 'Tile.dart';

class TileHelper {
  List<Tile> listTile() {
    List<Tile> list = <Tile>[
      Tile(
          id: 1,
          name: "La consommation d'insectes par les araignées(en tonnes)",
          categorie: Categorie(Names.faune),
          counter: 0,
          increment: 25,
          description:
              "Les araignées qui sont exclusivement carnivores sont les plus grands consommateurs d'insectes de la planète : avec 800 millions de tonnes, elles consomment deux fois plus de viande d'insectes que l'humanité ne consomme de viande, soit l'équivalent de plus de 25.300 kilos par seconde (compteur) !\n\nLes araignées sont donc de redoutables prédateurs dotés de sens très affûtés et qui rendent de grands services à l'humanité en exerçant leur prédation essentiellement sur des arthropodes (insectes, collemboles,…).\n\nChaque moustique pris dans une toile d'araignée est un service rendu, pensez-y avant de tuer les araignées !"),
      Tile(
          id: 6,
          name: "Le prélèvement végétal de l'humanité(kg)",
          categorie: Categorie(Names.flore),
          counter: 0,
          increment: 3500251,
          description:
              "Chaque année, l'homme prélève 25% de la production... végétale de planète pour ses besoins. Cela représente plus de 113 milliards de tonnes de biomasse chaque année, soit 16 tonnes par habitant de la planète en moyenne ! \n\nToutes les secondes, 3,5 millions de kilos de matière végétale (compteur) sont prélevés par l'homme. Cela représente 25% de toute la production de biomasse de la planète. Vers 2050, le prélèvement des 9 milliards habitants de la Terre sera d'environ 140 milliards de tonnes.\n\nLe prélèvement végétal est de 8,1% en Amérique du Sud et 17,7% en Afrique Le pire se passe en Inde (96,6 %), en Chine (89,7 %) et Europe occidentale (86,1 %)\n\nL’Amérique du Nord, grâce à ses grands espaces ne prélève « que » 28,8 % bien que ses habitants soient les plus « gloutons » de la planète avec une consommation annuelle de 6 tonnes de matières végétales sous forme de carbone."),
      Tile(
          id: 11,
          name: "Emissions de CO2 par habitant en France (en g)",
          categorie: Categorie(Names.rechauffement),
          counter: 0,
          increment: 0.2,
          description:
              "Un Français émet en moyenne 7,5 tonnes d'équivalent C02 par an (contre 9,6 t en 1990) soit environ 20,5 kilos de CO2 émis chaque jour. A l'origine de ces émissions : nos déplacements (33%), le chauffage, l'eau chaude et l'électricité.\n\nChaque personne contribue quotidiennement aux émissions de CO2 : un ménage français en rejette en moyenne 16.400 kilos par an dans l'atmosphère.\nLes principales sources d’émissions de gaz à effet de serre « domestiques » sont le chauffage de l’habitation et les déplacements en voiture.\n\nPour éviter que le climat ne se dérègle davantage, il faudrait diviser par 4 nos émissions de CO2 d'ici à 2050. Aussi, est-il important de réduire les émissions individuelles de gaz à effet de serre. Parce que des gestes simples peuvent diviser par deux nos émissions de gaz à effet de serre, chaque geste en la matière peut faire la différence !"),
      Tile(
          id: 16,
          name: "Coût de la pollution atmosphérique en France(en €)",
          categorie: Categorie(Names.pollution),
          counter: 0,
          increment: 1,
          description:
              "    Le coût de la pollution de l'air intérieur serait de près de 20 milliards d’euros par an en France.\n\nLe coût socio-économique de la pollution de l'air intérieur a été estimé en additionnant le coût de ses conséquences avec une estimation basse \n\nCancers du rein provoqués par l’inhalation de trichloréthylène ; \nleucémies imputables à l’exposition au benzène ; \ncancers du poumon liés au radon ou au tabagisme passif ;\n intoxication au monoxyde de carbone, maladies cardiovasculaires provoquées par la respiration de particules, etc. : chaque année, en France, la pollution de l’air intérieur serait responsable de près de 20 000 décès prématurés. Le coût de cette mortalité et de la baisse de qualité de vie des personnes malades s’élève à 18 milliards d'euros, auxquels viennent s’ajouter les pertes de journées travaillées, et les frais de prise en charge des soins, et ceux liés à la recherche.1 \nLes conséquences de la pollution de l'air intérieur\nCancers du rein provoqués par l’inhalation de trichloréthylène ; \nleucémies imputables à l’exposition au benzène ; \ncancers du poumon liés au radon ou au tabagisme passif ;\nintoxication au monoxyde de carbone, \nmaladies cardiovasculaires provoquées par la respiration de particules, etc.\n\nLes décès du à la pollution de l'air intérieur en France\n\nLa pollution de l’air intérieur serait responsable de près de 20 000 décès prématurés chaque année en France.\n\nLe coût de cette mortalité et de la baisse de qualité de vie des personnes malades s’élève à 18 milliards d'euros, auxquels viennent s’ajouter le coût journées de travail perdues, de la prise en charge des soins, et ceux liés à la recherche. "),
      Tile(
          id: 21,
          name: "Production mondiale de charbon(en tonnes)",
          categorie: Categorie(Names.energie),
          counter: 0,
          increment: 110,
          description:
              "Après avoir progressé en moyenne de 1,9 % par an entre 2002 et 2015, la production mondiale de charbon a décliné de 6,2 % en 2016, à environ 3,5 milliards de tonnes, l'équivalent de 110 tonnes par seconde : la production américaine de charbon a baissé de 19 % et la production chinoise de 7,9 %, avec la Chine comme premier producteur mondial (46,1 %)\n\n\nLe charbon en Europe\nEn 2016, plus de 130 millions de tonnes d’équivalent pétrole de charbon ont été produites dans l’union européenne contre 190 millions en 2006. À comparer à la production de charbon en Asie : 2,6 milliards de tonnes en 2016 contre 1,9 milliard en 2006.\n\nLe charbon en Afrique\nLa production de charbon en Afrique a été de plus de 150 millions de tonnes en 2016 contre 140 millions de tonnes en 2006. La consommation de charbon en Afrique a été de 95 millions de tonnes en 2016 contre 90 millions de tonnes en 2006.\n\nLe charbon en Amérique du Nord\nLa consommation de charbon en Amérique du Nord baisse : elle a été de 380 millions de tonnes en 2016 contre 600 millions de tonnes en 2006. La production de charbon en Amérique du Nord baisse également : 630 millions de tonnes en 2016 contre 400 en 2006.\n\nLa production mondiale de charbon décline depuis 2013. Cependant en 2015, le charbon représentait toujours 40 % de la production mondiale d’énergie contre 23 % pour les énergies renouvelables (dont les deux tiers proviennent des barrages et de l’hydroélectricité).    "),
      Tile(
          id: 26,
          name: "Recyclage de bouteilles de verre en Europe(en bouteilles)",
          categorie: Categorie(Names.dechet),
          counter: 0,
          increment: 793,
          description:
              "Chaque année ce sont 25 milliards de bouteilles de verre qui sont triées et recyclées en Europe. Cela représente 793 bouteilles et pots de verre collectés et recyclés chaque seconde"),
      Tile(
          id: 2,
          name: "Nombre de sangliers tués en France",
          categorie: Categorie(Names.faune),
          counter: 0,
          increment: 0.015,
          description:
              "Le nombre de sangliers tués en France par les chasseurs dépasse 1300 sangliers par jour, soit près de 500 000 sangliers tués chaque année. Le nombre de sangliers a fortement augmenté dans de nombreux départements français (Hérault, Gard...)\n\nLe nombre de sangliers tués est passé de 50 000 en 1975 à 323 000 en 1997 et le nombre global de ces animaux est estimé actuellement à 700 000 à 1 million de sangliers."),
      Tile(
          id: 7,
          name: "Coût de l'érosion de la biodiversité (en euros)",
          categorie: Categorie(Names.flore),
          counter: 0,
          increment: 100231,
          description:
              "Environ 150 espèces de flore et de faune sauvage disparaissent chaque jour.\n\n15 à 37% de la biodiversité auront disparu d'ici 2050 du fait du réchauffement planétaire, affirme un article publié en 2004 par un collectif de scientifiques du monde entier. Le rythme actuel de disparition des espèces de la planète est de 100 à 1000 fois supérieur au rythme naturel qu'on a connu depuis l'histoire de la terre.\n\nSur 41 415 espèces d'animaux recensées sur terre, 16 306 sont menacées d'extinction, soit 188 espèces de plus qu'en 2006.Entre 1 350 et 3 100 milliards d'euros par an, c'est le coût de l'érosion de la biodiversité, selon une étude présentée le 29 mai 2008 à la conférence de l'ONU à Bonn."),
      Tile(
          id: 12,
          name: "Fonte des glaces au Groënland(en L)",
          categorie: Categorie(Names.rechauffement),
          counter: 0,
          increment: 7800321,
          description:
              "Chaque année, la perte de masse de la calotte de glace en Antarctique représente en moyenne 7,8 millions de litres par seconde (compteur) et 247 milliards de tonnes (en moyenne sur 2006 - 2009) . La fonte des glaces était de 104 milliards de tonnes / an de 2002 à 2006.\n\nChaque année, entre 2011 et 2014, le Groënland a perdu 375 milliards de tonnes de glace chaque année.\nCela représente 11,8 millions de litres, soit pas loin de 3 piscines olympiques chaque seconde.\nSoit un ryhtme 2,5 fois plus rapide que pendant la période de 2003 à 2009."),
      Tile(
          id: 17,
          name:
              "Décès dus à une exposition aux produits chimiques dans l'environnement",
          categorie: Categorie(Names.pollution),
          counter: 0,
          increment: 0.25,
          description:
              "Chaque jour, 13.450 personnes décèdent à cause d'une exposition à des produits chimiques présents dans l'environnement. D'après une étude de l'OMS, 4,9 millions de décès auraient été attribuables à l'exposition à des produits chimiques dans l'environnement en 2004,\nsoit l'équivalent de 86 millions d'années de vies perdues !\n\n8,3 %, cela équivaut à un décès toutes les 4 secondes et a représenté selon l'OMS, 8,3 % de la mortalité globale.\n\nCombien de produits chimiques suspects ?\nIl existe environ 248.000 produits chimiques disponibles dans le commerce dont un grand nombre pouvant avoir des effets néfastes sur la santé humaine, la faune et l'environnement (comme par exemple les polluants organiques persistants, ou les pesticides).\n\nPhilippe Grandjean et Philip Landrigan ont édité en 2006 puis 2012 une liste de 214 substances chimiques connues pour leur toxicité pour le cerveau : notamment des métaux lourds (manganèse, aluminium, arsenic, mercure), des pesticides (Glyphosate, DDT), des solvants (toluène, benzène, acétone, tétrachloroéthylène). La liste des produits chimiques toxiques pour l'homme pourrait s'allonger car plus de 1000 substances sont reconnues comme neurotoxiques pour l'animal."),
      Tile(
          id: 22,
          name: "Production mondiale de pétrole(en nombre de barils)",
          categorie: Categorie(Names.energie),
          counter: 0,
          increment: 1107,
          description:
              "La production mondiale de pétrole s'établit à 95,62 millions de barils par jour soit presque 1107 barils par seconde. En 2014, les Etats-Unis sont devenus les premiers producteurs mondiaux grâce au pétrole de schiste. Depuis 2002, la demande mondiale de pétrole augmente plus vite que l'offre, due principalement aux hausses de la demande asiatique (Chine, Inde).\n\n Chaque jour, on produit dans le monde 95,62 millions de barils de pétrole. Ceci équivaut à plus de 15,2 milliards de litres.  \n \nLa production mondiale de pétrole en 2014 : 93,3 millions de barils par jour\nSelon l'Agence Internationale de l'Energie : \nLa production mondiale de pétrole en 2013 : 90,33 millions de barils par jour\nLa production mondiale de pétrole en 2012 : 89,76 millions de barils par jour\n \nDepuis 2014 les États-Unis sont devenus le premier producteur mondial de pétrole devant l'Arabie Saoudite notamment grâce à l'explosion du pétrole de schiste.        "),
      Tile(
          id: 27,
          name: "Coût global du gaspillage en France(en €)",
          categorie: Categorie(Names.dechet),
          counter: 0,
          increment: 4439,
          description:
              "Chaque seconde en France, ce sont 4.439 euros qui sont jetés par les fenêtres du fait de gaspillages administratif ou écologiques. Cela représente un gaspillage annuel de quelque 140 milliards"),
      Tile(
          id: 3,
          name: "Ailerons de requins prélevés(en kg)",
          categorie: Categorie(Names.faune),
          counter: 0,
          increment: 0.25,
          description:
              "Chaque année 8 000 tonnes d'ailerons de requins sont prélevés, une habitude qui contribue au massacre des requins.\nL'aileron ne représente au total que 4 % du poids total du requin\n\nLe requin est plus menacé par l'Homme qu'il n'est dangereux pour lui. La rapide croissance économique de la Chine a fait grandir le marché de l'aileron qui se met dans des soupes dont le bol vaut entre 50 et 400 dollars et qui n'apportent rien nutritionnellement parlant à l'être humain.\n\nPour pêcher le requin, certains braconniers vont dans les parcs naturels marins comme les îles Galapagos en Équateur où sa pêche est interdite depuis 2007. En mai 2015, 200 000 ailerons ont été saisis par la police équatorienne durant « la operación tiburón » où trois trafiquants ont été arrêtés.\n\nLa population des requin a été réduite de 70 % à 95 % selon les espèces. 18 espèces de requins sont en voie de disparition, selon un recensement de l'Union Internationale pour la Conservation de la Nature (IUCN)."),
      Tile(
          id: 8,
          name:
              "Nombre de nouvelles espèces classifiées et décrites par les scientifiques",
          categorie: Categorie(Names.flore),
          counter: 0,
          increment: 0.03,
          description:
              "Selon l'Institut International pour l'Exploration des Espèces (IISE), environ 18000 espèces sont découvertes par les scientifiques chaque année. \nOn ne cesse de découvrir de nouvelles espèces chaque jour, dont la plupart sont des invertébrés. A ce jour, un peu moins de 2 millions d'espèces vivantes ont été identifiées (largement représentées par les insectes). \n\nIl en resteraient autour de 10 millions qui n'ont pas encore été repertoriées par les scientifiques, selon des estimations récentes de l'Union Internationale pour la Conservation de la Nature (IUCN). Il y aurait au total entre 3 et 100 millions d'espèces sur Terre, avec des estimations raisonnables tournant autour de 13 à 15 millions d'espèces.\n\nLe nombre d'espèces de mammifères et d'oiseaux s'accroît chaque année de 0,1 à 0,2 % et celle des lézards et des serpents de 1,7%.\nLes forêts tropicales sont les écosystèmes les plus riches en espèces. Elles ne recouvrent que moins de 10 % de la surface de la terre mais contiennent peut-être 90 % des espèces vivant sur la planète. Les récifs de coraux et les landes méditerranéennes sont aussi très riches en espèces."),
      Tile(
          id: 13,
          name:
              "Litres d'eau fondue perdus par le glacier Pine Island en Antarctique",
          categorie: Categorie(Names.rechauffement),
          counter: 0,
          increment: 2536783,
          description:
              "Chaque seconde, ce sont 2.536.783 litres d'eau ou 2536 m3 d'eau que perd le glacier Pine Island, un des principaux glaciers de la calotte glacière de l'ouest antarctique, soit 80 km3 d'eau perdus par an. Une quantité énorme !\n\nLa fonte des glaces, glaciers, banquise, icebergs se généralise sous l'effet du réchauffement climatique. Un phénomène massif et une des principales causes de l'augmentation lente mais régulière du niveau des océans.\n\n80 000 000 000 000 litres d'eau, c'est la fonte de ce glacier géant antarctique en rythme annuel. Le glacier Pine island est un des glaciers qui bouge le plus vite (car il fond) en Antarctique : le PIG, ou Pine Island Glacier, draine envion un tiers de la fonte et de la glace de la calotte antarctique, d'où l'importance de son observation."),
      Tile(
          id: 18,
          name: "Ventes de bouteilles en plastique dans le monde",
          categorie: Categorie(Names.pollution),
          counter: 0,
          increment: 15000,
          description:
              "En 2016, 480 milliards de bouteilles en plastique ont été vendues dans le monde, soit plus de 15.000 par seconde (compteur). Et ça continue ! À ce rythme, en 2021, ce seront plus de 583 milliards de bouteilles en plastique qui seront écoulées par an.\n\n15.220 c'est le nombre de bouteilles en plastique écoulées chaque seconde sur la planète\nPrès d'un million de bouteilles en plastique sont achetées chaque minute dans le monde et ce nombre pourrait bien augmenter de 20% d'ici 2021.\nLa plupart des bouteilles en plastique utilisées pour l'eau ou les boissons gazeuses et l'eau sont fabriquées en polyéthylène téréphtalate (Pet), qui est hautement recyclable.\n\nLa plupart des bouteilles en plastique utilisées pour l'eau ou les boissons gazeuses sont fabriquées à partir d'un produit pétrolier connu sous le nom de polyéthylène téréphtalate (PET), et elles nécessitent d'énormes quantités de combustibles fossiles à la fois pour les fabriquer et les transporter. Si vous remplissez une bouteille en plastique avec un liquide de façon à ce qu'il soit plein de 25%, c'est à peu près la quantité d'huile utilisée pour fabriquer la bouteille. Pour un article à usage unique, c'est beaucoup.   \nDe plus, leur utilisation ayant tendance à augmenter dans le monde entier, les efforts de collecte et de recyclage ne parviennent pas à suivre le rythme. Et, une pollution massive en découle…De plus, le recycler des bouteilles en plastique ne suit pas le nombre massif de celles consommées dans le monde entier : ainsi, plus de la moitié ne sont pas recyclées. Elles finissent par stagner dans les décharges, en propageant des produits chimiques dangereux dans le sol. "),
      Tile(
          id: 23,
          name:
              "Consommation mondiale d'uranium par les centrales nucléaires (en kg)",
          categorie: Categorie(Names.energie),
          counter: 0,
          increment: 2.2,
          description:
              "70 000 tonnes d'uranium ont été consommées par les centrales nucléaires en 2008 (dont une partie provient de stocks militaires recycles)soit 2,2 kilos d'uranium brûlés chaque seconde par les centrales.\n\n \n\nLe nucléaire, seul challenger crédible du charbon ?\n\nDans ce contexte, seul le nucléaire semble pouvoir répondre au défi de répondre au besoin d’énergie dans les volumes nécessaires. D'où les doutes de certains écolo. On connaît les inconvénients du nucléaire (stockage de déchets radioactifs pendant des milliers d’années, etc.) mais on se souvient moins bien de ses avantages :\nChaque kWh nucléaire produit émet près de 50 fois moins de C02 que celui produit avec du charbon,\nLe nucléaire est la seule technologie capable de produire de l’énergie à forte puissance de manière continue avec aussi peu d’émission de gaz à effet de serre.\nLa part du prix du combustible – l’uranium – ne représente que 5% du prix du kWh\nLes réserves d’uranium sont estimées à plus de 5 siècles et les générateurs nucléaires de 4ème génération, à surgénération, sont capables de mieux recycler les déchets et surtout produisent 50 fois plus d’électricité avec la même quantité d’uranium.\n\nEmissions de CO2 par type d’énergie\n\nLes émissions du nucléaire sont très faibles, proches de celles de l’éolien et bien loin du charbon qui est la forme d’énergie qui émet le plus de dioxyde de carbone. En fait ce sont les émissions qui sont enregistrées pendant la construction des centrales qui sont mesurées ; la production en elle-même étant neutre.\nNucléaire : 19 kg équivalent carbone par tonne équivalent pétrole\nEolien : 32 équivalent carbone par tonnes équivalent pétrole\nSolaire photovoltaïque : 316 équivalent carbone par tonne équivalent pétrole\nGaz Naturel : 651 kg équivalent carbone par tep\nPétrole - essence : 830 kg équivalent carbone par tep\nDiesel - fioul : 856 kg équivalent carbone par tep\nCharbon : 1123 kg équivalent carbone par tep"),
      Tile(
          id: 28,
          name: "Production de déchets dans le monde(en tonnes)",
          categorie: Categorie(Names.dechet),
          counter: 0,
          increment: 103,
          description:
              "Difficile à estimer, ce chiffre varie de 3.400 à 4.000 milliards de tonnes par an, soit de 80 à 126 tonnes de déchets générés chaque seconde ! Chaque jour, l'activité humaine produit environ plus de 10 milliards de kilos de déchets. Le flou entourant les chiffres des déchets toxiques ou dangereux (solvants, ....) est important. Entre 2008 et 2020 la quantité de déchets devrait augmenter de 40% dans le monde."),
      Tile(
          id: 4,
          name: "Pêche mondiale de thon rouge(en kg)",
          categorie: Categorie(Names.faune),
          counter: 0,
          increment: 3.2,
          description:
              "La CICTA (Commission internationale pour la conservation des thonides de l'Atlantique) a annoncé que le quota de la pêche au thon rouge passera de 22 000 tonnes en 2009 à 13 500 tonnes en 2010.\n\nLa Commission internationale pour la conservation des thonidés (ICCAT), lors deson assemblée générale annuelle, a adopté un quota de pêche de 13 500 tonnes contre 22 000 tonnes en 2009 et 28 500 en 2008. La commission est  vivement critiquéepour ne pas assez défendre l'inscription de l’espèce sur l’une des annexes de la CITES défendue par plusieurs pays européens, qui interdira tout commerce international.\n\nLa biomasse du thon rouge en Méditerranée était estimée à moins de 150.000 tonnes en 2000. Grâce à la politique de quotas mis en place par l’Union Européenne, elle était revenue à 535.000 tonnes en 2014. Un succès fragile qui pourrait être mis à mal dès 2015 par l'augmentation de 20% des quotas de pêche."),
      Tile(
          id: 9,
          name: "Coût des espèces invasives en Europe (en €)",
          categorie: Categorie(Names.flore),
          counter: 0,
          increment: 381,
          description:
              "Le coût des plantes invasives ou plantes envahissantes dans l'Union européenne représente 12 milliards d'euros par an.\nL'ambroisie est une des plantes envahissantes les plus connues en France\n\nUne nouvelle proposition de loi vient a été déposée (N° 2340) en novembre 2014\n- Le texte de la loi s'élargit non seulement aux espèces du genre ambroisie mais également à d'autres espèces, végétales ou animales (chenille processionnaire du pin et du chêne, papillon de cendres) dont la prolifération est nuisible à la santé humaine.\nUn texte élaboré en concertation avec toutes les parties prenantes de la lutte contre les plantes invasives\nTous impliqués dans la lutte : gestionnaires d'espaces verts et de chantiers, agriculteurs, jardiniers amateurs, collectivités locales, Régions, Etat...\n\nUne réponse efficace aux plantes invasives qui représente un vrai casse-tête et dont le coût économique est un gouffre (le coût de la gestion des plantes envahissantes est estimé à 12 milliards d'euros par an à l'échelle de l'Union Européen."),
      Tile(
          id: 14,
          name: "Coût du réchauffement climatique dans le monde (en €)",
          categorie: Categorie(Names.rechauffement),
          counter: 0,
          increment: 2850,
          description:
              "Le réchauffement climatique est responsable de 300.000 morts par an et coute 90 milliards d'euros (125 milliards de dollars) chaque année soit plus de 2850 euros chaque seconde (compteur), selon un rapport publié par le Forum humanitaire mondial de mai 2009.\n Selon ce rapport, vers 2030, les décès au réchauffement atteindront près d'un million par an !\n\nl y a plus de 20 ans, de nombreux scientifiques s’interrogeaient sur l’existence ou non d’un «réchauffement climatique» avéré.\n\n Les observations et mesures effectuées ces dernières années ont levé le doute sur la question :\n-Les observations attestent que treize des quinze dernières années (1995-2008) figurent parmi les années les plus chaudes jamais enregistrées depuis que les températures de la surface du globe sont mesurées (1850). Au cours des cent dernières années (1906-2005), la température moyenne de la planète a augmenté de 0,74°C. Le niveau moyen des mers a augmenté de 17 cm au cours du vingtième siècle.\n-Augmentation lente, supérieure à 0,6°C en un siècle, des températures moyennes enregistrées par les stations météorologiques du monde entier, diminution de l’étendue et de l’épaisseur de la banquise arctique, recul des glaciers, hausse significative du niveau de la mer, autant d’indices sont venus confirmer la réalité du réchauffement climatique."),
      Tile(
          id: 19,
          name: "Consommation d'eau de Javel en France (en L)",
          categorie: Categorie(Names.pollution),
          counter: 0,
          increment: 7.2,
          description:
              "Combien d'eau de Javel en France ?\n245 millions de litres d'eau de javel /an commercialisés en France, en grand public. Cela représente 2 fois le volume des nettoyants ménagers et 3 fois le volume des liquides vaisselle.\n\nLa consommation d'eau de javel en France\nLa France est au 2ème rang de la consommation européenne en volume derrière l'Espagne et juste devant l'Italie (environ 220 millions de litres/an).\n\nEn France, il se vend environ 245 millions de litres/an en grand public (ce qui représente deux fois le volume des nettoyants ménagers et trois fois le volume des liquides vaisselle).\n\nEn France, 7 ménagères sur 10 utilisent de l’Eau de Javel.\nLa France est au 2ème rang de la consommation européenne d'eau de javel (en volume) derrière l'Espagne et juste devant l'Italie.\nLa France est au 5ème rang de la consommation mondiale d'eau de javel (en volume) derrière : les USA (700 millions de litres/an), le Mexique (600 millions de litres/an), l'Espagne (400 millions de litres/an) et le Brésil (350 millions de litres/an)."),
      Tile(
          id: 24,
          name: "Secteur solaire mondial (en €)",
          categorie: Categorie(Names.energie),
          counter: 0,
          increment: 792,
          description:
              "Chaque année environ 792 euros par seconde vont au marché du solaire dans le monde. Au total, le chiffre d'affaires du secteur solaire se chiffre à 25.000.000.000 d'euros par an.  \n\n Le marché de l'énergie solaire est estimé à 25 000 000 000 d'euros\n\n90 % des panneaux solaires installés en France viendraient de Chine\n\n20 %de l'énergie électrique en Europe devrait être produite à partir de sources renouvelables en 2020\n\nL'Allemagne est le premier producteur mondial d'électricité solaire mais aussi de panneaux photovoltaïques. Néanmoins, la Chine arrive sur les autres marchés avec des panneaux certes moins chers mais dont la fiabilité n'a pas encore été prouvée.\n\nDe plus, en avril 2012, l'entreprise allemande Q-Cells, qui était autrefois le leader mondial dans la production de cellules photovoltaïques a déposé le bilan et depuis, a déstabilisé le marché européen de l'énergie renouvelable          "),
      Tile(
          id: 29,
          name: "Nombre de jouets jetés en France",
          categorie: Categorie(Names.dechet),
          counter: 0,
          increment: 1.27,
          description:
              "Les jouets aussi ont une fin de vie : ils finissent dans les armoires ou à la poubelle. 1,27 sont jetés chaque seconde en France, soit 40 millions de jouets jetés chaque année.\n\n Recycler les jouets\n110 000 jouets finiraient chaque jour à la poubelle en France soit 40 millions de jouets jetés chaque année. Un montagne de jouets à recycler !!*\nPas étonnant au vu du nombre de jouets vendus chaque année, ne serait-ce qu'à Noël !  \nPas étonnant car 7 jouets sur 10 ne sont plus utilisés 8 mois après l’achat, * et finissent par dormir dans les armoires et sur les étagères \n\nRevendre ses jouets d'occasion sur internet\n Revendre ses vieux jouets sur internet se pratique de plus en plus : la vente de jouets d'occasion en ligne est en effet une manière d'acheter des jouets pas cher ou bien de récupérer un peu d'argent facilement. Car la demande est forte pour des jouets pas cher, notamment pour des jouets de marque ou des grands classiques comme la poupée Barbie ou les fameux Lego, ou Playmobil.               "),
      Tile(
          id: 5,
          name: "Animaux adoptés à la SPA",
          categorie: Categorie(Names.faune),
          counter: 0,
          increment: 0.0018,
          description:
              "Grâce à l’actionde la SPA, 16 000 chiens et 13 000 chats ont retrouvé un foyer en 2013.\n\nSi la fondation 30 Millions d’amis et la Société protectrice des animaux (SPA) en recueillent un grand nombre sur toutle territoire, elles ne peuvent pas tous les sauver d’une longue errance voire d’une mort certaine.\n\n53% des familles françaises possèdent aujourd'hui un animal de compagnie.\n\nPourtant, chaque année, ce sont des milliers d'animaux, chiens, chats ou NAC (Nouveaux animaux de compagnie) qui sont recueillis dans les SPA de France. Ces animaux sont alors suivis, soignés, avant d'être proposés à l'adoption."),
      Tile(
          id: 10,
          name: "Achats de plantes et végétaux par les Français",
          categorie: Categorie(Names.flore),
          counter: 0,
          increment: 0.02,
          description:
              "Il se vend 635 00 plantes d'intérieur ou d'extérieur en France chaque année pour plus de 3,3 milliards d'euros.\n-Ventes de végétaux d'extérieur :  435 600 unités pour  966 800 €\n-Ventes de végétaux d'intérieur : 128 100 unités pour  1 519 000 €\n-Végétaux pour cimetières et obsèques : 71 300 plantes pour  867 400 €\n\nLes fleuristes sont les canaux de vente privilégiés pour les végétaux d'intérieur avec près de 4 achat sur 10 : près de 75% des dépenses et 60 % des achats sont consacrés à des cadeaux.\nLes  espèces de fleurs les plus achetée sont : l'orchidée, la jacinthe, le cyclman, l'azalée, le bégonia, le kalanchoé, le chrysanthème"),
      Tile(
          id: 15,
          name:
              "Glace perdue par les glaciers de montagne du monde entier(en millions de litres d'eau)",
          categorie: Categorie(Names.rechauffement),
          counter: 0,
          increment: 8.7,
          description:
              "Chaque année, du fait du réchauffement climatique, les glaciers de montagne fondent en moyenne de 275 milliards de tonnes, cela représente l'équivalent d'une fonte de 8,7 millions de litres d'eau chaque seconde (compteur) soit la contenance de 2,3 piscines olympiques)\n\nChaque année, du fait du réchauffement climatique, les glaciers de montagne fondent en moyenne de 275 milliards de tonnes chaque année, cela représente l'équivalent d'une fonte de 8,7 millions de litres d'eau chaque seconde (compteur) soit la contenance de 2,3 piscines olympiques.\nCe chiffre est une moyenne calculée entre les années 1993 et 2009.\n\nL'eau de glace perdue par les glaciers représente l'équivalent de 73 millions de piscines olympiques chaque année, ou encore 2,3 piscines chaque seconde.\n753 000 t de glace sont perdues chaque jour par les glaciers de montagne du monde entier.\n\nLes glaciers de haute-montagne représente 460 000 km2 dans le monde. \nCes réservoirs d'eau douce fondent à une vitesse inégalée. "),
      Tile(
          id: 20,
          name: "Décès dus à la pollution dans le monde",
          categorie: Categorie(Names.pollution),
          counter: 0,
          increment: 0.37,
          description:
              "Selon une nouvelle étude parue dans le magazine scientifique Lancet en octobre 2017, en 2015, 6, 5 millions de personnes seraient mortes à cause de la pollution soient un total de 9 millions de morts si on compte les décès liés à la pollution des sols et de l’eau (1,8 million) et ceux liés à la pollution en milieu professionnel (0,8 million).\n\n9 000 000 de morts dus à la pollution, cela représente 16 % des décès enregistrés dans le monde chaque année, soit 1 sur 6 !\nEn octobre 2017, l’agence européenne pour l’environnement estimait le nombre de décès prématurés en Europe à cause de la pollution atmosphérique à 500 000 morts par an.\n\nLa pollution de l'air est également responsable d'un décès sur 10 dans le monde, un chiffre inquiétant qui montre l'ampleur du problème. Il s'agit du quatrième facteur de risque mortel dans le monde. C'est en Inde et en Chine que le problème semble se poser avec le plus d'acuité.\n\nLa Chine est le pays qui compte le plus de morts prématurés dus à la pollution atmosphérique suivie par l'Inde (621 138 décès) et la Russie (140 851 décès) selon l'étude de Berkeley de 2016."),
      Tile(
          id: 25,
          name: "Production mondiale d'électricité (en Mtep)",
          categorie: Categorie(Names.energie),
          counter: 0,
          increment: 5148,
          description:
              "              Le Mtep ou mégatonne équivalent pétrole est une unité d'énergie qui correspond à un million de tonnes équivalent pétrole soit 41,868 PJ (10 Pcal)\n\nLa production d'électricité dans le monde représente 19 800 Twh, soit 19 800 fois 1000 milliards de watts ! Cela représente 5 148 Mtep et 627 853 881 Wh par seconde (compteur).          \n\n La production mondiale d'électricité\nEn 2011, la production mondiale d'électricité a été estimée à 21.964 TWh, selon l'observatoire des énergies l'Observ'ER. \n\n     Les pays consommateurs d'électricité dans le monde \nEn 2012, les pays quiconsomment le le plus d’électricité dans le monde sont : la Chine (4 281 TWh), ?les États-Unis (3 798 TWh), le Japon (971 TWh), la Russie (878 TWh), l'Inde (804 TWh) et l’Allemagne (535 TWh)    "),
      Tile(
          id: 30,
          name: "Déchets électroniques DEEE produits en France (en kg)",
          categorie: Categorie(Names.dechet),
          counter: 0,
          increment: 45.72,
          description:
              "En 2016, 1,4 million de tonnes de déchets électriques et électroniques DEEE ont été jetés dans les poubelles françaises soit 45,72 kg par seconde (compteur)   \n\n Combien de DEEE en France ?\nEn 2016, 1 400 000 000 kg de déchets électriques et électroniques DEEE ont été jetés dans les poubelles françaises.\nEn 2014, 1 443 000 000 kg de déchets électriques et électroniques DEEE ont été jetés dans les poubelles françaises.\nEn 2013, 1,55 million de tonnes de déchets électriques et électroniques DEEE ont été jetés en France, soit 622 millions d'équipements et 24 kg par personne  \n\n   En France en 2016 ce sont 21,3 kg de déchets électroniques qui sont produits par habitant et par an.\nL’organisme Eco-système, créée en 2006, indique dans son bilan annuel avoir collecté 660 000 t de vieux appareils électriques et électroniques et avoir recyclé 570 000 t : selon cet organisme, cela plaça France en bonne position avec 9 à 10 kg par an et par habitant, tête des grands pays européens, mais derrière la Suisse et les pays scandinaves.\nEn France en 2016, les déchetteries ont collecté 50 % des vieux appareils électriques électroniques et les distributeurs ont collecté 20 % du total.           "),
    ];
    return list;
  }
}
