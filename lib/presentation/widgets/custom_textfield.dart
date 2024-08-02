import 'package:flutter/material.dart';
import 'package:pixel6_test/core/utils/size_config.dart';
import 'package:pixel6_test/presentation/widgets/custom_text.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final EdgeInsetsGeometry? padding;
  final bool? readOnly;
  final String? prefixText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool? isRequired;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.onChanged,
    this.padding,
    this.readOnly = false,
    this.prefixText,
    this.suffixIcon,
    this.focusNode,
    this.keyboardType,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(27)),
      child: TextField(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        focusNode: focusNode,
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText!,
        readOnly: readOnly!,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: suffixIcon,
          prefixIcon: prefixText != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(10)),
                  child: CustomText(
                    title: prefixText!,
                    fontSize: SizeConfig.getFontSize(18),
                  ),
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(title: hintText),
              if (isRequired!)
                const CustomText(
                  title: " *",
                  fontColor: Colors.red,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
