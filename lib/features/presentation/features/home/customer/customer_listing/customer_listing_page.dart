import 'package:flutter/material.dart';
import 'package:pixel6_test/core/constants/colors.dart';
import 'package:pixel6_test/core/constants/local_keys.dart';
import 'package:pixel6_test/features/presentation/features/home/customer/customer_listing/address/address_listing_page.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_button.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_text.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_textfield.dart';

class CustomerListingPage extends StatefulWidget {
  final String? customerId;

  const CustomerListingPage({super.key, this.customerId});

  @override
  State<CustomerListingPage> createState() => _CustomerListingPageState();
}

class _CustomerListingPageState extends State<CustomerListingPage> {
  final kPanAddressController = TextEditingController();
  final fullNameAddressController = TextEditingController();
  final emailAddressController = TextEditingController();
  final phoneAddressController = TextEditingController();
  final panFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  //
  String? selectedAddressId = "";
  List<Map<String, dynamic>> addresses = [];
  bool isPanValid = false;
  bool isEmailValid = false;
  bool isPhoneValid = false;
  bool isLoading = false;
  String panError = "";
  String emailError = "";
  String phoneError = "";

  FocusNode? currentFocusNode;

  @override
  void initState() {
    super.initState();
  }

  // validation
  // pan validation
  void _validatePanNumber() {
    final panNumber = kPanAddressController.text;
    final regex = RegExp(
        r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$'); // in this the first five character will be alphabets and followed by four digits and followed by single character.

    setState(() {
      isPanValid = regex.hasMatch(panNumber);
      panError = isPanValid ? "" : "Invalid PAN format";
      _validateForm();
    });
  }

  // validation logic for email
  void _validateEmail(){
    final email = emailAddressController.text;
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    setState(() {
      isEmailValid = regex.hasMatch(email);
      emailError = isEmailValid ? "" : "Invalid email format";
      _validateForm();
    });
  }

  void _validatePhoneNumber(){
    final phone = phoneAddressController.text;
    final regex = RegExp(r'^\d{10}$'); // in this it will check for ten digits
    setState(() {
      isPhoneValid = regex.hasMatch(phone);
      phoneError = isPhoneValid ? "" : "Invalid phone number format";
      _validateForm();
    });
  }

  // to validate the text fields if the value is valid and empty or not
  void _validateForm() {
    setState(() {
      bool isFormValid = isPanValid &&
          isEmailValid &&
          isPhoneValid &&
          selectedAddressId != null &&
          selectedAddressId!.isNotEmpty;
      if (addresses.isEmpty) {
        isFormValid = false;
      }
      isFormValid = isPanValid &&
          isEmailValid &&
          isPhoneValid &&
          selectedAddressId != null &&
          selectedAddressId!.isNotEmpty;
    });
  }

  @override
  void dispose() {
    // kPanAddressController.removeListener();
    // emailAddressController.removeListener();
    // phoneAddressController.removeListener();
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          title: widget.customerId == null ? MyLocalKeys.customerListing : MyLocalKeys.customerEditing,
          fontSize: 18,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(top: 20),
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: kPanAddressController,
                    focusNode: panFocusNode,
                    hintText: MyLocalKeys.panHintText,
                    padding: EdgeInsets.only(left: 25, right: 15),
                    suffixIcon: isLoading
                        ? Container(
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.all(10),
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                            ),
                          )
                        : Container(
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.all(10),
                          ),
                  ),
                ),
                CustomButton(
                  title: 'Fetch',
                  isEnabled: isPanValid,
                  margin: EdgeInsets.only(right: 25),
                  onTap: isPanValid ? () {} : null,
                ),
              ],
            ),
            // for PAN error message
            if (currentFocusNode == panFocusNode && !isPanValid)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 25.0),
                child: Text(
                  panError,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: fullNameAddressController,
              hintText: MyLocalKeys.fullNameHintText,
              readOnly: true,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: emailAddressController,
              hintText: MyLocalKeys.emailHintText,
              focusNode: emailFocusNode,
            ),
            //for Email error message
            if (currentFocusNode == emailFocusNode && !isEmailValid)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 25.0),
                child: Text(
                  emailError,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: phoneAddressController,
              focusNode: phoneFocusNode,
              hintText: MyLocalKeys.phoneNumberHintText,
              prefixText: "+91 |",
            ),
            // Phone number error message
            if (currentFocusNode == phoneFocusNode && !isPhoneValid)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 25.0),
                child: Text(
                  phoneError,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            const SizedBox(height: 20),

            const SizedBox(height: 20),
            GestureDetector(
              onTap: addresses.length < 10
                  ?
                  // _navigateToAddressListing
                  () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddressListingPage()));
                    }
                  : null,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: addresses.length < 10 ? MyColors.drawerSecondaryBg : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: addresses.length < 10 ? Colors.black : Colors.grey.shade600,
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          title: MyLocalKeys.addAddressButtonText,
                          fontSize: 17,
                          fontColor: addresses.length < 10 ? Colors.black : Colors.grey.shade600,
                        )
                      ],
                    ),
                  ),
                  CustomText(
                    title: addresses.length < 10 ? "" : "Address limit reached.",
                    fontSize: 10,
                    fontColor: Colors.red,
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),

            CustomButton(
              // isEnabled: isFormValid,
              onTap: () {},
              title: widget.customerId == null
                  ? MyLocalKeys.addCustomerButtonText
                  : MyLocalKeys.saveCustomerButtonText,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
