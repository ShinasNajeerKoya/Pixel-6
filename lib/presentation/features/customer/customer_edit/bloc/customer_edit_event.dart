part of 'customer_edit_bloc.dart';

abstract class CustomerEditEvent extends Equatable {
  const CustomerEditEvent();

  @override
  List<Object?> get props => [];
}

class LoadCustomerDataEvent extends CustomerEditEvent {
  final String customerId;

  const LoadCustomerDataEvent(this.customerId);
}

class LoadAllAddressDataEvent extends CustomerEditEvent {
  const LoadAllAddressDataEvent();
}

class AddOrEditCustomerDataEvent extends CustomerEditEvent {
  final AddOrEditCustomerConfig addOrEditCustomerConfig;

  const AddOrEditCustomerDataEvent(this.addOrEditCustomerConfig);
}

class DeleteAddressEvent extends CustomerEditEvent {
  final int index;

  const DeleteAddressEvent(this.index);
}

class VerifyPanNumberEvent extends CustomerEditEvent {
  final String panNumber;

  const VerifyPanNumberEvent({required this.panNumber});
}

class FocusChangedEvent extends CustomerEditEvent {
  final FocusNode focusNode;

  const FocusChangedEvent(this.focusNode);
}

class ValidatePanNumberEvent extends CustomerEditEvent {
  final String panNumber;

  const ValidatePanNumberEvent(this.panNumber);
}
