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
            expandedHeight: MediaQuery.of(context).size.height/6,
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
                        widget.categorie.logo,
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
          child:  Column(
                //mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                 width:MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3,
                child: Card(
                  child: Column(children: <Widget>[
                    AutoSizeText("Description:\n",
                    maxFontSize: 50,
                        style: TextStyle(
                            color: widget.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize:30)),
                    Expanded(
                      child: AutoSizeText(
                        widget.description,

                        style: TextStyle(color: widget.textColor, fontSize:MediaQuery.of(context).size.height/40),
                      ),
                    ),
                  ]),
                  color: Colors.red,
                ),
              ),
              Container(
                 width:MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3,
                child: Card(
                  child: Column(children: <Widget>[
                    Text("Tendance:",
                        style: TextStyle(
                            color: widget.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                    Container(
                      margin: EdgeInsets.all(20),
                     
                      child: Sparkline(fallbackHeight: 100,
                        data: widget.data,
                        pointSize: 8,
                        lineColor: Colors.orange,
                        pointColor: Colors.orange[700],
                        pointsMode: PointsMode.all,
                      ),
                    ),
                  ]),
                  color: Colors.blue,
                ),
              ),
              Container(
                width:MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3,
                child: Card(
                  child: Column(children: <Widget>[
                    AutoSizeText("Conseils:\n",
                        style: TextStyle(
                            color: widget.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                    Expanded(
                        child:  Align(alignment: Alignment.centerLeft,child:AutoSizeText(
                          
                      widget.categorie.conseils,
                      style: TextStyle(color: widget.textColor,
                            fontSize: 30),
                    ))),
                  ]),
                  color: Colors.green,
                ),
              ),
            ],
          ))
        ],
      )),
    );
  }
}
