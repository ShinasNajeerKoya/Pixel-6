

abstract class AddressEditEvent {}

class LoadAddressDetailsEvent extends AddressEditEvent {
  final String addressId;
  LoadAddressDetailsEvent(this.addressId);
}

class SaveAddressEvent extends AddressEditEvent {
  final String? addressId;
  SaveAddressEvent({this.addressId});
}

class ValidatePostcodeEvent extends AddressEditEvent {
  final String postcode;
  ValidatePostcodeEvent(this.postcode);
}

class FetchCityStateDetailsEvent extends AddressEditEvent {
}

