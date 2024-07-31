part of 'customer_edit_bloc.dart';

abstract class CustomerEditState extends Equatable {
  const CustomerEditState();

  @override
  List<Object> get props => [];
}

class CustomerEditInitialState extends CustomerEditState {}

class CustomerDataLoadingState extends CustomerEditState {}

class CustomerDataLoadedState extends CustomerEditState {
  final CustomerModel customer;

  const CustomerDataLoadedState(this.customer);

  @override
  List<Object> get props => [customer];
}

class CustomerDataLoadFailureState extends CustomerEditState {
  final String error;

  const CustomerDataLoadFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class AddressDataLoadingState extends CustomerEditState {}

class AddressDataLoadedState extends CustomerEditState {
  final List<AddressModel> addressList;

  const AddressDataLoadedState(this.addressList);

  @override
  List<Object> get props => [addressList];
}

class AddressDataLoadFailureState extends CustomerEditState {
  final String error;

  const AddressDataLoadFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class CustomerDataSavingState extends CustomerEditState {}

class CustomerDataSavedState extends CustomerEditState {
  final bool result;

  const CustomerDataSavedState(this.result);

  @override
  List<Object> get props => [result];
}

class CustomerDataSaveFailureState extends CustomerEditState {
  final String error;

  const CustomerDataSaveFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class AddressDeletingState extends CustomerEditState {}

class AddressDeletedState extends CustomerEditState {
  final List<AddressModel> addressList;

  const AddressDeletedState(this.addressList);

  @override
  List<Object> get props => [addressList];
}

class AddressDeleteFailureState extends CustomerEditState {
  final String error;

  const AddressDeleteFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class PanNumberVerifyingState extends CustomerEditState {}

class PanNumberVerifiedState extends CustomerEditState {
  final PanDetailsModel panDetailsModel;

  const PanNumberVerifiedState(this.panDetailsModel);

  @override
  List<Object> get props => [panDetailsModel];
}

class PanNumberVerifyFailureState extends CustomerEditState {
  final String error;

  const PanNumberVerifyFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class FocusChangedState extends CustomerEditState {
  final FocusNode focusNode;

  const FocusChangedState(this.focusNode);

  @override
  List<Object> get props => [focusNode];
}

class TextValidationState extends CustomerEditState{
  final ValidationStateEnum validationState;
  final String errorMessage;

  const TextValidationState({this.validationState = ValidationStateEnum.init, this.errorMessage = ''});
}

enum ValidationStateEnum { init, valid, notValid, failed }
