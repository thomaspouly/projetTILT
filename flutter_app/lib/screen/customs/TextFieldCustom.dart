import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  TextFieldCustom(
      {this.controller, this.title, this.icon, this.hide, this.textError,this.type,this.editable,this.colors});

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
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return new TextField(
      
      controller: controller,
      enabled: editable,
      obscureText: hide,
      keyboardType: type,
      style: TextStyle(color: colors),
      decoration: new InputDecoration(
        labelText: title,
        border: OutlineInputBorder(),
        prefixIcon: icon,
        fillColor: Theme.of(context).primaryColorLight,
        filled: true,
        errorText: textError,
      ),
    );
  }
}
