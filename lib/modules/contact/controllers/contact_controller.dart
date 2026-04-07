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

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    try {
      isLoading.value = true;
      final response = await _repo.getContacts(
        page: currentPage.value,
        limit: 10,
        search: searchController.text,
      );
      contactList.assignAll(response.contactData);
      totalItems.value = response.totalData;
      totalPages.value = (totalItems.value / 10).ceil();
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
