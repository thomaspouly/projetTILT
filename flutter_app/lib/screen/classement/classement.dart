import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Country.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/FirestoreProvider.dart';
import 'package:flutter_app/screen/customs/Countries.dart';
import 'package:flutter_app/screen/customs/fab.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// INITIALISATION

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);


AuthProvider authProvider;
FirestoreProvider firestoreProvider;

// LOGIN PAGE

class MyClassementPage extends StatefulWidget {
  MyClassementPage({Key key, this.title, this.child}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  String uid;
  final String title;

  //LoginBloc bloc;

  String emailError;
  String passwordError;

  final Widget child;

  @override
  _MyClassementPageState createState() => _MyClassementPageState();
}

class _MyClassementPageState extends State<MyClassementPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

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

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        print(widget.uid);
        getImage(widget.uid);
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

  var _currencies = [
    'Catégories',
    'Réchauffement',
    'Eau',
    'Electricité',
    'Pétrole'
  ];
  var _currentItemSelected = 'Catégories';

  var _currencies2 = [
    'Aujourd\'hui',
    'Cette semaine',
    'Ce mois-ci',
    'Cette année',
    'Depuis 2000'
  ];

  var _currentItemSelected2 = 'Aujourd\'hui';
  Color color = Colors.white;

  Widget _buildDropDownButton1() {
    return Container(
      decoration: new BoxDecoration(
        color: color,
        borderRadius: new BorderRadius.circular(7.0),
        boxShadow: [
          new BoxShadow(
            color: Colors.black,
            //  spreadRadius: 2,
            offset: new Offset(8.0, 8.0),
            blurRadius: 15.0,
          )
        ],
      ),
      child: DropdownButton<String>(
        items: _currencies.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(
              dropDownStringItem,
              style: TextStyle(fontSize: 15),
            ),
          );
        }).toList(),
        onChanged: (String newValueSelected) {
          // Your code to execute, when a menu item i
        },
        value: _currentItemSelected,
      ),
    );
  }

  Widget _buildDropDownButton2() {
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Colors.black,
            spreadRadius: 2,
            offset: new Offset(8.0, 8.0),
            blurRadius: 15.0,
          )
        ],
        color: color,
        borderRadius: new BorderRadius.circular(7.0),
      ),
      child: DropdownButton<String>(
        items: _currencies2.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(
              dropDownStringItem,
              style: TextStyle(fontSize: 15),
            ),
          );
        }).toList(),
        onChanged: (String newValueSelected) {
          // Your code to execute, when a menu item i
        },
        value: _currentItemSelected2,
      ),
    );
  }

  Future<String> _loadCountryAsset() async {
    return await rootBundle.loadString('assets/country.json');
  }

  Future<List<Country>> loadCountry() async {
    String jsonString = await _loadCountryAsset();
    List<dynamic> jsonResponse = json.decode(jsonString);
    List<Country> countries = new List();
    for(int i = 0; i < jsonResponse.length;i++) {
      Country country = Country.fromJson(jsonResponse[i]);
      countries.add(country);
    }
    return countries;
  }

  @override
  Widget build(BuildContext context) {
    //final bloc = BlocProvider.of(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: _buildFab(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildBottomBar(),
        backgroundColor: Color.fromRGBO(210, 251, 209, 1),
        body: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildDropDownButton1(),
                  _buildImage(),
                  _buildDropDownButton2(),
                ],
              ),
              new TextField(
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search),
                    hintText: 'Recherche...'),
              ),
              new FutureBuilder(future : loadCountry(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Expanded(
                        child:Countries(snapshot.data).build(context));
                }),
            ]),
      ),
    );
  }
}
