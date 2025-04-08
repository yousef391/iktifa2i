import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onChanged;
  final String? Function(String?)? validator;
  final icon;
  final bool readonly;
  final TextInputType? keyboardType;
  final VoidCallback? ontap;
  final suffixIcon;
  bool? obscureText;

  CustomTextField({
    this.obscureText = false,
    this.suffixIcon,
    this.ontap,
    this.keyboardType,
    this.readonly = false,
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.onChanged,
    String? errorText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      onTap: ontap,
      keyboardType: keyboardType,
      readOnly: readonly,
      validator: validator,
      controller: controller,
      onChanged: (_) => onChanged(),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        icon: icon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.3),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
