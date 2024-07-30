import 'package:flutter/material.dart';
import 'package:pixel6_test/core/constants/local_keys.dart';
import 'package:pixel6_test/features/presentation/features/home/customer/customer_listing/address/address_listing_page.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_button.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_text.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_textfield.dart';

class CustomerListingPage extends StatefulWidget {
  const CustomerListingPage({super.key});

  @override
  State<CustomerListingPage> createState() => _CustomerListingPageState();
}

class _CustomerListingPageState extends State<CustomerListingPage> {
  final kPanAddressController = TextEditingController();
  final fullNameAddressController = TextEditingController();
  final emailAddressController = TextEditingController();
  final phoneAddressController = TextEditingController();

  @override
  void dispose() {
    kPanAddressController.dispose();
    fullNameAddressController.dispose();
    emailAddressController.dispose();
    phoneAddressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          title: "Customer Entry",
          fontSize: 18,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(top: 20),
          children: [
            CustomTextField(
              controller: kPanAddressController,
              hintText: MyLocalKeys.panHintText,
              obscureText: false,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: fullNameAddressController,
              hintText: MyLocalKeys.fullNameHintText,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: emailAddressController,
              hintText: MyLocalKeys.emailHintText,
              obscureText: false,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: phoneAddressController,
              hintText: MyLocalKeys.phoneNumberHintText,
              obscureText: false,
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddressListingPage()));
              },
              title: MyLocalKeys.addAddressTitleText,
            ),
            const SizedBox(height: 35),
            CustomButton(
              onTap: () {},
              title: MyLocalKeys.addCustomerTitleText,
            ),
            const SizedBox(height: 80),
            const Center(
              child: CustomText(
                title: "v1.0, Pixel6 Web Studio Pvt. Ltd.",
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
