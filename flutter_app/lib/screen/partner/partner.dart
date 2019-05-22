import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/NoteForm.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/customs/Associations.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';
import 'package:flutter_app/screen/tree/form.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_svg/svg.dart';

final String sproutName = 'assets/sprout.svg';
final String treeName = 'assets/tree.svg';

final Widget sproutWidget = new SvgPicture.asset(
  sproutName,
  semanticsLabel: 'Acme Logo',
  width: 300,
  height: 400,
  color: Colors.green[300],
);

final Widget treeWidget = new SvgPicture.asset(
  treeName,
  semanticsLabel: 'Acme Logo',
  width: 300,
  height: 400,
  color: Colors.green[300],
);

class PartnerPage extends StatefulWidget {
  String uid;

  PartnerPage({this.uid});

  @override
  State<StatefulWidget> createState() {
    return new _PartnerPageState();
  }
}

class _PartnerPageState extends State<PartnerPage> {
  final departementFieldController = TextEditingController();

  _PartnerPageState() {
    departementFieldController.addListener(_departementListen);
  }

  String _departement;

  void _departementListen() {
    if (departementFieldController.text.isEmpty) {
      _departement = "";
    } else {
      _departement = departementFieldController.text;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Detache le controller quand tout est fini
    departementFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.ofPartenaire(context);
    int taille = 2;

    Widget getAssociations() {
      //TODO : Bug de FutureBuilder encore voir avec Maxime
      return new FutureBuilder(
          future: bloc.loadAssociations(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text(
                  "\n\n\nChargement...",
                  style: TextStyle(fontSize: 30),
                ),
              );
            } else {
              return Associations(snapshot.data, taille).build(context);
            }
          });
    }

    return new SafeArea(
      child: new Scaffold(
        appBar: AppBar(
         backgroundColor: Theme.of(context).primaryColorDark,
          elevation: 0,
          title: Text("Nos partenaires",
             ),
        ),
        body: Column(
          children: <Widget>[
            getAssociations(),
          ],
        ),
      ),
    );
  }
}
