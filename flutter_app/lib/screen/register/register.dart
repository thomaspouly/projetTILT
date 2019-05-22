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
  String emailError;
  String passwordError;
  String passwordError2;
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
  var heightScreen;

  final TextEditingController _nameFilter = new TextEditingController();
  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  final TextEditingController _passwordFilter2 = new TextEditingController();
  RegisterBloc _bloc;

  String _name = "";
  String _email = "";
  String _password = "";
  String _password2 = "";
  bool _booleanCheckBox = false;
  int _treeNumber = -1;
  String _textError = "";

  File _image;

  _RegisterPageState() {
    _nameFilter.addListener(_nameListen);
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
    _passwordFilter2.addListener(_passwordListen2);
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

  void _passwordListen2() {
    if (_passwordFilter2.text.isEmpty) {
      _password2 = "";
    } else {
      _password2 = _passwordFilter2.text;
    }
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
     if(image!=null){
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
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null){
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
   
  }

 
  void _showCGU() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Container(
          child: AlertDialog(
            title: new Text("Conditions générales d'utilisation:"),
            content: Center(child: Text("Hello World")),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          height: 200,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    heightScreen = MediaQuery.of(context).size.height;
    _bloc = BlocProvider.ofRegister(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.green[100]);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.only(right: 15, left: 15),
        child: SafeArea(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text("Inscription", style: TextStyle(fontSize: 25)),
              ),
              Container(
                  child: _buildImage(), margin: EdgeInsets.only(bottom: 30)),
              new Column(children: <Widget>[
                _buildTextFields(),
              ]),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return new Container(
      margin: EdgeInsets.only(bottom: 10),
      child: _image == null
          ? new Column(children: <Widget>[
            Container(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: <Widget>[
                      Text("Photo de profil:"),
                       FlatButton(
                   onPressed: () {
                  getImageFromCamera();
                },
                  child:CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(
                            Icons.photo_camera,
                            size: 40,
                          ),
                        ),),
                        
                         FlatButton(
                  onPressed: () async {
                  getImageFromGallery();
                },
                  child: new CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(
                            Icons.photo_library,
                            size: 40,
                          ),
                        ),
                         ),
                    ],
                  ),width: heightScreen,),
            ])
          : Column(children: <Widget>[

           Container(
                  height: 100,
                  width: 100,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: Image.file(_image).image,
                      ))),
                      RaisedButton(
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        color: Theme.of(context).primaryColorLight,
                        child: Text("Changer"),
                        onPressed: (){
                          setState(() {
                            _image=null;
                          });
                        },
                      )
          ],)
          
            
    );
  }

  Widget _buildTextFields() {
    double margin = 30;
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Container(
              width: MediaQuery.of(context).size.width / 2,
              margin: EdgeInsets.only(bottom: margin),
              child: new TextFieldCustom(
                  controller: _nameFilter,
                  title: 'Nom',
                  icon: Icon(Icons.person),
                  hide: false,
                  textError: widget.nameError)),
          new Container(
              width: MediaQuery.of(context).size.width / 2,
              margin: EdgeInsets.only(bottom: margin),
              child: new TextFieldCustom(
                controller: _emailFilter,
                title: 'Email',
                icon: Icon(Icons.email),
                hide: false,
                textError: widget.emailError,
              )),
          new Container(
              width: MediaQuery.of(context).size.width / 2,
              margin: EdgeInsets.only(bottom: margin),
              child: new TextFieldCustom(
                controller: _passwordFilter,
                title: 'Mot de Passe',
                icon: Icon(Icons.lock),
                hide: true,
                textError: widget.passwordError,
              )),
          new Container(
              width: MediaQuery.of(context).size.width / 2,
              margin: EdgeInsets.only(bottom: margin),
              child: new TextFieldCustom(
                controller: _passwordFilter2,
                title: 'Confirmer le mot de passe',
                icon: Icon(Icons.lock),
                hide: true,
                textError: widget.passwordError2,
              )),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Checkbox(
                value: _booleanCheckBox,
                onChanged: _valueChanged,
              ),
              GestureDetector(
                child: FlatButton(
                  child: Text("Accepter les CGU"),
                  onPressed: () {
                    _showCGU();
                  },
                ),
              ),
            ],
          ),
          new Container(
            child: new RaisedButton(
              child: new Text('Inscription'),
              padding: EdgeInsets.only(left: 40, right: 40),
              color: Theme.of(context).primaryColor,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              onPressed: () {
                _registerPressed();
              },
            ),
          )
        ],
      ),
    );
  }

  void _registerPressed() async {
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
    } else if (_passwordFilter.text != _passwordFilter2.text) {
      setState(() {
        widget.passwordError2 = "Les mots de passe sont différents";
      });
    } else if (_booleanCheckBox == false) {
      setState(() {
        _textError = "Veuillez accepter les CGU";
      });
    } else if (_image == null) {
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
      String id = await _bloc.registerUser(_email, _password, _name, 1, _image);
      if (id.isNotEmpty) {
        sleep(Duration(seconds: 2));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    uid: id,
                  )),
        );
      }
    }
  }
}
