import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/bloc/register_bloc.dart';
import 'package:flutter_app/provider/BlocProvider.dart';

class HomePage extends StatefulWidget {


  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _HomePageState();

  static RegisterBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .registerBloc;
  }
}

class _HomePageState extends State<HomePage> {

  RegisterBloc _bloc;


  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.ofRegister(context);
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: SafeArea(
         child: Center(
           child: new FloatingActionButton(
                onPressed: (){},
                tooltip: 'Pick Image',
                child: new Container(
      width: 300.0,
      height: 300.0,
      decoration: new BoxDecoration(
        
          shape: BoxShape.circle,
          image: new DecorationImage(
          fit: BoxFit.fill,
          image:NetworkImage('url'),
        

                 )
)),
              ),
                    
         )
        ),
      ),
    );
  }
}