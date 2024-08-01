import 'package:flutter/material.dart';
import 'package:pixel6_test/core/constants/colors.dart';
import 'package:pixel6_test/core/utils/size_config.dart';
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
    SizeConfig.init(context);
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(15), vertical: SizeConfig.getHeight(10)),
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(27), vertical: SizeConfig.getHeight(12)),
        decoration: BoxDecoration(
          border: Border.all(width: SizeConfig.getWidth(1), color: MyColors.mainRedColor.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(SizeConfig.getRadius(5)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: address.line1,
                    fontSize: SizeConfig.getFontSize(22),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  CustomText(
                    title: "Pincode: ${address.postcode}",
                    fontSize: SizeConfig.getFontSize(16),
                    fontColor: Colors.grey.shade700,
                    letterSpacing: 2,
                  ),
                  CustomText(
                    title: "City: ${address.city}",
                    fontSize: SizeConfig.getFontSize(16),
                    fontColor: Colors.grey.shade700,
                    letterSpacing: 2,
                  ),
                  CustomText(
                    title: "State: ${address.stateName}",
                    fontSize: SizeConfig.getFontSize(16),
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
