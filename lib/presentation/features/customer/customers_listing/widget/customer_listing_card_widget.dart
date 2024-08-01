import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixel6_test/core/constants/colors.dart';
import 'package:pixel6_test/core/utils/size_config.dart';
import 'package:pixel6_test/data/models/customer_model.dart';
import 'package:pixel6_test/presentation/widgets/custom_text.dart';

class CustomerListingCardWidget extends StatelessWidget {
  final CustomerModel customer;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  const CustomerListingCardWidget({
    super.key,
    required this.customer,
    this.onEditPressed,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GestureDetector(
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(20), vertical: SizeConfig.getHeight(15)),
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(20), vertical: SizeConfig.getHeight(15)),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: SizeConfig.getWidth(1), color: MyColors.mainRedColor.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(SizeConfig.getRadius(5)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 3),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: customer.fullName,
                      fontSize: SizeConfig.getFontSize(24),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    SizedBox(height: SizeConfig.getHeight(5)),
                    CustomText(
                      title: "PAN: ${customer.pan}",
                      fontSize: SizeConfig.getFontSize(16),
                      fontColor: Colors.grey.shade700,
                      letterSpacing: 2,
                    ),
                    CustomText(
                      title: "Email: ${customer.email}",
                      fontSize: SizeConfig.getFontSize(16),
                      fontColor: Colors.grey.shade700,
                      letterSpacing: 1,
                    ),
                    CustomText(
                      title: "Phone: ${customer.phone}",
                      fontSize: SizeConfig.getFontSize(16),
                      fontColor: Colors.grey.shade700,
                      letterSpacing: 2,
                    ),
                    SizedBox(height: SizeConfig.getHeight(5)),
                    CustomText(
                      title: "Address:",
                      fontSize: SizeConfig.getFontSize(17),
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      title: "Address: ${customer.addressModel?.line1 ?? ''}",
                      fontSize: SizeConfig.getFontSize(16),
                      fontColor: Colors.grey.shade700,
                      letterSpacing: 2,
                    ),
                    CustomText(
                      title: "Postcode: ${customer.addressModel?.postcode ?? ''}",
                      fontSize: SizeConfig.getFontSize(16),
                      fontColor: Colors.grey.shade700,
                      letterSpacing: 2,
                    ),
                    CustomText(
                      title: "City: ${customer.addressModel?.city ?? ''}",
                      fontSize: SizeConfig.getFontSize(16),
                      fontColor: Colors.grey.shade700,
                      letterSpacing: 2,
                    ),
                    CustomText(
                      title: "State: ${customer.addressModel?.stateName ?? ''}",
                      fontSize: SizeConfig.getFontSize(16),
                      fontColor: Colors.grey.shade700,
                      letterSpacing: 2,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: SizeConfig.getWidth(20)),
                child: Column(
                  children: [
                    IconButton(onPressed: onEditPressed, icon: const Icon(CupertinoIcons.pencil)),
                    SizedBox(height: SizeConfig.getHeight(20)),
                    IconButton(onPressed: onDeletePressed, icon: const Icon(CupertinoIcons.bin_xmark)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
