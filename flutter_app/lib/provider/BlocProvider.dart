import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/classement_bloc.dart';
import 'package:flutter_app/bloc/login_bloc.dart';
import 'package:flutter_app/bloc/register_bloc.dart';

class BlocProvider extends InheritedWidget{
  final loginBloc = LoginBloc();
  final registerBloc = RegisterBloc();
  final classementBloc = ClassementBloc();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static LoginBloc ofLogin(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).loginBloc;
  }

  static RegisterBloc ofRegister(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).registerBloc;
  }

  static ClassementBloc ofClassement(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).classementBloc;
  }
}