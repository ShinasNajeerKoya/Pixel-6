class PostcodeDetails {
  final String status;
  final int statusCode;
  final int postcode;
  final List<City> city;
  final List<State> state;

  PostcodeDetails({
    required this.status,
    required this.statusCode,
    required this.postcode,
    required this.city,
    required this.state,
  });

  factory PostcodeDetails.fromJson(Map<String, dynamic> json) {
    return PostcodeDetails(
      status: json['status'],
      statusCode: json['statusCode'],
      postcode: json['postcode'],
      city: (json['city'] as List).map((i) => City.fromJson(i)).toList(),
      state: (json['state'] as List).map((i) => State.fromJson(i)).toList(),
    );
  }
}

class City {
  final int id;
  final String name;

  City({
    required this.id,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}

class State {
  final int id;
  final String name;

  State({
    required this.id,
    required this.name,
  });

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json['id'],
      name: json['name'],
    );
  }
}
