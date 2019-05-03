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
  final int id;
  final String description;
  final Categorie categorie;
 final DateTime date;
 final CounterBloc bloc;
  StaggeredView(this.iconData, this.title,  this.id,
      this.description, this.categorie,this.date,this.bloc);

  @override
  State<StatefulWidget> createState() => new _StaggeredViewState();
}

class _StaggeredViewState extends State<StaggeredView> {
  String counter;
 

  @override
   void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 final formatter =
                  new NumberFormat("###,###,###,###,###,###,###,###");
  
 widget.bloc.actualise(widget.date);

  counter = formatter.format( widget.bloc.counter.toInt());
    Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
      
 widget.bloc.actualise(widget.date);
             
              counter = formatter.format( widget.bloc.counter.toInt());
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
                  type: null,
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
                      widget.categorie.logo,
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
                            fontWeight: FontWeight.bold,
                            fontFamily: "Monofonto-Regular"),
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
