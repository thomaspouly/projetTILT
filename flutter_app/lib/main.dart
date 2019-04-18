import 'package:flutter/material.dart';
import 'package:flutter_app/screen/home/home.dart';
import 'package:flutter_app/screen/register/register.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  var routes = <String, WidgetBuilder>{
    //"/Login": (BuildContext context) => new LoginPage(),
    "/Register": (BuildContext context) => new RegisterPage(),
    "/Home": (BuildContext context) => new HomePage(),
  };


  @override
  Widget build(BuildContext context) {
    return new BlocProvider(
      child:MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.green),
      home: new RegisterPage(),
      routes: routes,
    ),);
  }
}
