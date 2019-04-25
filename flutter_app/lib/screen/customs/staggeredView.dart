

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/screen/home/tuile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:page_transition/page_transition.dart';
class StaggeredView extends StatelessWidget {
  const StaggeredView(
      this.backgroundColor, this.iconData, this.title, this.value,this.id);
  final Color backgroundColor;
  final IconData iconData;
  final String title;
  final String value;
  final String id;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: (){
        print(id);

                    Navigator.push(context, PageTransition(duration:Duration(milliseconds: 500),type: PageTransitionType.rotate, child:     TuilePage(idCard: id,color: backgroundColor,title: title,value: value,iconData: iconData,)
              ));
              

      },
      
       child:Card(
        color: backgroundColor,
        child: new Stack(children: <Widget>[
         Positioned(
           child:Hero(tag:"icon_$id", child: Icon(
            iconData,
            color: Colors.black,
            size: 60,
          )),),
          Positioned(
            left: 50,
           child:Hero(tag:"title_$id", child: Text(
              title,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),),),
        
          Positioned(
            top:30,
            left:60,
            child:Hero(tag:"value_$id",    child:  Text(
            value,
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ))),
        ])));
  }
}
