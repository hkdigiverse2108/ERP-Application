import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'storage_service.dart';

class ThemeService {
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();

  final _storage = StorageService();
  final _key = StorageKeys.isDarkMode;

  /// Get the current theme mode
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Load theme from local storage
  bool _loadThemeFromBox() => _storage.read<bool>(_key) ?? false;

  /// Switch between light and dark theme
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }

  /// Save theme to local storage
  void _saveThemeToBox(bool isDarkMode) => _storage.write(_key, isDarkMode);
}
