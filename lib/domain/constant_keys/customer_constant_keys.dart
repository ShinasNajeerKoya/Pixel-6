class CustomerConstantKeys {
  static const String customerId = 'customerId';
  static const String fullName = 'fullName';
  static const String pan = 'pan';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String addressId = 'addressId';
}

class AddOrEditCustomerConfig {
  final String? customerId;
  final String fullName;
  final String email;
  final String phone;
  final String pan;
  final String addressId;

  AddOrEditCustomerConfig({
    this.customerId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.pan,
    required this.addressId,
  });
}
