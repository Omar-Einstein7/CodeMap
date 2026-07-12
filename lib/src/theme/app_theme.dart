import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff0E86D4);
  static const Color primaryDark = Color(0xffFF8C00);

  // Gradient backgrounds for glassmorphism
  static const Color bgLight = Color(0xffF0F8FF);
  static const Color bgDark = Color(0xff0A0E21);
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xff1E1E1E);

  // Glassmorphism gradient colors - light mode
  static const Color gradientLightTop = Color(0xFFD6EAF8);
  static const Color gradientLightBottom = Color(0xFFF0F8FF);
  static const Color gradientLightAccent = Color(0xFFE8F4FD);

  // Glassmorphism gradient colors - dark mode
  static const Color gradientDarkTop = Color(0xFF0D1117);
  static const Color gradientDarkBottom = Color(0xFF0A0E21);
  static const Color gradientDarkAccent = Color(0xFF16213E);

  static const Color accent = Color(0xffFFB300);
  static const Color error = Color(0xffD32F2F);
  static const Color success = Color(0xff388E3C);

  // Glass colors - improved for glassmorphism
  static const Color glassLight = Color(0xB3FFFFFF);  // 70% opacity
  static const Color glassDark = Color(0x26FFFFFF);   // 15% opacity
  static const Color glassBorderLight = Color(0x80FFFFFF);
  static const Color glassBorderDark = Color(0x1EFFFFFF);
  static const Color glassSurfaceLight = Color(0x8FF0F8FF); // glass surface
  static const Color glassSurfaceDark = Color(0x1A1E1E1E);
}

class AppConstants {
  static const String themeKey = "is_light_theme";
}

LinearGradient glassBackgroundGradient(bool isLight) {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: isLight
        ? [
            AppColors.gradientLightTop,
            AppColors.gradientLightAccent,
            AppColors.gradientLightBottom,
          ]
        : [
            AppColors.gradientDarkTop,
            AppColors.gradientDarkAccent,
            AppColors.gradientDarkBottom,
          ],
  );
}

ThemeData themeFor(bool isLight) {
  final brightness = isLight ? Brightness.light : Brightness.dark;
  final currentPrimary = isLight ? AppColors.primary : AppColors.primaryDark;
  final glassColor = isLight ? AppColors.glassLight : AppColors.glassDark;
  final glassBorder = isLight ? AppColors.glassBorderLight : AppColors.glassBorderDark;

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    primaryColor: currentPrimary,
    scaffoldBackgroundColor: isLight ? AppColors.bgLight : AppColors.bgDark,

    colorScheme: ColorScheme.fromSeed(
      seedColor: currentPrimary,
      brightness: brightness,
      primary: currentPrimary,
      surface: glassColor,
      surfaceContainerHighest: glassColor,
    ),

    // Glassmorphism card theme
    cardTheme: CardThemeData(
      color: glassColor,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: glassBorder),
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: isLight ? Colors.black87 : Colors.white),
      titleTextStyle: TextStyle(
        color: isLight ? Colors.black87 : Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: isLight ? const Color(0xFF0F172A) : Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: isLight ? const Color(0xFF0F172A) : Colors.white,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: isLight ? const Color(0xFF1E293B) : Colors.white,
      ),
      bodyMedium: TextStyle(
        color: isLight ? const Color(0xFF475569) : Colors.white70,
      ),
    ),

    // Glassmorphism elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: currentPrimary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),

    // Glassmorphism input fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isLight
          ? Colors.white.withOpacity(0.7)
          : Colors.white.withOpacity(0.08),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: glassBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: glassBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: currentPrimary, width: 1.5),
      ),
      labelStyle: TextStyle(
        color: isLight ? const Color(0xFF475569) : Colors.white60,
      ),
      hintStyle: TextStyle(
        color: isLight ? const Color(0xFF94A3B8) : Colors.white38,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: glassColor,
      elevation: 0,
    ),

    dividerTheme: DividerThemeData(
      color: isLight
          ? Colors.black.withOpacity(0.06)
          : Colors.white.withOpacity(0.08),
      thickness: 1,
    ),
  );
}
