import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/login_bloc.dart';

class BlocProvider extends InheritedWidget{
  final loginBloc = LoginBloc();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).loginBloc;
  }
}