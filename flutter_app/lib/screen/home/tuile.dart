import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/bloc/register_bloc.dart';
import 'package:flutter_app/screen/customs/fab.dart';
import 'package:flutter_app/screen/customs/staggeredView.dart';

import 'package:flutter_app/provider/login_bloc_provider.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class TuilePage extends StatefulWidget {
  /*String uid;
  TuilePage({this.uid});
*/
  @override
  State<StatefulWidget> createState() => new _TuilePageState();
}

class _TuilePageState extends State<TuilePage> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.grey);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return new SafeArea(
      child: new Scaffold(
          body: ListView(
            shrinkWrap: true,
            
        children: <Widget>[
          Container(
                height: 300,
                child:Card(
               
                  color: Colors.red,
                  child: new Stack(children: <Widget>[
        Positioned(
            top: 30,
            left: 100,
             child: Hero(
              tag: "icon",
               child:  Icon(
                          
                      Icons.nature,
                      color: Colors.white,
                      size: 100,
                    ),),),
                   Positioned(
                     
                    
                      child: Text(
                        "Eau gaspillée",
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                   Positioned(
                     top:50,
                     
                        child: Text(
                          "1 659 643 L",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ))
                  ]))),



             Container(
                height: 200,
                child:Card(
               
            child: Column(children: <Widget>[
              Text("Description:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              Text(
                  "Le développement mobile cross-platforms n’a jamais vraiment convaincu : amenant souvent de lourdes contraintes qui entachent la productivité ou l’expérience utilisateur. Mais Google a repensé cette approche et propose une solution qui fait beaucoup parler. Nous verrons ensemble pourquoi il faut prêter une attention particulière à cette technologie.")
            ]),
            color: Colors.yellow,
          ),),
          Container(
                height: 300,
                child:Card(
               
            child: Column(children: <Widget>[
              Text("Tendance:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              Text("METTRE GRAPH")
            ]),
            color: Colors.yellow[600],
          ),),
         Container(
                height: 200,
                child:Card(
               
            child: Column(children: <Widget>[
              Text("Conseils:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              Text(
                  "-Prenez des douches plus courtes\n-Ne prenez pas de bains\n-Fabriquez un récupérateur d'eau pour alimenter vos plantes")
            ]),
            color: Colors.yellow,
          ),),
        ],
      )),
    );
  }
}
