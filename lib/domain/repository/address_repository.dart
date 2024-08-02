import 'dart:convert';

import 'package:pixel6_test/core/constants/local_keys.dart';
import 'package:pixel6_test/data/models/address_model.dart';
import 'package:pixel6_test/domain/constant_keys/address_constant_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AddressRepository {
  AddressRepository();

  Future<List<AddressModel>> getAddressList() async {
    final prefs = await SharedPreferences.getInstance();

    final addressList = prefs.getStringList(AppLocalKeys.addresses) ?? [];

    List<Map<String, dynamic>> addressJsonDataList =
        addressList.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();

    return addressJsonDataList.map((data) => AddressModel.fromJson(data)).toList();
  }

  Future<AddressModel?> fetchAddressById(String? addressId) async {
    AddressModel? addressModel;

    final prefs = await SharedPreferences.getInstance();
    final addressesString = prefs.getStringList(AppLocalKeys.addresses) ?? [];
    final addressResponse = addressesString
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .firstWhere((a) => a[AddressConstantKeys.id] == addressId, orElse: () => {});

    if (addressResponse.isEmpty) {
      addressModel = AddressModel.emptyAddress();
    } else {
      addressModel = AddressModel.fromJson(addressResponse);
    }
    return addressModel;
  }

  Future<bool> saveAddressToPrefs({
    String? addressId,
    required String line1,
    String? line2,
    required String postcode,
    required String city,
    required String state,
  }) async {
    try {
      final address = {
        AddressConstantKeys.id: addressId ?? const Uuid().v4(),
        AddressConstantKeys.line1: line1,
        AddressConstantKeys.line2: line2,
        AddressConstantKeys.postcode: postcode,
        AddressConstantKeys.city: city,
        AddressConstantKeys.state: state,
      };

      final prefs = await SharedPreferences.getInstance();
      final addressesString = prefs.getStringList(AppLocalKeys.addresses) ?? [];
      final index = addressesString
          .indexWhere((e) => jsonDecode(e)[AddressConstantKeys.id] == address[AddressConstantKeys.id]);
      if (index != -1) {
        addressesString[index] = jsonEncode(address);
      } else {
        addressesString.add(jsonEncode(address));
      }
      await prefs.setStringList(AppLocalKeys.addresses, addressesString);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<AddressModel>> deleteSelectedAddress(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final addresses = prefs.getStringList(AppLocalKeys.addresses) ?? [];
    addresses.removeAt(index);
    await prefs.setStringList(AppLocalKeys.addresses, addresses);
    return getAddressList();
  }
}
