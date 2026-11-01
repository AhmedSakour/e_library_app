import 'package:flutter/material.dart';
import 'package:homework/themes/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.textInputType,
      required this.prefixIcon,
      required this.hint,
      this.obscureText = false,
      this.suffixIcon,
      this.suffixFunction,
      this.onFieldSubmitted,
      required this.validator,
      required this.label,
      this.onChanged});
  final TextEditingController controller;
  final TextInputType textInputType;
  final IconData prefixIcon;
  final String hint;
  final String label;
  final bool obscureText;
  final IconData? suffixIcon;
  final Function()? suffixFunction;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      keyboardType: textInputType,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefixIcon),
          suffixIcon:
              IconButton(onPressed: suffixFunction, icon: Icon(suffixIcon)),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: AppColors.primaryColor,
              ),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
