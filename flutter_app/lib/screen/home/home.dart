import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/bloc/counter_bloc.dart';
import 'package:flutter_app/models/Categorie.dart';
import 'package:flutter_app/models/NoteForm.dart';
import 'package:flutter_app/models/Tile.dart';
import 'package:flutter_app/models/TileHelper.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/customs/Countries.dart';
import 'package:flutter_app/screen/customs/staggeredView.dart';
import 'package:flutter_app/screen/friend/friend.dart';
import 'package:flutter_app/screen/home/settings.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:flutter_app/screen/partner/partner.dart';
import 'package:flutter_app/screen/profil/profil.dart';
import 'package:flutter_app/screen/ranking_friend/ranking_friend.dart';
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
  GlobalKey<ScaffoldState> scaffoldKey;
  var heightScreen;
  List<Tile> tiles = TileHelper().listTile();
  List<StaggeredView> tileGrid = new List<StaggeredView>();
  List<StaggeredTile> _staggeredTiles = List<StaggeredTile>();
  bool classement = false;

  ScrollController _hideButtonController = new ScrollController();

  double opacity = 1;

  String _dropdownCategoryValue = 'Catégories';
  String _dropdownDurationValue = 'Maintenant';

  bool b = true;
  DateTime date = DateTime.now();
  double heightTiles;
  List<int> ids = new List<int>();

  setHeightTiles(int i, bool retirer) {
    setState(() {
      if (retirer == true) {
        ids.remove(i);
      } else {
        ids.add(i);
      }
    });
  }

  loadingTiles(DateTime dateLoading) {
    tileGrid = new List<StaggeredView>();
    _staggeredTiles = List<StaggeredTile>();
    for (int i = 0; i < tiles.length; i++) {
      CounterBloc bloc = new CounterBloc();
      bloc.setCounter(tiles[i].increment);
      if (ids.contains(i)) {
        heightTiles = 4.5;
      } else {
        heightTiles = 1.5;
      }

      StaggeredView s = StaggeredView(
          tiles[i].icon,
          tiles[i].name,
          tiles[i].id,
          tiles[i].description,
          tiles[i].categorie,
          dateLoading,
          bloc,
          this.setHeightTiles,
          i);

      switch (_dropdownCategoryValue) {
        case 'Faune':
          if (s.categorie.name == Names.faune) {
            tileGrid.add(s);
            _staggeredTiles.add(StaggeredTile.count(4, heightTiles));
          }
          break;
        case 'Flore':
          if (s.categorie.name == Names.flore) {
            tileGrid.add(s);
            _staggeredTiles.add(StaggeredTile.count(4, heightTiles));
          }
          break;
        case 'Réchauffement':
          if (s.categorie.name == Names.rechauffement) {
            tileGrid.add(s);
            _staggeredTiles.add(StaggeredTile.count(4, heightTiles));
          }
          break;

        case 'Pollution':
          if (s.categorie.name == Names.pollution) {
            tileGrid.add(s);
            _staggeredTiles.add(StaggeredTile.count(4, heightTiles));
          }
          break;
        case 'Energies':
          if (s.categorie.name == Names.energie) {
            tileGrid.add(s);
            _staggeredTiles.add(StaggeredTile.count(4, heightTiles));
          }
          break;
        case 'Déchets':
          if (s.categorie.name == Names.dechet) {
            tileGrid.add(s);
            _staggeredTiles.add(StaggeredTile.count(4, heightTiles));
          }
          break;

        default:
          tileGrid.add(s);

          _staggeredTiles.add(StaggeredTile.count(4, heightTiles));
      }
    }
  }

  int index = 1;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.ofRanking(context);

    heightScreen = MediaQuery.of(context).size.height;
    loadingTiles(date);

    FlutterStatusbarcolor.setStatusBarColor(Colors.grey[200]);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    scaffoldKey = new GlobalKey<ScaffoldState>();
    return new SafeArea(
      child: new Scaffold(
          extendBody: true,
          //    key:_scaffoldKey,
          bottomNavigationBar: _buildBottomBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFab(context),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: Container(),
                backgroundColor: Colors.white.withOpacity(0),
                floating: false,
                expandedHeight: heightScreen / 7,
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
    return BottomAppBar(
      notchMargin: 7,
      shape: CircularNotchedRectangle(),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              //sleep(Duration(seconds : 3));
              _settingModalBottomSheet(context, widget.uid);
            },
            icon: Icon(Icons.menu),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  if (classement) {
                    setState(() {
                      classement = false;
                    });
                  }
                },
                icon: Icon(Icons.poll),
              ),
              IconButton(
                onPressed: () {
                  if (!classement) {
                    setState(() {
                      classement = true;
                    });
                  }
                },
                icon: Icon(Icons.format_list_numbered),
              ),
            ],
          ),
        ],
      ),
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
      elevation: 10.0,
    );
  }

  Widget _buildImage() {
    Future<String> url = getImage(widget.uid);
    return new FutureBuilder<String>(
      future: url,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return CircularProgressIndicator();
          case ConnectionState.active:
            return CircularProgressIndicator();

          case ConnectionState.waiting:
            return CircularProgressIndicator();

          case ConnectionState.done:
            return new CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data),
              radius: heightScreen / 25,
            );
        }
      },
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

  Color color = Colors.white;

  DropdownButton _buildDropDownStatCategory() {
    return DropdownButton<String>(
      value: _dropdownCategoryValue,
      onChanged: (String newValue) {
        setState(() {
          _dropdownCategoryValue = newValue;
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
            style: TextStyle(fontSize: heightScreen / 40),
          ),
        );
      }).toList(),
    );
  }

  DropdownButton _buildDropDownStatDuration() {
    return DropdownButton<String>(
      value: _dropdownDurationValue,
      onChanged: (String newValue) {
        setState(() {
          _dropdownDurationValue = newValue;
          b = false;

          switch (_dropdownDurationValue) {
            case 'Aujourd\'hui':
              date = DateTime.now();
              date = DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0);
              break;
            case 'Ce mois-ci':
              date = DateTime.now();
              date = DateTime(date.year, date.month, 1, 0, 0, 0, 0, 0);
              break;
            case 'Cette année':
              date = DateTime.now();
              date = DateTime(date.year, 1, 1, 0, 0, 0, 0, 0);
              break;
            case 'Depuis 2000':
              date = DateTime(2000, 1, 1);
              break;
            default:
              date = DateTime.now();
          }
        });
      },
      items: <String>[
        'Maintenant',
        'Aujourd\'hui',
        'Ce mois-ci',
        'Cette année',
        'Depuis 2000',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: heightScreen / 40),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDropDownRankingTop() {
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
              style: TextStyle(fontSize: heightScreen / 40),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDropDownRankingYear() {
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
              style: TextStyle(fontSize: heightScreen / 40),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _settingModalBottomSheet(context, uid) {
    if (uid == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Veuillez vous connecter"),
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
    } else {
      final blocProfil = BlocProvider.ofProfil(context);
      final blocTree = BlocProvider.ofFormTree(context);
      double sizeIconTiles = 30;
      double sizeTextTiles = 15;

      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Container(
              child: new Wrap(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(heightScreen / 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: heightScreen / 40),
                              child: _buildImage(),
                            ),
                            FutureBuilder(
                                future: blocProfil.getUserById(uid),
                                builder:
                                    (context, AsyncSnapshot<User> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.done:
                                      return Text(snapshot.data.name,
                                          style: TextStyle(fontSize: 20));
                                      break;
                                    default:
                                      return CircularProgressIndicator();
                                      break;
                                  }
                                })
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FutureBuilder(
                                future: blocTree.getNote(),
                                builder: (context,
                                    AsyncSnapshot<NoteForm> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.done:
                                      return Text(
                                        "Note: " +
                                            double.parse(snapshot.data.note)
                                                .toStringAsFixed(0) +
                                            "/10",
                                        style: TextStyle(fontSize: 15),
                                      );
                                      break;
                                    case ConnectionState.waiting:
                                      return CircularProgressIndicator();
                                      break;
                                    default:
                                      return CircularProgressIndicator();
                                      break;
                                  }
                                }),
                            FutureBuilder(
                                future: blocProfil.getUserById(uid),
                                builder:
                                    (context, AsyncSnapshot<User> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.done:
                                      return Text(
                                          "Pommes: " +
                                              snapshot.data.nbPomme.toString(),
                                          style: TextStyle(fontSize: 15));
                                      break;
                                    default:
                                      return CircularProgressIndicator();
                                      break;
                                  }
                                })
                          ],
                        )
                      ],
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  ListTile(
                    title: Text(
                      'Modifier le profil',
                      style: TextStyle(fontSize: sizeTextTiles),
                    ),
                    leading: Icon(
                      Icons.perm_contact_calendar,
                      size: sizeIconTiles,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyProfilPage(
                                  uid: widget.uid,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Ajouter un ami',
                      style: TextStyle(fontSize: sizeTextTiles),
                    ),
                    leading: Icon(
                      Icons.perm_contact_calendar,
                      size: sizeIconTiles,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyFriendPage(
                              uid: widget.uid,
                            )),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Classement entre ami',
                      style: TextStyle(fontSize: sizeTextTiles),
                    ),
                    leading: Icon(
                      Icons.format_list_numbered,
                      size: sizeIconTiles,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyRankingFriendPage(
                              uid: widget.uid,
                            )),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Partenaires',
                      style: TextStyle(fontSize: sizeTextTiles),
                    ),
                    leading: Icon(
                      Icons.center_focus_strong,
                      size: sizeIconTiles,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PartnerPage(
                                  uid: widget.uid,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Paramètres',
                        style: TextStyle(fontSize: sizeTextTiles)),
                    leading: Icon(
                      Icons.settings,
                      size: sizeIconTiles,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Settings(
                                  uid: widget.uid,
                                )),
                      );
                    },
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            );
          });
    }
  }

  Widget bar(bool b) {
    switch (b) {
      case false:
        return new Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildDropDownStatCategory(),
            Container(
              height: heightScreen / 10, width: heightScreen / 10,
              //child:svg
              child: FlareActor("assets/flare/Earth2.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  animation: "Preview2"),
            ),
            _buildDropDownStatDuration(),
          ],
        );
        break;
      case true:
        return new Column(children: <Widget>[
          new Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildDropDownRankingTop(),
              Container(
                height: heightScreen / 11, width: heightScreen / 11,
                //child:svg
                child: FlareActor("assets/flare/Earth2.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    animation: "Preview2"),
              ),
              _buildDropDownRankingYear(),
            ],
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text("Metrique tonnes de dioxyde de carbone"),
            ),
          ),
        ]);
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
