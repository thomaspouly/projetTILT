import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/counter_bloc.dart';
import 'package:flutter_app/models/Categorie.dart';
import 'package:flutter_app/screen/home/tilesDetail.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

import 'package:page_transition/page_transition.dart';

class StaggeredView extends StatefulWidget {
  final IconData iconData;
  final String title;
  final double value;
  final double increment;
  final int id;
  final String description;
  final Categorie categorie;

  StaggeredView(this.iconData, this.title, this.value, this.increment, this.id,
      this.description, this.categorie);

  @override
  State<StatefulWidget> createState() => new _StaggeredViewState();
}

class _StaggeredViewState extends State<StaggeredView> {
  String counter;
  CounterBloc bloc = new CounterBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bloc.setCounter(widget.value, widget.increment);

  counter = bloc.counter.toStringAsFixed(0);
    Timer.periodic(
        Duration(milliseconds: 100),
        (Timer t) => setState(() {
              bloc.increase();

              final formatter =
                  new NumberFormat("###,###,###,###,###,###,###,###");
              counter = formatter.format(bloc.counter.toInt());
            }));
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return new InkWell(
        onTap: () {
          print(widget.id);

          Navigator.push(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 500),
                  type: PageTransitionType.rotate,
                  child: TileDetail(widget.id, widget.iconData, widget.title,
                      widget.description, widget.categorie)));
        },
        child: Container(padding:EdgeInsets.only(left:2,right: 2),child:Card(
          
            elevation: 3,
            color: widget.categorie.color,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Hero(
                    tag: "icon_${widget.id}",
                    child: Icon(
                      widget.iconData,
                      color: widget.categorie.colorLogo,
                      size: 60,
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
                            fontSize: widthScreen/17,
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
                            fontFamily: "Calibre-Semibold"),
                        minFontSize: 7.0,
                        stepGranularity: 10.0,
                        maxLines: 1,
                      ),
                    ),
                  ],
                )
              ],
            ))));
  }
}
