import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/bloc/register_bloc.dart';
import 'package:flutter_app/screen/customs/fab.dart';
import 'package:flutter_app/screen/customs/staggeredView.dart';

import 'package:flutter_app/provider/login_bloc_provider.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(2, 1),
];

List<Widget> _tiles = const <Widget>[
  const StaggeredView(Colors.green, Icons.widgets),
  const StaggeredView(Colors.lightBlue, Icons.wifi),
  const StaggeredView(Colors.amber, Icons.panorama_wide_angle),
  const StaggeredView(Colors.brown, Icons.map),
  const StaggeredView(Colors.deepOrange, Icons.send),
  const StaggeredView(Colors.indigo, Icons.airline_seat_flat),
  const StaggeredView(Colors.red, Icons.bluetooth),
  const StaggeredView(Colors.pink, Icons.battery_alert),
  const StaggeredView(Colors.purple, Icons.desktop_windows),
  const StaggeredView(Colors.green, Icons.widgets),
  const StaggeredView(Colors.lightBlue, Icons.wifi),
  const StaggeredView(Colors.amber, Icons.panorama_wide_angle),
  const StaggeredView(Colors.brown, Icons.map),
  const StaggeredView(Colors.deepOrange, Icons.send),
  const StaggeredView(Colors.indigo, Icons.airline_seat_flat),
  const StaggeredView(Colors.red, Icons.bluetooth),
  const StaggeredView(Colors.pink, Icons.battery_alert),
  const StaggeredView(Colors.purple, Icons.desktop_windows),
];

/*
List<Widget> _tiles = const <Widget>[
  const StaggeredView(Colors.green, Icons.widgets),
  const StaggeredView(Colors.green, Icons.wifi),
  const StaggeredView(Colors.green, Icons.panorama_wide_angle),
  const StaggeredView(Colors.green, Icons.map),
  const StaggeredView(Colors.green, Icons.send),
  const StaggeredView(Colors.green, Icons.airline_seat_flat),
  const StaggeredView(Colors.green, Icons.bluetooth),
  const StaggeredView(Colors.green, Icons.battery_alert),
  const StaggeredView(Colors.green, Icons.desktop_windows),
  const StaggeredView(Colors.green, Icons.widgets),
  const StaggeredView(Colors.green, Icons.wifi),
  const StaggeredView(Colors.green, Icons.panorama_wide_angle),
  const StaggeredView(Colors.green, Icons.map),
  const StaggeredView(Colors.green, Icons.send),
  const StaggeredView(Colors.green, Icons.airline_seat_flat),
  const StaggeredView(Colors.green, Icons.bluetooth),
  const StaggeredView(Colors.green, Icons.battery_alert),
  const StaggeredView(Colors.green, Icons.desktop_windows),
];
*/
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

Future<String> getImage(String uid)  async{

  try{
  final ref = FirebaseStorage.instance
      .ref()
      .child("image/"+uid);
// no need of the file extension, the name will do fine.
   String url=await ref.getDownloadURL();


return url;

 } catch (e) {
    print(e.toString());
  }

}

class _HomePageState extends State<HomePage> {
  RegisterBloc _bloc;
  String url;


  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.ofRegi(context);
/*getImage(widget.uid).then((u) {
  setState(() {
    url=u;
  });
  });
  File i=NetworkImage(url) as File;*/
    FlutterStatusbarcolor.setStatusBarColor(Colors.green[100]);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return new SafeArea(
      child: new Scaffold(
        bottomNavigationBar: _buildBottomBar(),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFab(
            context), // This trailing comma makes auto-formatting nicer for build methods.

        body: Stack(alignment: Alignment.topCenter, children: <Widget>[
          Positioned(child: _buildStaggredView()),
        
           Positioned(child:  Column(children: <Widget>[
             _buildImage(),
  _buildDropDownButton(),
               

           ],),top: 10,)
               
           
        ]),
      ),
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
        print(widget.uid);
        getImage(widget.uid);
      },
      child: Icon(Icons.nature),
      elevation: 3.0,
    );
  }

  Widget _buildImage() {
//String url="https://firebasestorage.googleapis.com/v0/b/projet-tilt.appspot.com/o/image%2FKfjswgQ5socC1St0vO2xvS6HjE23?alt=media&token=9d4badbb-d893-496b-a620-338a3cdbf68f";
    Future<String> url=  getImage(widget.uid);
    return new Container(
      margin: EdgeInsets.only(bottom: 15),
      child: widget.uid== null
          ? new FlatButton(
              onPressed: () {
                Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyLoginPage()),
        );
              },
              child: new Container(
                  height: 100,
                  width: 100,
                  child:Text("Connexion",style: TextStyle(fontSize: 15),),
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue
                      
                      )),
            )
          : new FutureBuilder<String>(
future: url,
builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
                  height: 100,
                  width: 100,
                  decoration: new BoxDecoration(
                    
           
    boxShadow: [
            new BoxShadow(
              color: Colors.red[900],
              spreadRadius: 7,
              offset: new Offset(0.0, 00.0),
            //  blurRadius: 20.0,
            )
          ],
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(snapshot.data),
                      ))),
            );
    }
    return null; // unreachable
  },

          )
          
          
          
          /*new FlatButton(
              onPressed: () {},
              child: new Container(
                  height: 100,
                  width: 100,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(url),
                      ))),
            ),*/


    );
  }
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

Widget _buildDropDownButton() {
  Color color = Colors.white;
  return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children:<Widget>[
    
    Container(
    
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
            dropDownStringItem,style: TextStyle(fontSize: 18),
          ),
        );
      }).toList(),
      onChanged: (String newValueSelected) {
        // Your code to execute, when a menu item i
      },
      value: _currentItemSelected,
    ),
  ),

Padding(padding: EdgeInsets.all(30),),
 Container(
    decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black,
            //  spreadRadius: 2,
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
            dropDownStringItem,style: TextStyle(fontSize: 18),
          ),
        );
      }).toList(),
      onChanged: (String newValueSelected) {
        // Your code to execute, when a menu item i
      },
      value: _currentItemSelected2,
    ),
  )]);
}


Widget _buildStaggredView() {
  return StaggeredGridView.count(
    crossAxisCount: 4,
    shrinkWrap: true,
    staggeredTiles: _staggeredTiles,
    children: _tiles,
    mainAxisSpacing: 4.0,
    crossAxisSpacing: 4.0,
  );
}
