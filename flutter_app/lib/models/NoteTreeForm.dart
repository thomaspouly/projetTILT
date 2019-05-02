import 'package:cloud_firestore/cloud_firestore.dart';

class NoteTreeForm {
  String note;
  final DocumentReference reference;

  NoteTreeForm(
      {this.note,
        this.reference});

  NoteTreeForm.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['note'] != null),
        note = map['note'];

  NoteTreeForm.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() => {
    'note': note,
  };
}
