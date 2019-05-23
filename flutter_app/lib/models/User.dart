import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String name;
  final DocumentReference reference;
  int treeNumber;
  int nbPomme;
  String date;
  List<User> friendList;

  User(
      {this.email,
      this.name,
      this.treeNumber,
      this.nbPomme,
      this.reference,
      this.date,
      this.friendList});

  User.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['email'] != null),
        assert(map['name'] != null),
        assert(map['nbPomme'] != null),
        assert(map['treeNumber'] != null),
        assert(map['date'] != null),
        assert(map['friendList'] != null),
        email = map['email'],
        name = map['name'],
        nbPomme = map['nbPomme'],
        treeNumber = map['treeNumber'],
        date = map['date'],
        friendList = map['friendList'];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'treeNumber': treeNumber,
        'nbPomme': nbPomme,
        'date': date,
        'friendList': friendList,
      };

  @override
  String toString() =>
      "User<$email:$name:$treeNumber:$nbPomme:$date:$friendList>";
}
