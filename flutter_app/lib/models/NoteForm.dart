import 'package:cloud_firestore/cloud_firestore.dart';

class NoteForm {
  String note;
  final DocumentReference reference;

  NoteForm({this.note,this.reference});

  NoteForm.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['note'] != null),
        note = map['note'];

  NoteForm.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() => {
    'note': note,
  };

  @override
  String toString() => "NoteForm<$note>";


}
