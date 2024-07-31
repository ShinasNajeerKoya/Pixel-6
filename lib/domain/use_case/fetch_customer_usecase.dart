import 'package:pixel6_test/data/models/customer_model.dart';
import 'package:pixel6_test/domain/repository/customer_repository.dart';

class FetchCustomerUseCase {
  final CustomerRepository customerRepository;

  FetchCustomerUseCase({required this.customerRepository});

  Future<CustomerModel?> fetchCustomerById(String customerId) async {
    return customerRepository.getCustomerById(customerId);
  }

  Future<List<CustomerModel>> getCustomersList() async {
    return customerRepository.getCustomersList();
  }
}
