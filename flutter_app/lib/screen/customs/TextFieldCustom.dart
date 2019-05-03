import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  TextFieldCustom(
      {this.controller, this.title, this.icon, this.hide, this.textError,this.type,this.editable});

  /// icon data to use (normally Icons.flight_takeoff or Icons.flight_land)
  final TextEditingController controller;

  /// Title to show
  final String title;
  final String textError;
  final TextInputType type;
  final bool editable;

  /// Airport to show
  final Icon icon;
  final bool hide;

  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: controller,
      enabled: editable,
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
