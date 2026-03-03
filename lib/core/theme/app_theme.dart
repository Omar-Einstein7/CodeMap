import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

/// Provider to manage the app's theme state (light/dark mode).
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  final prefs = GetIt.instance<SharedPreferences>();
  return ThemeNotifier(prefs);
});

class ThemeNotifier extends StateNotifier<bool> {
  final SharedPreferences _prefs;

  ThemeNotifier(this._prefs)
    : super(_prefs.getBool(AppConstants.themeKey) ?? true) {
    _updateSystemUI();
  }

  void toggleTheme() {
    state = !state;
    _prefs.setBool(AppConstants.themeKey, state);
    _updateSystemUI();
  }

  void _updateSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: state ? Brightness.light : Brightness.dark,
        statusBarIconBrightness: state ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: state
            ? AppColors.surfaceLight
            : AppColors.surfaceDark,
        systemNavigationBarIconBrightness: state
            ? Brightness.dark
            : Brightness.light,
      ),
    );
  }

  ThemeData getTheme() {
    final Brightness brightness = state ? Brightness.light : Brightness.dark;
    final Color currentPrimary = state
        ? AppColors.primary
        : AppColors.primaryDark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: currentPrimary,
      scaffoldBackgroundColor: state ? AppColors.bgLight : AppColors.bgDark,

      colorScheme: ColorScheme.fromSeed(
        seedColor: currentPrimary,
        brightness: brightness,
        primary: currentPrimary,
        surface: state ? AppColors.surfaceLight : AppColors.surfaceDark,
        background: state ? AppColors.bgLight : AppColors.bgDark,
      ),

      cardTheme: CardThemeData(
        color: state ? AppColors.surfaceLight : AppColors.surfaceDark,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: state ? Colors.black87 : Colors.white),
        titleTextStyle: TextStyle(
          color: state ? Colors.black87 : Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: state ? Colors.black87 : Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: state ? Colors.black87 : Colors.white,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(color: state ? Colors.black87 : Colors.white),
        bodyMedium: TextStyle(color: state ? Colors.black54 : Colors.white70),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: currentPrimary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 2,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: state
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
        labelStyle: TextStyle(color: state ? Colors.black54 : Colors.white60),
        hintStyle: TextStyle(color: state ? Colors.black38 : Colors.white38),
      ),
    );
  }
}
