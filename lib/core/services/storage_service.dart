import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  // Add this
  static StorageService get instance => _instance;

  String? get token => read<String>(StorageKeys.accessToken);

  final _box = GetStorage();

  /// Initialize Storage
  static Future<void> init() async {
    await GetStorage.init();
  }

  /// Save Data
  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  /// Read Data
  T? read<T>(String key) {
    final value = _box.read(key);

    // Robust handling for type-mismatches in legacy data
    if (value is String && _isMapType<T>()) {
      try {
        return jsonDecode(value) as T;
      } catch (_) {
        return null;
      }
    }

    try {
      return value as T?;
    } catch (_) {
      return null;
    }
  }

  bool _isMapType<T>() {
    final mapType = _typeOf<Map<String, dynamic>>();
    final nullableMapType = _typeOf<Map<String, dynamic>?>();
    return T == mapType || T == nullableMapType;
  }

  Type _typeOf<X>() => X;

  /// Remove Data
  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  /// Clear All Data
  Future<void> clearAll() async {
    await _box.erase();
  }

  /// Clear Session
  Future<void> clearSession() async {
    await remove(StorageKeys.accessToken);
    await remove(StorageKeys.refreshToken);
    await remove(StorageKeys.userData);
    await remove(StorageKeys.isLoggedIn);
    await remove(StorageKeys.userPermissions);
  }

  /// Check if key exists
  bool hasData(String key) {
    return _box.hasData(key);
  }
}

class StorageKeys {
  static const String isDarkMode = 'isDarkMode';
  static const String language = 'language';
  static const String isLoggedIn = 'isLoggedIn';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String userData = 'userData';
  static const String onboardingCompleted = 'onboardingCompleted';
  static const String userPermissions = 'userPermissions';
  static const String financialYear = 'financialYear';
  static const String companyInfo = 'companyInfo';
  static const String isMainBranch = 'isMainBranch';
}
