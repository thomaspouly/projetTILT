import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
import 'package:flutter_app/screen/customs/fab.dart';
import 'package:flutter_app/screen/customs/staggeredView.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:flutter_app/screen/partenaire/partenaire.dart';
import 'package:flutter_app/screen/profil/profil.dart';
import 'package:flutter_app/screen/tree/tree.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void _recupID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("id", widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.ofRanking(context);
    _recupID();
    heightScreen = MediaQuery.of(context).size.height;
    loadingTiles(date);
    FlutterStatusbarcolor.setStatusBarColor(Colors.grey[200]);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    return new SafeArea(
      child: new Scaffold(
          bottomNavigationBar: _buildBottomBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFab(context),
          drawer: _buildDrawer(widget.uid),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: Container(),
                backgroundColor: Colors.white,
                floating: true,
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
    return FABBottomAppBar(
      height: 80,
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
          iconData: Icons.poll,
          text: 'Statistiques',
        ),
        FABBottomAppBarItem(
          iconData: Icons.format_list_numbered,
          text: 'Classements',
        ),
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
      elevation: 3.0,
    );
  }

  Widget _buildImage() {
    Future<String> url = getImage(widget.uid);
    final blocHome = BlocProvider.ofHome(context);
    return new Container(
        child: widget.uid == null
            ? new FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyLoginPage()),
                  );
                },
                child: new Container(
                    height: heightScreen / 9,
                    width: heightScreen / 9,
                    child: Center(
                      child: AutoSizeText(
                        "Connexion",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 200,
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyProfilPage(
                                      uid: widget.uid,
                                    )),
                          );
                          blocHome.logout();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyLoginPage()),
                          );
                        },
                        child: new Container(
                            height: heightScreen / 9,
                            width: heightScreen / 9,
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

  Widget _buildDrawer(String uid) {
    final blocProfil = BlocProvider.ofProfil(context);
    final blocTree = BlocProvider.ofFormTree(context);
    final blocHome = BlocProvider.ofHome(context);
    var sizeIconTiles = heightScreen / 40;
    var sizeTextTiles = heightScreen / 50;
    return new BlocProvider(
      child: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: FutureBuilder(
                  future: blocProfil.getUserById(uid),
                  builder: (context, AsyncSnapshot<User> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return Text(snapshot.data.name,
                            style: TextStyle(fontSize: heightScreen / 40));
                        break;
                      default:
                        return CircularProgressIndicator();
                        break;
                    }
                  }),
              currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                  child: FutureBuilder(
                      future: blocTree.getNote(),
                      builder: (context, AsyncSnapshot<NoteForm> snapshot) {
                        double note = double.parse(snapshot.data.note);
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            return Text(
                              note.toStringAsFixed(1) + "/10",
                              style: TextStyle(fontSize: heightScreen / 50),
                            );
                            break;

                          default:
                            return CircularProgressIndicator();
                            break;
                        }
                      })),
            ),
            ListTile(
              title: Text(
                'Partenaires',
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
                      builder: (context) => PartenairePage(
                            uid: widget.uid,
                          )),
                );
              },
            ),
            ListTile(
              title: Text('Faire un don',
                  style: TextStyle(fontSize: sizeTextTiles)),
              leading: Icon(
                Icons.monetization_on,
                size: sizeIconTiles,
              ),
              onTap: () {},
            ),
            ListTile(
              title:
                  Text('Mode nuit', style: TextStyle(fontSize: sizeTextTiles)),
              leading: Icon(
                Icons.brightness_2,
                size: sizeIconTiles,
              ),
              onTap: () {},
            ),
            ListTile(
              title:
                  Text('Paramètres', style: TextStyle(fontSize: sizeTextTiles)),
              leading: Icon(
                Icons.settings,
                size: sizeIconTiles,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('Deconnexion',
                  style: TextStyle(fontSize: sizeTextTiles)),
              leading: Icon(
                Icons.power_settings_new,
                size: sizeIconTiles,
              ),
              onTap: () {
                blocHome.logout();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyLoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget bar(bool b) {
    switch (b) {
      case false:
        return new Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildDropDownStatCategory(),
            Align(
              child: _buildImage(),
              alignment: Alignment.center,
            ),
            _buildDropDownStatDuration(),
          ],
        );
        break;
      case true:
        return new Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildDropDownRankingTop(),
            Align(
              child: _buildImage(),
              alignment: Alignment.center,
            ),
            _buildDropDownRankingYear(),
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
