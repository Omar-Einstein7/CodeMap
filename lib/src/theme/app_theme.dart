import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Constants for app colors
class AppColors {
  // Primary Palette
  static const Color primary = Color(0xff0E86D4); // Standard Blue
  static const Color primaryDark = Color(
    0xffFF8C00,
  ); // Deep Orange for Dark Mode

  // Backgrounds
  static const Color bgLight = Color(0xffF0F8FF);
  static const Color bgDark = Color(0xff121212);
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xff1E1E1E);

  // Accents
  static const Color accent = Color(0xffFFB300);
  static const Color error = Color(0xffD32F2F);
  static const Color success = Color(0xff388E3C);
}

class AppConstants {
  static const String themeKey = "is_light_theme";
}

/// Helper to build ThemeData for a given theme mode without Riverpod.
ThemeData themeFor(bool isLight) {
  final Brightness brightness = isLight ? Brightness.light : Brightness.dark;
  final Color currentPrimary = isLight
      ? AppColors.primary
      : AppColors.primaryDark;

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    primaryColor: currentPrimary,
    scaffoldBackgroundColor: isLight ? AppColors.bgLight : AppColors.bgDark,

    colorScheme: ColorScheme.fromSeed(
      seedColor: currentPrimary,
      brightness: brightness,
      primary: currentPrimary,
      surface: isLight ? AppColors.surfaceLight : AppColors.surfaceDark,
      background: isLight ? AppColors.bgLight : AppColors.bgDark,
    ),

    cardTheme: CardThemeData(
      color: isLight ? AppColors.surfaceLight : AppColors.surfaceDark,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: isLight ? Colors.black87 : Colors.white),
      titleTextStyle: TextStyle(
        color: isLight ? Colors.black87 : Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: isLight ? Colors.black87 : Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: isLight ? Colors.black87 : Colors.white,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: isLight ? Colors.black87 : Colors.white),
      bodyMedium: TextStyle(color: isLight ? Colors.black54 : Colors.white70),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: currentPrimary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 2,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isLight
          ? Colors.black.withOpacity(0.05)
          : Colors.white.withOpacity(0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: currentPrimary, width: 1.5),
      ),
      labelStyle: TextStyle(color: isLight ? Colors.black54 : Colors.white60),
      hintStyle: TextStyle(color: isLight ? Colors.black38 : Colors.white38),
    ),
  );
}


