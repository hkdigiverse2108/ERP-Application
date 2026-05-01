import 'dart:convert';
import 'package:ai_setu/core/helper/route_resolver.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/data/model/permission_model.dart';
import 'package:ai_setu/data/repositories/user/permission_repository.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:get/get.dart';

class PermissionService extends GetxService {
  static PermissionService get to => Get.find();

  final _repo = PermissionRepository();
  final _storage = StorageService.instance;

  final RxList<PermissionModel> permittedTabs = <PermissionModel>[].obs;
  final isLoading = false.obs;

  /// Tracks which drawer item was last tapped by its _id.
  /// Used to highlight the correct item even when two tabs share the same tabUrl.
  /// Empty string means "no tap recorded yet — fall back to route comparison".
  final RxString activeTabId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
  }

  void _loadFromStorage() {
    final stored = _storage.read<String>(StorageKeys.userPermissions);
    if (stored != null) {
      final decoded = jsonDecode(stored) as List;
      final result = decoded
          .map((x) => PermissionModel.fromJson(x as Map<String, dynamic>))
          .toList();
      _sortTabs(result);
      permittedTabs.assignAll(result);
    }
  }

  Future<void> fetchPermissions(String userId) async {
    try {
      isLoading.value = true;
      final result = await _repo.getPermissionTabs(userId);
      _sortTabs(result);
      permittedTabs.assignAll(result);

      // Clear active tab on fresh permission load (e.g. login)
      activeTabId.value = '';

      // Persist
      await _storage.write(
        StorageKeys.userPermissions,
        jsonEncode(result.map((e) => e.toJson()).toList()),
      );
    } catch (e) {
      // Error handled silently, falls back to loading state or empty list
    } finally {
      isLoading.value = false;
    }
  }

  void _sortTabs(List<PermissionModel> tabs) {
    tabs.sort((a, b) => a.number.compareTo(b.number));
    for (var tab in tabs) {
      if (tab.children.isNotEmpty) {
        _sortTabs(tab.children);
      }
    }
  }

  String get defaultRoute {
    if (permittedTabs.isEmpty) return Routes.signIn;

    // Prefer dashboard
    final dashboard = _findTabByName(permittedTabs, "dashboard");
    if (dashboard != null && dashboard.view) {
      final resolved = RouteResolver.resolve(dashboard);
      return resolved.isNotEmpty ? resolved : Routes.dashboard;
    }

    // Fallback to first permitted leaf tab
    final firstLeaf = _findFirstNavigableTab(permittedTabs);
    if (firstLeaf != null) return RouteResolver.resolve(firstLeaf);

    return Routes.accessDenied;
  }

  /// Walks the tree depth-first to find the first leaf tab with view permission
  /// that is actually navigable (has a registered route).
  PermissionModel? _findFirstNavigableTab(List<PermissionModel> tabs) {
    for (var tab in tabs) {
      if (tab.children.isNotEmpty) {
        final found = _findFirstNavigableTab(tab.children);
        if (found != null) return found;
      } else if (tab.view && RouteResolver.isNavigable(tab)) {
        return tab;
      }
    }
    return null;
  }

  PermissionModel? _findTabByName(List<PermissionModel> tabs, String name) {
    for (var tab in tabs) {
      if (tab.tabName.toLowerCase() == name.toLowerCase()) return tab;
      if (tab.children.isNotEmpty) {
        final found = _findTabByName(tab.children, name);
        if (found != null) return found;
      }
    }
    return null;
  }

  PermissionModel? findTabById(String id) {
    return _findTabById(permittedTabs, id);
  }

  PermissionModel? _findTabById(List<PermissionModel> tabs, String id) {
    for (var tab in tabs) {
      if (tab.id == id) return tab;
      if (tab.children.isNotEmpty) {
        final found = _findTabById(tab.children, id);
        if (found != null) return found;
      }
    }
    return null;
  }

  /// Validates if the currently active tab (from manual tap) still matches
  /// the actual route. If they diverge, clears manual selection so the drawer
  /// can fall back to route-based highlighting.
  void validateActiveTab(String? currentRoute) {
    if (activeTabId.value.isEmpty || currentRoute == null) return;

    final activeTab = findTabById(activeTabId.value);
    if (activeTab != null) {
      final resolved = RouteResolver.resolve(activeTab);
      // If the route resolver returns empty, it's not a navigable leaf node
      if (resolved.isNotEmpty && resolved != currentRoute) {
        activeTabId.value = '';
      }
    } else {
      activeTabId.value = '';
    }
  }

  bool isRoutePermitted(String? route) {
    if (route == null || route.isEmpty) return false;
    if (route == Routes.dashboard) {
      return isTabPermitted("dashboard");
    }
    return _checkRouteInTabs(permittedTabs, route);
  }

  bool _checkRouteInTabs(List<PermissionModel> tabs, String route) {
    for (var tab in tabs) {
      // Check both the raw tabUrl AND the resolved route to handle collisions
      if (tab.view) {
        if (tab.tabUrl == route) return true;
        if (RouteResolver.resolve(tab) == route) return true;
      }
      if (tab.children.isNotEmpty) {
        if (_checkRouteInTabs(tab.children, route)) return true;
      }
    }
    return false;
  }

  bool isTabPermitted(String tabName) {
    return _checkPermission(permittedTabs, tabName);
  }

  bool _checkPermission(List<PermissionModel> tabs, String tabName) {
    for (var tab in tabs) {
      if (tab.tabName.toLowerCase() == tabName.toLowerCase() && tab.view) {
        return true;
      }
      if (tab.children.isNotEmpty) {
        if (_checkPermission(tab.children, tabName)) return true;
      }
    }
    return false;
  }

  void clearPermissions() {
    permittedTabs.clear();
    activeTabId.value = '';
    _storage.remove(StorageKeys.userPermissions);
  }
}

