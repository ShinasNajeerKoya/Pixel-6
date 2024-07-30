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
      status: json['status'],
      statusCode: json['statusCode'],
      isValid: json['isValid'],
      fullName: json['fullName'],
    );
  }

  // this method is for converting a PanDetailsModel instance to a map.
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'isValid': isValid,
      'fullName': fullName,
    };
  }
}
