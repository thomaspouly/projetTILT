import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/classement_bloc.dart';
import 'package:flutter_app/bloc/counter_bloc.dart';
import 'package:flutter_app/bloc/form_tree_bloc.dart';
import 'package:flutter_app/bloc/login_bloc.dart';
import 'package:flutter_app/bloc/register_bloc.dart';

class BlocProvider extends InheritedWidget {
  final loginBloc = LoginBloc();
  final registerBloc = RegisterBloc();
  final classementBloc = ClassementBloc();
  final formBloc = FormTreeBloc();
  final counterWidget = CounterBloc();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static CounterBloc ofCounter(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .counterWidget;
  }

  static LoginBloc ofLogin(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .loginBloc;
  }

  static RegisterBloc ofRegister(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .registerBloc;
  }

  static ClassementBloc ofClassement(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .classementBloc;
  }

  static FormTreeBloc ofFormTree(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .formBloc;
  }
}
