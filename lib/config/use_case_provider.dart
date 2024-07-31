import 'package:pixel6_test/domain/use_case/delete_address_usecase.dart';
import 'package:pixel6_test/domain/use_case/delete_customer_usecase.dart';
import 'package:pixel6_test/domain/use_case/fetch_address_usecase.dart';
import 'package:pixel6_test/domain/use_case/fetch_customer_usecase.dart';
import 'package:pixel6_test/domain/use_case/pancard_usecase.dart';
import 'package:pixel6_test/domain/use_case/postcode_details_usecase.dart';
import 'package:pixel6_test/domain/use_case/save_address_usecase.dart';
import 'package:pixel6_test/domain/use_case/save_customer_usecase.dart';

import 'repository_provider.dart';

PostCodeDetailsUseCase providePostCodeDetailsUseCase() {
  return PostCodeDetailsUseCase(
    postcodeDetailsRepository: providePostcodeDetailsRepository(),
  );
}

PanCardDetailsUseCase providePanCardDetailsUseCase() {
  return PanCardDetailsUseCase(
    panCardRepository: providePanCardRepository(),
  );
}

SaveCustomerUseCase provideSaveCustomerUseCase() {
  return SaveCustomerUseCase(
    customerRepository: provideCustomerRepository(),
  );
}

DeleteCustomerUseCase provideDeleteCustomerUseCase() {
  return DeleteCustomerUseCase(
    customerRepository: provideCustomerRepository(),
  );
}

FetchCustomerUseCase provideFetchCustomerUseCase() {
  return FetchCustomerUseCase(
    customerRepository: provideCustomerRepository(),
  );
}

SaveAddressUseCase provideSaveAddressUseCase() {
  return SaveAddressUseCase(
    addressRepository: provideAddressRepository(),
  );
}

DeleteAddressUseCase provideDeleteAddressUseCase() {
  return DeleteAddressUseCase(
    addressRepository: provideAddressRepository(),
  );
}

FetchAddressUseCase provideFetchAddressUseCase() {
  return FetchAddressUseCase(
    addressRepository: provideAddressRepository(),
  );
}
