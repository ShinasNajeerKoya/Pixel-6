part of 'customers_listing_bloc.dart';

abstract class CustomersListingState extends Equatable {
  const CustomersListingState();

  @override
  List<Object> get props => [];
}

class CustomerLoadingState extends CustomersListingState {}

class CustomerLoadedState extends CustomersListingState {
  final List<CustomerModel> customers;

  const CustomerLoadedState({required this.customers});

  @override
  List<Object> get props => [customers];
}

class CustomerErrorState extends CustomersListingState {
  final String error;

  const CustomerErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
