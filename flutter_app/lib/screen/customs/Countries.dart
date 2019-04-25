import 'package:flutter/material.dart';
import 'package:flutter_app/models/Country.dart';
import 'package:flutter_svg/flutter_svg.dart';


final String assetName = 'assets/trophy.svg';

final Widget svg = new SvgPicture.asset(assetName, semanticsLabel: 'Acme Logo');

class Countries extends StatelessWidget {
  final List<Country> countries;
  Countries(this.countries);


  Widget _buildProductItem(BuildContext context, int index) {
    if(index<3) {
      return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            svg,
            Text(countries[index].name),
            Text(countries[index].value),
          ],
        ),
      );
    } else {
      return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(countries[index].rank.toString()),
            Text(countries[index].name),
            Text(countries[index].value),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: countries.length,
    );
  }
}