import 'package:flutter/material.dart';
import 'package:codemap2/src/theme/app_theme.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        cursorColor: isDark ? Colors.white : theme.colorScheme.primary,
        style: TextStyle(
          color: isDark ? Colors.white : theme.textPrimaryColor,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : theme.glassColor,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: isDark
                ? Colors.white.withValues(alpha: 0.6)
                : theme.textSecondaryColor,
            fontSize: 14,
          ),
          floatingLabelStyle: TextStyle(
            color: isDark ? Colors.white : theme.colorScheme.primary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.12)
                  : theme.glassBorder,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.12)
                  : theme.glassBorder,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isDark ? Colors.white : theme.colorScheme.primary,
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
                    data: IconThemeData(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.7)
                          : theme.textSecondaryColor,
                    ),
                    child: prefixIcon!,
                  ),
                )
              : null,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconTheme(
                    data: IconThemeData(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.7)
                          : theme.textSecondaryColor,
                    ),
                    child: suffixIcon!,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
