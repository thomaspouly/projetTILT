import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class TuilePage extends StatefulWidget {
  Color color;
  IconData iconData;
  String idCard;
  String title;
  String value;
  Color textColor = Colors.white;
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

  TuilePage({this.idCard, this.color, this.iconData, this.title, this.value});

  @override
  State<StatefulWidget> createState() => new _TuilePageState();
}

class _TuilePageState extends State<TuilePage> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.green);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return new SafeArea(
      child: new Scaffold(
          body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              widget.title,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            backgroundColor: widget.color,
            floating: true,
            expandedHeight: 170,
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(
              children: <Widget>[
                Hero(
                  tag: 'icon_${widget.idCard}',
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      widget.iconData,
                      color: Colors.black,
                      size: 150,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.value,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            )),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: Card(
                child: Column(children: <Widget>[
                  Text("Description:\n",
                      style: TextStyle(
                          color: widget.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  Text(
                    "Le développement mobile cross-platforms n’a jamais vraiment convaincu : amenant souvent de lourdes contraintes qui entachent la productivité ou l’expérience utilisateur. Mais Google a repensé cette approche et propose une solution qui fait beaucoup parler. Nous verrons ensemble pourquoi il faut prêter une attention particulière à cette technologie.",
                    style: TextStyle(color: widget.textColor),
                  )
                ]),
                color: Colors.red,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: Card(
                child: Column(children: <Widget>[
                  Text("Tendance:",
                      style: TextStyle(
                          color: widget.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Sparkline(
                      data: widget.data,
                      pointSize: 8,
                      lineColor: Colors.blue,
                      pointColor: Colors.blue[700],
                      pointsMode: PointsMode.all,
                    ),
                  ),
                ]),
                color: Colors.yellow[600],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: Card(
                child: Column(children: <Widget>[
                  Text("Conseils:\n",
                      style: TextStyle(
                          color: widget.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  Text(
                    "-Prenez des douches plus courtes\n-Ne prenez pas de bains\n-Fabriquez un récupérateur d'eau pour alimenter vos plantes",
                    style: TextStyle(color: widget.textColor),
                  )
                ]),
                color: Colors.green,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
