import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(Login());
}

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

final String assetName = 'assets/earth.svg';
final String chaiseName = 'assets/chaise.svg';
final String tableName = 'assets/table.svg';
final Widget svg = new SvgPicture.asset(
    assetName,
    semanticsLabel: 'Acme Logo'
);

final Widget chaise = new SvgPicture.asset(
    chaiseName,
    semanticsLabel: 'Acme Logo'
);

final Widget table = new SvgPicture.asset(
    tableName,
    semanticsLabel: 'Acme Logo'
);

class Login extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter login UI',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final emailFieldController = TextEditingController();
  final passFieldController = TextEditingController();
  String _email;
  String _password;

  _MyHomePageState() {
    emailFieldController.addListener(_emailListen);
    passFieldController.addListener(_passwordListen);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Detache le controller quand tout est fini
    emailFieldController.dispose();
    passFieldController.dispose();
    super.dispose();
  }

  void _emailListen() {
    if (emailFieldController.text.isEmpty) {
    } else {
      _email = emailFieldController.text;
    }
  }

  void _passwordListen() {
    if (passFieldController.text.isEmpty) {
    } else {
      _password = passFieldController.text;
    }
  }

  @override
  Widget build(BuildContext context) {

    void validate() async {
      setState(() {
        _email = emailFieldController.text;
        _password = passFieldController.text;
      });
      if (_email != null && _password != null) {
        try {
          new FutureBuilder(
              future: FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _email, password: _password),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print("Test");
                } else {
                  if (snapshot.hasData) {
                    print("Vous êtes connecté");
                  }
                }
              }
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        }
        catch (e) {
          print('Error : ${e}');
        }
      }
    }

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
          validate();
        },
        child: Text("Login",
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
            padding: EdgeInsets.only(left: 36,right: 36,top:36),
            child: Column (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                svg,
                emailField,
                Column(
                  children : <Widget> [
                    passwordField,
                    Row(
                        children : <Widget> [
                          Expanded(
                              child :
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
                  children : <Widget> [
                    loginButon,
                    Row(
                        children : <Widget> [
                          Expanded(
                              child :
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


/*class MySecondPage extends StatefulWidget {
  MySecondPage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _MySecondPageState createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {

  final emailFieldController = TextEditingController();
  final passFieldController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    // Detache le controller quand tout est fini
    emailFieldController.dispose();
    passFieldController.dispose();
    super.dispose();
  }

  String _email;
  String _password;


  void validate () async {
    setState(() {
      _email = emailFieldController.text;
      _password = passFieldController.text;
    });
    if(_email != null && _password != null) {
      try {
        /*FirebaseUser user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: _email, password: _password);*/
        new FutureBuilder(
            future: FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _email, password: _password),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
              } else {
                if (snapshot.hasData) {
                  print("Compte créé");
                }

              }
            }
        );
      }
      catch(e) {
        print('Error : ${e}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final emailField = TextField(
      obscureText: false,
      style: style,
      controller: emailFieldController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      controller: passFieldController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          validate();
        },
        child: Text("Create",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child :Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 35.0),
                emailField,
                SizedBox(height: 15.0),
                passwordField,
                SizedBox(
                  height: 25.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
*/

/*class MyThirdPage extends StatefulWidget {
  MyThirdPage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _MyThirdPageState createState() => _MyThirdPageState();
}

class _MyThirdPageState extends State<MyThirdPage> {

  //ListObjet l;

  Widget allElement() {
    /* Widget contenu;
    DocumentReference documentReference = Firestore.instance.collection('users').document('or25BQqLM7gZODQdVwbQORGleh82');
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        User u = new User(datasnapshot.data['email'],datasnapshot.data['inventaire']);
        CollectionReference collection = Firestore.instance.collection('${datasnapshot.data['inventaire']}');
        Objet o;
        collection.getDocuments().then((datasnapshot){
          if(datasnapshot.documents!=null) {
            o = new Objet(id: datasnapshot.documents.elementAt(0)['id'],
                quantite: datasnapshot.documents.elementAt(0)['quantité'],
                url: datasnapshot.documents.elementAt(0)['url'],
                reference: null);
          }
        });
        contenu = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('${u}'),
            Text('${o}')
          ],
        );
      }
      else {
        print("No such user");
      }
    });

    return contenu;*/
    return  StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('objet').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text("None");
          case ConnectionState.done:
            return new Text("done");
          case ConnectionState.waiting:
            return new Text('Loading...');
          case ConnectionState.active:
            return ListObjet(liste: _createList(snapshot.data.documents));
        }
      },

    );
  }

  List<Objet> _createList(List<DocumentSnapshot> documents) {
    List<Objet> liste = List<Objet>();
    for(int i = 0; i < documents.length;i++) {
      Objet o;
      if(documents.elementAt(i)['url'] != null && documents.elementAt(i)['id'] != null && documents.elementAt(i)['quantité'] != null) {
        o = new Objet(
            id: documents.elementAt(i)['id'],
            quantite: documents.elementAt(i)['quantité'],
            url: documents.elementAt(i)['url'],
            reference: null
        );

        liste.add(o);
      }
    }
    return liste;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: allElement(),
    );
  }
}


//method, create empty list, inject in list and return list

class ListObjet extends StatelessWidget {

  final List<Objet> liste;

  ListObjet({Key key,@required this.liste});

  Widget _buildRow(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.network(liste.elementAt(index).url),
        Text('id : ${liste.elementAt(index).id.toString()}'),
        Text('quantité : ${liste.elementAt(index).quantite.toString()} \n\n'),
        FloatingActionButton(

        )
      ],
    );


  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildRow,
      itemCount: liste.length,
    );
  }
}*/