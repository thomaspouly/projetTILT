import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/provider/login_bloc_provider.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:flutter_app/screen/register/register.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /*return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
  
          primarySwatch: Colors.green,
        ),
        home:MyHomePage(title: "is",));*/

    return new BlocProvider(
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: MyLoginPage(
                title: "is",
            ))
    );
  }
}


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyLoginPage()),
    );
/*
    setState(() {
      _counter++;
    });*/
  }

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
