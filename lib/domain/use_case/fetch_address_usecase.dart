import 'package:pixel6_test/data/models/address_model.dart';
import 'package:pixel6_test/domain/repository/address_repository.dart';

class FetchAddressUseCase {
  final AddressRepository addressRepository;

  FetchAddressUseCase({required this.addressRepository});

  Future<AddressModel?> fetchAddressById(String addressId) async {
    return addressRepository.fetchAddressById(addressId);
  }

  Future<List<AddressModel>> getAddressList() async {
    return addressRepository.getAddressList();
  }
}
