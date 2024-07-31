import 'package:pixel6_test/data/models/address_model.dart';
import 'package:pixel6_test/domain/repository/address_repository.dart';

class DeleteAddressUseCase {
  final AddressRepository addressRepository;

  DeleteAddressUseCase({required this.addressRepository});

  Future<List<AddressModel>> deleteSelectedAddress(int index) async {
    return addressRepository.deleteSelectedAddress(index);
  }
}
