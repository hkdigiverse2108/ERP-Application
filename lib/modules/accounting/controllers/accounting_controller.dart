import 'package:ai_setu/data/model/accounting/cradit_note_model.dart';
import 'package:ai_setu/data/model/accounting/debit_note_model.dart';
import 'package:ai_setu/data/repositories/accounting_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountingController extends GetxController {
  final isLoading = false.obs;
  final debitNoteList = <DebitNoteDatum>[].obs;
  final creditNoteList = <CreditNoteDatum>[].obs;

  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalItems = 0.obs;

  final selectedDateRange = Rx<DateTimeRange?>(null);

  final _repo = AccountingRepository();

  @override
  void onInit() {
    super.onInit();
    fetchDebitNote();
    fetchCreditNote();
  }

  Future<void> fetchDebitNote() async {
    try {
      isLoading.value = true;
      final debitNote = await _repo.getDebitNote();

      debitNoteList.assignAll(debitNote.debitNoteData);
      totalPages.value = debitNote.state.totalPages;
      totalItems.value = debitNote.totalData;
    } catch (e) {
      debugPrint("Error fetching debit notes: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCreditNote() async {
    try {
      isLoading.value = true;
      final creditNote = await _repo.getCreditNote();
      creditNoteList.assignAll(creditNote.creditNoteData);
      totalPages.value = creditNote.state.totalPages;
      totalItems.value = creditNote.totalData;
    } catch (e) {
      debugPrint("Error fetching credit notes: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
