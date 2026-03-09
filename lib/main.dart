import 'package:flutter/material.dart';
import 'package:ai_setu/app/app.dart';
import 'package:ai_setu/core/services/storage_service.dart';

void main() async {
  // Initialize all the required dependencies
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();

  // Run App
  runApp(const App());
}
