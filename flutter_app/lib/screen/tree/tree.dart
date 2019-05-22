import 'package:auto_size_text/auto_size_text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/NoteForm.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';
import 'package:flutter_app/screen/tree/form.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_svg/svg.dart';

import 'linky.dart';

final String sproutName = 'assets/sprout.svg';
final String appleName = 'assets/apple.svg';

final Widget sproutWidget = new SvgPicture.asset(
  sproutName,
  semanticsLabel: 'Acme Logo',
  width: 300,
  height: 400,
  color: Colors.green[900],
);

class TreePage extends StatefulWidget {
  String uid;

  TreePage({this.uid});

  @override
  State<StatefulWidget> createState() {
    return new _TreePageState();
  }
}

class _TreePageState extends State<TreePage> {
  var heightScreen;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.ofFormTree(context);
    heightScreen = MediaQuery.of(context).size.height;

    final Widget appleWidget = new SvgPicture.asset(
      appleName,
      semanticsLabel: 'Acme Logo',
      width: 50,
      height: 50,
      color: Theme.of(context).primaryColor,
    );

    Widget treeView() {
      // TODO : demander a Maxime pourquoi ça fonctionne pas
      return new FutureBuilder(
          future: bloc.getNote(),
          builder: (context, AsyncSnapshot<NoteForm> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return Text("Active .....");
                break;
              case ConnectionState.waiting:
                return Text("Chargement .....");
                break;
              case ConnectionState.done:
                if (double.parse(snapshot.data.note) < 5) {
                  return sproutWidget;
                } else if (double.parse(snapshot.data.note) == 5) {
                  return Container(
                    child: FlareActor("assets/flare/tree3.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        animation: "Preview2"),
                  );
                } else if (double.parse(snapshot.data.note) > 5 &&
                    double.parse(snapshot.data.note) <= 6) {
                  return Container(
                    child: FlareActor("assets/flare/tree3.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        animation: "Preview2"),
                  );
                } else if (double.parse(snapshot.data.note) > 6 &&
                    double.parse(snapshot.data.note) <= 7) {
                  return Container(
                    child: FlareActor("assets/flare/tree2.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        animation: "Preview2"),
                  );
                } else if (double.parse(snapshot.data.note) > 7 &&
                    double.parse(snapshot.data.note) <= 8) {
                  return Container(
                    child: FlareActor("assets/flare/tree2.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        animation: "Preview2"),
                  );
                } else if (double.parse(snapshot.data.note) > 8 &&
                    double.parse(snapshot.data.note) <= 9) {
                  return Container(
                    child: FlareActor("assets/flare/tree1.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        animation: "Preview2"),
                  );
                } else if (double.parse(snapshot.data.note) > 9 &&
                    double.parse(snapshot.data.note) <= 10) {
                  return Container(
                    child: FlareActor("assets/flare/Tree.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        animation: "Preview2"),
                  );
                }
                break;
              case ConnectionState.none:
                break;
            }
          });
    }

    return new SafeArea(
      child: new Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 3,
          centerTitle: true,
          title: Text("Votre arbre"),
        ),
        body: Stack(
          children: <Widget>[
            FlareActor("assets/flare/paysage.flr",
                alignment: Alignment.center,
                fit: BoxFit.fill,
                animation: "Preview2"),
            new FutureBuilder(
                future: bloc.getUserById(widget.uid),
                builder: (context, AsyncSnapshot<User> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        color: Colors.white12,
                        width: 120,
                        height: 60,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 1.25),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 50, height: 50, child: appleWidget),
                            Container(
                              padding: EdgeInsets.only(top: 15),
                              child: AutoSizeText(
                                snapshot.data.nbPomme.toString(),
                                style: TextStyle(fontSize: 35),
                                minFontSize: 12,
                              ),
                            ),
                          ],
                        ));
                  } else {
                    return Text("Chargement");
                  }
                }),
            Center(
                child: Container(
              padding: EdgeInsets.only(top: 0),
              width: heightScreen / 2,
              height: heightScreen / 2,
              child: treeView(),
            )),
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 25),
                    child: RaisedButton(
                      elevation: 5,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyFormTreePage()),
                        );
                      },
                      child: Text("Formulaire",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 25),
                    child: RaisedButton(
                      elevation: 5,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Linky()),
                        );
                      },
                      child: Text("Linky",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                ],
              ),
              alignment: Alignment.bottomCenter,
            )
          ],
        ),
      ),
    );
  }
}
