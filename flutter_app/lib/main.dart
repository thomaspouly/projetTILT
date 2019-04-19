import 'package:flutter/material.dart';
import 'package:flutter_app/provider/login_bloc_provider.dart';
import 'package:flutter_app/screen/login/login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

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

