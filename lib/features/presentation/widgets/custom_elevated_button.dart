
import 'package:flutter/material.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? backgroundColor;
  final String title;
  final Color? fontColor;

  const CustomElevatedButton({
    super.key,
    this.onTap,
    this.backgroundColor,
    required this.title,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xffD3D3D6),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 5),
              spreadRadius: 0,
              blurRadius: 5,
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        child: CustomText(
          title: title,
          fontSize: 16,
          fontColor: fontColor ?? Colors.black,
        ),
      ),
    );
  }
}