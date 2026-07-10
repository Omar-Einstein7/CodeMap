import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomTextfield({
    super.key,
    required this.labelText,
    required this.controller,
    required this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black.withOpacity(0.4),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 14,
          ),
          floatingLabelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          ),
          errorStyle: const TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.white.withOpacity(0.7)),
                    child: prefixIcon!,
                  ),
                )
              : null,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.white.withOpacity(0.7)),
                    child: suffixIcon!,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
