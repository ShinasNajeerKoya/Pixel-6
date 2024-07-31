import 'package:flutter/material.dart';
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

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.onChanged,
    this.padding = const EdgeInsets.symmetric(horizontal: 25.0),
    this.readOnly = false,
    this.prefixText,
    this.suffixIcon,
    this.focusNode,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
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
          prefixIcon: prefixText != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CustomText(
                    title: prefixText!,
                    fontSize: 16,
                  ),
                )
              : null,
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
