import 'package:cloud_firestore/cloud_firestore.dart';

class DataTreeForm {
  int valueWater, valueElectricity;
  String waste, don, bulk, bio, car, bike, bus;
  final DocumentReference reference;

  DataTreeForm(
      {this.valueWater,
      this.valueElectricity,
      this.waste,
      this.don,
      this.bulk,
      this.bio,
      this.car,
      this.bike,
      this.bus,
      this.reference});

  DataTreeForm.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['valueWater'] != null),
        assert(map['valueElectricity'] != null),
        assert(map['waste'] != null),
        assert(map['don'] != null),
        assert(map['bulk'] != null),
        assert(map['bio'] != null),
        assert(map['car'] != null),
        assert(map['bike'] != null),
        assert(map['bus'] != null),
        valueWater = map['valueWater'],
        valueElectricity = map['valueElectricity'],
        waste = map['waste'],
        don = map['don'],
        bulk = map['bulk'],
        bio = map['bio'],
        car = map['car'],
        bike = map['bike'],
        bus = map['bus'];

  DataTreeForm.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() => {
        'valueWater': valueWater,
        'valueElectricity': valueElectricity,
        'waste': waste,
        'don': don,
        'bulk': bulk,
        'bio': bio,
        'car': car,
        'bike': bike,
        'bus': bus,
      };
}
