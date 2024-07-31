import 'package:pixel6_test/domain/constant_keys/user_data_constant_keys.dart';

class UserDataModel {
  String username;
  String password;
  String email;
  String phoneNumber;
  String? image; // base64 encoded image string

  UserDataModel({
    required this.username,
    required this.password,
    required this.email,
    required this.phoneNumber,
    this.image,
  });

  // Convert a UserDataModel object into a Map object
  Map<String, dynamic> toJson() => {
        UserDataConstantKeys.username: username,
        UserDataConstantKeys.password: password,
        UserDataConstantKeys.email: email,
        UserDataConstantKeys.phoneNumber: phoneNumber,
        UserDataConstantKeys.image: image,
      };

  // Create a User object from a Map object
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      username: json[UserDataConstantKeys.username],
      password: json[UserDataConstantKeys.password],
      email: json[UserDataConstantKeys.email],
      phoneNumber: json[UserDataConstantKeys.phoneNumber],
      image: json[UserDataConstantKeys.image],
    );
  }
}
