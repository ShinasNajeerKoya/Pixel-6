import 'package:pixel6_test/domain/constant_keys/address_constant_keys.dart';

class AddressModel {
  final String id;
  final String line1;
  final String line2;
  final String postcode;
  final String city;
  final String stateName;

  AddressModel({
    required this.id,
    required this.line1,
    required this.line2,
    required this.postcode,
    required this.city,
    required this.stateName,
  });

  // this is factory constructor for creating a new AddressModel instance from a map.
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json[AddressConstantKeys.id],
      line1: json[AddressConstantKeys.line1],
      line2: json[AddressConstantKeys.line2],
      postcode: json[AddressConstantKeys.postcode],
      city: json[AddressConstantKeys.city],
      stateName: json[AddressConstantKeys.state],
    );
  }

  // this method is for converting a AddressModel instance to a map.
  Map<String, dynamic> toJson() {
    return {
      AddressConstantKeys.id: id,
      AddressConstantKeys.line1: line1,
      AddressConstantKeys.line2: line2,
      AddressConstantKeys.postcode: postcode,
      AddressConstantKeys.city: city,
      AddressConstantKeys.state: stateName,
    };
  }
}
