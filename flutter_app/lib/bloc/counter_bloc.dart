import 'package:flutter/material.dart';

class CounterBloc {
  double counter;
  double increment;

  setCounter(double value, double incr) {
    counter = value;
    increment = incr;
  }

  increase() {
    counter=counter+ (increment/10);
  }
}
