import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixel6_test/core/constants/colors.dart';
import 'package:pixel6_test/data/models/customer_model.dart';
import 'package:pixel6_test/presentation/widgets/custom_text.dart';

class CustomerListingCardWidget extends StatelessWidget {
  final CustomerModel customer;

  // final void Function()? onLongPress;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  const CustomerListingCardWidget({
    super.key,
    required this.customer,
    // this.onLongPress,
    this.onEditPressed,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    // final fullName = customer.fullName ?? '';
    // final panNumber = customer['pan'] ?? '';
    // final email = customer['email'] ?? '';
    // final phone = customer['phone'] ?? '';
    // final line1 = address['line1'] ?? '';
    // final postcode = address['postcode'] ?? '';
    // final city = address['city'] ?? '';
    // final state = address['state'] ?? '';

    return GestureDetector(
      // onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: MyColors.mainRedColor.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 3),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 260,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: customer.fullName,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                        const SizedBox(height: 5),
                        CustomText(
                          title: "PAN: ${customer.pan}",
                          fontSize: 14,
                          fontColor: Colors.grey.shade700,
                          letterSpacing: 2,
                        ),
                        CustomText(
                          title: "Email: ${customer.email}",
                          fontSize: 14,
                          fontColor: Colors.grey.shade700,
                          letterSpacing: 1,
                        ),
                        CustomText(
                          title: "Phone: ${customer.phone}",
                          fontSize: 14,
                          fontColor: Colors.grey.shade700,
                          letterSpacing: 2,
                        ),
                        const SizedBox(height: 5),
                        const Text('Address:', style: TextStyle(fontWeight: FontWeight.bold)),
                        CustomText(
                          title: "Address: ${customer.addressModel?.line1 ?? ''}",
                          fontSize: 14,
                          fontColor: Colors.grey.shade700,
                          letterSpacing: 2,
                        ),
                        CustomText(
                          title: "Postcode: ${customer.addressModel?.postcode ?? ''}",
                          fontSize: 14,
                          fontColor: Colors.grey.shade700,
                          letterSpacing: 2,
                        ),
                        CustomText(
                          title: "City: ${customer.addressModel?.city ?? ''}",
                          fontSize: 14,
                          fontColor: Colors.grey.shade700,
                          letterSpacing: 2,
                        ),
                        CustomText(
                          title: "State: ${customer.addressModel?.stateName ?? ''}",
                          fontSize: 14,
                          fontColor: Colors.grey.shade700,
                          letterSpacing: 2,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(onPressed: onEditPressed, icon: const Icon(CupertinoIcons.pencil)),
                      IconButton(onPressed: onDeletePressed, icon: const Icon(CupertinoIcons.bin_xmark)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
