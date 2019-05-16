import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String name;
  final DocumentReference reference;
  int treeNumber;
  int nbPomme;

  User({this.email, this.name, this.treeNumber,this.nbPomme, this.reference});

  User.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['email'] != null),
        assert(map['name'] != null),
        assert(map['nbPomme'] != null),
        assert(map['treeNumber'] != null),
        email = map['email'],
        name = map['name'],
        nbPomme = map['nbPomme'],
        treeNumber = map['treeNumber'];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'treeNumber': treeNumber,
        'nbPomme': nbPomme,
      };

  @override
  String toString() => "User<$email:$name:$treeNumber:$nbPomme>";


}
