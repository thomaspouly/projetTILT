import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/login_bloc.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/FirestoreProvider.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';
import 'package:flutter_app/screen/register/register.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

// INITIALISATION

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

final String assetName = 'assets/earth.svg';

final Widget svg = new SvgPicture.asset(assetName, semanticsLabel: 'Acme Logo');

AuthProvider authProvider;
FirestoreProvider firestoreProvider;

// LOGIN PAGE

class MyClassementPage extends StatefulWidget {
  MyClassementPage({Key key, this.title, this.child}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  //LoginBloc bloc;

  String emailError;
  String passwordError;

  final Widget child;

  @override
  _MyClassementPageState createState() => _MyClassementPageState();
}

class _MyClassementPageState extends State<MyClassementPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    //final bloc = BlocProvider.of(context);
    FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(210, 251, 209, 1));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(210, 251, 209, 1),
        body: new Column(children: <Widget>[
          new TextField(
            decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.search), hintText: 'Recherche...'),
          ),
          new Row(
            children: <Widget>[
              Image.asset(
                'assets/cup.png',
              ),
              Text("Chine"),
            ],
          )
        ]),
      ),
    );
  }
}
