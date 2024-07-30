part of 'customer_bloc.dart';





abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object?> get props => [];
}

class LoadCustomersEvent extends CustomerEvent {}

class DeleteCustomerEvent extends CustomerEvent {
  final int index;

  const DeleteCustomerEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class EditCustomerEvent extends CustomerEvent {
  final Map<String, dynamic> customer;

  const EditCustomerEvent({required this.customer});

  @override
  List<Object?> get props => [customer];
}

class AddCustomerEvent extends CustomerEvent {
  final Map<String, dynamic> customer;

  const AddCustomerEvent(this.customer);

  @override
  List<Object?> get props => [customer];
}

class NavigateToCustomerEntryPageEvent extends CustomerEvent {
  final BuildContext context;

  const NavigateToCustomerEntryPageEvent(this.context);

  @override
  List<Object?> get props => [context];
}

class NavigateToEditCustomerPageEvent extends CustomerEvent {
  final BuildContext context;
  final int index;

  const NavigateToEditCustomerPageEvent(this.context, this.index);

  @override
  List<Object?> get props => [context, index];
}
