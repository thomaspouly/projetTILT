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
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

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

  String _currentItemSelected = 'Top 40';


  var _currentItemSelected2 = '2017';
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
        value: _currentItemSelected,
        onChanged: (String newValue) {
          setState(() {
            _currentItemSelected=newValue;
          });
        },
        items: <String>[
          'Top 10',
          'Top 20',
          'Top 40',
          'Top 50',
          'Top 100'
        ]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,style: TextStyle(fontSize: 15),),

          );
        }).toList(),

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
      child:DropdownButton<String>(
        value: _currentItemSelected2,
        onChanged: (String newValue) {
          setState(() {
            _currentItemSelected2=newValue;
          });
        },
        items: <String>[
          'Cet année',
          '2018',
          '2017',
          '2016',
          '2015'
        ]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,style: TextStyle(fontSize: 15),),

          );
        }).toList(),

      ),
    );
  }

  Widget getLoadedCountry() {
    if(_currentItemSelected2 == "2017") {
      return new FutureBuilder(future: loadCountry2017(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Expanded(
                child: Countries(snapshot.data).build(context));
          });
    } else if(_currentItemSelected2 == "2016") {
      return new FutureBuilder(future: loadCountry2016(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Expanded(
                child: Countries(snapshot.data).build(context));
          });
    }else if(_currentItemSelected2 == "2015") {
      return new FutureBuilder(future: loadCountry2015(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Expanded(
                child: Countries(snapshot.data).build(context));
          });
    }else if(_currentItemSelected2 == "2014") {
      return new FutureBuilder(future: loadCountry2014(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Expanded(
                child: Countries(snapshot.data).build(context));
          });
    } else {
      return new FutureBuilder(future: loadCountry2017(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Expanded(
                child: Countries(snapshot.data).build(context));
          });
    }
  }

  Future<String> _loadCountry2017Asset() async {
    return await rootBundle.loadString('assets/country2017.json');
  }
  Future<String> _loadCountry2016Asset() async {
    return await rootBundle.loadString('assets/country2016.json');
  }
  Future<String> _loadCountry2015Asset() async {
    return await rootBundle.loadString('assets/country2015.json');
  }
  Future<String> _loadCountry2014Asset() async {
    return await rootBundle.loadString('assets/country2014.json');
  }

  Future<List<Country>> loadCountry2017() async {
    String jsonString = await _loadCountry2017Asset();
    List<dynamic> jsonResponse = json.decode(jsonString);
    List<Country> countries = new List();
    for(int i = 0; i < jsonResponse.length;i++) {
      Country country = Country.fromJson(jsonResponse[i]);
      countries.add(country);
    }
    return countries;
  }

  Future<List<Country>> loadCountry2016() async {
    String jsonString = await _loadCountry2016Asset();
    List<dynamic> jsonResponse = json.decode(jsonString);
    List<Country> countries = new List();
    for(int i = 0; i < jsonResponse.length;i++) {
      Country country = Country.fromJson(jsonResponse[i]);
      countries.add(country);
    }
    return countries;
  }

  Future<List<Country>> loadCountry2015() async {
    String jsonString = await _loadCountry2015Asset();
    List<dynamic> jsonResponse = json.decode(jsonString);
    List<Country> countries = new List();
    for(int i = 0; i < jsonResponse.length;i++) {
      Country country = Country.fromJson(jsonResponse[i]);
      countries.add(country);
    }
    return countries;
  }

  Future<List<Country>> loadCountry2014() async {
    String jsonString = await _loadCountry2014Asset();
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
              getLoadedCountry(),
            ]),
      ),
    );
  }
}
