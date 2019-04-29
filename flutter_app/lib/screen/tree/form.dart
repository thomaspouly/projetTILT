import 'package:flutter/material.dart';
import 'package:flutter_app/provider/BlocProvider.dart';
import 'package:flutter_app/screen/customs/TextFieldCustom.dart';

class MyFormTreePage extends StatefulWidget {
  MyFormTreePage({Key key}) : super(key: key);

  @override
  _MyFormTreePageState createState() => _MyFormTreePageState();
}

class _MyFormTreePageState extends State<MyFormTreePage> {
  double padding = 20;

  int _radioValueWaste;
  int _radioValueDon;
  int _radioValueBulk;
  int _radioValueBio;
  int _radioValueCar;
  int _radioValueBike;
  int _radioValueBus;

  final waterFieldController = TextEditingController();
  final electricityFieldController = TextEditingController();

  void _handleRadioValueChangeWaste(int value) {
    setState(() {
      _radioValueWaste = value;

      switch (_radioValueWaste) {
        case 0:
          //_result = ...
          break;
        case 1:
          //_result = ...
          break;
        case 2:
          //_result = ...
          break;
      }
    });
  }

  void _handleRadioValueChangeDon(int value) {
    setState(() {
      _radioValueDon = value;

      switch (_radioValueDon) {
        case 0:
        //_result = ...
          break;
        case 1:
        //_result = ...
          break;
        case 2:
        //_result = ...
          break;
      }
    });
  }

  void _handleRadioValueChangeBulk(int value) {
    setState(() {
      _radioValueBulk = value;

      switch (_radioValueBulk) {
        case 0:
        //_result = ...
          break;
        case 1:
        //_result = ...
          break;
        case 2:
        //_result = ...
          break;
      }
    });
  }

  void _handleRadioValueChangeBio(int value) {
    setState(() {
      _radioValueBio = value;

      switch (_radioValueBio) {
        case 0:
        //_result = ...
          break;
        case 1:
        //_result = ...
          break;
        case 2:
        //_result = ...
          break;
      }
    });
  }

  void _handleRadioValueChangeCar(int value) {
    setState(() {
      _radioValueCar = value;

      switch (_radioValueCar) {
        case 0:
        //_result = ...
          break;
        case 1:
        //_result = ...
          break;
        case 2:
        //_result = ...
          break;
      }
    });
  }

  void _handleRadioValueChangeBike(int value) {
    setState(() {
      _radioValueBike = value;

      switch (_radioValueBike) {
        case 0:
        //_result = ...
          break;
        case 1:
        //_result = ...
          break;
        case 2:
        //_result = ...
          break;
      }
    });
  }


  void _handleRadioValueChangeBus(int value) {
    setState(() {
      _radioValueBus = value;

      switch (_radioValueBus) {
        case 0:
        //_result = ...
          break;
        case 1:
        //_result = ...
          break;
        case 2:
        //_result = ...
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.ofFormTree(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(210, 251, 209, 1),
        body: Container(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                hide: false,
              ),
              TextFieldCustom(
                title: "Consommation d'éléctricité en kW/h",
                controller: electricityFieldController,
                icon: Icon(Icons.offline_bolt),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Trie dechets',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  new Radio(
                    value: 0,
                    groupValue: _radioValueWaste,
                    onChanged: _handleRadioValueChangeWaste,
                  ),
                  new Text(
                    'Oui',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: _radioValueWaste,
                    onChanged: _handleRadioValueChangeWaste,
                  ),
                  new Text(
                    'Non',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Don association',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  new Radio(
                    value: 0,
                    groupValue: _radioValueDon,
                    onChanged: _handleRadioValueChangeDon,
                  ),
                  new Text(
                    'Oui',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: _radioValueDon,
                    onChanged: _handleRadioValueChangeDon,
                  ),
                  new Text(
                    'Non',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Achat produit en vrac',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  new Radio(
                    value: 0,
                    groupValue: _radioValueBulk,
                    onChanged: _handleRadioValueChangeBulk,
                  ),
                  new Text(
                    'Oui',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: _radioValueBulk,
                    onChanged: _handleRadioValueChangeBulk,
                  ),
                  new Text(
                    'Non',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Achat produit bio',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  new Radio(
                    value: 0,
                    groupValue: _radioValueBio,
                    onChanged: _handleRadioValueChangeBio,
                  ),
                  new Text(
                    'Oui',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: _radioValueBio,
                    onChanged: _handleRadioValueChangeBio,
                  ),
                  new Text(
                    'Non',
                    style: new TextStyle(
                      fontSize: 16.0,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Voiture',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  new Radio(
                    value: 0,
                    groupValue: _radioValueCar,
                    onChanged: _handleRadioValueChangeCar,
                  ),
                  new Text(
                    'Régulièrement',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: _radioValueCar,
                    onChanged: _handleRadioValueChangeCar,
                  ),
                  new Text(
                    'Occasionnel',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  new Radio(
                    value: 2,
                    groupValue: _radioValueCar,
                    onChanged: _handleRadioValueChangeCar,
                  ),
                  new Text(
                    'Jamais',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Vélo',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  new Radio(
                    value: 0,
                    groupValue: _radioValueBike,
                    onChanged: _handleRadioValueChangeBike,
                  ),
                  new Text(
                    'Oui',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: _radioValueBike,
                    onChanged: _handleRadioValueChangeBike,
                  ),
                  new Text(
                    'Non',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Bus',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  new Radio(
                    value: 0,
                    groupValue: _radioValueBus,
                    onChanged: _handleRadioValueChangeBus,
                  ),
                  new Text(
                    'Oui',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: _radioValueBus,
                    onChanged: _handleRadioValueChangeBus,
                  ),
                  new Text(
                    'Non',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //bloc.enterDataFormForm(waterFieldController.text, valueElectricity, waste, don, bulk, bio, car, bike, bus)
                  new MaterialButton(
                    onPressed: null,
                    child: Text("Submit"),
                    color: Colors.blue,
                  ),
                  new MaterialButton(
                    onPressed: null,
                    child: Text("Annuler"),
                    color: Colors.blue,
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
