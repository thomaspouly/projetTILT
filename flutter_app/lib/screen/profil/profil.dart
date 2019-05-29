import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/FirestoreProvider.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';
import 'package:flutter_app/screen/home/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// INITIALISATION

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

final String assetName = 'assets/earth.svg';

final Widget svg = new SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo',
  width: 100,
  height: 100,
  color: Colors.green[300],
);

final String appleName = 'assets/apple.svg';

final Widget appleWidget = new SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo',
  width: 30,
  height: 30,
  color: Colors.green[300],
);

AuthProvider authProvider;
FirestoreProvider firestoreProvider;

// LOGIN PAGE

class MyProfilPage extends StatefulWidget {
  MyProfilPage({Key key, this.uid}) : super(key: key);

  String uid;

  @override
  _MyProfilPageState createState() => _MyProfilPageState();
}

class _MyProfilPageState extends State<MyProfilPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildImage() {
    Future<String> url = getImage(widget.uid);
    return new Container(
        child: new FutureBuilder<String>(
      future: url,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return CircularProgressIndicator();
          case ConnectionState.active:
            return CircularProgressIndicator();

          case ConnectionState.waiting:
            return CircularProgressIndicator();

          case ConnectionState.done:
            return new FlatButton(
              onPressed: null,
              child: new Container(
                  height: MediaQuery.of(context).size.height / 9,
                  width: MediaQuery.of(context).size.height / 9,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(snapshot.data),
                      ))),
            );
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.ofProfil(context);
    FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(210, 251, 209, 1));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    double padding = 50;

    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController pommeController = TextEditingController();
    TextEditingController addController = TextEditingController();

    Widget _buildTextFields() {
      return new FutureBuilder(
          future: bloc.getUserById(widget.uid),
          builder: (context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData) {
              pommeController.text = snapshot.data.nbPomme.toString();
              emailController.text = snapshot.data.email;
              nameController.text = snapshot.data.name;
              var email = new TextFieldCustom(
                icon: Icon(Icons.email),
                title: "Email",
                hide: false,
                colors: Theme.of(context).primaryColor,
                controller: emailController,
                editable: false,
              );
              var name = new TextFieldCustom(
                icon: Icon(Icons.person_outline),
                title: "Nom",
                hide: false,
                controller: nameController,
              );
              var addFriend = new TextFieldCustom(
                icon: Icon(Icons.person_outline),
                title: "Ajouter un amis, entrez son email",
                hide: false,
                controller: addController,
              );
              addController.text = "maxance@gmail.com";
              var pomme = new TextFieldCustom(
                icon: Icon(Icons.nature),
                title: "Nombre de pomme",
                hide: false,
                colors: Theme.of(context).primaryColor,
                editable: false,
                controller: pommeController,
              );
              return Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: name,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: email,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 50),
                    child: pomme,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 7,
                        right: MediaQuery.of(context).size.width / 7),
                    child: Material(
                      elevation: 5.0,
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                      child: MaterialButton(
                        onPressed: () {
                          if (email.controller.text.isEmpty) {
                            bloc.modifyUser(
                                widget.uid,
                                email.controller.text,
                                name.controller.text,
                                snapshot.data.treeNumber,
                                int.parse(pomme.controller.text),
                                snapshot.data.date,
                                snapshot.data.friendList);
                          } else if (name.controller.text.isEmpty) {
                            bloc.modifyUser(
                                widget.uid,
                                email.controller.text,
                                name.title,
                                snapshot.data.treeNumber,
                                int.parse(pomme.controller.text),
                                snapshot.data.date,
                                snapshot.data.friendList);
                          } else {
                            bloc.modifyUser(
                                widget.uid,
                                email.controller.text,
                                name.controller.text,
                                snapshot.data.treeNumber,
                                int.parse(pomme.controller.text),
                                snapshot.data.date,
                                snapshot.data.friendList);
                          }

                          Navigator.of(context).pop();
                        },
                        minWidth: MediaQuery.of(context).size.width,
                        child: AutoSizeText("Enregistrer",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    padding: EdgeInsets.only(bottom: 30),
                  ),
                  /*Container(
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 7,
                        right: MediaQuery.of(context).size.width / 7),
                    child: addFriend,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 7,
                        right: MediaQuery.of(context).size.width / 7),
                    child: Material(
                      elevation: 5.0,
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                      child: MaterialButton(
                        onPressed: () {
                          bloc.addUserInFriendList(addFriend.controller.text);
                        },
                        minWidth: MediaQuery.of(context).size.width,
                        child: AutoSizeText("Ajouter un amis via son email",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),*/
                ],
              );
            } else {
              return Text("Chargement");
            }
          });
    }

    Future getImageFromCamera() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        image = await ImageCropper.cropImage(
          sourcePath: image.path,
          ratioX: 1.0,
          ratioY: 1.0,
          maxWidth: 512,
          maxHeight: 512,
        );
        setState(() {
          bloc.modifyImageUser(image);
        });
      }
    }

    Future getImageFromGallery() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        image = await ImageCropper.cropImage(
          sourcePath: image.path,
          ratioX: 1.0,
          ratioY: 1.0,
          maxWidth: 512,
          maxHeight: 512,
        );
        setState(() {
          bloc.modifyImageUser(image);
        });
      }
    }

    double paddingModal = 20;
    double paddingBetweenFlat = 50;

    void _settingModalBottomSheet(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10, top: paddingModal),
                margin: EdgeInsets.only(bottom: paddingModal),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Changer votre photo de profil",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                margin:
                    EdgeInsets.only(top: paddingModal, bottom: paddingModal),
                padding: EdgeInsets.only(),
                child: Row(
                  children: <Widget>[
                    new Column(children: <Widget>[
                      Container(
                        child: FlatButton(
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
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Caméra"),
                        ),
                      ),
                    ]),
                    new Column(
                      children: <Widget>[
                        Container(
                          child: FlatButton(
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
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text("Gallerie"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]);
          });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profil"),
        ),
        body: Container(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: Stack(
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          child: _buildImage(),
                          onPressed: () {
                            _settingModalBottomSheet(context);
                          },
                        )
                      ],
                    ),
                    _buildTextFields(),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
