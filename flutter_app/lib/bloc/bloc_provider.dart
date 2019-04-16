import 'package:flutter/material.dart';
import 'register_bloc.dart';
class BlocProvider extends InheritedWidget{
  final bloc = RegisterBloc();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static RegisterBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bloc;
  }
}