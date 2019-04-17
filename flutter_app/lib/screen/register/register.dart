import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  var _colorTree1 = Colors.green[200];
  var _colorTree2 = Colors.green[200];
  var _colorTree3 = Colors.green[200];

  RegisterPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _RegisterPageState();
}

// Used for controlling whether the user is loggin or creating an account
enum FormType { login, register }

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameFilter = new TextEditingController();
  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _name = "";
  String _email = "";
  String _password = "";
  bool _booleanCheckBox = false;
  int _threeNumber = -1;
  String _textError = "";
  _RegisterPageState() {
    _nameFilter.addListener(_nameListen);
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _nameListen() {
    if (_nameFilter.text.isEmpty) {
      _name = "";
    } else {
      _name = _nameFilter.text;
    }
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Inscription"),
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: SafeArea(
          child: new ListView(
            children: <Widget>[
              _buildTextFields(),
              _selectArbre(),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    Color colorTextField = Colors.green[100];
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: new TextField(
              controller: _nameFilter,
              decoration: new InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  fillColor: colorTextField,
                  filled: true),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: new TextField(
              controller: _emailFilter,
              decoration: new InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
                fillColor: colorTextField,
                filled: true,
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 10, bottom: 20),
            child: new TextField(
              controller: _passwordFilter,
              decoration: new InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  fillColor: colorTextField,
                  filled: true),
              obscureText: true,
            ),
          ),
          new Container(
            child: new Text("Choississez un arbre:",
                style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }

  Widget _selectArbre() {
    double sizeSquare = 85;
    return new Container(
      margin: EdgeInsets.only(top:10,bottom: 10),
      child: new Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Container(
            width: sizeSquare,
            height: sizeSquare,
            child: RaisedButton(
              child: Icon(Icons.nature),
              color: widget._colorTree1,
              onPressed: () {
                setState(() {
                  widget._colorTree1=Colors.green[400];
                  widget._colorTree2=Colors.green[200];
                  widget._colorTree3=Colors.green[200];
                  _threeNumber = 1;
                });
              },
            ),
          ),


          new Container(
            width: sizeSquare,
            height: sizeSquare,
            child: RaisedButton(
              child: Icon(Icons.nature),
              color: widget._colorTree2,
              onPressed: () {
                setState(() {
                  widget._colorTree1=Colors.green[200];
                  widget._colorTree2=Colors.green[400];
                  widget._colorTree3=Colors.green[200];
                  _threeNumber = 2;
                });
              },
            ),
          ),


          new Container(
            width: sizeSquare,
            height: sizeSquare,
            child: RaisedButton(

              color: widget._colorTree3,
              child: Icon(Icons.nature),
              onPressed: () {
                setState(() {
                  widget._colorTree1=Colors.green[200];
                  widget._colorTree2=Colors.green[200];
                  widget._colorTree3=Colors.green[400];
                  _threeNumber = 3;
                });

              },
            ),
          ),


        ],
      ),
    );
  }

  void _valueChanged(bool value) => setState(() => _booleanCheckBox = value);

  Widget _buildButtons() {
    return new Container(
      child: new Column(
        children: <Widget>[
          Text(
            _textError,
            style: TextStyle(fontSize: 12, color: Colors.red),
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: _booleanCheckBox,
                onChanged: _valueChanged,
              ),
              GestureDetector(
                // onTap: () => _setAgreedToTOS(!_agreedToTOS),
                child: const Text(
                  'Accepter les CGU',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          new Container(
            child: new RaisedButton(
              child: new Text('Inscription'),
              padding: EdgeInsets.only(left: 40,right: 40),
              color: Colors.green[200],
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              onPressed: _loginPressed,
            ),
          )
        ],
      ),
    );
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed() async {
    if (_booleanCheckBox == false) {
      setState(() {
        _textError = "Veuillez accepter les CGU";
      });
    } else if (_threeNumber < 0) {
      setState(() {
        _textError = "Veuillez selectionner un arbre";
      });
    } else if (_password.length < 7) {
      setState(() {
        _textError = "Le mot de passe doit faire au moins 6 caractères";
      });
    } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email)) {
      setState(() {
        _textError = "Email incorrect";
      });
    } else if (_name.isEmpty || _email.isEmpty || _password.isEmpty) {
      setState(() {
        _textError = "Veuillez remplir tout les champs";
      });
    } else {
      setState(() {
        _textError = "";
      });
      FirebaseUser user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      Firestore.instance.collection('user').document(user.uid).setData({
        'name': _name,
        'email': _email,
        'numArbre': _threeNumber,
      });
    }
  }
}