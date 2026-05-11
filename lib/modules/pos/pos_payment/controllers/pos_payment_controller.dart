import 'dart:async';
import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/data/model/bank_cash/expense_model.dart';
import 'package:ai_setu/data/model/bank_cash/pos_payment_model.dart';
import 'package:ai_setu/data/repositories/bank_cash/expense_repository.dart';
import 'package:ai_setu/data/repositories/bank_cash/payment_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PosPaymentController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _paymentRepo = PaymentRepository();
  final _expenseRepo = ExpenseRepository();

  late TabController tabController;

  // Sales Data
  final salesPayments = <PosPaymentModel>[].obs;
  final salesCurrentPage = 1.obs;
  final salesTotalPages = 1.obs;
  final salesTotalItems = 0.obs;
  final isSalesLoading = false.obs;

  // Expense Data
  final expenses = <ExpenseModel>[].obs;
  final expenseCurrentPage = 1.obs;
  final expenseTotalPages = 1.obs;
  final expenseTotalItems = 0.obs;
  final isExpenseLoading = false.obs;

  // Common
  final searchQuery = ''.obs;
  final limit = 10.obs;
  Timer? _debounceTimer;
  final selectedDateRange = FinancialYearController.to.selectedRange.obs;

  late Worker _fyWorker;
  late Worker _branchWorker;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        // Refresh data if search query is present or just to be sure
        refreshCurrentTab();
      }
    });

    _setupGlobalFilters();
  }

  void _setupGlobalFilters() {
    _fyWorker = ever(FinancialYearController.to.selectedYear, (year) {
      if (year != null) {
        selectedDateRange.value = year.dateRange;
        refreshAllData();
      }
    });

    _branchWorker = ever(BranchController.to.selectedBranch, (_) {
      refreshAllData();
    });
  }

  @override
  void onReady() {
    super.onReady();
    refreshAllData();
  }

  String _formatDate(DateTime date) => date.toUtc().toIso8601String();

  Future<void> fetchSalesPayments() async {
    try {
      isSalesLoading.value = true;
      final pagination = await _paymentRepo.getAllPayments(
        page: salesCurrentPage.value,
        limit: limit.value,
        fromDate: _formatDate(selectedDateRange.value.start),
        toDate: _formatDate(selectedDateRange.value.end),
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        voucherTypeFilter: 'sales',
        activeFilter: 'true',
        branchId: BranchController.to.selectedBranch.value?.id,
      );

      salesPayments.value = pagination.items;
      salesTotalPages.value = pagination.totalPages;
      salesTotalItems.value = pagination.totalItems;
    } catch (e) {
      Log.e("POS Payment Controller Error (Sales)", e);
    } finally {
      isSalesLoading.value = false;
    }
  }

  Future<void> fetchExpenses() async {
    try {
      isExpenseLoading.value = true;
      final pagination = await _expenseRepo.getAllExpenses(
        page: expenseCurrentPage.value,
        limit: limit.value,
        fromDate: _formatDate(selectedDateRange.value.start),
        toDate: _formatDate(selectedDateRange.value.end),
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        activeFilter: 'true',
        branchId: BranchController.to.selectedBranch.value?.id,
      );

      expenses.value = pagination.items;
      expenseTotalPages.value = pagination.totalPages;
      expenseTotalItems.value = pagination.totalItems;
    } catch (e) {
      Log.e("POS Payment Controller Error (Expense)", e);
    } finally {
      isExpenseLoading.value = false;
    }
  }

  void onSearch(String query) {
    searchQuery.value = query;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (tabController.index == 0) {
        salesCurrentPage.value = 1;
        fetchSalesPayments();
      } else {
        expenseCurrentPage.value = 1;
        fetchExpenses();
      }
    });
  }

  void refreshCurrentTab() {
    if (tabController.index == 0) {
      salesCurrentPage.value = 1;
      fetchSalesPayments();
    } else {
      expenseCurrentPage.value = 1;
      fetchExpenses();
    }
  }

  void refreshAllData() {
    salesCurrentPage.value = 1;
    expenseCurrentPage.value = 1;
    fetchSalesPayments();
    fetchExpenses();
  }

  void goToSalesPage(int page) {
    if (page >= 1 && page <= salesTotalPages.value) {
      salesCurrentPage.value = page;
      fetchSalesPayments();
    }
  }

  void goToExpensePage(int page) {
    if (page >= 1 && page <= expenseTotalPages.value) {
      expenseCurrentPage.value = page;
      fetchExpenses();
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    _debounceTimer?.cancel();
    _fyWorker.dispose();
    _branchWorker.dispose();
    super.onClose();
  }
}
