import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/models/Tile.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/customs/Countries.dart';
import 'package:flutter_app/screen/customs/fab.dart';
import 'package:flutter_app/screen/customs/staggeredView.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:flutter_app/screen/tree/tree.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class HomePage extends StatefulWidget {
  String uid;

  HomePage({this.uid});

  @override
  State<StatefulWidget> createState() => new _HomePageState();
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

class _HomePageState extends State<HomePage> {
  List<Tile> tiles = Tile().listTile();
  List<StaggeredView> tileGrid;
  List<StaggeredTile> _staggeredTiles;
  bool classement = false;

  ScrollController _hideButtonController = new ScrollController();

  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.ofClassement(context);
    tileGrid = new List<StaggeredView>();
    _staggeredTiles = List<StaggeredTile>();

    List<Tile> tiles = Tile().listTile();

    for (int i = 0; i < tiles.length; i++) {
      StaggeredView s = StaggeredView(
          tiles[i].icon,
          tiles[i].name,
          tiles[i].counter,
          tiles[i].increment,
          tiles[i].id,
          tiles[i].description,
          tiles[i].categorie);

      tileGrid.add(s);
      _staggeredTiles.add(StaggeredTile.count(4, 1.5));
    }

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
                      child: Center(child: bar(classement))),
                ),
              ),
              SliverToBoxAdapter(
                child: body(classement, bloc),
              ),
            ],
          )),
    );
  }

  Widget getLoadedRankingCountry(var bloc) {
    if (_currentYearItemSelected == "2017") {
      return new FutureBuilder(
          future: bloc.loadCountries(_currentYearItemSelected),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text(
                  "\n\n\nChargement...",
                  style: TextStyle(fontSize: 30),
                ),
                
              );
            } else {
              return Countries(snapshot.data, taille, _hideButtonController)
                  .build(context);
            }
          });
    } else if (_currentYearItemSelected == "2016") {
      return new FutureBuilder(
          future: bloc.loadCountries(_currentYearItemSelected),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text(
                  "\n\n\nChargement...",
                  style: TextStyle(fontSize: 30),
                ),
              );
            } else {
              return Countries(snapshot.data, taille, _hideButtonController)
                  .build(context);
            }
          });
    } else if (_currentYearItemSelected == "2015") {
      return new FutureBuilder(
          future: bloc.loadCountries(_currentYearItemSelected),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text(
                  "\n\n\nChargement...",
                  style: TextStyle(fontSize: 30),
                ),
              );
            } else {
              return Countries(snapshot.data, taille, _hideButtonController)
                  .build(context);
            }
          });
    } else if (_currentYearItemSelected == "2014") {
      return new FutureBuilder(
          future: bloc.loadCountries(_currentYearItemSelected),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text(
                  "\n\n\nChargement...",
                  style: TextStyle(fontSize: 30),
                ),
              );
            } else {
              return Countries(snapshot.data, taille, _hideButtonController)
                  .build(context);
            }
          });
    } else {
      return new FutureBuilder(
          future: bloc.loadCountries(_currentYearItemSelected),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text(
                  "\n\n\nChargement...",
                  style: TextStyle(fontSize: 30),
                ),
              );
            } else {
              return Countries(snapshot.data, taille, _hideButtonController)
                  .build(context);
            }
          });
    }
  }

  Widget _buildBottomBar() {
    return FABBottomAppBar(
      color: Colors.grey,
      selectedColor: Colors.green,
      notchedShape: CircularNotchedRectangle(),
      onTabSelected: (index) {
        if (index == 1) {
          setState(() {
            classement = true;
          });
        } else {
          setState(() {
            classement = false;
          });
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

            ///////////////
            : new FutureBuilder<String>(
                future: url,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                        return CircularProgressIndicator();
                    case ConnectionState.active:
                        return CircularProgressIndicator();

                    case ConnectionState.waiting:
                         return CircularProgressIndicator();

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
                },
              ));
  }

  Color color = Colors.white;

  String _dropdownValue = 'Catégories';

  DropdownButton _buildDropDownButton() {
    return DropdownButton<String>(
      value: _dropdownValue,
      onChanged: (String newValue) {
        setState(() {
          _dropdownValue = newValue;
        });
      },
      items: <String>[
        'Catégories',
        'Faune',
        'Flore',
        'Réchauffement',
        'Pollution',
        'Energies',
        'Déchets'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
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

  String _currentTopItemSelected = 'Top 40';

  var _currentYearItemSelected = '2017';
  int taille = 40;

  Widget _buildDropDownButton1() {
    return Container(
      child: DropdownButton<String>(
        value: _currentTopItemSelected,
        onChanged: (String newValue) {
          setState(() {
            _currentTopItemSelected = newValue;
            taille <= 40
                ? taille = int.parse(_currentTopItemSelected.split(' ')[1])
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
        value: _currentYearItemSelected,
        onChanged: (String newValue) {
          setState(() {
            _currentYearItemSelected = newValue;
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

  Widget bar(bool b) {
    switch (b) {
      case false:
        return Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Hero(tag: 'image', child: _buildImage()),
            _buildDropDownButton()
          ],
        );
        break;
      case true:
        return Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildDropDownButton1(),
            Hero(tag: 'image', child: _buildImage()),
            _buildDropDownButton2()
          ],
        );
        break;
    }
  }

  Widget body(bool b, var bloc) {
    switch (b) {
      case false:
        return _buildStaggredView(
            _hideButtonController, _staggeredTiles, tileGrid);
        break;
      case true:
        return getLoadedRankingCountry(bloc);
        break;
    }
  }
}
