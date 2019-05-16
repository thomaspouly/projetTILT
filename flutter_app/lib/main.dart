import 'package:flutter/material.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/home/home.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

final String assetName = 'assets/images/earth.png';

void main() {
  SharedPreferences.getInstance().then((prefs) {

    if(prefs.getString("theme") == null) {
      prefs.setString("theme","Défaut");
    }
    print("THEME: " + prefs.getString("theme"));

    if(prefs.getBool("nightMode") == null) {
      prefs.setBool("nightMode",false);
    }
    print("Night: " + prefs.getBool("nightMode").toString());

    var id = prefs.getString('id');
    bool nightMode = prefs.getBool("nightMode");

    Brightness b;
    if (nightMode == false || nightMode == null) {
      b = Brightness.light;
    } else {
      b = Brightness.dark;
    }
    runApp(MaterialApp(
      home: id == null
          ? new BlocProvider(
              child: DynamicTheme(
                  defaultBrightness: b,
                  data: (brightness) {
                    switch (prefs.getString("theme")) {
                      case "Bleu":
                        return ThemeData(
                            primarySwatch: Colors.blue, brightness: brightness);
                        break;
                      case "Rouge":
                        return ThemeData(
                            primarySwatch: Colors.red, brightness: brightness);
                        break;
                      default:
                        return ThemeData(
                            primarySwatch: Colors.green,
                            brightness: brightness);
                        break;
                    }
                  },
                  themedWidgetBuilder: (context, theme) {
                    return new MaterialApp(
                      title: 'Flutter Demo',
                      theme: theme,
                      home: new SplashScreen(
                          seconds: 5,
                          navigateAfterSeconds: new MyLoginPage(),
                          title: new Text(
                            'EarthState',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.green,
                                wordSpacing: 3),
                          ),
                          image: Image.asset(
                            "assets/images/earth.png",
                            width: 3000,
                          ),
                          styleTextUnderTheLoader: new TextStyle(),
                          photoSize: 100.0,
                          loaderColor: Colors.blue),
                    );
                  }))
          : new BlocProvider(
              child: DynamicTheme(
                  defaultBrightness: b,
                  data: (brightness) {
                    switch (prefs.getString("theme")) {
                      case "Bleu":
                        return ThemeData(
                            primarySwatch: Colors.blue, brightness: brightness);
                        break;
                      case "Rouge":
                        return ThemeData(
                            primarySwatch: Colors.red, brightness: brightness);
                        break;
                      default:
                        return ThemeData(
                            primarySwatch: Colors.green,
                            brightness: brightness);
                        break;
                    }
                  },
                  themedWidgetBuilder: (context, theme) {
                    return new MaterialApp(
                      title: 'Flutter Demo',
                      theme: theme,
                      home: new SplashScreen(
                          seconds: 5,
                          navigateAfterSeconds: new HomePage(
                            uid: id,
                          ),
                          title: new Text(
                            'EarthState',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                wordSpacing: 3),
                          ),
                          image: Image.asset(assetName),
                          styleTextUnderTheLoader: new TextStyle(),
                          photoSize: 100.0,
                          loaderColor: Colors.greenAccent),
                    );
                  }),
            ),
    ));
  });
}
