import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'storage_service.dart';

class ShowcaseService extends GetxService {
  static ShowcaseService get to => Get.find();

  final StorageService _storage = StorageService.instance;
  static const String _tourKey = 'has_seen_tour_v1';

  // Scope Names
  static const String homeScope = 'home_scope';
  static const String inventoryScope = 'inventory_scope';

  // Home Page Keys
  final GlobalKey drawerKey = GlobalKey();
  final GlobalKey searchKey = GlobalKey();
  final GlobalKey themeKey = GlobalKey();
  final GlobalKey salesKey = GlobalKey();
  final GlobalKey purchaseKey = GlobalKey();

  // Product Page Keys
  final GlobalKey productSearchKey = GlobalKey();
  final GlobalKey productFilterKey = GlobalKey();

  // New Showcases
  final GlobalKey yearSelectionKey = GlobalKey();
  final GlobalKey dateRangeKey = GlobalKey();
  final GlobalKey tableRowKey = GlobalKey();

  bool get hasSeenTour => _storage.read<bool>(_tourKey) ?? false;

  Future<void> markTourAsSeen() async {
    await _storage.write(_tourKey, true);
  }

  // To track if we are in the middle of a multi-page tour
  final isNavigatingFromTour = false.obs;

  void startProductTour() {
    isNavigatingFromTour.value = true;
  }

  void endProductTour() {
    isNavigatingFromTour.value = false;
  }
}
