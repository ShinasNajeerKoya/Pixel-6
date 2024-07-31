import 'package:pixel6_test/domain/repository/address_repository.dart';

class SaveAddressUseCase {
  final AddressRepository addressRepository;

  SaveAddressUseCase({required this.addressRepository});

  Future<bool> saveAddressToPrefs({
    String? addressId,
    required String line1,
    String? line2,
    required String postcode,
    required String city,
    required String state,
  }) async {
    return addressRepository.saveAddressToPrefs(
      addressId: addressId,
      line1: line1,
      line2: line2,
      postcode: postcode,
      city: city,
      state: state,
    );
  }

}
