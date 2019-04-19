import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/provider/login_bloc_provider.dart';
import 'package:flutter_app/screen/home/home.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:flutter_app/screen/register/register.dart';
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
            home: RegisterPage())
    );
  }
}

