import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pixel6_test/core/constants/local_keys.dart';
import 'package:pixel6_test/features/data/models/postcode_details_model.dart' as postcode_model;
import 'package:pixel6_test/features/data/service/postcode_service.dart';
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

    line1AddressController.addListener(_validateAddress);
    postcodeAddressController.addListener(() {
      _validatePostcode(postcodeAddressController.text);
      _validateAddress();
    });
    cityAddressController.addListener(_validateAddress);
    stateAddressController.addListener(_validateAddress);
  }

  // to load the address if any already stored in shared prefs
  Future<void> _loadAddressDetails(String addressId) async {
    setState(() {
      // for the loading indicator
      isLoading = true;
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
        fontSize: 15,
      )));
    }

    setState(() {
      // to end the loading indicator
      isLoading = false;
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
      isLoading = true;
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
      isLoading = false;
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

  ///
// for api response handling for the postcode
  Future<void> _fetchCityStateDetails() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      final response = await fetchPostcodeDetails(postcodeAddressController.text);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'Success') {
          final postcodeDetails = postcode_model.PostcodeDetails.fromJson(data);
          setState(() {
            cityAddressController.text = postcodeDetails.city[0].name;
            stateAddressController.text = postcodeDetails.state[0].name;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: CustomText(
                title: 'Invalid postcode',
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load address details')),
        );
      }
    } catch (e) {
      print('Error fetching postcode details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something unexpected happened, Please try again.')),
      );
    }

    setState(() {
      isLoading = false; // to hide loading indicator
    });
  }

  ///

  ///
  // validation starts
  //validation for postcode
  void _validatePostcode(String postcode) {
    final regex = RegExp(r'^\d{6}$'); // validation for 6 consecutive digits only
    if (regex.hasMatch(postcode)) {
      setState(() {
        isPostcodeValid = true;
        postcodeErrorMessage = null;
      });
    } else {
      setState(() {
        isPostcodeValid = false;
        postcodeErrorMessage = 'Enter a valid 6-digit postcode';
      });
    }
  }

  // validation to check all the required areas are filled or not
  void _validateAddress() {
    setState(() {
      isAddressValid = line1AddressController.text.isNotEmpty &&
          isPostcodeValid &&
          cityAddressController.text.isNotEmpty &&
          stateAddressController.text.isNotEmpty;
    });
  }

  // validation ends
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
                      _validatePostcode(postcode);
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
                          _fetchCityStateDetails();
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
                      _saveAddress();
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
