

import 'package:equatable/equatable.dart';
import 'package:pixel6_test/data/models/address_model.dart';

abstract class AddressEditState extends Equatable {
  const AddressEditState();

  @override
  List<Object> get props => [];
}

class AddressInitialState extends AddressEditState {}

class AddressLoadingState extends AddressEditState {}

class AddressLoadedState extends AddressEditState {
  final AddressModel address;

  const AddressLoadedState(this.address);

  @override
  List<Object> get props => [address];
}

class AddressSavedState extends AddressEditState {}

class CityStateFetchedState extends AddressEditState {
  final String city;
  final String state;

  const CityStateFetchedState(this.city, this.state);

  @override
  List<Object> get props => [city, state];
}

class PostcodeValidState extends AddressEditState {}

class PostcodeInvalidState extends AddressEditState {
  final String errorMessage;

  const PostcodeInvalidState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class AddressErrorState extends AddressEditState {
  final String errorMessage;

  const AddressErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
