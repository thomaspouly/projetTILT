import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/bloc/register_bloc.dart';
import 'package:flutter_app/screen/customs/fab.dart';
import 'package:flutter_app/screen/customs/staggeredView.dart';

import 'package:flutter_app/provider/login_bloc_provider.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:flutter_app/screen/tree/tree.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class HomePage extends StatefulWidget {
  String uid;
  HomePage({this.uid});

  @override
  State<StatefulWidget> createState() => new _HomePageState();

  static RegisterBloc ofRegi(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .registerBloc;
  }
}

Future<String> getImage(String uid) async {
  try {
    final ref = FirebaseStorage.instance.ref().child("image/" + uid);
// no need of the file extension, the name will do fine.
    String url = await ref.getDownloadURL();

    return url;
  } catch (e) {
    print(e.toString());
  }
}

class _HomePageState extends State<HomePage> {
  ScrollController _hideButtonController = new ScrollController();

  double opacity = 1;

  RegisterBloc _bloc;

  @override
  Widget build(BuildContext context) {
   // _bloc = BlocProvider.ofRegister(context);
    List<Widget> _tiles = new List<Widget>();
    List<StaggeredTile> _staggeredTiles = List<StaggeredTile>();
    int tileLength = 50;

    for (int i = 0; i < tileLength; i++) {
      StaggeredView s = StaggeredView(Colors.lightGreen[400], Icons.nature,
          "Arbres coupés", "2 000 000", i.toString());
      _tiles.add(s);
    }

    _staggeredTiles.add(StaggeredTile.count(2, 2));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(4, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(4, 2));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 2));
    _staggeredTiles.add(StaggeredTile.count(2, 2));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 2));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(4, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(4, 2));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 2));
    _staggeredTiles.add(StaggeredTile.count(2, 2));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 2));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(4, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(4, 2));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 2));
    _staggeredTiles.add(StaggeredTile.count(2, 2));
    _staggeredTiles.add(StaggeredTile.count(2, 1));
    _staggeredTiles.add(StaggeredTile.count(2, 1));

    FlutterStatusbarcolor.setStatusBarColor(Colors.grey[200]);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
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
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                child: _buildStaggredView(
                    _hideButtonController, _staggeredTiles, _tiles),
              ),
            ],
          )),
    );
  }

  Widget _buildBottomBar() {
    return FABBottomAppBar(
      color: Colors.grey,
      selectedColor: Colors.green,
      notchedShape: CircularNotchedRectangle(),
      //  onTabSelected: _selectedTab,
      items: [
        FABBottomAppBarItem(iconData: Icons.my_location, text: 'Statistiques'),
        FABBottomAppBarItem(
            iconData: Icons.format_list_numbered, text: 'Classements'),
      ],
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if(widget.uid!=null){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TreePage(uid: widget.uid,)), 
        );
        }else{
 showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Veuillez vous connecter pour acceder à l'arbre"),
          content: 
          RaisedButton(
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
//String url="https://firebasestorage.googleapis.com/v0/b/projet-tilt.appspot.com/o/image%2FKfjswgQ5socC1St0vO2xvS6HjE23?alt=media&token=9d4badbb-d893-496b-a620-338a3cdbf68f";
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

                                /*  boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black,
                                    spreadRadius: 3,
                                    offset: new Offset(0.0, 00.0),
                                    // blurRadius: 10.0,
                                  )
                                ],*/
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



Color color = Colors.white;

String dropdownValue1 = 'Catégories';
DropdownButton _buildDropDownButton1() {
  return  DropdownButton<String>(
    value: dropdownValue1,
    onChanged: (String newValue) {
     setState(() {
       
     dropdownValue1=newValue;

     });
     
    },
    items: <String>[
  'Catégories',
  'Réchauffement',
  'Eau',
  'Electricité',
  'Pétrole'
]
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        
       child: Text(value,style: TextStyle(fontSize: 15),),
      );
    }).toList(),
  );
}


String dropdownValue2 = 'Aujourd\'hui';
DropdownButton _buildDropDownButton2() {
  return DropdownButton<String>(
    value: dropdownValue2,
    onChanged: (String newValue) {
      setState(() {
        dropdownValue2=newValue;
      });
    },
    items: <String>[
  'Aujourd\'hui',
  'Cette semaine',
  'Ce mois-ci',
  'Cette année',
  'Depuis 2000'
]
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value,style: TextStyle(fontSize: 15),),
        
      );
    }).toList(),
   
  );
}

Widget _buildStaggredView(ScrollController controller,
    List<StaggeredTile> staggeredTiles, List<Widget> tiles) {
  return StaggeredGridView.count(
    crossAxisCount: 4,
    shrinkWrap: true,
    staggeredTiles: staggeredTiles,
    children: tiles,
    controller: controller,
    mainAxisSpacing: 4.0,
    crossAxisSpacing: 4.0,
  );
}

}

