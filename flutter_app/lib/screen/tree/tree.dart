import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/NoteForm.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/tree/form.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttie/fluttie.dart';

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
                } else if(double.parse(snapshot.data.note) > 5 && double.parse(snapshot.data.note) <= 6) {
                  return Container(
                    child: FlareActor("assets/flare/tree3.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        animation: "Preview2"),
                  );
                }
                else if(double.parse(snapshot.data.note) > 6 && double.parse(snapshot.data.note) <= 7) {
                  return Container(
                    child: FlareActor("assets/flare/tree2.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        animation: "Preview2"),
                  );
                }
                else if(double.parse(snapshot.data.note) > 7 && double.parse(snapshot.data.note) <= 8) {
                  return Container(
                    child: FlareActor("assets/flare/tree2.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        animation: "Preview2"),
                  );
                }
                else if(double.parse(snapshot.data.note) > 8 && double.parse(snapshot.data.note) <= 9) {
                  return Container(
                    child: FlareActor("assets/flare/tree1.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        animation: "Preview2"),
                  );
                }
                else if(double.parse(snapshot.data.note) > 9 && double.parse(snapshot.data.note) <= 10) {
                  return Container(
                    child: FlareActor("assets/flare/Tree.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        animation: "Preview2"),
                  );
                }
                break;
              case ConnectionState.none :
                break;
            }
          });
    }

    return new SafeArea(
      child: new Scaffold(
        backgroundColor: Colors.cyan[200],
        appBar: AppBar(
          backgroundColor: Colors.green[600],
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
            Center(
                child: Container(
              padding: EdgeInsets.only(top: 0),
              width: heightScreen / 2,
              height: heightScreen / 2,
              child: treeView(),
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(bottom: 25),
                child: RaisedButton(
                  elevation: 5,
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyFormTreePage()),
                    );
                  },
                  child: Text("Formulaire",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEvolution() {
    var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Evolution de votre arbre:"),
          content: Container(
            margin: EdgeInsets.all(20),
            child: Sparkline(
              data: data,
              pointSize: 8,
              lineColor: Colors.blue,
              pointColor: Colors.blue[700],
              pointsMode: PointsMode.all,
            ),
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
}
