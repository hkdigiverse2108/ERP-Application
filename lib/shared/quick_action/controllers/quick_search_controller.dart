import 'package:ai_setu/core/helper/route_resolver.dart';
import 'package:ai_setu/core/services/permission_service.dart';
import 'package:ai_setu/data/model/permission_model.dart';
import 'package:get/get.dart';

class QuickSearchController extends GetxController {
  final searchQuery = ''.obs;
  final allItems = <PermissionModel>[].obs;
  final groupedResults = <String, List<PermissionModel>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeItems();

    // Update results whenever search query or all items change
    ever(searchQuery, (_) => _filterItems());
    ever(allItems, (_) => _filterItems());
  }

  void _initializeItems() {
    final List<PermissionModel> leafNodes = [];

    void findLeafNodes(List<PermissionModel> tabs) {
      for (final tab in tabs) {
        if (!tab.view) continue;

        if (tab.children.isNotEmpty) {
          findLeafNodes(tab.children);
        } else {
          // If it's a leaf node and navigable, add it
          if (RouteResolver.isNavigable(tab)) {
            leafNodes.add(tab);
          }
        }
      }
    }

    findLeafNodes(PermissionService.to.permittedTabs);
    allItems.value = leafNodes;
    _filterItems();
  }

  void _filterItems() {
    final query = searchQuery.value.toLowerCase().trim();

    final filtered = allItems.where((item) {
      if (query.isEmpty) return true;

      final matchesName = item.displayName.toLowerCase().contains(query);
      final matchesParent = item.parentName.toLowerCase().contains(query);
      final matchesTabName = item.tabName.toLowerCase().contains(query);

      return matchesName || matchesParent || matchesTabName;
    }).toList();

    // Group by parentName
    final Map<String, List<PermissionModel>> groups = {};
    for (final item in filtered) {
      final parent = item.parentName.isNotEmpty ? item.parentName : 'General';
      if (!groups.containsKey(parent)) {
        groups[parent] = [];
      }
      groups[parent]!.add(item);
    }

    groupedResults.value = groups;
  }

  void clearSearch() {
    searchQuery.value = '';
  }

  void navigateTo(PermissionModel tab) {
    final route = RouteResolver.resolve(tab);
    if (route.isNotEmpty) {
      PermissionService.to.activeTabId.value = tab.id;
      Get.toNamed(route);
    }
  }
}
