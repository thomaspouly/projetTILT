class Association {
  int department;
  String association;

  Association({this.department, this.association});

  factory Association.fromJson(Map<String, dynamic> parsedJson) {
    return Association(
        department: parsedJson['rank'],
        association: parsedJson['associaion']);
  }

  Map<String, dynamic> toJson() => {
    'department': department,
    'associaion': association,
  };
}
