import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/provider/BlocProvider.dart';

class Friends extends StatelessWidget {
  List<String> friends = new List();
  int taille;

  Friends(this.friends, this.taille);

  Widget _buildProductItem(BuildContext context, int index) {
    final bloc = BlocProvider.ofFriend(context);
    return Card(
      color: Theme.of(context).primaryColor,
      child: Container(
        height: 35,
        padding: EdgeInsets.only(right: 10, left: MediaQuery.of(context).size.width/4, bottom: 10, top: 10),
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FutureBuilder(
                future: bloc.getUserById(friends[index]),
                builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text(
                        "\n\n\nChargement...",
                        style: TextStyle(fontSize: 30),
                      ),
                    );
                  } else {
                    return Row(
                      children: <Widget>[
                        AutoSizeText(
                          snapshot.data.name,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }
                }),
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
