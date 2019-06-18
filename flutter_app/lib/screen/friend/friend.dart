import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/FirestoreProvider.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/customs/Friends.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';
import 'package:flutter_app/screen/home/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// INITIALISATION

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

class MyFriendPage extends StatefulWidget {
  MyFriendPage({Key key, this.uid}) : super(key: key);

  String uid;

  @override
  _MyFriendPageState createState() => _MyFriendPageState();
}

class _MyFriendPageState extends State<MyFriendPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.ofFriend(context);
    FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(210, 251, 209, 1));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    double padding = 50;
    TextEditingController addController = TextEditingController();

    Widget _buildTextFields() {
      var addFriend = new TextFieldCustom(
        icon: Icon(Icons.person_outline),
        title: "Ajouter un amis, entrez son email",
        hide: false,
        controller: addController,
      );
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 30),
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 7,
                right: MediaQuery.of(context).size.width / 7),
            child: addFriend,
          ),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 7,
                right: MediaQuery.of(context).size.width / 7),
            child: Material(
              elevation: 5.0,
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5),
              child: MaterialButton(
                onPressed: () {
                  bloc.addUserInFriendList(addFriend.controller.text);
                },
                minWidth: MediaQuery.of(context).size.width,
                child: AutoSizeText("Enregistrer les modifications",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top : 30,bottom:20),
            child: Text("Votre liste d'amis"),
          ),
          Container(
            child: FutureBuilder(
                future: bloc.getAllFriend(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      return Text("Active");
                      break;
                    case ConnectionState.done:
                      //print("List ===>" + snapshot.data.toString());
                      return Friends(snapshot.data, snapshot.data.length)
                          .build(context);
                      break;
                    case ConnectionState.none:
                      return Text("None");
                      break;
                    case ConnectionState.waiting:
                      return Text("Waiting");
                      break;
                  }
                }),
            padding: EdgeInsets.only(bottom: 20),
          ),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ajouter un ami"),
        ),
        body: Container(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: ListView(children: <Widget>[
            _buildTextFields(),
          ]),
        ),
      ),
    );
  }
}
