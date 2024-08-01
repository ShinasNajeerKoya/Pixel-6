import 'dart:convert';

import 'package:pixel6_test/core/constants/local_keys.dart';
import 'package:pixel6_test/data/models/customer_model.dart';
import 'package:pixel6_test/domain/constant_keys/customer_constant_keys.dart';
import 'package:pixel6_test/domain/repository/address_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CustomerRepository {
  final AddressRepository addressRepository;

  CustomerRepository({required this.addressRepository});

  Future<List<CustomerModel>> getCustomersList() async {
    final List<CustomerModel> customersModelList = [];

    final prefs = await SharedPreferences.getInstance();

    final customerList = prefs.getStringList(AppLocalKeys.customers) ?? [];

    List<Map<String, dynamic>> customersJsonDataList =
        customerList.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();

    for (final customerData in customersJsonDataList) {
      final addressModel =
          await addressRepository.fetchAddressById(customerData[CustomerConstantKeys.addressId]);
      final customerModel = CustomerModel.fromJson(customerData, addressModel: addressModel);
      customersModelList.add(customerModel);
    }

    return customersModelList;
  }

  Future<CustomerModel?> getCustomerById(String customerId) async {
    CustomerModel? customerModel;

    final prefs = await SharedPreferences.getInstance();
    final customersString = prefs.getStringList(AppLocalKeys.customers) ?? [];
    final customerResponse = customersString
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .firstWhere((a) => a[CustomerConstantKeys.customerId] == customerId, orElse: () => {});
    final addressModel =
        await addressRepository.fetchAddressById(customerResponse[CustomerConstantKeys.addressId]);
    customerModel = CustomerModel.fromJson(customerResponse, addressModel: addressModel);

    return customerModel;
  }

  Future<bool> addOrEditCustomer(AddOrEditCustomerConfig addCustomerConfig) async {
    try {
      final customer = {
        CustomerConstantKeys.customerId: addCustomerConfig.customerId ?? const Uuid().v4(),
        CustomerConstantKeys.fullName: addCustomerConfig.fullName,
        CustomerConstantKeys.email: addCustomerConfig.email,
        CustomerConstantKeys.phone: addCustomerConfig.phone,
        CustomerConstantKeys.pan: addCustomerConfig.pan,
        CustomerConstantKeys.addressId: addCustomerConfig.addressId,
      };

      final prefs = await SharedPreferences.getInstance();
      final customerStringList = prefs.getStringList(AppLocalKeys.customers) ?? [];

      final index = customerStringList.indexWhere(
          (e) => jsonDecode(e)[CustomerConstantKeys.customerId] == customer[CustomerConstantKeys.customerId]);
      if (index != -1) {
        customerStringList[index] = jsonEncode(customer);
      } else {
        customerStringList.add(jsonEncode(customer));
      }
      await prefs.setStringList(AppLocalKeys.customers, customerStringList);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<CustomerModel>> deleteSelectedCustomer(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final customers = prefs.getStringList(AppLocalKeys.customers) ?? [];
    customers.removeAt(index);
    await prefs.setStringList(AppLocalKeys.customers, customers);
    return getCustomersList();

  }
}
