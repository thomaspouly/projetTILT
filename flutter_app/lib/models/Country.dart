class Country {
  int rank;
  String name;
  String value;

  Country({this.rank, this.name, this.value});

  factory Country.fromJson(Map<String, dynamic> parsedJson) {
    return Country(
        rank: parsedJson['rank'],
        name: parsedJson['name'],
        value: parsedJson['value']);
  }
}
