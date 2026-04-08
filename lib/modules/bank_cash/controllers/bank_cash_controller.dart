import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/bank_cash/bank_model.dart';
import 'package:ai_setu/data/model/bank_cash/expense_model.dart';
import 'package:ai_setu/data/model/bank_cash/pos_payment_model.dart';
import 'package:ai_setu/data/model/bank_cash/salary_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/repositories/bank_cash.dart';
import 'package:ai_setu/data/model/bank_cash/bank_transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BankCashController extends GetxController {
  static BankCashController get instance => Get.find();
  final BankCashRepository _repo = BankCashRepository();

  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxList<BankModel> bankCashList = <BankModel>[].obs;
  final RxList<BankTransactionModel> bankCashTransactionList =
      <BankTransactionModel>[].obs;

  final RxList<PosPaymentModel> paymentTermsList = <PosPaymentModel>[].obs;

  final RxList<ExpenseModel> expenseList = <ExpenseModel>[].obs;

  final RxList<SalaryModel> salaryList = <SalaryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchBankCash() async {
    isLoading.value = true;
    error.value = '';

    try {
      final ResModel res = await _repo.getBankCash();

      if (res.status == 200 && res.data != null) {
        final Map<String, dynamic> data = res.data as Map<String, dynamic>;
        List<dynamic> bankData = data['bank_data'] ?? [];
        if (bankData.isEmpty) {
          for (var value in data.values) {
            if (value is List) {
              bankData = value;
              break;
            }
          }
        }

        bankCashList.assignAll(
          bankData.map((json) => BankModel.fromJson(json)).toList(),
        );

        if (data['state'] != null) {
          totalPages.value =
              int.tryParse(data['state']['totalPages']?.toString() ?? '0') ?? 0;
        }
        totalItems.value =
            int.tryParse(data['totalData']?.toString() ?? data['total']?.toString() ?? '0') ?? 0;
      } else {
        error.value = res.message ?? 'Failed to fetch bank cash';
      }
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.error(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBankCashTransaction() async {
    isLoading.value = true;
    error.value = '';

    try {
      final ResModel res = await _repo.getBankCashTransaction(
        page: currentPage.value,
        fromDate: DateFormat(
          'yyyy-MM-dd',
        ).format(selectedDateRange.value.start),
        toDate: DateFormat('yyyy-MM-dd').format(selectedDateRange.value.end),
      );

      if (res.status == 200 && res.data != null) {
        final Map<String, dynamic> data = res.data as Map<String, dynamic>;
        List<dynamic> listData =
            data['transaction_data'] ?? data['bank_transaction_data'] ?? data['bankTransaction_data'] ?? [];
        if (listData.isEmpty) {
          for (var value in data.values) {
            if (value is List) {
              listData = value;
              break;
            }
          }
        }

        bankCashTransactionList.assignAll(
          listData.map((json) => BankTransactionModel.fromJson(json)).toList(),
        );

        if (data['state'] != null) {
          totalPages.value =
              int.tryParse(data['state']['totalPages']?.toString() ?? '0') ?? 0;
        }
        totalItems.value =
            int.tryParse(data['totalData']?.toString() ?? data['total']?.toString() ?? '0') ?? 0;
      } else {
        error.value = res.message ?? 'Failed to fetch bank transactions';
      }
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.error(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPaymentTerms() async {
    isLoading.value = true;
    error.value = '';

    try {
      final ResModel res = await _repo.getPaymentTerms(
        page: currentPage.value,
        fromDate: DateFormat(
          'yyyy-MM-dd',
        ).format(selectedDateRange.value.start),
        toDate: DateFormat('yyyy-MM-dd').format(selectedDateRange.value.end),
      );

      if (res.status == 200 && res.data != null) {
        final Map<String, dynamic> data = res.data as Map<String, dynamic>;
        List<dynamic> listData = data['posPayment_data'] ?? data['paymentTerms_data'] ?? [];
        if (listData.isEmpty) {
          for (var value in data.values) {
            if (value is List) {
              listData = value;
              break;
            }
          }
        }

        paymentTermsList.assignAll(
          listData.map((json) => PosPaymentModel.fromJson(json)).toList(),
        );

        if (data['state'] != null) {
          totalPages.value =
              int.tryParse(data['state']['totalPages']?.toString() ?? '0') ?? 0;
        }
        totalItems.value =
            int.tryParse(data['totalData']?.toString() ?? data['total']?.toString() ?? '0') ?? 0;
      } else {
        error.value = res.message ?? 'Failed to fetch bank transactions';
      }
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.error(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchReceipts() async {
    // Same as fetchPaymentTerms but might use different logic later
    await fetchPaymentTerms();
  }

  Future<void> fetchExpenses() async {
    isLoading.value = true;
    error.value = '';

    try {
      final ResModel res = await _repo.getExpenses(
        page: currentPage.value,
        fromDate: DateFormat(
          'yyyy-MM-dd',
        ).format(selectedDateRange.value.start),
        toDate: DateFormat('yyyy-MM-dd').format(selectedDateRange.value.end),
      );

      if (res.status == 200 && res.data != null) {
        final Map<String, dynamic> data = res.data as Map<String, dynamic>;
        List<dynamic> listData = data['expense_data'] ?? [];
        if (listData.isEmpty) {
          for (var value in data.values) {
            if (value is List) {
              listData = value;
              break;
            }
          }
        }

        expenseList.assignAll(
          listData.map((json) => ExpenseModel.fromJson(json)).toList(),
        );

        if (data['state'] != null) {
          totalPages.value =
              int.tryParse(data['state']['totalPages']?.toString() ?? '0') ?? 0;
        }
        totalItems.value =
            int.tryParse(data['totalData']?.toString() ?? data['total']?.toString() ?? '0') ?? 0;
      } else {
        error.value = res.message ?? 'Failed to fetch expenses';
      }
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.error(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSalary() async {
    isLoading.value = true;
    error.value = '';

    try {
      final ResModel res = await _repo.getSalary(
        page: currentPage.value,
        fromDate: DateFormat(
          'yyyy-MM-dd',
        ).format(selectedDateRange.value.start),
        toDate: DateFormat('yyyy-MM-dd').format(selectedDateRange.value.end),
      );

      if (res.status == 200 && res.data != null) {
        final Map<String, dynamic> data = res.data as Map<String, dynamic>;
        List<dynamic> listData = data['salary_data'] ?? [];
        if (listData.isEmpty) {
          for (var value in data.values) {
            if (value is List) {
              listData = value;
              break;
            }
          }
        }

        salaryList.assignAll(
          listData.map((json) => SalaryModel.fromJson(json)).toList(),
        );

        if (data['state'] != null) {
          totalPages.value =
              int.tryParse(data['state']['totalPages']?.toString() ?? '0') ?? 0;
        }
        totalItems.value =
            int.tryParse(data['totalData']?.toString() ?? data['total']?.toString() ?? '0') ?? 0;
      } else {
        error.value = res.message ?? 'Failed to fetch salary';
      }
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.error(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  final Rx<DateTimeRange> selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 0.obs;
  final RxInt totalItems = 0.obs;

  final RxBool topCustomersLoading = false.obs;
  final RxInt topCustomersPage = 1.obs;
  final RxInt topCustomersTotalPages = 0.obs;
  final RxInt topCustomersTotalItems = 0.obs;
}
