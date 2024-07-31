import 'package:flutter/material.dart';
import 'package:pixel6_test/core/constants/colors.dart';
import 'package:pixel6_test/data/models/address_model.dart';
import 'package:pixel6_test/presentation/widgets/custom_text.dart';

class AddressListingCard extends StatelessWidget {
  final AddressModel address;
  final bool isSelected;
  final VoidCallback onLongPress;
  final VoidCallback onSelect;

  const AddressListingCard({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onLongPress,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: MyColors.mainRedColor.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: address.line1,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  CustomText(
                    title: "Pincode: ${address.postcode}",
                    fontSize: 14,
                    fontColor: Colors.grey.shade700,
                    letterSpacing: 2,
                  ),
                  CustomText(
                    title: "City: ${address.city}",
                    fontSize: 14,
                    fontColor: Colors.grey.shade700,
                    letterSpacing: 2,
                  ),
                  CustomText(
                    title: "State: ${address.stateName}",
                    fontSize: 14,
                    fontColor: Colors.grey.shade700,
                    letterSpacing: 2,
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: address.id,
              activeColor: MyColors.radioButtonBg,
              groupValue: isSelected ? address.id : null,
              onChanged: (value) => onSelect(),
            ),
          ],
        ),
      ),
    );
  }
}
