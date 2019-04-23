/*
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredView extends StatelessWidget {
  const StaggeredView(
      this.backgroundColor, this.iconData, this.title, this.value);

  final Color backgroundColor;
  final IconData iconData;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return new Card(
        color: backgroundColor,
        child: new Stack(children: <Widget>[
          Positioned(
              child: Icon(
            iconData,
            color: Colors.white,
            size: 60,
          )),
          Positioned(
            left: 50,
            child: Text(
              title,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          Positioned(
            top:30,
            left:60,
              child: Text(
            value,
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ))
        ]));
  }
}
*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/screen/home/tuile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredView extends StatelessWidget {
  const StaggeredView(
      this.backgroundColor, this.iconData, this.title, this.value);
  final Color backgroundColor;
  final IconData iconData;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: (){
   Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 2),
                      pageBuilder: (_, __, ___) => TuilePage())
                  );

      },
      
       child:Card(
        color: backgroundColor,
        child: new Stack(children: <Widget>[
         Positioned(
           child:Hero(tag:"icon", child: Icon(
            iconData,
            color: Colors.white,
            size: 60,
          )),),
          Positioned(
            left: 50,
          child: Text(
              title,
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),),
        
          Positioned(
            top:30,
            left:60,
              child:  Text(
            value,
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ))
        ])));
  }
}
