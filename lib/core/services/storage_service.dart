import 'package:get_storage/get_storage.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

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
    return _box.read<T>(key);
  }

  /// Remove Data
  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  /// Clear All Data
  Future<void> clearAll() async {
    await _box.erase();
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
}
