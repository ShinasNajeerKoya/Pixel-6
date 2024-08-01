import 'package:flutter/material.dart';
import 'package:pixel6_test/core/constants/colors.dart';
import 'package:pixel6_test/core/utils/size_config.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final EdgeInsetsGeometry? margin;
  final bool isEnabled;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.title,
    this.margin,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AbsorbPointer(
        absorbing: !isEnabled,
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: SizeConfig.getHeight(15), horizontal: SizeConfig.getWidth(15)),
          margin: margin ?? EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(25)),
          decoration: BoxDecoration(
            color: isEnabled ? MyColors.mainRedColor : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(SizeConfig.getRadius(8)),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isEnabled ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.getFontSize(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
