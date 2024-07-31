import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_test/config/bloc_provider.dart';
import 'package:pixel6_test/core/constants/colors.dart';
import 'package:pixel6_test/presentation/features/customer/customers_listing/bloc/customers_listing_bloc.dart';
import 'package:pixel6_test/presentation/features/customer/customers_listing/widget/customer_listing_card_widget.dart';
import 'package:pixel6_test/presentation/widgets/custom_text.dart';

class CustomersListingPage extends StatelessWidget {
  const CustomersListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = provideCustomersListingBloc();
    return BlocProvider(
      create: (_) => bloc..add(LoadCustomersEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const CustomText(
            title: "Customers List",
            fontSize: 20,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CustomersListingBloc, CustomersListingState>(
          builder: (context, state) {
            if (state is CustomerLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CustomerLoadedState) {
              return state.customers.isEmpty
                  ? const Center(
                      child: CustomText(
                        title: "No customers available.",
                        fontSize: 16,
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.customers.length,
                      itemBuilder: (context, index) {
                        final customer = state.customers[index];

                        return CustomerListingCardWidget(
                          customer: customer,
                          onEditPressed: () {
                            bloc.add(NavigateToEditCustomerPageEvent(
                                context: context, customerId: customer.customerId));
                          },
                          onDeletePressed: () {
                            bloc.add(DeleteCustomerEvent(index));
                          },
                        );
                      },
                    );
            } else if (state is CustomerErrorState) {
              return Center(
                child: CustomText(
                  title: "An error occurred: ${state.error}",
                  fontSize: 16,
                  fontColor: Colors.red,
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: MyColors.mainRedColor,
          child: const Icon(Icons.add),
          onPressed: () {
            bloc.add(NavigateToEditCustomerPageEvent(context: context));
          },
        ),
      ),
    );
  }
}
