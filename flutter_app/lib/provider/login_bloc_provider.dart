import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/login_bloc.dart';

class LoginBlocProvider extends InheritedWidget{
  final bloc = new LoginBloc();

  LoginBlocProvider({Key key, @required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;
}