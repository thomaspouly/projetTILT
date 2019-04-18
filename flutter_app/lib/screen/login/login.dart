import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/login_bloc.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/FirestoreProvider.dart';
import 'package:flutter_app/provider/login_bloc_provider.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';
import 'package:flutter_app/screen/register/register.dart';
import 'package:flutter_svg/flutter_svg.dart';

// INITIALISATION

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

final String assetName = 'assets/earth.svg';
final String chaiseName = 'assets/chaise.svg';
final String tableName = 'assets/table.svg';
final Widget svg = new SvgPicture.asset(assetName, semanticsLabel: 'Acme Logo');

final Widget chaise =
    new SvgPicture.asset(chaiseName, semanticsLabel: 'Acme Logo');

final Widget table =
    new SvgPicture.asset(tableName, semanticsLabel: 'Acme Logo');

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
  String _email;
  String _password;

  _MyLoginPageState() {
    emailFieldController.addListener(_emailListen);
    passFieldController.addListener(_passwordListen);
  }

  void _emailListen() {
    if (emailFieldController.text.isEmpty) {
      _email = "";
    } else {
      _email = emailFieldController.text;
    }
  }

  void _passwordListen() {
    if (passFieldController.text.isEmpty) {
      _password = "";
    } else {
      _password = passFieldController.text;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Detache le controller quand tout est fini
    emailFieldController.dispose();
    passFieldController.dispose();
    super.dispose();
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Invalide email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);

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
      color: Color.fromRGBO(32, 168, 30, 1),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (bloc.submit(
                  emailFieldController.text, passFieldController.text) !=
              null) {
            if (authProvider != null) {
              try{
                authProvider
                    .authenticateUser(emailFieldController.text, passFieldController.text)
                    .then((userId) {
                        new FutureBuilder(
                            future: firestoreProvider.getUserById(userId),
                            builder: (BuildContext context, snapshot) {
                              //AsyncSnapShot User
                              //print("EMAIL ======> " + snapshot.data['email']);
                              //print("NAME =======> " + snapshot.data['name']);
                              //print(snapshot.data['treeNumber']);
                            });

                })
                /*
                .catchError((onError) {
                  print("en erreur");
                  setState(() {
                    widget.emailError = onError.toString();
                  });
                  print("error $onError");
                })
                */;
              } catch (e) {
                print("bouhouuuuu");
                print(e.toString());
              }

            }
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
                widget.emailError = "Invalide Email";
              });
            } else if (passFieldController.text.length < 6) {
              setState(() {
                widget.passwordError = "Password too short";
              });
            }
          }
        },
        child: Text("Login",
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
          color: Color.fromRGBO(32, 168, 30, 1),
        ),
      ),
      onPressed:
      register,
    );

    final _forgot = MaterialButton(
      padding: EdgeInsets.all(0),
      child: Text(
        "Forgot password ?",
        textAlign: TextAlign.end,
        style: TextStyle(
          color: Color.fromRGBO(32, 168, 30, 1),
        ),
      ),
      onPressed: () {
        _showDialog();
      },
    );

    final _continue = MaterialButton(
        child: Text(
      "Continuer en tant qu'invité",
      style: TextStyle(
        color: Color.fromRGBO(32, 168, 30, 1),
      ),
    ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(210, 251, 209, 1),
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 36, right: 36, top: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                svg,
                emailField,
                Column(
                  children: <Widget>[
                    passwordField,
                    Row(children: <Widget>[
                      Expanded(
                          child: Align(
                        alignment: Alignment.topRight,
                        child: _forgot,
                      )),
                    ]),
                  ],
                ),
                Column(
                  children: <Widget>[
                    loginButon,
                    Row(children: <Widget>[
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerRight,
                        child: _register,
                      )),
                    ]),
                  ],
                ),
                _continue,
              ],
            ),
          ),
        ),
      ),
    );
  }
}