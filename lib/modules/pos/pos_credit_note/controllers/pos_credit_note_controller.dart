import 'dart:async';
import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/data/model/pos/pos_credit_note_model.dart';
import 'package:ai_setu/data/repositories/pos/pos_credit_note_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PosCreditNoteController extends GetxController {
  static PosCreditNoteController get to => Get.find();

  final _repository = PosCreditNoteRepository();

  final creditNotes = <PosCreditNoteModel>[].obs;
  final isLoading = false.obs;

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalItems = 0.obs;
  final limit = 10.obs;

  // Filters
  final searchQuery = ''.obs;
  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;
  final statusFilter = RxnString();
  final activeFilter = RxnString();

  Timer? _debounceTimer;
  Worker? _fyWorker;

  @override
  void onInit() {
    super.onInit();
    selectedDateRange.value = FinancialYearController.to.selectedRange;
    _fyWorker = ever(FinancialYearController.to.selectedYear, (year) {
      if (year != null) {
        selectedDateRange.value = year.dateRange;
        fetchCreditNotes();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    fetchCreditNotes();
  }

  String _formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  Future<void> fetchCreditNotes() async {
    try {
      isLoading.value = true;
      final pagination = await _repository.getAllPosCreditNotes(
        page: currentPage.value,
        limit: limit.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        startDate: _formatDate(selectedDateRange.value.start),
        endDate: _formatDate(selectedDateRange.value.end),
        statusFilter: statusFilter.value,
        activeFilter: activeFilter.value,
      );

      creditNotes.assignAll(pagination.items);
      totalPages.value = pagination.totalPages;
      totalItems.value = pagination.totalItems;
    } catch (e) {
      Log.e("PosCreditNoteController Error", e);
    } finally {
      isLoading.value = false;
    }
  }

  void onSearch(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      searchQuery.value = query;
      currentPage.value = 1;
      fetchCreditNotes();
    });
  }

  void onDateRangeChanged(DateTimeRange range) {
    selectedDateRange.value = range;
    currentPage.value = 1;
    fetchCreditNotes();
  }

  void onStatusChanged(String? status) {
    statusFilter.value = status;
    currentPage.value = 1;
    fetchCreditNotes();
  }

  void onActiveChanged(String? active) {
    activeFilter.value = active;
    currentPage.value = 1;
    fetchCreditNotes();
  }

  Future<void> onPageChanged(int page) async {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      await fetchCreditNotes();
    }
  }

  Future<void> refreshData() async {
    currentPage.value = 1;
    await fetchCreditNotes();
  }

  @override
  void onClose() {
    _fyWorker?.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }
}
