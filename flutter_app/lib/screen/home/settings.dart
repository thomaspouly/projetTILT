import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter_app/screen/home/home.dart';
import 'package:flutter_app/screen/login/login.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class Settings extends StatefulWidget {
  final String uid;
  Settings({this.uid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
  String _currentThemeSelected;
  var heightScreen;
  bool nightMode;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        if (prefs.getBool("nightMode")!=null) {
          nightMode = prefs.getBool("nightMode");
        } else {
          nightMode = false;
        }

        _currentThemeSelected = prefs.getString("theme");
      });
      print("NIGHTMODE PREFS: " + prefs.getBool("nightMode").toString());
      print("Theme: " + _currentThemeSelected);
    });
  }


  void changeBrightness(bool b) {
  
    setState(() {
      DynamicTheme.of(context).setBrightness(
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark);
    });

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("nightMode", b);
    });
  }

  void changeTheme(String theme) {
    switch (theme) {
      case "Bleu":
        DynamicTheme.of(context)
            .setThemeData(new ThemeData(primarySwatch: Colors.blue));
        break;
      case "Rouge":
        DynamicTheme.of(context)
            .setThemeData(new ThemeData(primarySwatch: Colors.red));
        break;
      default:
        DynamicTheme.of(context)
            .setThemeData(new ThemeData(primarySwatch: Colors.green));
        break;
    }

setState(() {
  if(nightMode)nightMode=false;
});
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("theme", theme);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Theme: " + nightMode.toString());

    heightScreen = MediaQuery.of(context).size.height;
    double sizeIconTiles = 30;
    double sizeTextTiles = 15;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Paramètres"),
        ),
        body: Wrap(
          children: <Widget>[
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Thème', style: TextStyle(fontSize: sizeTextTiles)),
                  DropdownButton<String>(
                    value: _currentThemeSelected,
                    onChanged: (String newValue) {
                      setState(() {
                        _currentThemeSelected = newValue;
                        changeTheme(_currentThemeSelected);
                      });
                    },
                    items: <String>['Défaut', 'Rouge', 'Bleu']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: heightScreen / 40),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              leading: Icon(
                Icons.brightness_1,
                size: sizeIconTiles,
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Mode nuit', style: TextStyle(fontSize: sizeTextTiles)),
                  Switch(
                    value: nightMode,
                    onChanged: (value) {
                      setState(() {
                        nightMode = value;
                      });
                      print("hi");
                      changeBrightness(nightMode);
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  )
                ],
              ),
              leading: Icon(
                Icons.brightness_3,
                size: sizeIconTiles,
              ),
            ),
            ListTile(
              title: Text('Deconnexion',
                  style: TextStyle(fontSize: sizeTextTiles)),
              leading: Icon(
                Icons.power_settings_new,
                size: sizeIconTiles,
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                prefs.remove("id").then((onValue) {
                  print("ID PREFSDECO: " + prefs.getString('id').toString());

 Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyLoginPage()),
                );

                
                }).catchError((onError) {
                  print(onError);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
