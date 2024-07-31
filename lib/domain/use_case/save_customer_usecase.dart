import 'package:pixel6_test/domain/constant_keys/customer_constant_keys.dart';
import 'package:pixel6_test/domain/repository/customer_repository.dart';

class SaveCustomerUseCase {
  final CustomerRepository customerRepository;

  SaveCustomerUseCase({required this.customerRepository});

  Future<bool> saveCustomerToPrefs(AddOrEditCustomerConfig addCustomerConfig) async {
    return customerRepository.addOrEditCustomer(
      addCustomerConfig,
    );
  }
}
