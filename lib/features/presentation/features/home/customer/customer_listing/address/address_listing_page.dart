import 'package:flutter/material.dart';
import 'package:pixel6_test/core/constants/local_keys.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_button.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_text.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_textfield.dart';

class AddressListingPage extends StatefulWidget {
  const AddressListingPage({super.key});

  @override
  State<AddressListingPage> createState() => _AddressListingPageState();
}

class _AddressListingPageState extends State<AddressListingPage> {
  final line1AddressController = TextEditingController();
  final line2AddressController = TextEditingController();
  final postcodeAddressController = TextEditingController();
  final cityAddressController = TextEditingController();
  final stateAddressController = TextEditingController();

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
          title: "Address Entry",
          fontSize: 18,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(top: 20),
          children: [
            const SizedBox(height: 20),
            CustomTextField(
              controller: line1AddressController,
              hintText: MyLocalKeys.addressHintText,
              obscureText: false,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: line2AddressController,
              hintText: MyLocalKeys.addressHintText,
              obscureText: false,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: postcodeAddressController,
              hintText: MyLocalKeys.postCodeHintText,
              obscureText: false,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: cityAddressController,
              hintText: MyLocalKeys.cityHintText,
              obscureText: false,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: stateAddressController,
              hintText: MyLocalKeys.stateHintText,
              obscureText: false,
            ),
            const SizedBox(height: 35),
            CustomButton(
              onTap: () {},
              title: MyLocalKeys.addAddressTitleText,
            ),
            const SizedBox(height: 100),
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
