import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_test/data/models/address_model.dart';
import 'package:pixel6_test/domain/use_case/delete_address_usecase.dart';
import 'package:pixel6_test/domain/use_case/fetch_address_usecase.dart';
import 'package:pixel6_test/domain/use_case/postcode_details_usecase.dart';
import 'package:pixel6_test/domain/use_case/save_address_usecase.dart';
import 'package:pixel6_test/presentation/features/address_edit/bloc/address_edit_event.dart';
import 'package:pixel6_test/presentation/features/address_edit/bloc/address_edit_state.dart';

class AddressEditBloc extends Bloc<AddressEditEvent, AddressEditState> {
  final line1AddressController = TextEditingController();
  final line2AddressController = TextEditingController();
  final postcodeAddressController = TextEditingController();
  final cityAddressController = TextEditingController();
  final stateAddressController = TextEditingController();

  final _isEntryValidStreamController = StreamController<bool>();

  Stream<bool> get isEntryValidStream => _isEntryValidStreamController.stream;

  bool isPostcodeValid = false;
  bool isAddressValid = false;
  bool isLoading = false;
  String? postcodeErrorMessage;

  final PostCodeDetailsUseCase postCodeDetailsUseCase;
  final SaveAddressUseCase saveAddressUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;
  final FetchAddressUseCase fetchAddressUseCase;

  AddressEditBloc({
    required this.postCodeDetailsUseCase,
    required this.saveAddressUseCase,
    required this.deleteAddressUseCase,
    required this.fetchAddressUseCase,
  }) : super(AddressInitialState()) {
    on<LoadAddressDetailsEvent>(_onLoadAddressDetails);
    on<SaveAddressEvent>(_onSaveAddress);
    on<ValidatePostcodeEvent>(_onValidatePostcode);
    on<FetchCityStateDetailsEvent>(_onFetchCityStateDetails);
  }

  Future<void> _onLoadAddressDetails(LoadAddressDetailsEvent event, Emitter<AddressEditState> emit) async {
    emit(AddressLoadingState());
    try {
      final address = await _loadAddressFromPrefs(event.addressId);
      if (address == null) {
        emit(const AddressErrorState('Failed to load address details'));
      } else {
        emit(AddressLoadedState(address));
        isPostcodeValid = true;
      }
    } catch (e) {
      emit(const AddressErrorState('Failed to load address details'));
    }
  }

  Future<void> _onSaveAddress(SaveAddressEvent event, Emitter<AddressEditState> emit) async {
    emit(AddressLoadingState());
    try {
      await _saveAddressToPrefs(addressId: event.addressId).then((value) {
        if (value) {
          emit(AddressSavedState());
        } else {
          emit(const AddressErrorState('Failed to save address'));
        }
      });
    } catch (e) {
      emit(const AddressErrorState('Failed to save address'));
    }
  }

  void _onValidatePostcode(ValidatePostcodeEvent event, Emitter<AddressEditState> emit) {
    final regex = RegExp(r'^\d{6}$');
    if (regex.hasMatch(event.postcode)) {
      isPostcodeValid = true;
      emit(PostcodeValidState());
    } else {
      isPostcodeValid = false;
      emit(const PostcodeInvalidState('Enter a valid 6-digit postcode'));
    }
  }

  Future<void> _onFetchCityStateDetails(
      FetchCityStateDetailsEvent event, Emitter<AddressEditState> emit) async {
    emit(AddressLoadingState());
    isLoading = true;
    try {
      final postalCodeData =
          await postCodeDetailsUseCase.fetchPostCodeDetails(postcodeAddressController.text);

      if (postalCodeData != null) {
        cityAddressController.text = postalCodeData.city.first.name;
        stateAddressController.text = postalCodeData.state.first.name;
        isLoading = false;
      } else {
        emit(const AddressErrorState('Invalid postcode'));
      }
    } catch (e) {
      emit(const AddressErrorState('Failed to load address details'));
    }
  }

  Future<AddressModel?> _loadAddressFromPrefs(String addressId) async {
    final addressModel = await fetchAddressUseCase.fetchAddressById(addressId);

    if (addressModel != null) {
      line1AddressController.text = addressModel.line1;
      line2AddressController.text = addressModel.line2;
      postcodeAddressController.text = addressModel.postcode;
    }
    return addressModel;
  }

  Future<bool> _saveAddressToPrefs({String? addressId}) async {
    return saveAddressUseCase.saveAddressToPrefs(
      addressId: addressId,
      line1: line1AddressController.text,
      line2: line2AddressController.text,
      postcode: postcodeAddressController.text,
      city: cityAddressController.text,
      state: stateAddressController.text,
    );
  }

  bool isAddressEntryValid() {
    isAddressValid = line1AddressController.text.isNotEmpty &&
        isPostcodeValid &&
        cityAddressController.text.isNotEmpty &&
        stateAddressController.text.isNotEmpty;
    _isEntryValidStreamController.add(isAddressValid);
    return isAddressValid;
  }
}
