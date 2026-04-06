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
  final RxList<BankDatum> bankCashList = <BankDatum>[].obs;
  final RxList<BankTransactionDatum> bankCashTransactionList =
      <BankTransactionDatum>[].obs;

  final RxList<PosPaymentDatum> paymentTermsList = <PosPaymentDatum>[].obs;

  final RxList<ExpenseDatum> expenseList = <ExpenseDatum>[].obs;

  final RxList<SalaryDatum> salaryList = <SalaryDatum>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBankCash();
    fetchBankCashTransaction();
    fetchPaymentTerms();
    fetchExpenses();
    fetchSalary();
  }

  Future<void> fetchBankCash() async {
    isLoading.value = true;
    error.value = '';

    try {
      final ResModel res = await _repo.getBankCash();

      if (res.status == 200 && res.data != null) {
        final Map<String, dynamic> data = res.data as Map<String, dynamic>;
        final List<dynamic> bankData = data['bank_data'] ?? [];

        bankCashList.assignAll(
          bankData.map((json) => BankDatum.fromJson(json)).toList(),
        );
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
        final BankTransactionModel transactionModel =
            BankTransactionModel.fromJson(res.data);
        bankCashTransactionList.assignAll(transactionModel.bankTransactionData);
        totalItems.value = transactionModel.totalData;
        totalPages.value = transactionModel.state.totalPages;
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
        final PosPaymentModel paymentModel = PosPaymentModel.fromJson(res.data);
        paymentTermsList.assignAll(paymentModel.posPaymentData);
        totalItems.value = paymentModel.totalData;
        totalPages.value = paymentModel.state.totalPages;
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
        final PosPaymentModel receiptVoucherModel = PosPaymentModel.fromJson(
          res.data,
        );
        paymentTermsList.assignAll(receiptVoucherModel.posPaymentData);
        totalItems.value = receiptVoucherModel.totalData;
        totalPages.value = receiptVoucherModel.state.totalPages;
      } else {
        error.value = res.message ?? 'Failed to fetch receipt voucher';
      }
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.error(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
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
        final ExpenseModel expenseModel = ExpenseModel.fromJson(res.data);
        expenseList.assignAll(expenseModel.expenseData);
        totalItems.value = expenseModel.totalData;
        totalPages.value = expenseModel.state.totalPages;
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
        final SalaryModel salaryModel = SalaryModel.fromJson(res.data);
        salaryList.assignAll(salaryModel.salaryData);
        totalItems.value = salaryModel.totalData;
        totalPages.value = salaryModel.state.totalPages;
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
