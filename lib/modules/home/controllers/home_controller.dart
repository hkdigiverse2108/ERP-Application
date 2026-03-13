import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentPage = 1.obs;
  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  final isLoaded = false.obs;

  @override
  void onReady() {
    super.onReady();
    // Delay building heavy UI components to allow navigation transition to complete
    Future.delayed(const Duration(milliseconds: 100), () {
      isLoaded.value = true;
    });
  }
}
