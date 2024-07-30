import 'package:flutter/material.dart';
import 'package:pixel6_test/core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final EdgeInsetsGeometry? margin;
  final bool isEnabled;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.title,
    this.margin = const EdgeInsets.symmetric(horizontal: 25),
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AbsorbPointer(
        absorbing: !isEnabled,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          margin: margin,
          decoration: BoxDecoration(
            color: isEnabled ? MyColors.mainRedColor : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isEnabled ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
