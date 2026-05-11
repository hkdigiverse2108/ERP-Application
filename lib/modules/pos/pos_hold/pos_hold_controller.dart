import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../data/repositories/pos/pos_order_repository.dart';
import '../pos_new/controllers/pos_new_controller.dart';

class PosHoldController extends GetxController {
  final PosOrderRepository _repository = PosOrderRepository();

  final isLoading = false.obs;
  final _allHoldOrders = <Map<String, dynamic>>[];
  final holdOrders = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHoldOrders();
  }

  void onSearch(String query) {
    if (query.isEmpty) {
      holdOrders.assignAll(_allHoldOrders);
      return;
    }

    final filtered = _allHoldOrders.where((order) {
      final orderNo = (order['orderNo'] ?? '').toString().toLowerCase();
      final customer = order['customerId'] as Map<String, dynamic>?;
      final customerName =
          "${customer?['firstName'] ?? ''} ${customer?['lastName'] ?? ''}"
              .toLowerCase();
      return orderNo.contains(query.toLowerCase()) ||
          customerName.contains(query.toLowerCase());
    }).toList();
    holdOrders.assignAll(filtered);
  }

  Future<void> fetchHoldOrders() async {
    try {
      isLoading.value = true;
      final res = await _repository.getHoldOrders();
      if (res.status == 200) {
        _allHoldOrders.clear();
        _allHoldOrders.addAll(List<Map<String, dynamic>>.from(res.data));
        holdOrders.assignAll(_allHoldOrders);
      }
    } catch (e) {
      debugPrint("Error fetching hold orders: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onOrderTap(String orderId) async {
    try {
      isLoading.value = true;
      final res = await _repository.getPosOrderDetails(orderId);

      if (res.status == 200) {
        final orderData = res.data as Map<String, dynamic>;

        // Get the PosNewController instance
        if (Get.isRegistered<PosNewController>()) {
          final posController = Get.find<PosNewController>();
          Get.back(); // Go back to POS screen FIRST
          posController.resumeOrder(
            orderData,
          ); // Then fill the order (shows snackbar)
        } else {
          debugPrint("PosNewController not registered. Cannot resume order.");
          AppSnackbar.error("Something went wrong. Please try again.");
        }
      } else {
        AppSnackbar.error(res.message ?? "Failed to fetch order details");
      }
    } catch (e) {
      debugPrint("Error resuming hold order: $e");
      AppSnackbar.error("Failed to resume order: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeHoldOrder(String orderId) async {
    try {
      isLoading.value = true;
      final res = await _repository.deletePosOrder(orderId);
      if (res.status == 200) {
        AppSnackbar.success("Order deleted successfully");
        fetchHoldOrders(); // Refresh the list
      } else {
        AppSnackbar.error(res.message ?? "Failed to delete order");
      }
    } catch (e) {
      debugPrint("Error deleting hold order: $e");
      AppSnackbar.error("Failed to delete order");
    } finally {
      isLoading.value = false;
    }
  }
}
