import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/login_bloc_provider.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';

AuthProvider authProvider;

class ForgotPage extends StatefulWidget {
  ForgotPage({Key key}) : super(key: key);

  String emailError;

  @override
  State<StatefulWidget> createState() => new _ForgotPageState();
}

// Used for controlling whether the user is loggin or creating an account

class _ForgotPageState extends State<ForgotPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final emailFieldController = TextEditingController();
  String _email;
  String _password;

  _ForgotPageState() {
    emailFieldController.addListener(_emailListen);
  }

  void _emailListen() {
    if (emailFieldController.text.isEmpty) {
      _email = "";
    } else {
      _email = emailFieldController.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);

    final loginButon = Material(
      elevation: 5.0,
      color: Color.fromRGBO(32, 168, 30, 1),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (bloc.submitWithEmail(emailFieldController.text) != null) {
            if (authProvider != null) {
              authProvider.resetPasswordUser(emailFieldController.text);
            }
          }
        },
        child: Text("Reset password",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: Text("Reset password"),
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: SafeArea(
          child: new ListView(
            children: <Widget>[
              _buildTextFields(),
              loginButon,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: new TextFieldCustom(
              controller: emailFieldController,
              icon: Icon(Icons.email),
              title: 'Email',
              hide: false,
            ),
          ),
        ],
      ),
    );
  }
}
