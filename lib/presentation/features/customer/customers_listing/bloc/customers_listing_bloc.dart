import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_test/core/constants/local_keys.dart';
import 'package:pixel6_test/data/models/address_model.dart';
import 'package:pixel6_test/data/models/customer_model.dart';
import 'package:pixel6_test/domain/use_case/delete_customer_usecase.dart';
import 'package:pixel6_test/domain/use_case/fetch_address_usecase.dart';
import 'package:pixel6_test/domain/use_case/fetch_customer_usecase.dart';
import 'package:pixel6_test/presentation/features/customer/customer_edit/customer_edit_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'customers_listing_event.dart';
part 'customers_listing_state.dart';

class CustomersListingBloc extends Bloc<CustomersListingEvent, CustomersListingState> {
  final FetchCustomerUseCase fetchCustomerUseCase;
  final FetchAddressUseCase fetchAddressUseCase;
  final DeleteCustomerUseCase deleteCustomerUseCase;

  CustomersListingBloc({
    required this.fetchCustomerUseCase,
    required this.fetchAddressUseCase,
    required this.deleteCustomerUseCase,
  }) : super(CustomerLoadingState()) {
    on<LoadCustomersEvent>(_onLoadCustomers);
    on<DeleteCustomerEvent>(_onDeleteCustomer);
    on<EditCustomerEvent>(_onEditCustomer);
    on<AddCustomerEvent>(_onAddCustomer);
    on<NavigateToEditCustomerPageEvent>(_onNavigateToEditCustomerPage);
  }

  Future<void> _onLoadCustomers(LoadCustomersEvent event, Emitter<CustomersListingState> emit) async {
    try {
      emit(CustomerLoadingState());

      final customersList = await fetchCustomerUseCase.getCustomersList();

      emit(CustomerLoadedState(customers: customersList, addresses: const []));
    } catch (e) {
      emit(CustomerErrorState(error: e.toString()));
    }
  }

  Future<void> _onDeleteCustomer(DeleteCustomerEvent event, Emitter<CustomersListingState> emit) async {
    try {
      await deleteCustomerUseCase.deleteSelectedCustomer(event.index).then((value) {
        if (value.isNotEmpty) {
          emit(CustomerLoadedState(customers: value, addresses: const []));
        } else {
          emit(const CustomerErrorState(error: 'No Customers available.'));
        }
      });
    } catch (e) {
      emit(CustomerErrorState(error: e.toString()));
    }
  }

  Future<void> _onEditCustomer(EditCustomerEvent event, Emitter<CustomersListingState> emit) async {
    if (state is CustomerLoadedState) {
      try {
        final prefs = await SharedPreferences.getInstance();
        List<Map<String, dynamic>> updatedCustomers = List.from((state as CustomerLoadedState).customers);

        final index = updatedCustomers.indexWhere(
            (customer) => customer[AppLocalKeys.customerId] == event.customer[AppLocalKeys.customerId]);

        if (index != -1) {
          updatedCustomers[index] = event.customer;
          final updatedCustomerStrings = updatedCustomers.map((e) => jsonEncode(e)).toList();
          await prefs.setStringList(AppLocalKeys.customers, updatedCustomerStrings);

          // emit(CustomerLoadedState(
          //     customers: updatedCustomers, addresses: (state as CustomerLoadedState).addresses));
        }
      } catch (e) {
        emit(CustomerErrorState(error: e.toString()));
      }
    }
  }

  Future<void> _onAddCustomer(AddCustomerEvent event, Emitter<CustomersListingState> emit) async {
    if (state is CustomerLoadedState) {
      try {
        final prefs = await SharedPreferences.getInstance();
        List<Map<String, dynamic>> updatedCustomers = List.from((state as CustomerLoadedState).customers);
        updatedCustomers.add(event.customer);
        final updatedCustomerStrings = updatedCustomers.map((e) => jsonEncode(e)).toList();
        await prefs.setStringList(AppLocalKeys.customers, updatedCustomerStrings);

        // emit(CustomerLoadedState(
        //     customers: updatedCustomers, addresses: (state as CustomerLoadedState).addresses));
      } catch (e) {
        emit(CustomerErrorState(error: e.toString()));
      }
    }
  }

  Future<void> _onNavigateToEditCustomerPage(
      NavigateToEditCustomerPageEvent event, Emitter<CustomersListingState> emit) async {
    final result = await Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) => CustomerEditPage(
          customerId: event.customerId,
        ),
      ),
    );

    if (result == true) {
      add(LoadCustomersEvent());
    }
  }
}
