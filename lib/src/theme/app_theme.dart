import 'dart:ui';
import 'package:flutter/material.dart';

// ─── Apple-Inspired Liquid Glass Color Palette ─────────────────────────────────

class AppColors {
  // Light Mode - Apple-inspired
  static const Color primary = Color(0xFF007AFF);
  static const Color primaryDark = Color(0xFF0A84FF);
  static const Color secondary = Color(0xFF5856D6);
  static const Color tertiary = Color(0xFFFF9500);

  // Backgrounds
  static const Color bgLight = Color(0xFFF5F6FA);
  static const Color bgDark = Color(0xFF000000);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1C1C1E);

  // System colors
  static const Color accent = Color(0xFFFF9500);
  static const Color error = Color(0xFFFF3B30);
  static const Color success = Color(0xFF34C759);

  // Gradient backgrounds
  static const Color gradientLightTop = Color(0xFFF5F6FA);
  static const Color gradientLightBottom = Color(0xFFE8ECF0);
  static const Color gradientLightAccent = Color(0xFFE8F1FF);
  static const Color gradientDarkTop = Color(0xFF000000);
  static const Color gradientDarkBottom = Color(0xFF1C1C1E);
  static const Color gradientDarkAccent = Color(0xFF1A1A2E);

  // Glass colors - fine-tuned for Liquid Glass aesthetic
  static const Color glassLight = Color(0xBFF5F7FA);  // 75% opacity
  static const Color glassDark = Color(0x1AFFFFFF);    // 10% opacity
  static const Color glassBorderLight = Color(0x8FFFFFFF);
  static const Color glassBorderDark = Color(0x1EFFFFFF);
  static const Color glassSurfaceLight = Color(0xB3FFFFFF);
  static const Color glassSurfaceDark = Color(0x14FFFFFF);

  // Text colors
  static const Color textPrimaryLight = Color(0xFF1D1D1F);
  static const Color textPrimaryDark = Color(0xFFF5F5F7);
  static const Color textSecondaryLight = Color(0xFF86868B);
  static const Color textSecondaryDark = Color(0xFF98989D);
  static const Color textTertiaryLight = Color(0xFFAEAEB2);
  static const Color textTertiaryDark = Color(0xFF636366);
}

class AppConstants {
  static const String themeKey = "is_light_theme";
}

// ─── Gradient Helpers ──────────────────────────────────────────────────────────

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

LinearGradient primaryGradient(bool isDark) {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: isDark
        ? [AppColors.primaryDark, AppColors.primaryDark.withValues(alpha: 0.8)]
        : [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
  );
}

// ─── Theme Extensions ──────────────────────────────────────────────────────────

extension AppThemeX on ThemeData {
  Color get glassColor =>
      brightness == Brightness.light ? AppColors.glassLight : AppColors.glassDark;
  Color get glassBorder =>
      brightness == Brightness.light ? AppColors.glassBorderLight : AppColors.glassBorderDark;
  Color get glassSurface =>
      brightness == Brightness.light ? AppColors.glassSurfaceLight : AppColors.glassSurfaceDark;
  Color get textPrimaryColor =>
      brightness == Brightness.light ? AppColors.textPrimaryLight : AppColors.textPrimaryDark;
  Color get textSecondaryColor =>
      brightness == Brightness.light ? AppColors.textSecondaryLight : AppColors.textSecondaryDark;
  Color get textTertiaryColor =>
      brightness == Brightness.light ? AppColors.textTertiaryLight : AppColors.textTertiaryDark;
  Color get successColor => AppColors.success;
  Color get tertiaryColor =>
      brightness == Brightness.light ? AppColors.tertiary : AppColors.tertiary;
}

extension AppContextX on BuildContext {
  Color get glassColor => Theme.of(this).glassColor;
  Color get glassBorder => Theme.of(this).glassBorder;
  Color get glassSurface => Theme.of(this).glassSurface;
  Color get textPrimary => Theme.of(this).textPrimaryColor;
  Color get textSecondary => Theme.of(this).textSecondaryColor;
  Color get textTertiary => Theme.of(this).textTertiaryColor;
  Color get adaptivePrimary =>
      Theme.of(this).brightness == Brightness.light
          ? AppColors.primary
          : AppColors.primaryDark;
}

// ─── ThemeData Factory ─────────────────────────────────────────────────────────

ThemeData themeFor(bool isLight) {
  final brightness = isLight ? Brightness.light : Brightness.dark;
  final primary = isLight ? AppColors.primary : AppColors.primaryDark;
  final bg = isLight ? AppColors.bgLight : AppColors.bgDark;
  final surface = isLight ? AppColors.surfaceLight : AppColors.surfaceDark;
  final glass = isLight ? AppColors.glassLight : AppColors.glassDark;
  final glassBorder = isLight ? AppColors.glassBorderLight : AppColors.glassBorderDark;
  final textPrimary = isLight ? AppColors.textPrimaryLight : AppColors.textPrimaryDark;
  final textSecondary = isLight ? AppColors.textSecondaryLight : AppColors.textSecondaryDark;
  final error = isLight ? AppColors.error : AppColors.error;

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    primaryColor: primary,
    scaffoldBackgroundColor: bg,

    colorScheme: ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      tertiary: AppColors.tertiary,
      onTertiary: Colors.white,
      error: error,
      onError: Colors.white,
      surface: surface,
      onSurface: textPrimary,
      surfaceContainerHighest: glass,
      outline: glassBorder,
    ),

    // ── Card Theme ─────────────────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: glass,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: glassBorder),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
    ),

    // ── AppBar Theme ───────────────────────────────────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: textPrimary,
        size: 22,
      ),
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
      ),
    ),

    // ── Text Theme ─────────────────────────────────────────────────────────
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: textPrimary,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        color: textPrimary,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.4,
      ),
      displaySmall: TextStyle(
        color: textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.3,
      ),
      headlineLarge: TextStyle(
        color: textPrimary,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
      ),
      headlineMedium: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: textPrimary,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
      ),
      titleMedium: TextStyle(
        color: textPrimary,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: textPrimary,
        fontSize: 17,
        letterSpacing: -0.2,
      ),
      bodyMedium: TextStyle(
        color: textSecondary,
        fontSize: 15,
        letterSpacing: -0.1,
      ),
      bodySmall: TextStyle(
        color: textSecondary,
        fontSize: 13,
      ),
      labelLarge: TextStyle(
        color: textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: textSecondary,
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
    ),

    // ── Elevated Button ────────────────────────────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: primary.withValues(alpha: 0.4),
        disabledForegroundColor: Colors.white.withValues(alpha: 0.6),
        elevation: 0,
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 54),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
          color: Colors.white,
        ),
      ),
    ),

    // ── Outlined Button ────────────────────────────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        backgroundColor: Colors.transparent,
        side: BorderSide(color: glassBorder),
        elevation: 0,
        minimumSize: const Size(double.infinity, 54),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
          color: primary,
        ),
      ),
    ),

    // ── Text Button ────────────────────────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: primary,
        ),
      ),
    ),

    // ── Input Decoration ───────────────────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: glass,
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
        borderSide: BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      labelStyle: TextStyle(
        color: textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        color: isLight ? AppColors.textTertiaryLight : AppColors.textTertiaryDark,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      floatingLabelStyle: TextStyle(
        color: primary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: textSecondary,
      suffixIconColor: textSecondary,
    ),

    // ── Bottom Navigation Bar ──────────────────────────────────────────────
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: primary,
      unselectedItemColor: textSecondary,
      selectedLabelStyle: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
      type: BottomNavigationBarType.fixed,
    ),

    // ── Navigation Bar (Material 3) ────────────────────────────────────────
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      indicatorColor: primary.withValues(alpha: 0.15),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          );
        }
        return const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: primary, size: 24);
        }
        return IconThemeData(color: textSecondary, size: 24);
      }),
    ),

    // ── Navigation Rail ────────────────────────────────────────────────────
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: Colors.transparent,
      indicatorColor: primary.withValues(alpha: 0.15),
      labelType: NavigationRailLabelType.all,
      selectedLabelTextStyle: TextStyle(
        color: primary,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelTextStyle: TextStyle(
        color: textSecondary,
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
    ),

    // ── Floating Action Button ─────────────────────────────────────────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      extendedTextStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    // ── Dialog ─────────────────────────────────────────────────────────────
    dialogTheme: DialogThemeData(
      backgroundColor: isLight ? AppColors.surfaceLight : AppColors.surfaceDark,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      contentTextStyle: TextStyle(
        color: textSecondary,
        fontSize: 15,
      ),
    ),

    // ── Bottom Sheet ───────────────────────────────────────────────────────
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: isLight ? AppColors.surfaceLight : AppColors.surfaceDark,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      dragHandleColor: isLight
          ? AppColors.textTertiaryLight
          : AppColors.textTertiaryDark,
      dragHandleSize: const Size(36, 5),
    ),

    // ── Snack Bar ──────────────────────────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: isLight ? AppColors.surfaceDark : AppColors.surfaceLight,
      contentTextStyle: TextStyle(
        color: isLight ? Colors.white : textPrimary,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      actionTextColor: primary,
    ),

    // ── Chip ───────────────────────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: glass,
      disabledColor: glass.withValues(alpha: 0.5),
      selectedColor: primary.withValues(alpha: 0.15),
      secondarySelectedColor: primary.withValues(alpha: 0.1),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: TextStyle(
        color: textPrimary,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: TextStyle(
        color: textSecondary,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      brightness: brightness,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: glassBorder),
      ),
      iconTheme: IconThemeData(
        color: textSecondary,
        size: 18,
      ),
      checkmarkColor: primary,
    ),

    // ── Switch ─────────────────────────────────────────────────────────────
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary;
        }
        return isLight ? Colors.white : AppColors.textTertiaryDark;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary.withValues(alpha: 0.4);
        }
        return isLight
            ? AppColors.textTertiaryLight.withValues(alpha: 0.4)
            : AppColors.textTertiaryDark.withValues(alpha: 0.4);
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
    ),

    // ── Checkbox ───────────────────────────────────────────────────────────
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      side: BorderSide(color: textSecondary),
    ),

    // ── Slider ─────────────────────────────────────────────────────────────
    sliderTheme: SliderThemeData(
      activeTrackColor: primary,
      inactiveTrackColor: isLight
          ? AppColors.textTertiaryLight.withValues(alpha: 0.3)
          : AppColors.textTertiaryDark.withValues(alpha: 0.3),
      thumbColor: Colors.white,
      overlayColor: primary.withValues(alpha: 0.12),
      valueIndicatorColor: primary,
      valueIndicatorTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      activeTickMarkColor: Colors.transparent,
      inactiveTickMarkColor: Colors.transparent,
    ),

    // ── Progress Indicator ─────────────────────────────────────────────────
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primary,
      linearTrackColor: isLight
          ? AppColors.textTertiaryLight.withValues(alpha: 0.3)
          : AppColors.textTertiaryDark.withValues(alpha: 0.3),
      circularTrackColor: isLight
          ? AppColors.textTertiaryLight.withValues(alpha: 0.3)
          : AppColors.textTertiaryDark.withValues(alpha: 0.3),
    ),

    // ── Divider ────────────────────────────────────────────────────────────
    dividerTheme: DividerThemeData(
      color: isLight
          ? Colors.black.withValues(alpha: 0.06)
          : Colors.white.withValues(alpha: 0.08),
      thickness: 1,
      space: 1,
    ),

    // ── Tab Bar ────────────────────────────────────────────────────────────
    tabBarTheme: TabBarThemeData(
      labelColor: primary,
      unselectedLabelColor: textSecondary,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      indicatorColor: primary,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
    ),

    // ── Menu ───────────────────────────────────────────────────────────────
    popupMenuTheme: PopupMenuThemeData(
      color: isLight ? AppColors.surfaceLight : AppColors.surfaceDark,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: TextStyle(
        color: textPrimary,
        fontSize: 15,
      ),
      labelTextStyle: WidgetStateProperty.all(
        TextStyle(
          color: textPrimary,
          fontSize: 15,
        ),
      ),
    ),

    // ── List Tile ──────────────────────────────────────────────────────────
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: TextStyle(
        color: textSecondary,
        fontSize: 13,
      ),
      leadingAndTrailingTextStyle: TextStyle(
        color: textSecondary,
        fontSize: 14,
      ),
      iconColor: textSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // ── Time Picker ────────────────────────────────────────────────────────
    timePickerTheme: TimePickerThemeData(
      backgroundColor: isLight ? AppColors.surfaceLight : AppColors.surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      hourMinuteTextColor: textPrimary,
      dayPeriodTextColor: textPrimary,
      hourMinuteColor: glass,
      dayPeriodColor: glass,
      entryModeIconColor: primary,
    ),

    // ── Date Picker ────────────────────────────────────────────────────────
    datePickerTheme: DatePickerThemeData(
      backgroundColor: isLight ? AppColors.surfaceLight : AppColors.surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      headerBackgroundColor: primary,
      headerForegroundColor: Colors.white,
      todayForegroundColor: WidgetStateProperty.all(primary),
      todayBackgroundColor: WidgetStateProperty.all(primary.withValues(alpha: 0.12)),
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.white;
        return textPrimary;
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return primary;
        return null;
      }),
    ),

    // ── Tooltip ────────────────────────────────────────────────────────────
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: isLight ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyle(
        color: isLight ? Colors.white : textPrimary,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // ── Canvas / General────────────────────────────────────────────────────
    splashColor: primary.withValues(alpha: 0.08),
    highlightColor: primary.withValues(alpha: 0.04),
    hoverColor: primary.withValues(alpha: 0.04),
    focusColor: primary.withValues(alpha: 0.12),
    disabledColor: textSecondary.withValues(alpha: 0.5),
  );
}
