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
import 'package:ai_setu/data/repositories/dashboard_repository.dart';
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
  final graphsLoading = false.obs;
  final salesAndPurchaseGraph = <SalesAndPurchaseGraphModel>[].obs;
  final transactionGraph = <TransactionGraphModel>[].obs;

  // ── Section 3: Customers ──
  final customersLoaded = false.obs;
  final customersLoading = false.obs;
  final topCustomers = <TopCustomerModel>[].obs;
  final categoryWiseCustomers = <CategoryWiseCustomersModel>[].obs;
  final categoryWiseCustomersCount = <CategoryWiseCustomersCountModel>[].obs;

  // ── Section 4: Products ──
  final productsLoaded = false.obs;
  final productsLoading = false.obs;
  final bestSelling = <SellingsModel>[].obs;
  final leastSelling = <SellingsModel>[].obs;
  final categorySales = <CategorySalesModel>[].obs;

  // ── Section 5: Finance ──
  final financeLoaded = false.obs;
  final financeLoading = false.obs;
  final topExpenses = <TopExpensesModel>[].obs;
  final topCoupons = <TopCouponsModel>[].obs;
  final receivables = <ReceivableModel>[].obs;
  final payables = <PayableModel>[].obs;
  final loginLogs = <LoginLogModel>[].obs;

  final isLoaded = false.obs;

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
      getTopSectionData(); // Section 1 fires immediately
    });
  }

  Future<void> getTopSectionData() async {
    try {
      topSectionLoading.value = true;
      final response = await _repo.getTransactions(
        startDate: selectedDateRange.value.start,
        endDate: selectedDateRange.value.end,
      );
      topSectionData.value = response;
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.error(e.toString().replaceAll('Exception: ', ''));
    } finally {
      topSectionLoading.value = false;
    }
  }

  // Each section guard: only fetch once
  Future<void> loadGraphs() async {
    if (graphsLoaded.value) return;
    graphsLoading.value = true;
    final results = await Future.wait([
      _repo
          .getSalesAndPurchaseGraph(
            startDate: selectedDateRange.value.start,
            endDate: selectedDateRange.value.end,
          )
          .catchError((_) => <SalesAndPurchaseGraphModel>[]),
      _repo
          .getTransactionGraph(
            startDate: selectedDateRange.value.start,
            endDate: selectedDateRange.value.end,
          )
          .catchError((_) => <TransactionGraphModel>[]),
    ]);
    salesAndPurchaseGraph.value =
        results[0] as List<SalesAndPurchaseGraphModel>;
    transactionGraph.value = results[1] as List<TransactionGraphModel>;
    graphsLoaded.value = true;
    graphsLoading.value = false;
  }

  Future<void> loadCustomers() async {
    if (customersLoaded.value) return;
    customersLoading.value = true;
    final results = await Future.wait([
      _repo
          .getTopCustomers(
            startDate: selectedDateRange.value.start,
            endDate: selectedDateRange.value.end,
          )
          .catchError((_) => <TopCustomerModel>[]),
      _repo
          .getCategoryWiseCustomers(
            startDate: selectedDateRange.value.start,
            endDate: selectedDateRange.value.end,
          )
          .catchError((_) => <CategoryWiseCustomersModel>[]),
      _repo
          .getCategoryWiseCustomersCount(
            startDate: selectedDateRange.value.start,
            endDate: selectedDateRange.value.end,
          )
          .catchError((_) => <CategoryWiseCustomersCountModel>[]),
    ]);
    topCustomers.value = results[0] as List<TopCustomerModel>;
    categoryWiseCustomers.value =
        results[1] as List<CategoryWiseCustomersModel>;
    categoryWiseCustomersCount.value =
        results[2] as List<CategoryWiseCustomersCountModel>;
    customersLoaded.value = true;
    customersLoading.value = false;
  }

  Future<void> loadProducts() async {
    if (productsLoaded.value) return;
    productsLoading.value = true;
    final results = await Future.wait([
      _repo
          .getBestSellingProducts(
            startDate: selectedDateRange.value.start,
            endDate: selectedDateRange.value.end,
          )
          .catchError((_) => <SellingsModel>[]),
      _repo
          .getLeastSellingProducts(
            startDate: selectedDateRange.value.start,
            endDate: selectedDateRange.value.end,
          )
          .catchError((_) => <SellingsModel>[]),
      _repo
          .getCategorySales(
            startDate: selectedDateRange.value.start,
            endDate: selectedDateRange.value.end,
          )
          .catchError((_) => <CategorySalesModel>[]),
    ]);
    bestSelling.value = results[0] as List<SellingsModel>;
    leastSelling.value = results[1] as List<SellingsModel>;
    categorySales.value = results[2] as List<CategorySalesModel>;
    productsLoaded.value = true;
    productsLoading.value = false;
  }

  Future<void> loadFinance() async {
    if (financeLoaded.value) return;
    financeLoading.value = true;
    final results = await Future.wait([
      _repo
          .getTopExpenses(
            startDate: selectedDateRange.value.start,
            endDate: selectedDateRange.value.end,
          )
          .catchError((_) => <TopExpensesModel>[]),
      _repo
          .getTopCoupons(
            startDate: selectedDateRange.value.start,
            endDate: selectedDateRange.value.end,
          )
          .catchError((_) => <TopCouponsModel>[]),
      _repo
          .getReceivables(
            startDate: selectedDateRange.value.start,
            endDate: selectedDateRange.value.end,
          )
          .catchError((_) => <ReceivableModel>[]),
      _repo
          .getPayables(
            startDate: selectedDateRange.value.start,
            endDate: selectedDateRange.value.end,
          )
          .catchError((_) => <PayableModel>[]),
      _repo
          .getLoginLogs(
            startDate: selectedDateRange.value.start,
            endDate: selectedDateRange.value.end,
          )
          .catchError((_) => <LoginLogModel>[]),
    ]);
    topExpenses.value = results[0] as List<TopExpensesModel>;
    topCoupons.value = results[1] as List<TopCouponsModel>;
    receivables.value = results[2] as List<ReceivableModel>;
    payables.value = results[3] as List<PayableModel>;
    loginLogs.value = results[4] as List<LoginLogModel>;
    financeLoaded.value = true;
    financeLoading.value = false;
  }
}
