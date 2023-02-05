import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.hintText,
    required this.obscureText,
    required this.textInputType,
    required this.validator,
    this.suffixIcon,
    this.color,
    this.maxLength,
    this.initialValue,
    this.enabled,
    this.labelText,
    this.onSaved,
  }) : super(key: key);
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final bool obscureText;
  final TextInputType textInputType;
  final Function validator;
  final Function? onSaved;

  final Color? color;
  final bool? enabled;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      initialValue: initialValue,
      maxLength: maxLength,
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.black,
      keyboardType: textInputType,
      validator: (value) => validator(value),
      onSaved: (value) => onSaved!(value),
      decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          labelText: labelText,
          fillColor: color,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,

          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.green)),
          filled: true),
    );
  }
}
