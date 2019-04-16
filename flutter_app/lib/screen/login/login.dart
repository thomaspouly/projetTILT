import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/login_bloc.dart';
import 'package:flutter_app/provider/login_bloc_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

// INITIALISATION

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

final String assetName = 'assets/earth.svg';
final String chaiseName = 'assets/chaise.svg';
final String tableName = 'assets/table.svg';
final Widget svg = new SvgPicture.asset(assetName, semanticsLabel: 'Acme Logo');

final Widget chaise =
new SvgPicture.asset(chaiseName, semanticsLabel: 'Acme Logo');

final Widget table =
new SvgPicture.asset(tableName, semanticsLabel: 'Acme Logo');


// LOGIN PAGE

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key, this.title, this.child}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  LoginBloc bloc;

  final Widget child;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();


}

class _MyLoginPageState extends State<MyLoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final emailFieldController = TextEditingController();
  final passFieldController = TextEditingController();
  String _email;
  String _password;
  LoginBloc _bloc;

  _MyLoginPageState() {
    emailFieldController.addListener(_emailListen);
    passFieldController.addListener(_passwordListen);
  }

  void _emailListen() {
    if (emailFieldController.text.isEmpty) {
      _email = "";
    } else {
      _email = emailFieldController.text;
    }
  }

  void _passwordListen() {
    if (passFieldController.text.isEmpty) {
      _password = "";
    } else {
      _password = passFieldController.text;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Detache le controller quand tout est fini
    emailFieldController.dispose();
    passFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);

    /*return new LoginBlocProvider(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('On t\'a niqué enculé'),
        ),
        body: FlatButton(onPressed: () =>  print(_bloc.toString()), child: Text("ich ich")),
      ),
    );*/

    //_bloc = LoginBlocProvider.of(context);

    final emailField = TextField(
      obscureText: false,
      style: style,
      controller: emailFieldController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder()),
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      controller: passFieldController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder()),
    );
    final loginButon = Material(
      elevation: 5.0,
      color: Color.fromRGBO(32, 168, 30, 1),
      child: MaterialButton(
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          bloc.submit(emailFieldController.text,passFieldController.text);
        },
        child: Text(bloc.toString(),
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final _register = MaterialButton(
      padding: EdgeInsets.all(0),
      child: Text("Register",
        textAlign: TextAlign.end,
        style: TextStyle(color: Color.fromRGBO(32, 168, 30, 1),),
      ),
    );

    final _forgot = MaterialButton(
      padding: EdgeInsets.all(0),
      child: Text("Forgot password ?",
        textAlign: TextAlign.end,
        style: TextStyle(color: Color.fromRGBO(32, 168, 30, 1),),
      ),
    );

    final _continue = MaterialButton(
        child: Text("Continuer en tant qu'invité",
          style: TextStyle(color: Color.fromRGBO(32, 168, 30, 1),),

        ));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(210, 251, 209, 1),
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 36, right: 36, top: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                svg,
                emailField,
                Column(
                  children: <Widget>[
                    passwordField,
                    Row(
                        children: <Widget>[
                          Expanded(
                              child:
                              Align(
                                alignment: Alignment.topRight,
                                child: _forgot,
                              )
                          ),
                        ]
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    loginButon,
                    Row(
                        children: <Widget>[
                          Expanded(
                              child:
                              Align(
                                alignment: Alignment.centerRight,
                                child: _register,
                              )
                          ),
                        ]
                    ),
                  ],
                ),
                _continue,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTree extends StatefulWidget {
  @override
  _MyTreeState createState() => new _MyTreeState();
}

class _MyTreeState extends State<MyTree> {
  @override
  Widget build(BuildContext context) {
    return new BlocProvider(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('On t\'a niqué enculé'),
        ),
      ),
    );
  }
}

