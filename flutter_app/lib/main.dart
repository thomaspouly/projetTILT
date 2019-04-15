import 'package:flutter/material.dart';
import 'package:flutter_app/screen/register/register.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  var routes = <String, WidgetBuilder>{
    //"/Login": (BuildContext context) => new LoginPage(),
    "/Register": (BuildContext context) => new RegisterPage(),
  };


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.green),
      home: new RegisterPage(),
      routes: routes,
    );
  }
}
