import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Association.dart';
import 'package:flutter_app/models/Country.dart';
import 'package:flutter_svg/flutter_svg.dart';

final String assetName = 'assets/delete.svg';

final Widget cupRank1 = new SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo',
  color: Colors.amber,
  width: 50,
  height: 50,
);

final Widget cupRank2 = new SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo',
  color: Color(0xFFC0C0C0),
  width: 50,
  height: 50,
);

final Widget cupRank3 = new SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo',
  color: Color(0xffb36700),
  width: 50,
  height: 50,
);

class Associations extends StatelessWidget {
  List<Association> associations = new List();
  int length;

  Associations(this.associations, this.length);

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      color: Colors.green[400],
      child: Container(
        height: 50,
        padding: EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 10),
        margin: EdgeInsets.all(10),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AutoSizeText(
              associations[index].department.toString(),
              style: TextStyle(fontSize: 15, color: Colors.green[900]),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.green[400],
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: AutoSizeText(
                associations[index].association,
                minFontSize: 10,
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: _buildProductItem,
      itemCount: length,
    );
  }
}
