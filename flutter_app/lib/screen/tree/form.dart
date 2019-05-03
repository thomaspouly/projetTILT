import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class MyFormTreePage extends StatefulWidget {
  MyFormTreePage({Key key}) : super(key: key);

  @override
  _MyFormTreePageState createState() => _MyFormTreePageState();
}

class _MyFormTreePageState extends State<MyFormTreePage> {
  double padding = 10;

  int note = 1;

  int _radioValueWaste,
      _radioValueDon,
      _radioValueBulk,
      _radioValueBio,
      _radioValueCar,
      _radioValueBike,
      _radioValueBus;

  String textWaste, textDon, textBulk, textBio, textCar, textBike, textBus;

  final waterFieldController = TextEditingController();
  final electricityFieldController = TextEditingController();

  void _handleRadioValueChangeWaste(int value) {
    setState(() {
      _radioValueWaste = value;

      switch (_radioValueWaste) {
        case 0:
          textWaste = "Oui";
          break;
        case 1:
          textWaste = "Non";
          break;
      }
    });
  }

  void _handleRadioValueChangeDon(int value) {
    setState(() {
      _radioValueDon = value;

      switch (_radioValueDon) {
        case 0:
          textDon = "Oui";
          break;
        case 1:
          textDon = "Non";
          break;
      }
    });
  }

  void _handleRadioValueChangeBulk(int value) {
    setState(() {
      _radioValueBulk = value;

      switch (_radioValueBulk) {
        case 0:
          textBulk = "Oui";
          break;
        case 1:
          textBulk = "Non";
          break;
      }
    });
  }

  void _handleRadioValueChangeBio(int value) {
    setState(() {
      _radioValueBio = value;

      switch (_radioValueBio) {
        case 0:
          textBio = "Oui";
          break;
        case 1:
          textBio = "Non";
          break;
      }
    });
  }

  void _handleRadioValueChangeCar(int value) {
    setState(() {
      _radioValueCar = value;

      switch (_radioValueCar) {
        case 0:
          textCar = "Régulièrement";
          break;
        case 1:
          textCar = "Occasionnel";
          break;
        case 2:
          textCar = "Jamais";
          break;
      }
    });
  }

  void _handleRadioValueChangeBike(int value) {
    setState(() {
      _radioValueBike = value;

      switch (_radioValueBike) {
        case 0:
          textBike = "Oui";
          break;
        case 1:
          textBike = "Non";
          break;
      }
    });
  }

  void _handleRadioValueChangeBus(int value) {
    setState(() {
      _radioValueBus = value;

      switch (_radioValueBus) {
        case 0:
          textBus = "Oui";
          break;
        case 1:
          textBus = "Non";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.ofFormTree(context);
    FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(210, 251, 209, 1));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    double fontSize = 18;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(210, 251, 209, 1),
        body: Container(
          child: Stack(
            children: <Widget>[
              ListView(
                padding: EdgeInsets.only(left: padding, right: padding),
                children: <Widget>[
                  Text(
                    "Consommations",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  TextFieldCustom(
                    title: "Consommation d'eau en m²",
                    controller: waterFieldController,
                    icon: Icon(Icons.opacity),
                    type: TextInputType.number,
                    hide: false,
                  ),
                  TextFieldCustom(
                    title: "Consommation d'éléctricité en kW/h",
                    controller: electricityFieldController,
                    icon: Icon(Icons.offline_bolt),
                    type: TextInputType.number,
                    hide: false,
                  ),
                  new Container(
                    height: 5.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.amber,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  ),
                  Text(
                    "Actions",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new AutoSizeText(
                        'Trie dechets',
                        minFontSize: 6,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Oui',
                            minFontSize: 6,
                            style: TextStyle(fontSize: fontSize),
                          ),
                          value: 0,
                          groupValue: _radioValueWaste,
                          onChanged: _handleRadioValueChangeWaste,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Non',
                            minFontSize: 6,
                            style: TextStyle(fontSize: fontSize),
                          ),
                          value: 1,
                          groupValue: _radioValueWaste,
                          onChanged: _handleRadioValueChangeWaste,
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new AutoSizeText(
                        'Don association',
                        minFontSize: 6,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Oui',
                            minFontSize: 6,
                            style: TextStyle(fontSize: fontSize),
                          ),
                          value: 0,
                          groupValue: _radioValueDon,
                          onChanged: _handleRadioValueChangeDon,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Non',
                            minFontSize: 6,
                            style: TextStyle(fontSize: fontSize),
                          ),
                          value: 1,
                          groupValue: _radioValueDon,
                          onChanged: _handleRadioValueChangeDon,
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new AutoSizeText(
                        'Achat produit en vrac',
                        minFontSize: 6,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Oui',
                            minFontSize: 6,
                            style: TextStyle(fontSize: fontSize),
                          ),
                          value: 0,
                          groupValue: _radioValueBulk,
                          onChanged: _handleRadioValueChangeBulk,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Non',
                            minFontSize: 6,
                            style: TextStyle(fontSize: fontSize),
                          ),
                          value: 1,
                          groupValue: _radioValueBulk,
                          onChanged: _handleRadioValueChangeBulk,
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new AutoSizeText(
                        'Achat produit bio',
                        minFontSize: 6,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Oui',
                            minFontSize: 6,
                            style: TextStyle(fontSize: fontSize),
                          ),
                          value: 0,
                          groupValue: _radioValueBio,
                          onChanged: _handleRadioValueChangeBio,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Non',
                            minFontSize: 6,
                            style: TextStyle(fontSize: fontSize),
                          ),
                          value: 1,
                          groupValue: _radioValueBio,
                          onChanged: _handleRadioValueChangeBio,
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    height: 5.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.amber,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  ),
                  Text(
                    "Utilitaires",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new AutoSizeText(
                        'Voiture',
                        minFontSize: 6,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Régulièrement',
                            minFontSize: 6,
                            style: TextStyle(fontSize: 12),
                          ),
                          value: 0,
                          groupValue: _radioValueCar,
                          onChanged: _handleRadioValueChangeCar,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Occasionnel',
                            minFontSize: 6,
                            style: TextStyle(fontSize: 12),
                          ),
                          value: 1,
                          groupValue: _radioValueCar,
                          onChanged: _handleRadioValueChangeCar,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Jamais',
                            minFontSize: 6,
                            style: TextStyle(fontSize: 12),
                          ),
                          value: 2,
                          groupValue: _radioValueCar,
                          onChanged: _handleRadioValueChangeCar,
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new AutoSizeText(
                        'Vélo',
                        minFontSize: 6,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Oui',
                            minFontSize: 6,
                            style: TextStyle(fontSize: fontSize),
                          ),
                          value: 0,
                          groupValue: _radioValueBike,
                          onChanged: _handleRadioValueChangeBike,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Non',
                            minFontSize: 6,
                            style: TextStyle(fontSize: fontSize),
                          ),
                          value: 1,
                          groupValue: _radioValueBike,
                          onChanged: _handleRadioValueChangeBike,
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new AutoSizeText(
                        'Bus',
                        minFontSize: 6,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Oui',
                            minFontSize: 6,
                            style: TextStyle(fontSize: fontSize),
                          ),
                          value: 0,
                          groupValue: _radioValueBus,
                          onChanged: _handleRadioValueChangeBus,
                        ),
                      ),
                      new Expanded(
                        child: new RadioListTile(
                          title: AutoSizeText(
                            'Non',
                            minFontSize: 6,
                            style: TextStyle(fontSize: fontSize),
                          ),
                          value: 1,
                          groupValue: _radioValueBus,
                          onChanged: _handleRadioValueChangeBus,
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //bloc.enterDataFormForm(waterFieldController.text, valueElectricity, waste, don, bulk, bio, car, bike, bus)
                      new MaterialButton(
                        child: AutoSizeText("Submit",minFontSize: 10,),
                        color: Colors.blue,
                        onPressed: () {
                          note = 1;
                          /*bloc.enterDataFormForm(
                              int.parse(waterFieldController.text),
                              int.parse(electricityFieldController.text),
                              textWaste,
                              textDon,
                              textBulk,
                              textBio,
                              textCar,
                              textBike,
                              textBus);*/

                          if(_radioValueWaste.toString() == "0") {
                            note++;
                          }
                          if(_radioValueDon.toString() == "0") {
                            note++;
                          }
                          if(_radioValueBulk.toString() == "0") {
                            note++;
                          }
                          if(_radioValueBio.toString() == "0") {
                            note++;
                          }
                          if(_radioValueCar.toString() == "1" || _radioValueCar.toString() == "2") {
                            note++;
                          }
                          if(_radioValueBike.toString() == "0") {
                            note++;
                          }
                          if(_radioValueBus.toString() == "0") {
                            note++;
                          }
                          if(int.parse(waterFieldController.text) <= 123456789) {
                            note++;
                          }
                          if(int.parse(electricityFieldController.text) <= 123456789) {
                            note++;
                          }

                          bloc.enterNote(note.toString());
                          Navigator.of(context).pop();
                        },
                      ),
                      new MaterialButton(
                        child: Text("Annuler"),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
