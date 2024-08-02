import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_test/config/bloc_provider.dart';
import 'package:pixel6_test/core/constants/colors.dart';
import 'package:pixel6_test/core/constants/local_keys.dart';
import 'package:pixel6_test/core/utils/size_config.dart';
import 'package:pixel6_test/data/models/address_model.dart';
import 'package:pixel6_test/domain/constant_keys/customer_constant_keys.dart';
import 'package:pixel6_test/presentation/features/address_edit/address_edit_page.dart';
import 'package:pixel6_test/presentation/features/customer/customer_edit/bloc/customer_edit_bloc.dart';
import 'package:pixel6_test/presentation/features/customer/customer_edit/widget/address_listing_card.dart';
import 'package:pixel6_test/presentation/widgets/custom_button.dart';
import 'package:pixel6_test/presentation/widgets/custom_text.dart';
import 'package:pixel6_test/presentation/widgets/custom_textfield.dart';

class CustomerEditPage extends StatefulWidget {
  final String? customerId;

  const CustomerEditPage({super.key, this.customerId});

  @override
  State<CustomerEditPage> createState() => _CustomerEditPageState();
}

class _CustomerEditPageState extends State<CustomerEditPage> {
  late CustomerEditBloc customerEditBloc;

  // Controllers and FocusNodes
  final kPanAddressController = TextEditingController();
  final fullNameAddressController = TextEditingController();
  final emailAddressController = TextEditingController();
  final phoneAddressController = TextEditingController();
  final panFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  // State variables
  bool isPanValid = false;
  bool isEmailValid = false;
  bool isPhoneValid = false;
  bool isLoading = false;

  FocusNode? currentFocusNode;

  @override
  void initState() {
    super.initState();
    customerEditBloc = provideCustomerEditBloc()..add(const LoadAllAddressDataEvent());

    if (widget.customerId != null) {
      customerEditBloc.add(LoadCustomerDataEvent(widget.customerId!));
    }

    kPanAddressController.addListener(() {
      setState(() {
        isPanValid = customerEditBloc.validatePanNumber(kPanAddressController.text);
      });
    });
    emailAddressController.addListener(() {
      setState(() {
        isEmailValid = customerEditBloc.validateEmail(emailAddressController.text);
      });
    });
    phoneAddressController.addListener(() {
      setState(() {
        isPhoneValid = customerEditBloc.validatePhoneNumber(phoneAddressController.text);
      });
    });

    panFocusNode.addListener(() {
      setState(() {
        currentFocusNode = panFocusNode;
        if (!panFocusNode.hasFocus) {
          isPanValid = customerEditBloc.validatePanNumber(kPanAddressController.text);
        }
      });
    });

    emailFocusNode.addListener(() {
      setState(() {
        currentFocusNode = emailFocusNode;
        if (!emailFocusNode.hasFocus) {
          customerEditBloc.validateEmail(emailAddressController.text);
        }
      });
    });

    phoneFocusNode.addListener(() {
      setState(() {
        currentFocusNode = phoneFocusNode;
        if (!phoneFocusNode.hasFocus) {
          customerEditBloc.validatePhoneNumber(phoneAddressController.text);
        }
      });
    });
  }

  @override
  void dispose() {
    kPanAddressController.removeListener(() {
      isPanValid = customerEditBloc.validatePanNumber(kPanAddressController.text);
    });
    emailAddressController.removeListener(() {
      customerEditBloc.validateEmail(emailAddressController.text);
    });
    phoneAddressController.removeListener(() {
      customerEditBloc.validatePhoneNumber(phoneAddressController.text);
    });
    kPanAddressController.dispose();
    fullNameAddressController.dispose();
    emailAddressController.dispose();
    phoneAddressController.dispose();
    panFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return StreamBuilder<String>(
        stream: customerEditBloc.selectedAddressIdStream,
        builder: (context, snapshot) {
          final selectedAddress = snapshot.data ?? '';

          return StreamBuilder<List<AddressModel>>(
              stream: customerEditBloc.addressListStream,
              builder: (context, snapshot) {
                List<AddressModel> addressList = snapshot.data ?? [];
                return BlocProvider(
                  create: (context) => customerEditBloc,
                  child: BlocBuilder<CustomerEditBloc, CustomerEditState>(
                    bloc: customerEditBloc,
                    builder: (context, state) {
                      return Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          title: CustomText(
                            title: widget.customerId == null
                                ? AppLocalKeys.customerListing
                                : AppLocalKeys.customerEditing,
                            fontSize: SizeConfig.getFontSize(22),
                          ),
                          centerTitle: true,
                        ),
                        body: SafeArea(
                          child: BlocListener<CustomerEditBloc, CustomerEditState>(
                            listener: (context, state) {
                              if (state is CustomerDataLoadedState) {
                                final customer = state.customer;
                                kPanAddressController.text = customer.pan;
                                // fullNameAddressController.text = customer.fullName;
                                emailAddressController.text = customer.email;
                                phoneAddressController.text = customer.phone;
                              }
                            },
                            child: ListView(
                              padding: EdgeInsets.only(top: SizeConfig.getHeight(20)),
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        controller: kPanAddressController,
                                        focusNode: panFocusNode,
                                        hintText: AppLocalKeys.panHintText,
                                        padding: EdgeInsets.only(
                                            left: SizeConfig.getWidth(25), right: SizeConfig.getWidth(15)),
                                        suffixIcon: customerEditBloc.isLoading
                                            ? Container(
                                                width: SizeConfig.getWidth(15),
                                                height: SizeConfig.getHeight(15),
                                                margin: EdgeInsets.all(SizeConfig.getHeight(15)),
                                                child: const CircularProgressIndicator(
                                                  strokeWidth: 1.5,
                                                ),
                                              )
                                            : Container(
                                                width: SizeConfig.getWidth(15),
                                                height: SizeConfig.getHeight(15),
                                                margin: EdgeInsets.all(SizeConfig.getHeight(15)),
                                              ),
                                      ),
                                    ),
                                    CustomButton(
                                      title: 'Fetch',
                                      isEnabled: isPanValid,
                                      margin: EdgeInsets.only(right: SizeConfig.getWidth(25)),
                                      onTap: isPanValid
                                          ? () {
                                              customerEditBloc.add(VerifyPanNumberEvent(
                                                  panNumber: kPanAddressController.text));
                                            }
                                          : null,
                                    ),
                                  ],
                                ),
                                // PAN error message
                                if (currentFocusNode == panFocusNode && !isPanValid)
                                  _showValidationErrorMessage(
                                    errorMessage: 'Invalid PAN format',
                                  ),
                                SizedBox(height: SizeConfig.getHeight(20)),
                                BlocConsumer<CustomerEditBloc, CustomerEditState>(
                                  listener: (context, state) {
                                    if (state is PanNumberVerifiedState) {
                                      fullNameAddressController.text = state.panDetailsModel.fullName;
                                    }
                                  },
                                  builder: (context, state) {
                                    return CustomTextField(
                                      controller: fullNameAddressController,
                                      hintText: AppLocalKeys.fullNameHintText,
                                      readOnly: true,
                                    );
                                  },
                                ),
                                SizedBox(height: SizeConfig.getHeight(20)),
                                CustomTextField(
                                  controller: emailAddressController,
                                  focusNode: emailFocusNode,
                                  hintText: AppLocalKeys.emailHintText,
                                ),
                                // Email error message
                                if (currentFocusNode == emailFocusNode && !isEmailValid)
                                  _showValidationErrorMessage(
                                    errorMessage: 'Invalid email format',
                                  ),
                                SizedBox(height: SizeConfig.getHeight(20)),
                                CustomTextField(
                                  controller: phoneAddressController,
                                  focusNode: phoneFocusNode,
                                  hintText: AppLocalKeys.phoneNumberHintText,
                                  keyboardType: TextInputType.phone,
                                  prefixText: "+91 |",
                                ),
                                // Phone number error message
                                if (currentFocusNode == phoneFocusNode && !isPhoneValid)
                                  _showValidationErrorMessage(
                                    errorMessage: 'Invalid phone number format',
                                  ),
                                SizedBox(height: SizeConfig.getHeight(10)),
                                Column(
                                  children: List.generate(addressList.length, (index) {
                                    final address = addressList[index];
                                    return AddressListingCard(
                                      address: address,
                                      isSelected: selectedAddress == address.id,
                                      onLongPress: () async {
                                        final action = await showDialog<String>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Choose an action'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'Edit'),
                                                child: const Text('Edit'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'Delete'),
                                                child: const Text('Delete'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                            ],
                                          ),
                                        );
                                        if (action == 'Delete') {
                                          final confirm = await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Confirm'),
                                              content:
                                                  const Text('Are you sure you want to delete this address?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context, true),
                                                  child: const Text('Yes'),
                                                ),
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context, false),
                                                  child: const Text('No'),
                                                ),
                                              ],
                                            ),
                                          );
                                          if (confirm == true) {
                                            customerEditBloc
                                                .add(DeleteAddressEvent(index, addressId: address.id));
                                          }
                                        } else if (action == 'Edit') {
                                          await _navigateToEditAddress(addressId: address.id);
                                        }
                                      },
                                      onSelect: () {
                                        customerEditBloc.updateSelectedAddress(address.id);
                                        customerEditBloc.validateForm();
                                      },
                                    );
                                  }),
                                ),
                                SizedBox(height: SizeConfig.getHeight(10)),
                                GestureDetector(
                                  onTap: addressList.length < 10 ? () => _navigateToEditAddress() : null,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: SizeConfig.getHeight(50),
                                        margin: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(25)),
                                        decoration: BoxDecoration(
                                          color: addressList.length < 10
                                              ? MyColors.drawerSecondaryBg
                                              : Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(SizeConfig.getRadius(5)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: addressList.length < 10
                                                  ? Colors.black
                                                  : Colors.grey.shade600,
                                            ),
                                            SizedBox(height: SizeConfig.getHeight(10)),
                                            CustomText(
                                              title: AppLocalKeys.addAddressButtonText,
                                              fontSize: SizeConfig.getFontSize(18),
                                              fontColor: addressList.length < 10
                                                  ? Colors.black
                                                  : Colors.grey.shade600,
                                            )
                                          ],
                                        ),
                                      ),
                                      _showValidationErrorMessage(
                                        errorMessage: addressList.length < 10 ? '' : 'Address limit reached.',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: SizeConfig.getHeight(10)),
                                CustomButton(
                                  isEnabled: customerEditBloc.validateForm(),
                                  onTap: customerEditBloc.validateForm()
                                      ? () {
                                          customerEditBloc.add(AddOrEditCustomerDataEvent(
                                              AddOrEditCustomerConfig(
                                                  customerId: widget.customerId,
                                                  fullName: fullNameAddressController.text,
                                                  email: emailAddressController.text,
                                                  pan: kPanAddressController.text,
                                                  phone: phoneAddressController.text,
                                                  addressId: customerEditBloc.selectedAddressId)));
                                        }
                                      : null,
                                  title: widget.customerId == null
                                      ? AppLocalKeys.addCustomerButtonText
                                      : AppLocalKeys.saveCustomerButtonText,
                                ),
                                SizedBox(height: SizeConfig.getHeight(20)),
                                BlocListener<CustomerEditBloc, CustomerEditState>(
                                  listener: (context, state) {
                                    if (state is CustomerDataSavedState) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Customer ${widget.customerId == null ? 'added' : 'updated'} successfully')),
                                      );

                                      Navigator.pop(context, true);
                                    }
                                  },
                                  child: const SizedBox(),
                                ),
                                BlocListener<CustomerEditBloc, CustomerEditState>(
                                  listener: (context, state) {
                                    if (state is PanNumberVerifyFailureState) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.error)),
                                      );
                                    }
                                  },
                                  child: const SizedBox(),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              });
        });
  }

  Padding _showValidationErrorMessage({required String errorMessage}) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.getHeight(8), left: SizeConfig.getWidth(25)),
      child: Text(
        errorMessage,
        style: TextStyle(color: Colors.red, fontSize: SizeConfig.getFontSize(14)),
      ),
    );
  }

  Future<void> _navigateToEditAddress({String? addressId}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressEditPage(
          addressId: addressId,
        ),
      ),
    );

    if (result == true) {
      customerEditBloc.add(const LoadAllAddressDataEvent());
    }
  }
}
