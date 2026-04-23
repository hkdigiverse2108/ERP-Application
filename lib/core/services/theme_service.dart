import 'package:ai_setu/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'storage_service.dart';

class ThemeService {
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  static const Duration themeTransitionDuration = Duration(milliseconds: 300);

  late final RxBool isDarkModeObs;

  ThemeService._internal() {
    isDarkModeObs = _loadThemeFromBox().obs;
  }

  final _storage = StorageService();
  final _key = StorageKeys.isDarkMode;

  /// Get the current theme mode
  ThemeMode get theme => isDarkModeObs.value ? ThemeMode.dark : ThemeMode.light;

  /// Check if the app is currently in Dark Mode (abstracts Get.isDarkMode)
  bool get isDarkMode => isDarkModeObs.value;

  /// Load theme from local storage
  bool _loadThemeFromBox() => _storage.read<bool>(_key) ?? false;

  /// Switch between light and dark theme
  void switchTheme() {
    final newMode = !isDarkModeObs.value;
    Get.changeThemeMode(newMode ? ThemeMode.dark : ThemeMode.light);
    isDarkModeObs.value = newMode;
    _saveThemeToBox(newMode);
  }

  /// Save theme to local storage
  void _saveThemeToBox(bool isDarkMode) => _storage.write(_key, isDarkMode);
}

extension ThemeContext on BuildContext {
  /// Access custom app colors defined in ThemeExtensions
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>()!;

  /// Shortcut for responsive values based on current theme brightness
  T responsive<T>({required T light, required T dark}) =>
      Theme.of(this).brightness == Brightness.dark ? dark : light;
}
