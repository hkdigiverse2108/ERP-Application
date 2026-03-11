import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'storage_service.dart';

class ThemeService {
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;

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
  /// Convenient way to access ThemeService().isDarkMode
  bool get isDarkMode => ThemeService().isDarkMode;

  /// Shortcut for responsive values
  T responsive<T>({required T light, required T dark}) => isDarkMode ? dark : light;
}
