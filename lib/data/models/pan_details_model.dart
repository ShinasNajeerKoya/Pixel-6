import 'package:pixel6_test/domain/constant_keys/pan_details_constant_keys.dart';

class PanDetailsModel {
  final String status;
  final int statusCode;
  final bool isValid;
  final String fullName;

  PanDetailsModel({
    required this.status,
    required this.statusCode,
    required this.isValid,
    required this.fullName,
  });

  // this is factory constructor for creating a new PanDetailsModel instance from a map.
  factory PanDetailsModel.fromJson(Map<String, dynamic> json) {
    return PanDetailsModel(
      status: json[PanDetailsConstantKeys.status],
      statusCode: json[PanDetailsConstantKeys.statusCode],
      isValid: json[PanDetailsConstantKeys.isValid],
      fullName: json[PanDetailsConstantKeys.fullName],
    );
  }

  // this method is for converting a PanDetailsModel instance to a map.
  Map<String, dynamic> toJson() {
    return {
      PanDetailsConstantKeys.status: status,
      PanDetailsConstantKeys.statusCode: statusCode,
      PanDetailsConstantKeys.isValid: isValid,
      PanDetailsConstantKeys.fullName: fullName,
    };
  }
}
