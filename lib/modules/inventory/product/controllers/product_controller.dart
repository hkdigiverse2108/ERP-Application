import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final _repo = ProductRepository();
  final products = <ProductItemModel>[].obs;
  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  // pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final limit = 10.obs;
  final totalItems = 0.obs;

  final isLodding = false.obs;

  @override
  void onReady() {
    super.onReady();
    getProductsData();
  }

  Future<void> getProductsData() async {
    try {
      isLodding.value = true;
      final res = await _repo.getProductsForTable(
        page: currentPage.value,
        limit: limit.value,
      );
      products.value = res.items;
      totalPages.value = res.totalPages;
      totalItems.value = res.totalItems;
      currentPage.value = res.currentPage;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLodding.value = false;
    }
  }

  Future<void> nextPage() async {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      await getProductsData();
    }
  }

  Future<void> previousPage() async {
    if (currentPage.value > 1) {
      currentPage.value--;
      await getProductsData();
    }
  }

  Future<void> goToPage(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await getProductsData();
    }
  }
}
