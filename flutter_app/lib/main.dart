import 'package:flutter/material.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/classement/classement.dart';
import 'package:flutter_app/screen/home/home.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:flutter_app/screen/tree/tree.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(new MyApp());

final String assetName = 'assets/earth.png';

final Widget svg = new SvgPicture.asset(assetName, semanticsLabel: 'Acme Logo');

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
        home: new SplashScreen(
            seconds: 2,
            navigateAfterSeconds: new MyLoginPage(),
            title: new Text(
              'Bienvenue sur EarthState',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 20, color: Colors.grey, wordSpacing: 3),
            ),
            image: Image.asset(assetName),
            backgroundColor: Color.fromRGBO(210, 251, 209, 1),
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            loaderColor: Colors.greenAccent),
      ),
    );
  }
}
