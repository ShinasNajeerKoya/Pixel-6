import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_test/config/bloc_provider.dart';
import 'package:pixel6_test/core/constants/colors.dart';
import 'package:pixel6_test/core/constants/local_keys.dart';
import 'package:pixel6_test/core/utils/size_config.dart';
import 'package:pixel6_test/presentation/features/customer/customers_listing/bloc/customers_listing_bloc.dart';
import 'package:pixel6_test/presentation/features/customer/customers_listing/widget/customer_listing_card_widget.dart';
import 'package:pixel6_test/presentation/widgets/custom_text.dart';

class CustomersListingPage extends StatefulWidget {
  const CustomersListingPage({super.key});

  @override
  State<CustomersListingPage> createState() => _CustomersListingPageState();
}

class _CustomersListingPageState extends State<CustomersListingPage> {
  late CustomersListingBloc bloc;
  @override
  void initState() {
    bloc = provideCustomersListingBloc()..add(LoadCustomersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocProvider(
      create: (_) => bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CustomText(
            title: AppLocalKeys.customersList,
            fontSize: SizeConfig.getFontSize(22),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CustomersListingBloc, CustomersListingState>(
          builder: (context, state) {
            if (state is CustomerLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CustomerLoadedState) {
              return state.customers.isEmpty
                  ? Center(
                      child: CustomText(
                        title: "No customers available.",
                        fontSize: SizeConfig.getFontSize(18),
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
                  fontSize: SizeConfig.getFontSize(18),
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
