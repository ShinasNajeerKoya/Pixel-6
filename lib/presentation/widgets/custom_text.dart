import 'package:flutter/material.dart';
import 'package:pixel6_test/core/utils/size_config.dart';

class CustomText extends StatelessWidget {
  final double? fontSize;
  final FontWeight? fontWeight;
  final String title;
  final Color? fontColor;
  final double? letterSpacing;

  const CustomText({
    super.key,
    required this.title,
    this.fontWeight,
    this.fontSize,
    this.fontColor,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Text(
      title,
      style: TextStyle(
          letterSpacing: letterSpacing,
          color: fontColor ?? Colors.black,
          fontSize: fontSize ?? SizeConfig.getFontSize(13),
          fontWeight: fontWeight ?? FontWeight.normal),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
