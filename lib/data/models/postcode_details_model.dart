import 'package:pixel6_test/domain/constant_keys/postcode_constant_keys.dart';

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
      status: json[PostCodeConstantKeys.status],
      statusCode: json[PostCodeConstantKeys.statusCode],
      postcode: json[PostCodeConstantKeys.postcode],
      city: (json[PostCodeConstantKeys.city] as List).map((i) => City.fromJson(i)).toList(),
      state: (json[PostCodeConstantKeys.state] as List).map((i) => State.fromJson(i)).toList(),
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
      id: json[CityStateConstantKeys.id],
      name: json[CityStateConstantKeys.name],
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
      id: json[CityStateConstantKeys.id],
      name: json[CityStateConstantKeys.name],
    );
  }
}
