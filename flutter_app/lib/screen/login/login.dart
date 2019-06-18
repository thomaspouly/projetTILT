import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/login_bloc.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/FirestoreProvider.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';
import 'package:flutter_app/screen/home/home.dart';
import 'package:flutter_app/screen/register/register.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

// INITIALISATION

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

final String assetName = 'assets/earth.svg';

AuthProvider authProvider;
FirestoreProvider firestoreProvider;

// LOGIN PAGE

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key, this.title, this.child}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  LoginBloc bloc;
  String emailError;
  String passwordError;
  final Widget child;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final emailFieldController = TextEditingController();
  final passFieldController = TextEditingController();

  String email;
  String password;

  var localAuth = new LocalAuthentication();
  bool didAuthenticate = false;
  bool canCheckBiometrics;
  String id;

  _MyLoginPageState() {
    emailFieldController.addListener(_emailListen);
    passFieldController.addListener(_passwordListen);
  }

  void _emailListen() {
    if (emailFieldController.text.isEmpty) {
      email = "";
    } else {
      email = emailFieldController.text;
    }
  }

  void _passwordListen() {
    if (passFieldController.text.isEmpty) {
      password = "";
    } else {
      password = passFieldController.text;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    localAuth.canCheckBiometrics.then((onValue) {
      canCheckBiometrics = onValue;
    });

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        id = prefs.getString("id");
      });
      print("ID: " + id);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Detache le controller quand tout est fini
    emailFieldController.dispose();
    passFieldController.dispose();
    super.dispose();
  }

  bool souvenir = false;

  @override
  Widget build(BuildContext context) {
    final Widget svg = new SvgPicture.asset(
      assetName,
      semanticsLabel: 'Acme Logo',
      width: 100,
      height: 100,
      color: Theme.of(context).primaryColorDark,
    );
    final bloc = BlocProvider.ofLogin(context);
    FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(210, 251, 209, 1));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    final emailField = TextFieldCustom(
      title: "Email",
      controller: emailFieldController,
      icon: Icon(Icons.email),
      hide: false,
      textError: widget.emailError,
    );
    final passwordField = TextFieldCustom(
      title: "Password",
      controller: passFieldController,
      icon: Icon(Icons.lock),
      hide: true,
      textError: widget.passwordError,
    );

    final loginButon = Material(
      elevation: 5.0,
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(5),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (emailFieldController.text.contains(" ")) {
            setState(() {
              widget.emailError = "Un email ne contient pas d'espace";
            });
          } else {
            if (bloc
                    .submit(emailFieldController.text, passFieldController.text)
                    .then((userId) {
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setBool('remember', souvenir);
                    bloc.login(userId, DateTime.now());
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => HomePage(
                                  uid: userId,
                                )));
                  });
                }).catchError((error) {
                  print(error);
                }) !=
                null) {
            } else {
              if (emailFieldController.text.isEmpty) {
                setState(() {
                  widget.emailError = "Veuillez remplir tous les champs";
                });
              } else if (passFieldController.text.isEmpty) {
                setState(() {
                  widget.passwordError = "Veuillez remplir tous les champs";
                });
              } else if (!RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                  .hasMatch(emailFieldController.text)) {
                setState(() {
                  widget.emailError = "Email incorrecte";
                });
              } else if (passFieldController.text.length < 6) {
                setState(() {
                  widget.passwordError = "Password trop court";
                });
              }
            }
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final loginButonFb = Material(
      elevation: 5.0,
      color: Colors.blue,
      borderRadius: BorderRadius.circular(5),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          try {
            bloc.authenticateUserWithFb().then((userID) {
              //print("USER ID ===>" + userID);
              if (souvenir == true) {
                //bloc.login(userID, DateTime.now());
                /*bloc.getUserById(userID).then((user) {
                bloc.getNote().then((note) {
                  if (int.parse(note.note) == 10) {
                    int date = DateTime.now()
                        .difference(DateTime.parse(user.date))
                        .inDays;
                    bloc.enterNbPomme(date);
                  }
                });
              });*/
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => HomePage(
                          uid: userID,
                        )));
              } else {
                /*bloc.getUserById(userID).then((user) {
                bloc.getNote().then((note) {
                  if (int.parse(note.note) == 10) {
                    int date = DateTime.now()
                        .difference(DateTime.parse(user.date))
                        .inDays;
                    bloc.enterNbPomme(date);
                  }
                });
              });*/
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                        uid: userID,
                      )),
                );
              }
            });
          } on Exception catch(e) {
            print(e);
          }

        },
        child: Text("Login with Facebook",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    void register() async {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterPage()),
      );
    }

    Widget _buildTextFields() {
      return new Container(
        child: new Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: new TextFieldCustom(
            controller: emailFieldController,
            icon: Icon(Icons.email),
            title: 'Email',
            hide: false,
          ),
        ),
      );
    }

    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Reset password"),
            content: _buildTextFields(),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Envoyer"),
                onPressed: () {
                  if (bloc.submitWithEmail(emailFieldController.text) != null) {
                    if (authProvider != null) {
                      authProvider.resetPasswordUser(emailFieldController.text);
                    }
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    final _register = MaterialButton(
      padding: EdgeInsets.all(0),
      child: Text(
        "Register",
        textAlign: TextAlign.end,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: register,
    );

    final _forgot = MaterialButton(
      padding: EdgeInsets.all(0),
      child: Text(
        "Forgot password ?",
        textAlign: TextAlign.end,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: () {
        _showDialog();
      },
    );

    final _continue = MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      uid: null,
                    )),
          );
        },
        child: Text(
          "Continuer en tant qu'invité",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ));

    final _fingerprint = MaterialButton(
      padding: EdgeInsets.all(0),
      child: Icon(Icons.fingerprint,size: 50,color:Theme.of(context).primaryColorDark ,),
      onPressed: () {
        try {
          localAuth
              .authenticateWithBiometrics(
                  localizedReason: 'Please authenticate yourself')
              .then((onValue) {
           
           setState(() {
              didAuthenticate = onValue;
           });
           
          });

          if (didAuthenticate) {
            SharedPreferences.getInstance().then((prefs) {
               bloc.login(id, DateTime.now());
              prefs.setBool('remember', souvenir);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => HomePage(
                            uid: id,
                          )));
            });
          }
        } on PlatformException catch (e) {}
      },
    );

    double padding = 20;

    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomPadding: false,
        body: Container(
            padding: EdgeInsets.only(left: padding, right: padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  child: svg,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: emailField,
                  padding: EdgeInsets.only(bottom: 10),
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: passwordField),
                Row(children: <Widget>[
                  Expanded(
                      child: Align(
                    alignment: Alignment.center,
                    child: _forgot,
                  )),
                ]),
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: loginButon),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Checkbox(
                        value: souvenir,
                        onChanged: (bool value) {
                          setState(() {
                            souvenir = value;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 5),
                          child: AutoSizeText(
                            "Se souvenir de moi",
                            minFontSize: 10,
                          )),
                    ]),
                _register,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _continue,
                ),
                id != null && canCheckBiometrics == true
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: _fingerprint,
                      )
                    : Container()
              ],
            )),
      ),
    );
  }
}
