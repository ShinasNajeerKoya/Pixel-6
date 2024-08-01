import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_test/data/models/address_model.dart';
import 'package:pixel6_test/data/models/customer_model.dart';
import 'package:pixel6_test/data/models/pan_details_model.dart';
import 'package:pixel6_test/domain/constant_keys/customer_constant_keys.dart';
import 'package:pixel6_test/domain/use_case/delete_address_usecase.dart';
import 'package:pixel6_test/domain/use_case/fetch_address_usecase.dart';
import 'package:pixel6_test/domain/use_case/fetch_customer_usecase.dart';
import 'package:pixel6_test/domain/use_case/pancard_usecase.dart';
import 'package:pixel6_test/domain/use_case/save_customer_usecase.dart';

part 'customer_edit_event.dart';
part 'customer_edit_state.dart';

class CustomerEditBloc extends Bloc<CustomerEditEvent, CustomerEditState> {
  final PanCardDetailsUseCase panCardDetailsUseCase;
  final SaveCustomerUseCase saveCustomerUseCase;
  final FetchCustomerUseCase fetchCustomerUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;
  final FetchAddressUseCase fetchAddressUseCase;

  final _selectedAddressIdStreamController = StreamController<String>();
  final _addressListStreamController = StreamController<List<AddressModel>>();
  final _inputValidationStatusStreamController = StreamController<Map<InputTypeEnum, bool>>();

  Stream<String> get selectedAddressIdStream => _selectedAddressIdStreamController.stream;

  Stream<List<AddressModel>> get addressListStream => _addressListStreamController.stream;

  Stream<Map<InputTypeEnum, bool>> get inputValidationStatusStream =>
      _inputValidationStatusStreamController.stream;

  String selectedAddressId = '';
  List<AddressModel> addressList = [];
  bool isPanValid = false;
  bool isEmailValid = false;
  bool isPhoneValid = false;
  bool isLoading = false;
  String panError = '';
  String emailError = '';
  String phoneError = '';

  CustomerEditBloc({
    required this.panCardDetailsUseCase,
    required this.saveCustomerUseCase,
    required this.fetchCustomerUseCase,
    required this.deleteAddressUseCase,
    required this.fetchAddressUseCase,
  }) : super(CustomerEditInitialState()) {
    _inputValidationStatusStreamController.add({
      InputTypeEnum.pan: false,
      InputTypeEnum.email: false,
      InputTypeEnum.phone: false,
    });
    on<LoadCustomerDataEvent>(_onLoadCustomerDataEvent);
    on<LoadAllAddressDataEvent>(_onLoadAllAddressDataEvent);
    on<AddOrEditCustomerDataEvent>(_onAddOrEditCustomerDataEvent);
    on<DeleteAddressEvent>(_onDeleteAddressEvent);
    on<VerifyPanNumberEvent>(_onVerifyPanNumberEvent);
    on<ValidatePanNumberEvent>(_onValidatePanNumberEvent);
  }

  Future<void> _onLoadCustomerDataEvent(LoadCustomerDataEvent event, Emitter<CustomerEditState> emit) async {
    try {
      emit(CustomerDataLoadingState());

      final customerModel = await fetchCustomerUseCase.fetchCustomerById(event.customerId);

      if (customerModel != null) {
        emit(CustomerDataLoadedState(customerModel));
        updateSelectedAddress(customerModel.addressModel?.id ?? '');
      } else {
        emit(const CustomerDataLoadFailureState('Failed to fetch customer'));
      }
    } catch (e) {
      emit(CustomerDataLoadFailureState(e.toString()));
    }
  }

  Future<void> _onLoadAllAddressDataEvent(
      LoadAllAddressDataEvent event, Emitter<CustomerEditState> emit) async {
    emit(AddressDataLoadingState());

    try {
      final list = await fetchAddressUseCase.getAddressList();
      addressList = list;
      _addressListStreamController.add(list);
      emit(AddressDataLoadedState(list));
    } catch (e) {
      emit(AddressDataLoadFailureState(e.toString()));
    }
  }

  Future<void> _onAddOrEditCustomerDataEvent(
      AddOrEditCustomerDataEvent event, Emitter<CustomerEditState> emit) async {
    try {
      emit(CustomerDataSavingState());

      await saveCustomerUseCase.saveCustomerToPrefs(event.addOrEditCustomerConfig).then((result) {
        if (result) {
          emit(CustomerDataSavedState(result));
        } else {
          emit(const CustomerDataSaveFailureState('Failed to perform operation'));
        }
      });
    } catch (e) {
      emit(CustomerDataSaveFailureState(e.toString()));
    }
  }

  Future<void> _onDeleteAddressEvent(DeleteAddressEvent event, Emitter<CustomerEditState> emit) async {
    try {
      emit(AddressDeletingState());

      await deleteAddressUseCase.deleteSelectedAddress(event.index).then((result) {
        if (event.addressId.isNotEmpty) {
          add(const LoadAllAddressDataEvent());
        }
        emit(AddressDeletedState(result));
      });
    } catch (e) {
      emit(AddressDeleteFailureState(e.toString()));
    }
  }

  Future<void> _onVerifyPanNumberEvent(VerifyPanNumberEvent event, Emitter<CustomerEditState> emit) async {
    try {
      emit(PanNumberVerifyingState());

      final panData = await panCardDetailsUseCase.fetchPostCodeDetails(event.panNumber);
      if (panData == null) {
        panError = 'Failed to verify PAN';
        emit(const PanNumberVerifyFailureState('Failed to verify PAN'));
      } else if (panData.isValid) {
        // fullNameAddressController.text = panData.fullName;
        panError = '';
        emit(PanNumberVerifiedState(panData));
      } else {
        panError = 'Invalid pan number';
        emit(const PanNumberVerifyFailureState('Invalid pan number'));
      }
    } catch (e) {
      emit(PanNumberVerifyFailureState(e.toString()));
    }
  }

  Future<void> _onValidatePanNumberEvent(
      ValidatePanNumberEvent event, Emitter<CustomerEditState> emit) async {
    try {
      emit(const TextValidationState());

      final regex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');

      final isValidPan = regex.hasMatch(event.panNumber);
      final panValidationState = isValidPan ? ValidationStateEnum.valid : ValidationStateEnum.notValid;
      final errorMsg = isValidPan ? '' : 'Invalid PAN format';

      emit(TextValidationState(validationState: panValidationState, errorMessage: errorMsg));
    } catch (e) {
      emit(const TextValidationState(validationState: ValidationStateEnum.failed));
    }
  }

  bool validatePanNumber(String panNumber) {
    add(ValidatePanNumberEvent(panNumber));
    final regex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');

    isPanValid = regex.hasMatch(panNumber);
    panError = isPanValid ? '' : 'Invalid PAN format';
    validateForm();

    return isPanValid;
  }

  bool validateEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    isEmailValid = regex.hasMatch(email);
    validateForm();

    return isEmailValid;
  }

  bool validatePhoneNumber(String phone) {
    final regex = RegExp(r'^\d{10}$');
    isPhoneValid = regex.hasMatch(phone);
    validateForm();

    return isPhoneValid;
  }

  bool validateForm() {
    bool isFormValid = isPanValid && isEmailValid && isPhoneValid && selectedAddressId.isNotEmpty;
    if (addressList.isEmpty) {
      isFormValid = false;
    }
    isFormValid = isPanValid && isEmailValid && isPhoneValid && selectedAddressId.isNotEmpty;
    return isFormValid;
  }

  void updateSelectedAddress(String id) {
    selectedAddressId = id;
    _selectedAddressIdStreamController.add(id);
  }

// void _updateValidationStatus(InputTypeEnum inputType, bool status) async {
//   final currentStatus = await inputValidationStatusStream.first;
//   final updatedStatus = Map<InputTypeEnum, bool>.from(currentStatus);
//   updatedStatus[inputType] = status;
//   _inputValidationStatusStreamController.add(updatedStatus);
// }
}

enum InputTypeEnum { pan, email, phone }
