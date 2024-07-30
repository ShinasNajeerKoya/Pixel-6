import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pixel6_test/core/constants/local_keys.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_button.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_text.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AddressListingPage extends StatefulWidget {
  final String? addressId;

  const AddressListingPage({super.key, this.addressId});

  @override
  State<AddressListingPage> createState() => _AddressListingPageState();
}

class _AddressListingPageState extends State<AddressListingPage> {
  final line1AddressController = TextEditingController();
  final line2AddressController = TextEditingController();
  final postcodeAddressController = TextEditingController();
  final cityAddressController = TextEditingController();
  final stateAddressController = TextEditingController();

  bool isPostcodeValid = false;
  bool isAddressValid = false;
  bool isLoading = false;
  String? postcodeErrorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.addressId != null) {
      _loadAddressDetails(widget.addressId!);
    }
  }

  // to load the address if any already stored in shared prefs
  Future<void> _loadAddressDetails(String addressId) async {
    setState(() {
      // for the loading indicator
    });

    try {
      final address = await _loadAddressFromPrefs(addressId);
      setState(() {
        line1AddressController.text = address['line1'] ?? '';
        line2AddressController.text = address['line2'] ?? '';
        postcodeAddressController.text = address['postcode'] ?? '';
        cityAddressController.text = address['city'] ?? '';
        stateAddressController.text = address['state'] ?? '';
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: CustomText(
        title: 'Failed to load address details',
      )));
    }

    setState(() {
      // to end the loading indicator
    });
  }

  Future<Map<String, dynamic>> _loadAddressFromPrefs(String addressId) async {
    final prefs = await SharedPreferences.getInstance();
    final addressesString = prefs.getStringList('addresses') ?? [];
    final address = addressesString
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .firstWhere((a) => a['id'] == addressId, orElse: () => {});
    return address;
  }

  ///
  // to save values into shared prefs
  Future<void> _saveAddress() async {
    setState(() {
      // for the loading indicator
    });

    try {
      final address = {
        'id': widget.addressId ?? const Uuid().v4(),
        'line1': line1AddressController.text,
        'line2': line2AddressController.text,
        'postcode': postcodeAddressController.text,
        'city': cityAddressController.text,
        'state': stateAddressController.text,
      };
      await _saveAddressToPrefs(address);
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save address')),
      );
    }
    setState(() {
      // to end the loading indicator
    });
  }

  Future<void> _saveAddressToPrefs(Map<String, dynamic> address) async {
    final prefs = await SharedPreferences.getInstance();
    final addressesString = prefs.getStringList('addresses') ?? [];
    final index = addressesString.indexWhere((e) => jsonDecode(e)['id'] == address['id']);
    if (index != -1) {
      addressesString[index] = jsonEncode(address);
    } else {
      addressesString.add(jsonEncode(address));
    }
    await prefs.setStringList('addresses', addressesString);
  }

  ///

  @override
  void dispose() {
    line1AddressController.dispose();
    line2AddressController.dispose();
    postcodeAddressController.dispose();
    cityAddressController.dispose();
    stateAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          title: widget.addressId != null ? MyLocalKeys.addressEditing : MyLocalKeys.addressListing,
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
              controller: line1AddressController,
              hintText: MyLocalKeys.addressLine1HintText,
              onChanged: (_) {
                //can add logic here is we want to validate the address
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: line2AddressController,
              hintText: MyLocalKeys.addressLine2HintText,
              onChanged: (_) {
                //can add logic here is we want to validate the address
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: postcodeAddressController,
                    hintText: MyLocalKeys.postCodeHintText,
                    padding: const EdgeInsets.only(left: 25, right: 15),
                    onChanged: (postcode) {
                      /// validating postcode here
                    },
                    suffixIcon: isLoading
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
                  ),
                ),
                CustomButton(
                  isEnabled: isPostcodeValid,
                  onTap: isPostcodeValid
                      ? () {
                          /// after validation postcode api call here
                        }
                      : null,
                  margin: const EdgeInsets.only(right: 25),
                  title: 'Fetch',
                )
              ],
            ),
            if (postcodeErrorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 25.0),
                child: Text(
                  postcodeErrorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 10),
                ),
              ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: cityAddressController,
              hintText: MyLocalKeys.cityHintText,
              obscureText: false,
              readOnly: true,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: stateAddressController,
              hintText: MyLocalKeys.stateHintText,
              obscureText: false,
              readOnly: true,
            ),
            const SizedBox(height: 35),
            CustomButton(
              isEnabled: isAddressValid,
              onTap: isAddressValid
                  ? () {
                      /// whole address validation here
                    }
                  : null,
              title: widget.addressId == null
                  ? MyLocalKeys.addAddressButtonText
                  : MyLocalKeys.saveAddressButtonText,
            ),
          ],
        ),
      ),
    );
  }
}
