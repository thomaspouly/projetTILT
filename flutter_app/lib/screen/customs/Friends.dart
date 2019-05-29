import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';

class Friends extends StatelessWidget {
  List<User> friends = new List();
  int taille;
  Friends(this.friends,this.taille);

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: Container(
        height: 50,
        padding: EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 10),
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AutoSizeText(
              friends[index].name.toString(),
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: Theme.of(context).primaryColor,
            ),
            AutoSizeText(
              friends[index].email.toString(),
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: Theme.of(context).primaryColor,
            ),
            AutoSizeText(
              friends[index].nbPomme.toString(),
              minFontSize: 10,
              style: TextStyle(fontSize: 25,color: Theme.of(context).primaryColorDark,),
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
      itemCount: taille,
    );
  }
}
