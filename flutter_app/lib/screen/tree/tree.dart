import 'package:flutter/material.dart';
import 'package:flutter_app/screen/tree/form.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:fluttie/fluttie.dart';

class TreePage extends StatefulWidget {
  String uid;

  TreePage({this.uid});

  @override
  State<StatefulWidget> createState() {
    return new _TreePageState();
  }
}

class _TreePageState extends State<TreePage> {
  FluttieAnimationController tree;
  bool ready = false;

  @override
  initState() {
    super.initState();

    /// Load and prepare our animations after this widget has been added
    prepareAnimation();
  }

  // async because the plugin will have to do some background-work
  prepareAnimation() async {
    // Checks if the platform we're running on is supported by the animation plugin
    bool canBeUsed = await Fluttie.isAvailable();
    if (!canBeUsed) {
      print("Animations are not supported on this platform");
      return;
    }

    var instance = Fluttie();

    // Load our first composition for the emoji animation
    var emojiComposition =
        await instance.loadAnimationFromAsset("assets/animations/pot.json");
    // And prepare its animation, which should loop infinitely and take 2s per
    // iteration. Instead of RepeatMode.START_OVER, we could have choosen
    // REVERSE, which would play the animation in reverse on every second iteration.
    tree = await instance.prepareAnimation(emojiComposition,
        duration: const Duration(seconds: 10),
        repeatCount: const RepeatCount.infinite(),
        repeatMode: RepeatMode.START_OVER);

    // Loading animations may take quite some time. We should check that the
    // widget is still used before updating it, it might have been removed while
    // we were loading our animations!
    if (mounted) {
      setState(() {
        ready = true; // The animations have been loaded, we're ready
        tree.start(); //start our looped emoji animation
      });
    }
  }

  Widget buildStarContent(BuildContext context) {
    return FluttieAnimation(tree);
  }

  @override
  Widget build(BuildContext context) {
    Widget content =
        ready ? buildStarContent(context) : Text("Loading animation...");

    return new SafeArea(
      child: new Scaffold(
        backgroundColor: Colors.cyan[200],
        appBar: AppBar(
          backgroundColor: Colors.cyan[200],
          elevation: 0,
          centerTitle: true,
          title: Text("Votre arbre"),
        ),
        body: Stack(
          children: <Widget>[
            Center(
                child: Container(
              padding: EdgeInsets.only(bottom: 50),
              width: 300,
              height: 400,
              child: content,
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(bottom: 25),
                child: RaisedButton(
                  elevation: 5,
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyFormTreePage()),
                    );
                  },
                  child: Text("Formulaire",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEvolution() {
    var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Evolution de votre arbre:"),
          content: Container(
            margin: EdgeInsets.all(20),
            child: Sparkline(
              data: data,
              pointSize: 8,
              lineColor: Colors.blue,
              pointColor: Colors.blue[700],
              pointsMode: PointsMode.all,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}