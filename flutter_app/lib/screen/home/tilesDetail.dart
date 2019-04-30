import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Categorie.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class TileDetail extends StatefulWidget {
  IconData iconData;
  int idCard;
  String title;
  String description;
  Categorie categorie;
  Color textColor = Colors.white;
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

  TileDetail(
      this.idCard, this.iconData, this.title, this.description, this.categorie);

  @override
  State<StatefulWidget> createState() => new _TileDetailState();
}

class _TileDetailState extends State<TileDetail> {
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
          body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              widget.title,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            backgroundColor: widget.categorie.color,
            floating: true,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Hero(
                    tag: 'icon_${widget.idCard}',
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        widget.iconData,
                        color: widget.categorie.colorLogo,
                        size: 100,
                      ),
                    ),
                  ),
                ),
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
                  AutoSizeText(
                    widget.description,
                    style: TextStyle(color: widget.textColor),
                  ),
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
                    widget.categorie.conseils,
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
