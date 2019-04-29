import 'package:flutter/material.dart';
import 'package:flutter_app/models/Country.dart';
import 'package:flutter_svg/flutter_svg.dart';

final String assetName = 'assets/trophy.svg';

final Widget svg = new SvgPicture.asset(assetName, semanticsLabel: 'Acme Logo');

class Countries extends StatelessWidget {
  List<Country> countries = new List();
  int taille;

  Countries(this.countries, this.taille);

  Widget _buildProductItem(BuildContext context, int index) {
    if (index < 3) {
      return Card(
        color: Color(0xFF65ff7f),
        child: Container(
          padding: EdgeInsets.only(right: 10,left: 10,bottom: 10,top: 10),
          margin: EdgeInsets.all(10),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              svg,
              Text(countries[index].name, style: TextStyle(fontSize: 25),),
              Text(countries[index].value, style: TextStyle(fontSize: 20),),
            ],
          ),
        ),
      );
    } else {
      return Card(
        color: Color(0xFF65ff7f),
        child: Container(
          height: 50,
          padding: EdgeInsets.only(right: 10,left: 10,bottom: 10,top: 10),
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(countries[index].rank.toString(), style: TextStyle(fontSize: 20),),
              Text(countries[index].name, style: TextStyle(fontSize: 25),),
              Text(countries[index].value, style: TextStyle(fontSize: 20),),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: taille,
    );
  }
}
