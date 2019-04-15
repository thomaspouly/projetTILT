import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  TextFieldCustom({this.controller, this.title, this.icon});
  /// icon data to use (normally Icons.flight_takeoff or Icons.flight_land)
  final TextEditingController controller;
  /// Title to show
  final String title;
  /// Airport to show
  final Icon icon;
  @override
  Widget build(BuildContext context) {
 return new TextField(
              controller: controller,
              decoration: new InputDecoration(
                labelText: title,
                border: OutlineInputBorder(),
                prefixIcon: icon,
                fillColor: Colors.green[100],
                filled: true,
              ),
            );
  }
}