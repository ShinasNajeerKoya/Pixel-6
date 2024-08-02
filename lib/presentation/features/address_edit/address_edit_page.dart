import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_test/config/bloc_provider.dart';
import 'package:pixel6_test/core/constants/local_keys.dart';
import 'package:pixel6_test/core/utils/size_config.dart';
import 'package:pixel6_test/presentation/features/address_edit/bloc/address_edit_bloc.dart';
import 'package:pixel6_test/presentation/features/address_edit/bloc/address_edit_event.dart';
import 'package:pixel6_test/presentation/features/address_edit/bloc/address_edit_state.dart';
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
    SizeConfig.init(context);
    return StreamBuilder<bool>(
        stream: addressBloc.isEntryValidStream,
        builder: (context, snapshot) {
          final isAddressValid = snapshot.data ?? false;
          return BlocProvider(
            create: (context) => addressBloc,
            child: BlocBuilder<AddressEditBloc, AddressEditState>(
              bloc: addressBloc,
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: CustomText(
                      title: widget.addressId != null
                          ? AppLocalKeys.addressEditing
                          : AppLocalKeys.addressListing,
                      fontSize: SizeConfig.getFontSize(22),
                    ),
                    centerTitle: true,
                  ),
                  body: SafeArea(
                    child: ListView(
                      padding: EdgeInsets.only(top: SizeConfig.getHeight(20)),
                      children: [
                        SizedBox(height: SizeConfig.getHeight(20)),
                        CustomTextField(
                          controller: addressBloc.line1AddressController,
                          hintText: AppLocalKeys.addressLine1HintText,
                          onChanged: (_) {
                            addressBloc.isAddressEntryValid();
                          },
                        ),
                        SizedBox(height: SizeConfig.getHeight(20)),
                        CustomTextField(
                          controller: addressBloc.line2AddressController,
                          hintText: AppLocalKeys.addressLine2HintText,
                          isRequired: false,
                          onChanged: (_) {
                            addressBloc.isAddressEntryValid();
                          },
                        ),
                        SizedBox(height: SizeConfig.getHeight(20)),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: addressBloc.postcodeAddressController,
                                hintText: AppLocalKeys.postCodeHintText,
                                padding: EdgeInsets.only(
                                    left: SizeConfig.getWidth(27), right: SizeConfig.getWidth(25)),
                                keyboardType: TextInputType.phone,
                                suffixIcon: addressBloc.isLoading
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
                                onChanged: (postcode) {
                                  addressBloc.add(ValidatePostcodeEvent(postcode));
                                },
                              ),
                            ),
                            CustomButton(
                              isEnabled: addressBloc.isPostcodeValid,
                              title: 'Fetch',
                              margin: EdgeInsets.only(right: SizeConfig.getHeight(25)),
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
                                padding: EdgeInsets.only(
                                    top: SizeConfig.getHeight(8), left: SizeConfig.getWidth(30)),
                                child: Text(
                                  (state).errorMessage,
                                  style: TextStyle(color: Colors.red, fontSize: SizeConfig.getFontSize(12)),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        SizedBox(height: SizeConfig.getHeight(20)),
                        CustomTextField(
                          controller: addressBloc.cityAddressController,
                          hintText: AppLocalKeys.cityHintText,
                          readOnly: true,
                        ),
                        SizedBox(height: SizeConfig.getHeight(20)),
                        CustomTextField(
                          controller: addressBloc.stateAddressController,
                          hintText: AppLocalKeys.stateHintText,
                          readOnly: true,
                        ),
                        SizedBox(height: SizeConfig.getHeight(35)),
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
                        SizedBox(height: SizeConfig.getHeight(20)),
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
        });
  }
}
