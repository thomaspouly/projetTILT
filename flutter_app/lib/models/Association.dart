class Association {
  int department;
  String association;
  String link;

  Association({this.department, this.association,this.link});

  factory Association.fromJson(Map<String, dynamic> parsedJson) {
    return Association(
        department: parsedJson['rank'],
        association: parsedJson['association'],
        link: parsedJson['link']);
  }

  Map<String, dynamic> toJson() => {
    'department': department,
    'association': association,
    'link': link,
  };
}
