import 'package:cloud_firestore/cloud_firestore.dart';

class NoteForm {
  String value;
  final DocumentReference reference;

  NoteForm(
      {this.value,
        this.reference});

  NoteForm.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['value'] != null),
        value = map['value'];

  NoteForm.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() => {
    'value': value,
  };
}
