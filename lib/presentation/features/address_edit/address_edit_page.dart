import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_test/config/bloc_provider.dart';
import 'package:pixel6_test/core/constants/local_keys.dart';
import 'package:pixel6_test/presentation/features/address_edit/bloc/address_edit_bloc.dart';
import 'package:pixel6_test/presentation/widgets/custom_button.dart';
import 'package:pixel6_test/presentation/widgets/custom_text.dart';
import 'package:pixel6_test/presentation/widgets/custom_textfield.dart';

class AddressEditPage extends StatefulWidget {
  final String? addressId;

  const AddressEditPage({super.key, this.addressId});

  @override
  State<AddressEditPage> createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  late AddressEditBloc addressBloc;

  @override
  void initState() {
    super.initState();
    addressBloc = provideAddressEditBloc();

    if (widget.addressId != null) {
      addressBloc.add(LoadAddressDetailsEvent(widget.addressId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: addressBloc.isEntryValidStream,
      builder: (context, snapshot) {
        final isAddressValid = snapshot.data ??false;
        return BlocProvider(
          create: (context) => addressBloc,
          child: BlocBuilder<AddressEditBloc, AddressEditState>(
            bloc: addressBloc,
            builder: (context, state) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: CustomText(
                    title: widget.addressId != null ? AppLocalKeys.addressEditing : AppLocalKeys.addressListing,
                    fontSize: 18,
                  ),
                  centerTitle: true,
                ),
                body: SafeArea(
                  child: ListView(
                    padding: const EdgeInsets.only(top: 20),
                    children: [
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: addressBloc.line1AddressController,
                        hintText: AppLocalKeys.addressLine1HintText,
                        obscureText: false,
                        onChanged: (_) {
                          addressBloc.isAddressEntryValid();
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: addressBloc.line2AddressController,
                        hintText: AppLocalKeys.addressLine2HintText,
                        obscureText: false,
                        onChanged: (_) {
                          addressBloc.isAddressEntryValid();
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: addressBloc.postcodeAddressController,
                              hintText: AppLocalKeys.postCodeHintText,
                              padding: const EdgeInsets.only(left: 25, right: 15),
                              obscureText: false,
                              keyboardType: TextInputType.phone,
                              suffixIcon: addressBloc.isLoading
                                  ? Container(
                                      width: 10,
                                      height: 10,
                                      margin: const EdgeInsets.all(10),
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 1.5,
                                      ),
                                    )
                                  : Container(
                                      width: 10,
                                      height: 10,
                                      margin: const EdgeInsets.all(10),
                                    ),
                              onChanged: (postcode) {
                                addressBloc.add(ValidatePostcodeEvent(postcode));
                              },
                            ),
                          ),
                          CustomButton(
                            isEnabled: addressBloc.isPostcodeValid,
                            title: 'Fetch',
                            margin: const EdgeInsets.only(right: 25),
                            onTap: addressBloc.isPostcodeValid
                                ? () {
                                    addressBloc.add(FetchCityStateDetailsEvent());
                                  }
                                : null,
                          ),
                        ],
                      ),
                      BlocBuilder<AddressEditBloc, AddressEditState>(
                        builder: (context, state) {
                          if (state is PostcodeInvalidState) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 25.0),
                              child: Text(
                                (state).errorMessage,
                                style: const TextStyle(color: Colors.red, fontSize: 10),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: addressBloc.cityAddressController,
                        hintText: AppLocalKeys.cityHintText,
                        obscureText: false,
                        readOnly: true,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: addressBloc.stateAddressController,
                        hintText: AppLocalKeys.stateHintText,
                        obscureText: false,
                        readOnly: true,
                      ),
                      const SizedBox(height: 35),
                      CustomButton(
                        isEnabled: isAddressValid,
                        onTap: addressBloc.isAddressEntryValid()
                            ? () {
                                addressBloc.add(SaveAddressEvent(addressId: widget.addressId));
                              }
                            : null,
                        title: widget.addressId == null
                            ? AppLocalKeys.addAddressButtonText
                            : AppLocalKeys.saveAddressButtonText,
                      ),
                      BlocListener<AddressEditBloc, AddressEditState>(
                        listener: (context, state) {
                          if (state is AddressErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text((state).errorMessage)),
                            );
                          }
                        },
                        child: Container(),
                      ),
                      BlocListener<AddressEditBloc, AddressEditState>(
                        listener: (context, state) {
                          if (state is AddressSavedState) {
                            Navigator.pop(context, true);
                          }
                        },
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    );
  }
}
