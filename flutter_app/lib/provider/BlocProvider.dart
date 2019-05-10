import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/classement_bloc.dart';
import 'package:flutter_app/bloc/counter_bloc.dart';
import 'package:flutter_app/bloc/form_tree_bloc.dart';
import 'package:flutter_app/bloc/login_bloc.dart';
import 'package:flutter_app/bloc/partenaire_bloc.dart';
import 'package:flutter_app/bloc/profil_bloc.dart';
import 'package:flutter_app/bloc/register_bloc.dart';
import 'package:flutter_app/bloc/theme_bloc.dart';

class BlocProvider extends InheritedWidget {
  final loginBloc = LoginBloc();
  final registerBloc = RegisterBloc();
  final rankingBloc = ClassementBloc();
  final formBloc = FormTreeBloc();
  final counterWidget = CounterBloc();
  final profilBloc = ProfilBloc();
  final partenaireBloc = PartenaireBloc();
  final themeBloc= ThemeBloc();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

 static ThemeBloc ofTheme(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .themeBloc;
  }




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

  static ClassementBloc ofRanking(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .rankingBloc;
  }

  static FormTreeBloc ofFormTree(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .formBloc;
  }

  static ProfilBloc ofProfil(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .profilBloc;
  }

  static PartenaireBloc ofPartenaire(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .partenaireBloc;
  }
}
