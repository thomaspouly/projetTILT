import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/classement_bloc.dart';
import 'package:flutter_app/bloc/counter_bloc.dart';
import 'package:flutter_app/bloc/form_tree_bloc.dart';
import 'package:flutter_app/bloc/friend_bloc.dart';
import 'package:flutter_app/bloc/home_bloc.dart';
import 'package:flutter_app/bloc/login_bloc.dart';
import 'package:flutter_app/bloc/partner_bloc.dart';
import 'package:flutter_app/bloc/profile_bloc.dart';
import 'package:flutter_app/bloc/register_bloc.dart';

class BlocProvider extends InheritedWidget {
  final loginBloc = LoginBloc();
  final registerBloc = RegisterBloc();
  final rankingBloc = ClassementBloc();
  final formBloc = FormTreeBloc();
  final counterWidget = CounterBloc();
  final profileBloc = ProfileBloc();
  final partnerBloc = PartnerBloc();
  final homeBloc = HomeBloc();
  final friendBloc = FriendBloc();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static FriendBloc ofFriend(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .friendBloc;
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

  static ProfileBloc ofProfil(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .profileBloc;
  }

  static PartnerBloc ofPartenaire(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .partnerBloc;
  }

  static HomeBloc ofHome(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .homeBloc;
  }
}
