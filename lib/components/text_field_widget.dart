import 'package:flutter/material.dart';
import 'package:moviee_app/theme/app_colors.dart';
import 'package:moviee_app/theme/app_text_style.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.hint,
    required this.obscureText,
    required this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.controller,
    this.validator,
    this.maxLength,
  });

  final String hint;
  final bool obscureText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        height: 70,
        child: TextFormField(
          maxLength: maxLength,
          validator: validator,
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          cursorColor: Colors.grey,
          cursorHeight: 20,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            isDense: true,
            errorMaxLines: 1,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.kLogoColor),
            ),
            errorStyle: TextStyle(height: 0),
            prefixIcon: Icon(prefixIcon, color: Colors.black54, size: 25),
            suffixIcon: suffixIcon,
            hint: AppText(hint, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            focusColor: AppColors.kLogoColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.kLogoColor),
            ),
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
