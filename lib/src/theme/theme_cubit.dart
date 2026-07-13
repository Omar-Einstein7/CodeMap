import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_theme.dart';

/// Cubit to manage the app's theme (light/dark).
class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(true) {
    _init();
  }

  Future<void> _init() async {
    final prefs = GetIt.instance<SharedPreferences>();
    final isLight = prefs.getBool(AppConstants.themeKey) ?? true;
    emit(isLight);
    _updateSystemUI(isLight);
  }

  void toggleTheme() {
    final next = !state;
    emit(next);
    final prefs = GetIt.instance<SharedPreferences>();
    prefs.setBool(AppConstants.themeKey, next);
    _updateSystemUI(next);
  }

  void _updateSystemUI(bool isLight) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: isLight ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: isLight
            ? AppColors.surfaceLight
            : AppColors.gradientDarkBottom,
        systemNavigationBarIconBrightness: isLight
            ? Brightness.dark
            : Brightness.light,
      ),
    );
  }

  /// Expose a ThemeData for the current theme state.
  ThemeData themeData() {
    return themeFor(state);
  }
}
