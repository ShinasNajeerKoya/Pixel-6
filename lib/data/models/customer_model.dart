import 'package:pixel6_test/data/models/address_model.dart';
import 'package:pixel6_test/domain/constant_keys/customer_constant_keys.dart';

class CustomerModel {
  final String customerId;
  final String fullName;
  final String pan;
  final String email;
  final String phone;
  final AddressModel? addressModel;

  CustomerModel({
    required this.customerId,
    required this.fullName,
    required this.pan,
    required this.email,
    required this.phone,
    required this.addressModel,
  });

  // this is factory constructor for creating a new CustomerModel instance from a map.
  factory CustomerModel.fromJson(Map<String, dynamic> json, {AddressModel? addressModel}) {
    return CustomerModel(
      customerId: json[CustomerConstantKeys.customerId],
      fullName: json[CustomerConstantKeys.fullName],
      pan: json[CustomerConstantKeys.pan],
      email: json[CustomerConstantKeys.email],
      phone: json[CustomerConstantKeys.phone],
      addressModel: addressModel,
    );
  }

  // this method is for converting a CustomerModel instance to a map.
  Map<String, dynamic> toJson() {
    return {
      CustomerConstantKeys.customerId: customerId,
      CustomerConstantKeys.fullName: fullName,
      CustomerConstantKeys.pan: pan,
      CustomerConstantKeys.email: email,
      CustomerConstantKeys.phone: phone,
      // CustomerConstantKeys.state: addressModel,
    };
  }
}
