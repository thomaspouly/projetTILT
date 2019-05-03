import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  TextFieldCustom(
      {this.controller, this.title, this.icon, this.hide, this.textError,this.type});

  /// icon data to use (normally Icons.flight_takeoff or Icons.flight_land)
  final TextEditingController controller;

  /// Title to show
  final String title;
  final String textError;
  final TextInputType type;

  /// Airport to show
  final Icon icon;
  final bool hide;

  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: controller,
      obscureText: hide,
      keyboardType: type,
      decoration: new InputDecoration(
        labelText: title,
        border: OutlineInputBorder(),
        prefixIcon: icon,
        fillColor: Colors.green[100],
        filled: true,
        errorText: textError,
      ),
    );
  }
}
