import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';
import 'package:flutter_app/screen/home/home.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_app/bloc/register_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_crop/image_crop.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class RegisterPage extends StatefulWidget {
  var _colorTree1 = Colors.green[200];
  var _colorTree2 = Colors.green[200];
  var _colorTree3 = Colors.green[200];

  String emailError;
  String passwordError;
  String nameError;

  RegisterPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _RegisterPageState();

  static RegisterBloc ofRegi(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .registerBloc;
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameFilter = new TextEditingController();
  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  RegisterBloc _bloc;

  String _name = "";
  String _email = "";
  String _password = "";
  bool _booleanCheckBox = false;
  int _treeNumber = -1;
  String _textError = "";

  File _image;

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

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    image = await ImageCropper.cropImage(
      sourcePath: image.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );
    setState(() {
      _image = image;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    image = await ImageCropper.cropImage(
      sourcePath: image.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );
    setState(() {
      _image = image;
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Selectionnez une image:"),
          content: Column(
            children: <Widget>[
              new RaisedButton(
                onPressed: () {
                  getImageFromCamera();
                  Navigator.of(context).pop();
                },
                child: Text("Camera"),
              ),
              new RaisedButton(
                onPressed: () async {
                  getImageFromGallery();
                  Navigator.of(context).pop();
                },
                child: Text("Galerie"),
              )
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


 void _showCGU() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Conditions générales d'utilisation:"),
          content: Center(
            child:Text("Hello World")
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.ofRegister(context);
       FlutterStatusbarcolor.setStatusBarColor(Colors.green[100]);
       FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.only(right: 15, left: 15),
        child: SafeArea(
          child: new ListView(
            children: <Widget>[
              new Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 15, top: 15),
                  child: Text("Inscription", style: TextStyle(fontSize: 30)),
                ),
              ),
              _buildImage(),
              _buildTextFields(),
              _selectArbre(),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(bottom: 15),
            child: _image == null
                ? new Column(children: <Widget>[
                    new FlatButton(
                      onPressed: _showDialog,
                      child: new Container(
                          height: 100,
                          width: 100,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/avatar.png"),
                              ))),
                    ),
              Text("Choisissez une image"),
                  ])
                : new FlatButton(
                    onPressed: _showDialog,
                    child: new Container(
                        height: 100,
                        width: 100,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: Image.file(_image).image,
                            ))),
                  ),
          ),
        ]);
  }

  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
              margin: EdgeInsets.only(bottom: 30),
              child: new TextFieldCustom(
                  controller: _nameFilter,
                  title: 'Nom',
                  icon: Icon(Icons.person),
                  hide: false,
                  textError: widget.nameError)),
          new Container(
              margin: EdgeInsets.only(top: 10, bottom: 30),
              child: new TextFieldCustom(
                controller: _emailFilter,
                title: 'Email',
                icon: Icon(Icons.email),
                hide: false,
                textError: widget.emailError,
              )),
          new Container(
              margin: EdgeInsets.only(top: 10, bottom: 30),
              child: new TextFieldCustom(
                controller: _passwordFilter,
                title: 'Mot de Passe',
                icon: Icon(Icons.lock),
                hide: true,
                textError: widget.passwordError,
              )),
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
      margin: EdgeInsets.only(top: 10, bottom: 10),
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
                  widget._colorTree1 = Colors.green[400];
                  widget._colorTree2 = Colors.green[200];
                  widget._colorTree3 = Colors.green[200];
                  _treeNumber = 1;
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
                  widget._colorTree1 = Colors.green[200];
                  widget._colorTree2 = Colors.green[400];
                  widget._colorTree3 = Colors.green[200];
                  _treeNumber = 2;
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
                  widget._colorTree1 = Colors.green[200];
                  widget._colorTree2 = Colors.green[200];
                  widget._colorTree3 = Colors.green[400];
                  _treeNumber = 3;
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
                child: FlatButton(child: Text("Accepter les CGU"),onPressed: (){
                _showCGU();
              },),
              ),
               
            ],
          ),
          new Container(
            child: new RaisedButton(
              child: new Text('Inscription'),
              padding: EdgeInsets.only(left: 40, right: 40),
              color: Colors.green[200],
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              onPressed: () {
                _loginPressed();
              },
            ),
          )
        ],
      ),
    );
  }


  void _loginPressed() async {
    if (_nameFilter.text.isEmpty) {
      setState(() {
        widget.nameError = "Veuillez remplir tout les champs";
      });
    } else if (_emailFilter.text.isEmpty) {
      setState(() {
        widget.emailError = "Veuillez remplir tout les champs";
      });
    } else if (_passwordFilter.text.isEmpty) {
      setState(() {
        widget.passwordError = "Veuillez remplir tout les champs";
      });
    } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailFilter.text)) {
      setState(() {
        widget.emailError = "Email incorrect";
      });
    } else if (_passwordFilter.text.length < 6) {
      setState(() {
        widget.passwordError =
            "Le mot de passe doit faire au moins 6 caractères";
      });
    } else if (_booleanCheckBox == false) {
      setState(() {
        _textError = "Veuillez accepter les CGU";
      });
    } else if (_treeNumber < 0) {
      setState(() {
        _textError = "Veuillez selectionner un arbre";
      });
    } else if (_image==null) {
      setState(() {
      //  _image =new File("avatar.png");
      });
    } else {
      setState(() {
        _textError = "";
      });

      try {} catch (e) {
        print(e.toString());
      }



_image = await ImageCrop.sampleImage(
    file: _image,
    preferredWidth: 100,
    preferredHeight: 100,
);
      String id = await _bloc.registerUser(
          _email, _password, _name, _treeNumber, _image);
      if (id.isNotEmpty) {
        sleep(Duration(seconds: 2));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage(uid: id,)), 
        );
      }
    }
  }
}
