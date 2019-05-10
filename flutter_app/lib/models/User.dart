import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String name;
  final DocumentReference reference;
  int treeNumber;

  User({this.email, this.name, this.treeNumber, this.reference});

  User.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['email'] != null),
        assert(map['name'] != null),
        assert(map['treeNumber'] != null),
        email = map['email'],
        name = map['name'],
        treeNumber = map['treeNumber'];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'treeNumber': treeNumber,
      };

  @override
  String toString() => "User<$email:$name:$treeNumber>";


}
