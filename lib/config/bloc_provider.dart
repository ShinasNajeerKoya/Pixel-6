import 'package:pixel6_test/config/use_case_provider.dart';
import 'package:pixel6_test/presentation/features/address_edit/bloc/address_edit_bloc.dart';
import 'package:pixel6_test/presentation/features/customer/customer_edit/bloc/customer_edit_bloc.dart';
import 'package:pixel6_test/presentation/features/customer/customers_listing/bloc/customers_listing_bloc.dart';

CustomersListingBloc provideCustomersListingBloc() {
  return CustomersListingBloc(
    fetchCustomerUseCase: provideFetchCustomerUseCase(),
    fetchAddressUseCase: provideFetchAddressUseCase(),
    deleteCustomerUseCase: provideDeleteCustomerUseCase(),
  );
}

CustomerEditBloc provideCustomerEditBloc() {
  return CustomerEditBloc(
    panCardDetailsUseCase: providePanCardDetailsUseCase(),
    saveCustomerUseCase: provideSaveCustomerUseCase(),
    fetchCustomerUseCase: provideFetchCustomerUseCase(),
    deleteAddressUseCase: provideDeleteAddressUseCase(),
    fetchAddressUseCase: provideFetchAddressUseCase(),
  );
}

AddressEditBloc provideAddressEditBloc() {
  return AddressEditBloc(
    postCodeDetailsUseCase: providePostCodeDetailsUseCase(),
    saveAddressUseCase: provideSaveAddressUseCase(),
    deleteAddressUseCase: provideDeleteAddressUseCase(),
    fetchAddressUseCase: provideFetchAddressUseCase(),
  );
}
