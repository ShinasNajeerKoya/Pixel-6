import 'package:pixel6_test/data/models/customer_model.dart';
import 'package:pixel6_test/domain/repository/customer_repository.dart';

class DeleteCustomerUseCase {
  final CustomerRepository customerRepository;

  DeleteCustomerUseCase({required this.customerRepository});

  Future<List<CustomerModel>> deleteSelectedCustomer(int index) async {
    return customerRepository.deleteSelectedCustomer(index);
  }
}
