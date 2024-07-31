part of 'customers_listing_bloc.dart';

abstract class CustomersListingEvent extends Equatable {
  const CustomersListingEvent();

  @override
  List<Object?> get props => [];
}

class LoadCustomersEvent extends CustomersListingEvent {}

class DeleteCustomerEvent extends CustomersListingEvent {
  final int index;

  const DeleteCustomerEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class EditCustomerEvent extends CustomersListingEvent {
  final Map<String, dynamic> customer;

  const EditCustomerEvent(this.customer);

  @override
  List<Object?> get props => [customer];
}

class AddCustomerEvent extends CustomersListingEvent {
  final Map<String, dynamic> customer;

  const AddCustomerEvent(this.customer);

  @override
  List<Object?> get props => [customer];
}

class NavigateToEditCustomerPageEvent extends CustomersListingEvent {
  final BuildContext context;
  final String? customerId;

  const NavigateToEditCustomerPageEvent({required this.context, this.customerId});

  @override
  List<Object?> get props => [context, customerId];
}
