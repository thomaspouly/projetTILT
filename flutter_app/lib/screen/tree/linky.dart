import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class Linky extends StatefulWidget {
  @override
  _LinkyState createState() => _LinkyState();
}

class _LinkyState extends State<Linky> {
  var heightScreen;
  String t = "";
  File pickedImage;

  bool isImageLoaded = false;

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      image = await ImageCropper.cropImage(
        sourcePath: image.path,
       
      );
      setState(() {
        pickedImage = image;
        isImageLoaded = true;
      });
    }
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      image = await ImageCropper.cropImage(
        sourcePath: image.path,
      );
      setState(() {
        pickedImage = image;
        isImageLoaded = true;
      });
    }
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();

    VisionText readText = await recognizeText.processImage(ourImage);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          setState(() {
            t += " " + word.text;
          });
        }
      }
    }
  }
/*

 detectPicture() {
 
final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);
   final VisionEdgeImageLabeler visionEdgeLabeler = FirebaseVision.instance.visionEdgeImageLabeler(
 'auto_ml', 
 VisionEdgeImageLabelerOptions(confidenceThreshold: 0.5)
);
 visionEdgeLabeler.processImage(visionImage).then((onValue){
for(int i=0;i<onValue.length;i++){
  final String text = onValue[i].text;
  final double confidence =  onValue[i].confidence;

  setState(() {
    t+="\nTexte:"+text+" ; Confidence"+confidence.toString();
  });
}
  
  });



  
  }
*/

  Widget _buildImage() {
    return new Container(
        margin: EdgeInsets.only(bottom: 10),
        child: pickedImage == null
            ? new Column(children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center
                    ,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          getImageFromCamera();
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(
                            Icons.photo_camera,
                            size: 40,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          getImageFromGallery();
                        },
                        child: new CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(
                            Icons.photo_library,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  width: heightScreen / 3,
                ),
              ])
            : Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    width: 300,
                    child: Image.file(pickedImage),
                  ),
                  RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Theme.of(context).primaryColorLight,
                    child: Text("Changer"),
                    onPressed: () {
                      setState(() {
                        pickedImage = null;
                      });
                    },
                  )
                ],
              ));
  }

  @override
  Widget build(BuildContext context) {
    heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: _buildImage(),
        ),
        RaisedButton(
          child: Text('Read Text'),
          onPressed: readText,
          
        ),
        RaisedButton(
          child: Text('Détecter image'),
         // onPressed: detectPicture,
          
        ),
        RaisedButton(
          child: Text('Clear Text'),
          onPressed: (){setState(() {
            t="";
          });},
          
        ),
        Text(
          "Résultat:",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          t,
          style: TextStyle(fontSize: 15),
        )
      ],
    )));
  }
}
