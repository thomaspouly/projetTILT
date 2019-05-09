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
  String counter;

  double widthScreen;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  bool developemment = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final formatter = new NumberFormat("###,###,###,###,###,###,###,###");

    widget.bloc.actualise(widget.date);

    counter = formatter.format(widget.bloc.counter.toInt());
    counter = counter.replaceAll(",", ".");
    Timer.periodic(
        Duration(seconds: 1),
            (Timer t) => setState(() {
          widget.bloc.actualise(widget.date);

          counter = formatter.format(widget.bloc.counter.toInt());
          counter = counter.replaceAll(",", ".");
        }));
  }

  Widget back(bool b) {
    switch (b) {
      case false:
        return Card(
            color: widget.categorie.color,
            child:  Stack(

                children: <Widget>[ Column(children: <Widget>[
                  Stack(

                    children: <Widget>[
                      Align(alignment: Alignment.bottomCenter,child:Opacity(child:Icon(widget.categorie.logo,color: widget.categorie.colorLogo,size: widthScreen/3,),opacity: 0.5,)) ,
                      Container(

                        padding: EdgeInsets.only(left: widthScreen/20,right:  widthScreen/20),
                        child: Column(children: <Widget>[
                          AutoSizeText(

                            counter,
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
                                color: widget.categorie.colorLogo, fontSize: widthScreen/28),
                            overflow: TextOverflow.ellipsis ,
                            maxLines: 4,

                          )

                        ]),
                      ),
                    ],
                  ),



                ]),
                Align(
                    child: FlatButton(
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                        size: widthScreen / 20,
                      ),
                      onPressed: () {
                        setState(() {
                          developemment = true;
                          widget.notifyParent(widget.tileId, false);
                        });
                      },
                    ),
                    alignment: Alignment.bottomRight),
                ])

        );
        break;
      case true:
        return Card(
            color: widget.categorie.color,
            child:  Stack(

                children: <Widget>[ Column(children: <Widget>[
                  Stack(

                    children: <Widget>[
                      Align(alignment: Alignment.bottomCenter,child:Opacity(child:Icon(widget.categorie.logo,color: widget.categorie.colorLogo,size: widthScreen/3,),opacity: 0.5,)) ,
                      Container(

                        padding: EdgeInsets.only(left: widthScreen/20,right:  widthScreen/20),
                        child: Column(children: <Widget>[
                          Text(
                            counter,
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
                                color: widget.categorie.colorLogo, fontSize: widthScreen/28),
                          ),
                        ]),
                      ),
                    ],
                  ),

                  Container(

                    padding: EdgeInsets.only(left: widthScreen/20,right:  widthScreen/20,top:widthScreen/15),
                    child: Column(children: <Widget>[
                      Text("Conseils:\n",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: widthScreen/22)),
                      AutoSizeText(
                        widget.categorie.conseils,
                        style: TextStyle(color: widget.categorie.colorLogo, fontSize: widthScreen/28),
                      ),
                    ]),
                  ),


                ]),
                Align(
                    child: FlatButton(
                      child: Icon(
                        Icons.arrow_drop_up,
                        color: Colors.white,
                        size: widthScreen / 20,
                      ),
                      onPressed: () {
                        setState(() {
                          developemment = false;
                          widget.notifyParent(widget.tileId, true);
                        });
                      },
                    ),
                    alignment: Alignment.bottomRight),
                ])

        );
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
                              color: widget.categorie.colorLogo,
                              size: widthScreen/7,
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
                                    color: widget.categorie.colorLogo,
                                    fontWeight: FontWeight.bold),
                                minFontSize: 10.0,
                                stepGranularity: 10.0,
                                maxLines: 3,
                              ),
                            ),
                            Container(
                              width: widthScreen / 3 * 2,
                              child: AutoSizeText(
                                counter,
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
                back: back(developemment))));
  }
}
