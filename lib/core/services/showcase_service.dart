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
  GlobalKey drawerKey = GlobalKey();
  GlobalKey searchKey = GlobalKey();
  GlobalKey themeKey = GlobalKey();
  GlobalKey salesKey = GlobalKey();
  GlobalKey purchaseKey = GlobalKey();

  // Product Page Keys
  GlobalKey productSearchKey = GlobalKey();
  GlobalKey productFilterKey = GlobalKey();

  // New Showcases
  GlobalKey yearSelectionKey = GlobalKey();
  GlobalKey dateRangeKey = GlobalKey();
  GlobalKey tableRowKey = GlobalKey();

  void resetKeys() {
    drawerKey = GlobalKey();
    searchKey = GlobalKey();
    themeKey = GlobalKey();
    salesKey = GlobalKey();
    purchaseKey = GlobalKey();
    productSearchKey = GlobalKey();
    productFilterKey = GlobalKey();
    yearSelectionKey = GlobalKey();
    dateRangeKey = GlobalKey();
    tableRowKey = GlobalKey();
  }

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
