class Association {
  String presentation;
  String association;
  String link;

  Association({this.presentation, this.association,this.link});

  factory Association.fromJson(Map<String, dynamic> parsedJson) {
    return Association(
        presentation: parsedJson['presentation'],
        association: parsedJson['association'],
        link: parsedJson['link']);
  }

  Map<String, dynamic> toJson() => {
    'presentation': presentation,
    'association': association,
    'link': link,
  };
}
