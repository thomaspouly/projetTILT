import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Association.dart';


class Associations extends StatelessWidget {
  List<Association> associations = new List();
  int length;

  Associations(this.associations, this.length);

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      color:Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
       
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: AutoSizeText(
                associations[index].association,
                minFontSize: 10,
                style: TextStyle(fontSize: 25,color: Theme.of(context).primaryColorDark),
              ),
            ),
            AutoSizeText(
              associations[index].presentation,
              style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColorLight),
            ),
            FlatButton(
              onPressed: () {
                //_buildView();
                /*WebView(
                  initialUrl: associations[index].link,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                  },
                );*/
              },
              child: AutoSizeText(
                associations[index].link,
                style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColorLight),
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
