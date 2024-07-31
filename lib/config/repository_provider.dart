import 'package:pixel6_test/data/service/pan_service.dart';
import 'package:pixel6_test/data/service/postcode_service.dart';
import 'package:pixel6_test/domain/repository/address_repository.dart';
import 'package:pixel6_test/domain/repository/customer_repository.dart';
import 'package:pixel6_test/domain/repository/pancard_repository.dart';
import 'package:pixel6_test/domain/repository/postcode_details_repository.dart';

PostcodeDetailsRepository providePostcodeDetailsRepository() {
  return PostcodeDetailsRepository(
    postcodeService: PostcodeService(),
  );
}

PanCardRepository providePanCardRepository() {
  return PanCardRepository(
    panCodeService: PanCodeService(),
  );
}

CustomerRepository provideCustomerRepository() {
  return CustomerRepository(addressRepository: provideAddressRepository());
}

AddressRepository provideAddressRepository() {
  return AddressRepository();
}
