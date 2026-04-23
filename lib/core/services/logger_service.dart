import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// A centralized logging utility to replace scattered print/debugPrint statements.
/// It uses the 'logger' package for formatted output and automatically handles
/// production/debug mode differences.
class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 80, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      dateTimeFormat: DateTimeFormat.dateAndTime, // Include a time stamp
    ),
    // Disable logging in production for performance and security
    level: kDebugMode ? Level.all : Level.off,
  );

  /// Log a message at level [Level.trace]
  static void t(String message) => _logger.t(message);

  /// Log a message at level [Level.debug]
  static void d(String message) => _logger.d(message);

  /// Log a message at level [Level.info]
  static void i(String message) => _logger.i(message);

  /// Log a message at level [Level.warning]
  static void w(String message) => _logger.w(message);

  /// Log a message at level [Level.error]
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    try {
      _logger.e(message, error: error, stackTrace: stackTrace);
    } catch (e) {
      debugPrint("Logging Error: $e");
      debugPrint("Original Message: $message");
      debugPrint("Original Error: $error");
    }
  }

  /// Log a message at level [Level.fatal]
  static void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    try {
      _logger.f(message, error: error, stackTrace: stackTrace);
    } catch (e) {
      debugPrint("Logging Fatal Error: $e");
      debugPrint("Original Message: $message");
      debugPrint("Original Error: $error");
    }
  }
}
