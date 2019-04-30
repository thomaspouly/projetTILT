import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/models/Tile.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/classement/classement.dart';
import 'package:flutter_app/screen/customs/Countries.dart';
import 'package:flutter_app/screen/customs/fab.dart';
import 'package:flutter_app/screen/customs/staggeredView.dart';
import 'package:flutter_app/screen/home/home.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:flutter_app/screen/tree/tree.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class MyClassementPage extends StatefulWidget {
  String uid;
  MyClassementPage({this.uid});

  @override
  State<StatefulWidget> createState() => new _MyClassementPageState();
}

Future<String> getImage(String uid) async {
  try {
    final ref = FirebaseStorage.instance.ref().child("image/" + uid);
// no need of the file extension, the name will do fine.
    String url = await ref.getDownloadURL();
    return url;
  } catch (e) {
    // print(e.toString());
  }
}

class _MyClassementPageState extends State<MyClassementPage> {
  ScrollController _hideButtonController = new ScrollController();

  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.ofClassement(context);

    FlutterStatusbarcolor.setStatusBarColor(Colors.grey[200]);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    Widget getLoadedRankingCountry() {
      if (_currentItemSelected2 == "2017") {
        return new FutureBuilder(
            future: bloc.loadCountries(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Countries(snapshot.data, taille,_hideButtonController ).build(context);
            });
      } else if (_currentItemSelected2 == "2016") {
        return new FutureBuilder(
            future: bloc.loadCountries(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Countries(snapshot.data, taille,_hideButtonController ).build(context);
            });
      } else if (_currentItemSelected2 == "2015") {
        return new FutureBuilder(
            future: bloc.loadCountries(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Countries(snapshot.data, taille,_hideButtonController ).build(context);
            });
      } else if (_currentItemSelected2 == "2014") {
        return new FutureBuilder(
            future: bloc.loadCountries(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Countries(snapshot.data, taille,_hideButtonController ).build(context);
            });
      } else {
        return new FutureBuilder(
            future: bloc.loadCountries(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Countries(snapshot.data, taille,_hideButtonController ).build(context);
            });
      }
    }

    return new SafeArea(
      child: new Scaffold(
          bottomNavigationBar: _buildBottomBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFab(context),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: Container(),
                backgroundColor: Colors.white,
                floating: true,
                expandedHeight: 100,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Center(
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildDropDownButton1(),
                            _buildImage(),
                            _buildDropDownButton2(),
                          ],
                        ),
                      )),
                ),
              ),
           SliverToBoxAdapter(
                child: getLoadedRankingCountry(),
              ),
            ],
          )),
    );
  }

  Widget _buildBottomBar() {
  
    return FABBottomAppBar(
    index: 1,
      color: Colors.grey,
      selectedColor: Colors.green,
      notchedShape: CircularNotchedRectangle(),
      
      onTabSelected: (index) {
       
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      uid: widget.uid,
                      
                    )),
          );
        }
      },
      items: [
        FABBottomAppBarItem(
          iconData: Icons.my_location,
          text: 'Statistiques',
        ),
        FABBottomAppBarItem(
            iconData: Icons.format_list_numbered, text: 'Classements'),
      ],
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (widget.uid != null) {
          print("UID:" + widget.uid);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TreePage(
                      uid: widget.uid,
                    )),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title:
                    new Text("Veuillez vous connecter pour acceder à l'arbre"),
                content: RaisedButton(
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyLoginPage()),
                    );
                  },
                  child: Text("Connexion"),
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      child: Icon(Icons.nature),
      elevation: 3.0,
    );
  }

  Widget _buildImage() {
   Future<String> url = getImage(widget.uid);
    return new Container(
        //  margin: EdgeInsets.only(bottom: 15),
        child: widget.uid == null
            ? new FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyLoginPage()),
                  );
                },
                child: new Container(
                    height: 75,
                    width: 75,
                    child: Center(
                      child: Text(
                        "Connexion",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[200],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue)),
              )

            ///////////////
            : new FutureBuilder<String>(
                future: url,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('Press button to start.');
                    case ConnectionState.active:

                    case ConnectionState.waiting:
                      return Text('Awaiting result...');

                    case ConnectionState.done:
                      return new FlatButton(
                        onPressed: () {},
                        child: new Container(
                            height: 70,
                            width: 70,
                            decoration: new BoxDecoration(

                             
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(snapshot.data),
                                ))),
                      );
                  }
                  return null; // unreachable
                },
              ));
  }

  String _currentItemSelected = 'Top 40';

  var _currentItemSelected2 = '2017';
  int taille = 40;
  Color color = Colors.white;

  Widget _buildDropDownButton1() {
    return Container(
      child: DropdownButton<String>(
        value: _currentItemSelected,
        onChanged: (String newValue) {
          setState(() {
            _currentItemSelected = newValue;
            taille <= 40
                ? taille = int.parse(_currentItemSelected.split(' ')[1])
                : taille = 40;
          });
        },
        items: <String>['Top 3', 'Top 5', 'Top 10', 'Top 20', 'Top 40']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDropDownButton2() {
    return Container(
      child: DropdownButton<String>(
        value: _currentItemSelected2,
        onChanged: (String newValue) {
          setState(() {
            _currentItemSelected2 = newValue;
          });
        },
        items: <String>['Cet année', '2018', '2017', '2016', '2015']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          );
        }).toList(),
      ),
    );
  }
}
