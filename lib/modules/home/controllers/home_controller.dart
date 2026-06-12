import 'dart:isolate';
import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/core/services/financial_year_controller.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/dashboard/category_sales_model.dart';
import 'package:ai_setu/data/model/dashboard/category_wise_customers_count_model.dart';
import 'package:ai_setu/data/model/dashboard/category_wise_customers_model.dart';
import 'package:ai_setu/data/model/dashboard/login_log_model.dart';
import 'package:ai_setu/data/model/dashboard/payable_model.dart';
import 'package:ai_setu/data/model/dashboard/receivable_model.dart';
import 'package:ai_setu/data/model/dashboard/sales_and_purchase_graph_model.dart';
import 'package:ai_setu/data/model/dashboard/sellings_model.dart';
import 'package:ai_setu/data/model/dashboard/top_coupons_model.dart';
import 'package:ai_setu/data/model/dashboard/top_customer_model.dart';
import 'package:ai_setu/data/model/dashboard/top_expenses_model.dart';
import 'package:ai_setu/data/model/dashboard/transaction_graph_model.dart';
import 'package:ai_setu/data/model/dashboard/transactions_model.dart';
import 'package:ai_setu/data/repositories/home/dashboard_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final _repo = DashboardRepository();
  final currentPage = 1.obs;
  final selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  // ── Section 1: Top Summary (loads immediately) ──
  final topSectionLoading = false.obs;
  final topSectionData = TransactionsModel.empty().obs;

  // ── Section 2: Graphs ──
  final graphsLoaded = false.obs;
  final salesAndPurchaseGraphLoading = false.obs;
  final transactionGraphLoading = false.obs;
  final transactionGraphType = "sales".obs;
  final transactionGraphTypes = ['sales', 'purchase'];
  final salesAndPurchaseGraph = <SalesAndPurchaseGraphModel>[].obs;
  final transactionGraph = <TransactionGraphModel>[].obs;

  // Pre-calculated graph values and labels
  final salesAndPurchaseGraphValues = <List<double>>[].obs;
  final salesAndPurchaseGraphLabels = <String>[].obs;
  final transactionGraphValues = <List<double>>[].obs;
  final transactionGraphLabels = <String>[].obs;

  // ── Section 3: Customers ──
  final customersLoaded = false.obs;
  final topCustomersLoading = false.obs;
  final categoryWiseCustomersLoading = false.obs;
  final categoryWiseCustomersCountLoading = false.obs;
  final topCustomers = <TopCustomerModel>[].obs;
  final categoryWiseCustomers = <CategoryWiseCustomersModel>[].obs;
  final categoryWiseCustomersCount = <CategoryWiseCustomersCountModel>[].obs;

  // ── Section 4: Products ──
  final productsLoaded = false.obs;
  final bestSellingLoading = false.obs;
  final leastSellingLoading = false.obs;
  final categorySalesLoading = false.obs;
  final bestSelling = <SellingsModel>[].obs;
  final leastSelling = <SellingsModel>[].obs;
  final categorySales = <CategorySalesModel>[].obs;

  // ── Section 5: Finance ──
  final financeLoaded = false.obs;
  final topExpensesLoading = false.obs;
  final topCouponsLoading = false.obs;
  final receivablesLoading = false.obs;
  final payablesLoading = false.obs;
  final loginLogsLoading = false.obs;
  final topExpenses = <TopExpensesModel>[].obs;
  final topCoupons = <TopCouponsModel>[].obs;
  final receivables = <ReceivableModel>[].obs;
  final payables = <PayableModel>[].obs;
  final loginLogs = <LoginLogModel>[].obs;

  final isLoaded = false.obs;
  Worker? _fyWorker;

  @override
  void onInit() {
    super.onInit();
    // Listen to financial year changes globally
    _fyWorker = ever(FinancialYearController.to.selectedYear, (year) {
      if (year != null) {
        selectedDateRange.value = year.dateRange;
        // Reset all section flags to force refresh
        graphsLoaded.value = false;
        customersLoaded.value = false;
        productsLoaded.value = false;
        financeLoaded.value = false;

        // Refresh the immediate top section
        getTopSectionData();
      }
    });

    // Initialize date range from current selection
    selectedDateRange.value = FinancialYearController.to.selectedRange;

    // Listen to branch changes globally
    ever(BranchController.to.selectedBranch, (branch) {
      if (branch == null) return;
      // Reset all section flags to force refresh
      graphsLoaded.value = false;
      customersLoaded.value = false;
      productsLoaded.value = false;
      financeLoaded.value = false;

      // Refresh the immediate top section
      getTopSectionData();
    });
  }

  // Pagination states for Each Table (Client-side)
  final topCustomersPage = 1.obs;
  final categorySalesPage = 1.obs;
  final bestSellingPage = 1.obs;
  final leastSellingPage = 1.obs;
  final topExpensesPage = 1.obs;
  final topCouponsPage = 1.obs;
  final todaysPayablePage = 1.obs;
  final toPayPage = 1.obs;
  final todaysReceivablePage = 1.obs;
  final toReceivePage = 1.obs;
  final loginLogsPage = 1.obs;

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 100), () {
      isLoaded.value = true;
      getTopSectionData();
    });
  }

  Future<void> getTopSectionData() async {
    try {
      topSectionLoading.value = true;
      final response = await _repo.getTransactions(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
        branchId: BranchController.to.selectedBranch.value?.id,
      );
      topSectionData.value = response;
    } catch (e) {
      Log.e("Home Module Error", e);
      AppSnackbar.error(e.toString().replaceAll('Exception: ', ''));
    } finally {
      topSectionLoading.value = false;
    }
  }

  // Each section guard: only fetch once
  Future<void> loadGraphs() async {
    if (graphsLoaded.value) return;
    graphsLoaded.value = true;
    await Future.wait([getSalesAndPurchaseGraph(), getTransactionGraph()]);
  }

  Future<void> getSalesAndPurchaseGraph() async {
    try {
      salesAndPurchaseGraphLoading.value = true;
      final response = await _repo.getSalesAndPurchaseGraph(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
        branchId: BranchController.to.selectedBranch.value?.id,
      );
      salesAndPurchaseGraph.value = response;

      // Map graph data in Isolate
      final parsed = await Isolate.run(() {
        final values = response
            .map((e) => [e.sales, e.salesReturn, e.purchase, e.purchaseReturn])
            .toList();
        final labels = response.map((e) => e.date).toList();
        return (values: values, labels: labels);
      });
      salesAndPurchaseGraphValues.value = parsed.values;
      salesAndPurchaseGraphLabels.value = parsed.labels;
    } catch (e) {
      Log.e("Home Module Error", e);
    } finally {
      salesAndPurchaseGraphLoading.value = false;
    }
  }

  Future<void> getTransactionGraph() async {
    try {
      transactionGraphLoading.value = true;
      final response = await _repo.getTransactionGraph(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
        branchId: BranchController.to.selectedBranch.value?.id,
        typeFilter: transactionGraphType.value,
      );
      transactionGraph.value = response;

      // Map graph data in Isolate
      final parsed = await Isolate.run(() {
        final values = response
            .map((e) => [e.cash, e.upi, e.bank, e.card, e.cheque, e.other])
            .toList();
        final labels = response.map((e) => e.date).toList();
        return (values: values, labels: labels);
      });
      transactionGraphValues.value = parsed.values;
      transactionGraphLabels.value = parsed.labels;
    } catch (e) {
      Log.e("Home Module Error", e);
    } finally {
      transactionGraphLoading.value = false;
    }
  }

  Future<void> loadCustomers() async {
    if (customersLoaded.value) return;
    customersLoaded.value = true;
    await Future.wait([
      getTopCustomers(),
      getCategoryWiseCustomers(),
      getCategoryWiseCustomersCount(),
    ]);
  }

  Future<void> getTopCustomers() async {
    try {
      topCustomersLoading.value = true;
      final response = await _repo.getTopCustomers(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
        branchId: BranchController.to.selectedBranch.value?.id,
      );
      topCustomers.value = response;
    } catch (e) {
      Log.e("Home Module Error", e);
    } finally {
      topCustomersLoading.value = false;
    }
  }

  Future<void> getCategoryWiseCustomers() async {
    try {
      categoryWiseCustomersLoading.value = true;
      final response = await _repo.getCategoryWiseCustomers(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
        // branchId: BranchController.to.selectedBranch.value?.id,
      );
      categoryWiseCustomers.value = response;
    } catch (e) {
      Log.e("Home Module Error", e);
    } finally {
      categoryWiseCustomersLoading.value = false;
    }
  }

  Future<void> getCategoryWiseCustomersCount() async {
    try {
      categoryWiseCustomersCountLoading.value = true;
      final response = await _repo.getCategoryWiseCustomersCount(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
        branchId: BranchController.to.selectedBranch.value?.id,
      );
      categoryWiseCustomersCount.value = response;
    } catch (e) {
      Log.e("Home Module Error", e);
    } finally {
      categoryWiseCustomersCountLoading.value = false;
    }
  }

  Future<void> loadProducts() async {
    if (productsLoaded.value) return;
    productsLoaded.value = true;
    await Future.wait([
      getBestSellingProducts(),
      getLeastSellingProducts(),
      getCategorySales(),
    ]);
  }

  Future<void> getBestSellingProducts() async {
    try {
      bestSellingLoading.value = true;
      final response = await _repo.getBestSellingProducts(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
        branchId: BranchController.to.selectedBranch.value?.id,
      );
      bestSelling.value = response;
    } catch (e) {
      Log.e("Home Module Error", e);
    } finally {
      bestSellingLoading.value = false;
    }
  }

  Future<void> getLeastSellingProducts() async {
    try {
      leastSellingLoading.value = true;
      final response = await _repo.getLeastSellingProducts(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
        branchId: BranchController.to.selectedBranch.value?.id,
      );
      leastSelling.value = response;
    } catch (e) {
      Log.e("Home Module Error", e);
    } finally {
      leastSellingLoading.value = false;
    }
  }

  Future<void> getCategorySales() async {
    try {
      categorySalesLoading.value = true;
      final response = await _repo.getCategorySales(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
        branchId: BranchController.to.selectedBranch.value?.id,
      );
      categorySales.value = response;
    } catch (e) {
      Log.e("Home Module Error", e);
    } finally {
      categorySalesLoading.value = false;
    }
  }

  Future<void> loadFinance() async {
    if (financeLoaded.value) return;
    financeLoaded.value = true;
    await Future.wait([
      getTopExpenses(),
      getTopCoupons(),
      getReceivables(),
      getPayables(),
      getLoginLogs(),
    ]);
  }

  Future<void> getTopExpenses() async {
    try {
      topExpensesLoading.value = true;
      final response = await _repo.getTopExpenses(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
        branchId: BranchController.to.selectedBranch.value?.id,
      );
      topExpenses.value = response;
    } catch (e) {
      Log.e("Home Module Error", e);
    } finally {
      topExpensesLoading.value = false;
    }
  }

  Future<void> getTopCoupons() async {
    try {
      topCouponsLoading.value = true;
      final response = await _repo.getTopCoupons(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
        branchId: BranchController.to.selectedBranch.value?.id,
      );
      topCoupons.value = response;
    } catch (e) {
      Log.e("Home Module Error", e);
    } finally {
      topCouponsLoading.value = false;
    }
  }

  Future<void> getReceivables() async {
    try {
      receivablesLoading.value = true;
      final response = await _repo.getReceivables(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
        branchId: BranchController.to.selectedBranch.value?.id,
      );
      receivables.value = response;
    } catch (e) {
      Log.e("Home Module Error", e);
    } finally {
      receivablesLoading.value = false;
    }
  }

  Future<void> getPayables() async {
    try {
      payablesLoading.value = true;
      final response = await _repo.getPayables(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
        branchId: BranchController.to.selectedBranch.value?.id,
      );
      payables.value = response;
    } catch (e) {
      Log.e("Home Module Error", e);
    } finally {
      payablesLoading.value = false;
    }
  }

  Future<void> getLoginLogs() async {
    try {
      loginLogsLoading.value = true;
      final response = await _repo.getLoginLogs(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
        branchId: BranchController.to.selectedBranch.value?.id,
      );
      loginLogs.value = response;
    } catch (e) {
      Log.e("Home Module Error", e);
    } finally {
      loginLogsLoading.value = false;
    }
  }

  @override
  void onClose() {
    _fyWorker?.dispose();
    super.onClose();
  }
}
