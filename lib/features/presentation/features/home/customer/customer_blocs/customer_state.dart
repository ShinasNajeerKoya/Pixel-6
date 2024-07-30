part of 'customer_bloc.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

class CustomerLoadingState extends CustomerState {}

class CustomerLoadedState extends CustomerState {
  final List<Map<String, dynamic>> customers;
  final List<Map<String, dynamic>> addresses;

  const CustomerLoadedState({required this.customers, required this.addresses});

  @override
  List<Object> get props => [customers, addresses];
}

class CustomerErrorState extends CustomerState {
  final String error;

  const CustomerErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
