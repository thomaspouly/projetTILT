import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/FirestoreProvider.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';
import 'package:flutter_app/screen/home/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

// INITIALISATION

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

final String assetName = 'assets/earth.svg';

final Widget svg = new SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo',
  width: 100,
  height: 100,
  color: Colors.green[300],
);

AuthProvider authProvider;
FirestoreProvider firestoreProvider;

// LOGIN PAGE

class MyProfilPage extends StatefulWidget {
  MyProfilPage({Key key, this.uid}) : super(key: key);

  String uid;

  @override
  _MyProfilPageState createState() => _MyProfilPageState();
}

class _MyProfilPageState extends State<MyProfilPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildImage() {
    Future<String> url = getImage(widget.uid);
    return new Container(
        child: new FutureBuilder<String>(
      future: url,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return CircularProgressIndicator();
          case ConnectionState.active:
            return CircularProgressIndicator();

          case ConnectionState.waiting:
            return CircularProgressIndicator();

          case ConnectionState.done:
            return new FlatButton(
              onPressed: null,
              child: new Container(
                  height: MediaQuery.of(context).size.height / 9,
                  width: MediaQuery.of(context).size.height / 9,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(snapshot.data),
                      ))),
            );
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.ofProfil(context);
    FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(210, 251, 209, 1));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    double padding = 50;

    Widget _buildTextEmailFields() {
      // TODO : VOIR AVEC MAXIME POURQUOI IL MARCHE PAS CE PUTAIN DE FUTURE BUILDER DE MERDE

      return FutureBuilder(
          future: bloc.getUserById(widget.uid),
          builder: (context, AsyncSnapshot<User> snapshot) {
            print("SNAPSHOT ===> " + snapshot.data.toString());
            if (snapshot.hasData) {
              return new Container(
                padding: EdgeInsets.only(left: padding, right: padding),
                child: new Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: new TextFieldCustom(
                    icon: Icon(Icons.email),
                    editable: false,
                    title: snapshot.data.email,
                    hide: false,
                  ),
                ),
              );
            }
          });
    }

    Widget _buildTextNameFields() {
      /*return new FutureBuilder(
          future: bloc.getUserById(widget.uid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print("SNAPSHOT ====>" + snapshot.data.toString());
            if (snapshot.data == null) {
              return Center(
                child: Text(
                  "\n\n\nChargement...",
                  style: TextStyle(fontSize: 30),
                ),
              );
            } else {
              return new Container(
                padding: EdgeInsets.only(left :padding,right:padding),
                child: new Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: new TextFieldCustom(
                    icon: Icon(Icons.nature),
                    editable: false,
                    title: snapshot.data['name'],
                    hide: false,
                  ),
                ),
              );
            }
          });*/
      return Center(
        child: Text(
          "\n\n\nChargement...",
          style: TextStyle(fontSize: 30),
        ),
      );
    }

    Widget _buildTextTreeFields() {
      /*return new FutureBuilder(
          future: bloc.getUserById(widget.uid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print("SNAPSHOT ====>" + snapshot.data.toString());
            if (snapshot.data == null) {
              return Center(
                child: Text(
                  "\n\n\nChargement...",
                  style: TextStyle(fontSize: 30),
                ),
              );
            } else {
              return new Container(
                padding: EdgeInsets.only(left :padding,right:padding),
                child: new Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: new TextFieldCustom(
                    icon: Icon(Icons.nature),
                    editable: false,
                    title: snapshot.data['treeNumber'],
                    hide: false,
                  ),
                ),
              );
            }
          });*/
      return Center(
        child: Text(
          "\n\n\nChargement...",
          style: TextStyle(fontSize: 30),
        ),
      );
    }

    final modify = Material(
      elevation: 5.0,
      color: Color.fromRGBO(32, 168, 30, 1),
      borderRadius: BorderRadius.circular(5),
      child: MaterialButton(
        onPressed: null,
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text("Modifier",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: Stack(
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildImage(),
                    _buildTextNameFields(),
                    _buildTextEmailFields(),
                    _buildTextTreeFields(),
                    modify,
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
