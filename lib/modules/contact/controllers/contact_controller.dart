import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/repositories/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final isLoading = false.obs;
  final contactList = <ContactModel>[].obs;

  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalItems = 0.obs;

  final searchController = TextEditingController();

  final contactRepository = ContactRepository();

  final selectedDateRange = Rx<DateTimeRange?>(null);

  final _repo = ContactRepository();


  Future<void> fetchContacts() async {
    try {
      isLoading.value = true;
      final response = await _repo.getContacts(
        page: currentPage.value,
        limit: 10,
        search: searchController.text,
      );
      
      final dynamic rawData = response.data;
      List<dynamic> targetList = [];
      if (rawData is List) {
        targetList = rawData;
      } else if (rawData is Map) {
        if (rawData.containsKey("contact_data") && rawData["contact_data"] is List) {
          targetList = rawData["contact_data"];
        } else if (rawData.containsKey("data") && rawData["data"] is List) {
          targetList = rawData["data"];
        } else {
          for (var value in rawData.values) {
            if (value is List) {
              targetList = value;
              break;
            }
          }
        }
        
        if (rawData['state'] != null) {
          totalPages.value = int.tryParse(rawData['state']['totalPages']?.toString() ?? '0') ?? 0;
        }
        totalItems.value = int.tryParse(rawData['totalData']?.toString() ?? rawData['total']?.toString() ?? '0') ?? 0;
      }
      
      contactList.assignAll(targetList.map((e) => ContactModel.fromJson(e)).toList());
      
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void search(String query) {
    currentPage.value = 1;
    fetchContacts();
  }
}
