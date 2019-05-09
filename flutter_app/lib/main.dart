import 'package:flutter/material.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/home/home.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

final String assetName = 'assets/earth.png';


void main() => SharedPreferences.getInstance().then((prefs) {
      var id = prefs.getString('id');
      print("ID user connecté "  + id);
      runApp(MaterialApp(
          home: id == null
              ? new BlocProvider(
                  child: MaterialApp(
                    title: 'Flutter Demo',
                    theme: ThemeData(
                        primarySwatch: Colors.green,
                        fontFamily: 'Calibre-Semibold'),
                    home: new SplashScreen(
                        seconds: 5,
                        navigateAfterSeconds: new MyLoginPage(),
                        title: new Text(
                          'Bienvenue sur EarthState',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, color: Colors.grey, wordSpacing: 3),
                        ),
                        image: Image.asset(assetName),
                        styleTextUnderTheLoader: new TextStyle(),
                        photoSize: 100.0,
                        loaderColor: Colors.greenAccent),
                  ),
                )
              : new BlocProvider(
                  child: MaterialApp(
                    title: 'Flutter Demo',
                    theme: ThemeData(
                        primarySwatch: Colors.green,
                        fontFamily: 'Calibre-Semibold'),
                    home: new SplashScreen(
                        seconds: 5,
                        navigateAfterSeconds: new HomePage(
                          uid: id,
                        ),
                        title: new Text(
                          'Bienvenue sur EarthState',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, color: Colors.grey, wordSpacing: 3),
                        ),
                        image: Image.asset(assetName),
                        styleTextUnderTheLoader: new TextStyle(),
                        photoSize: 100.0,
                        loaderColor: Colors.greenAccent),
                  ),
                )));
    });

/*void main() {
  runApp(MyApp());
}*/

final Widget svg = new SvgPicture.asset(assetName, semanticsLabel: 'Acme Logo');

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new BlocProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.green, fontFamily: 'Calibre-Semibold'),
        home: new SplashScreen(
            seconds: 3,
            navigateAfterSeconds: new MyLoginPage(),
            title: new Text(
              'Bienvenue sur EarthState',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 20, color: Colors.grey, wordSpacing: 3),
            ),
            image: Image.asset(assetName),
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            loaderColor: Colors.greenAccent),
      ),
    );
  }
}
