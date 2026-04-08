import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/invetory/material_consumption_model.dart';
import 'package:intl/intl.dart';

class InventoryController extends GetxController {
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalItems = 0.obs;
  final isLoading = false.obs;

  final materialConsumptionList = <MaterialConsumptionModel>[].obs;

  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  Future<void> fetchMaterialConsumption() async {
    try {
      isLoading.value = true;
      final api = Get.find<ApiService>();
      
      final String url = ApiConstants.buildUrl(ApiConstants.getAllMaterialConsumption, {
        "page": currentPage.value,
        "limit": 10,
        "fromDate": DateFormat('yyyy-MM-dd').format(selectedDateRange.value.start),
        "toDate": DateFormat('yyyy-MM-dd').format(selectedDateRange.value.end),
      });

      final res = await api.get(url);
      
      if (res.status == 200 && res.data != null) {
        final dynamic rawData = res.data;
        List<dynamic> targetList = [];
        
        if (rawData is List) {
          targetList = rawData;
        } else if (rawData is Map) {
          if (rawData.containsKey("data") && rawData["data"] is List) {
            targetList = rawData["data"];
          } else if (rawData.containsKey("materialConsumption_data") && rawData["materialConsumption_data"] is List) {
            targetList = rawData["materialConsumption_data"];
          } else {
            for (var value in rawData.values) {
              if (value is List) {
                targetList = value;
                break;
              }
            }
          }
          
          if (rawData['state'] != null) {
            totalPages.value = int.tryParse(rawData['state']['totalPages']?.toString() ?? '0') ?? 1;
          }
          totalItems.value = int.tryParse(rawData['totalData']?.toString() ?? rawData['total']?.toString() ?? '0') ?? 0;
        }

        materialConsumptionList.assignAll(
          targetList.map((e) => MaterialConsumptionModel.fromJson(e)).toList(),
        );
      }
    } catch (e) {
      debugPrint("Error fetching material consumption: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
