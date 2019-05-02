import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/classement_bloc.dart';
import 'package:flutter_app/models/Country.dart';
import 'package:flutter_svg/flutter_svg.dart';

final String assetName = 'assets/trophy.svg';

final Widget cupRank1 = new SvgPicture.asset(assetName,
    semanticsLabel: 'Acme Logo', color: Colors.amber);

final Widget cupRank2 = new SvgPicture.asset(assetName,
    semanticsLabel: 'Acme Logo', color: Color(0xFFC0C0C0));

final Widget cupRank3 = new SvgPicture.asset(assetName,
    semanticsLabel: 'Acme Logo', color: Color(0xffb36700));

class Countries extends StatelessWidget {
  List<Country> countries = new List();
  int taille;
  ScrollController controller;

  Countries(this.countries, this.taille,this.controller);

  Widget _buildProductItem(BuildContext context, int index) {
    if (index == 0) {
      return Card(
        color: Colors.green[600],
        child: Container(
          padding: EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 10),
          margin: EdgeInsets.all(10),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text((index + 1).toString(),
                  style: TextStyle(fontSize: 20, color: Colors.green[300])),
              cupRank1,
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2,
                child: AutoSizeText(
                  countries[index].name,
                  minFontSize: 10,
                  style: TextStyle(fontSize: 25),
                ),),
              Text(
                countries[index].value,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }
      else if (index == 1) {
        return Card(
          color: Colors.green[600],
          child: Container(
            padding: EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 10),
            margin: EdgeInsets.all(10),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text((index+1).toString(), style: TextStyle(fontSize: 20,color: Colors.green[300])),
                cupRank2,
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: AutoSizeText(
                    countries[index].name,
                    minFontSize: 10,
                    style: TextStyle(fontSize: 25),
                  ),),
                Text(
                  countries[index].value,
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
              ],
            ),
          ),
        );
    }
    else if (index == 2) {
      return Card(
        color: Colors.green[600],
        child: Container(
          padding: EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 10),
          margin: EdgeInsets.all(10),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text((index+1).toString(), style: TextStyle(fontSize: 20,color: Colors.green[300])),
              cupRank3,
              Container(
                width: MediaQuery.of(context).size.width/2,
                child: AutoSizeText(
                  countries[index].name,
                  minFontSize: 10,
                  style: TextStyle(fontSize: 25),
                ),),
              Text(
                countries[index].value,
                style: TextStyle(fontSize: 20,color: Colors.white),
              ),
            ],
          ),
        ),
      );





    } else {
      return Card(
        color: Colors.green[400],
        child: Container(
          height: 50,
          padding: EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 10),
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AutoSizeText(
                countries[index].rank.toString(),
                style: TextStyle(fontSize: 20,color: Colors.green[900]),
              ),
            Container(
               width: MediaQuery.of(context).size.width/2,
               child: AutoSizeText(
                countries[index].name,
                minFontSize: 10,
                style: TextStyle(fontSize: 25),
              ),),
              Text(
                countries[index].value,
                style: TextStyle(fontSize: 20,color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: _buildProductItem,
      itemCount: taille,
      controller: controller,
    );
  }
}
