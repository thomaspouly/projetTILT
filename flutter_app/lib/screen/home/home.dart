import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/models/Tile.dart';
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
  Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
        Duration(milliseconds: 100),
        (Timer t) => setState(() {
              for (int i = 0; i < tiles.length; i++) {
                tiles[i].increase();
              }
            }));
  }

  ScrollController _hideButtonController = new ScrollController();

  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    tileGrid = new List<StaggeredView>();
    List<StaggeredTile> _staggeredTiles = List<StaggeredTile>();

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

    /*
  _staggeredTiles.add(StaggeredTile.count(4, 1));
  _staggeredTiles.add(StaggeredTile.count(4, 1));
  _staggeredTiles.add(StaggeredTile.count(4, 1));
  _staggeredTiles.add(StaggeredTile.count(4, 1));
*/
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
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildImage(),
                            _buildDropDownButton(),
                          ],
                        ),
                      )),
                ),
              ),
              SliverToBoxAdapter(
                child: _buildStaggredView(
                    _hideButtonController, _staggeredTiles, tileGrid),
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

  DropdownButton _buildDropDownButton() {
    return DropdownButton<String>(
      value: dropdownValue1,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue1 = newValue;
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
}
