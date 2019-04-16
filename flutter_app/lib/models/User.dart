import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  String email;
  String name;
  final DocumentReference reference;
  int treeNumber;

  User({this.email, name, this.treeNumber, this.reference});


  User.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['name'] != null),
        assert(map['treeNumber'] != null),
        email = map['id'],
        name = map['name'],
        treeNumber = map['treeNumber'];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "User<$email:$name:$treeNumber>";

}