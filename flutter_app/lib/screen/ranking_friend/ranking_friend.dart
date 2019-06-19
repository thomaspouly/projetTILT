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

class MyRankingFriendPage extends StatefulWidget {
  MyRankingFriendPage({Key key, this.uid}) : super(key: key);

  String uid;

  @override
  _MyRankingFriendPageState createState() => _MyRankingFriendPageState();
}

class _MyRankingFriendPageState extends State<MyRankingFriendPage> {
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

    Widget _buildTextFields() {
      return Column(
        children: <Widget>[
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
                      return Friends(snapshot.data, snapshot.data.length,true)
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
          title: Text("Classement entre amis"),
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
