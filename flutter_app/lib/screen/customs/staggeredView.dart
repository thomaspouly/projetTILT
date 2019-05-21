import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/counter_bloc.dart';
import 'package:flutter_app/models/Categorie.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:flip_card/flip_card.dart';

class StaggeredView extends StatefulWidget {
  final IconData iconData;
  final String title;
  final int id;
  final String description;
  final Categorie categorie;
  final DateTime date;
  final CounterBloc bloc;
  final Function(int, bool) notifyParent;
  final int tileId;

  StaggeredView(this.iconData, this.title, this.id, this.description,
      this.categorie, this.date, this.bloc, this.notifyParent, this.tileId);

  @override
  State<StatefulWidget> createState() => new _StaggeredViewState();
}

class _StaggeredViewState extends State<StaggeredView>
    with SingleTickerProviderStateMixin {
  String counterFront;
  String counterBack;
  double widthScreen;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  bool development = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.bloc.actualise(widget.date);
    counterFront = buildCounterFront(widget.bloc.counter.toInt());
    counterBack = buildCounterBack(widget.bloc.counter.toInt());
    Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              widget.bloc.actualise(widget.date);
              counterFront = buildCounterFront(widget.bloc.counter.toInt());
              counterBack = buildCounterBack(widget.bloc.counter.toInt());
            }));
  }

  String buildCounterFront(int number) {
    final formatter = new NumberFormat("###,###,###,###,###,###,###,###");
    String res = formatter.format(number);
    return res.replaceAll(",", ".");
  }

  String buildCounterBack(int number) {
    String res;
    if (1000000000 > number && number > 999999) {
      res = (number / 1000000).toStringAsFixed(0) + " millions";
    } else if (number > 999999999) {
      int n=(number / 1000000000).round();
      res=buildCounterFront(n);
      res+=" milliards";
   
    } else {
      res = buildCounterFront(number);
    }

    return res;
  }

  Widget back(bool b) {
    switch (b) {
      case false:
        return Card(
            color: widget.categorie.color,
            child: Stack(children: <Widget>[
              Column(children: <Widget>[
                Stack(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Opacity(
                          child: Icon(
                            widget.categorie.logo,
                            color: widget.categorie.colorLogo,
                            size: widthScreen / 3,
                          ),
                          opacity: 0.5,
                        )),
                    Container(
                      padding: EdgeInsets.only(
                          left: widthScreen / 20, right: widthScreen / 20),
                      child: Column(children: <Widget>[
                        AutoSizeText(
                          counterBack,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: widthScreen / 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Monofonto-Regular"),
                          maxLines: 1,
                        ),
                        Text(
                          widget.description,
                          style: TextStyle(
                              color: widget.categorie.colorText,
                              fontSize: widthScreen / 28),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        )
                      ]),
                    ),
                  ],
                ),
              ]),
              Align(
                  child: FlatButton(
                    child: Text(
                      "Voir plus",
                      style: TextStyle(
                          fontSize: widthScreen / 40, color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        development = true;
                        widget.notifyParent(widget.tileId, false);
                      });
                    },
                  ),
                  alignment: Alignment.bottomRight),
            ]));
        break;
      case true:
        return Card(
            color: widget.categorie.color,
            child: Stack(children: <Widget>[
              Column(children: <Widget>[
                Stack(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Opacity(
                          child: Icon(
                            widget.categorie.logo,
                            color: widget.categorie.colorLogo,
                            size: widthScreen / 3,
                          ),
                          opacity: 0.5,
                        )),
                    Container(
                      padding: EdgeInsets.only(
                          left: widthScreen / 20, right: widthScreen / 20),
                      child: Column(children: <Widget>[
                        Text(
                          counterBack,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: widthScreen / 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Monofonto-Regular"),
                          maxLines: 1,
                        ),
                        Text(
                          widget.description,
                          style: TextStyle(
                              color: widget.categorie.colorText,
                              fontSize: widthScreen / 28),
                        ),
                      ]),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: widthScreen / 20,
                      right: widthScreen / 20,
                      top: widthScreen / 15),
                  child: Column(children: <Widget>[
                    Text("Conseils:\n",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: widthScreen / 22)),
                    AutoSizeText(
                      widget.categorie.conseils,
                      style: TextStyle(
                          color: widget.categorie.colorText,
                          fontSize: widthScreen / 28),
                    ),
                  ]),
                ),
              ]),
              Align(
                  child: FlatButton(
                    child: Text(
                      "Voir moins",
                      style: TextStyle(
                          fontSize: widthScreen / 40, color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        development = false;
                        widget.notifyParent(widget.tileId, true);
                      });
                    },
                  ),
                  alignment: Alignment.bottomRight),
            ]));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return new InkWell(
        child: Container(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: FlipCard(
                direction: FlipDirection.VERTICAL, // default
                front: Card(
                    elevation: 3,
                    color: widget.categorie.color,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Hero(
                            tag: "icon_${widget.id}",
                            child: Icon(
                              widget.categorie.logo,
                              color: widget.categorie.colorText,
                              size: widthScreen / 7,
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              width: widthScreen / 3 * 2,
                              child: AutoSizeText(
                                widget.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: widthScreen / 17,
                                    color: widget.categorie.colorText,
                                    fontWeight: FontWeight.bold),
                                minFontSize: 10.0,
                                stepGranularity: 10.0,
                                maxLines: 3,
                              ),
                            ),
                            Container(
                              width: widthScreen / 3 * 2,
                              child: AutoSizeText(
                                counterFront,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: widthScreen / 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Monofonto-Regular"),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                back: back(development))));
  }
}
