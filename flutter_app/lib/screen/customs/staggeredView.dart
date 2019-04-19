
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class StaggeredView extends StatelessWidget {
 const StaggeredView(this.backgroundColor, this.iconData);

 final Color backgroundColor;
 final IconData iconData;

 @override
 Widget build(BuildContext context) {
   return new Card(
     color: backgroundColor,
     child: new Center(
         child: new Icon(
             iconData,
             color: Colors.white,
           ),
     ),
   );
 }
}




/*

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
];

List<Widget> _tiles = const <Widget>[
 const _StaggeredView(Colors.green, Icons.widgets),
 const _StaggeredView(Colors.lightBlue, Icons.wifi),
 const _StaggeredView(Colors.amber, Icons.panorama_wide_angle),
 const _StaggeredView(Colors.brown, Icons.map),
 const _StaggeredView(Colors.deepOrange, Icons.send),
 const _StaggeredView(Colors.indigo, Icons.airline_seat_flat),
 const _StaggeredView(Colors.red, Icons.bluetooth),
 const _StaggeredView(Colors.pink, Icons.battery_alert),
 const _StaggeredView(Colors.purple, Icons.desktop_windows),
 const _StaggeredView(Colors.blue, Icons.radio),
];

void main() {
 runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
 // This widget is the root of your application.
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Application',
     theme: ThemeData(
       primarySwatch: Colors.green,
     ),
     home: SampleAppPage(),
   );
 }
}

class SampleAppPage extends StatefulWidget {
 SampleAppPage({Key key}) : super(key: key);

 @override
 _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> with TickerProviderStateMixin {
 // Default placeholder text

 @override
 Widget build(BuildContext context) {
   return SafeArea(
     child : Scaffold(
   appBar: AppBar(
   title: Center(child : Image.asset("images/Earth.svg"))
   ),
     body : new StaggeredGridView.count(
             crossAxisCount: 4,
             staggeredTiles: _staggeredTiles,
             children: _tiles,
             mainAxisSpacing: 4.0,
             crossAxisSpacing: 4.0,
       ),
     ),

   );
 }
}
*/