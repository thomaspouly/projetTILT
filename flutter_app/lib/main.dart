import 'package:flutter/material.dart';
import 'package:flutter_app/screen/register/register.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
<<<<<<< Updated upstream
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
  
          primarySwatch: Colors.green,
        ),
        home:MyHomePage(title: "is",));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
/*
    setState(() {
      _counter++;
    });*/
  }
=======
  var routes = <String, WidgetBuilder>{
    //"/Login": (BuildContext context) => new LoginPage(),
    "/Register": (BuildContext context) => new RegisterPage(),
  };
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.green),
      home: new RegisterPage(),
      routes: routes,
    );
  }
}
