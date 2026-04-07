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

  @override
  void onInit() {
    super.onInit();
    debugPrint("AccountingController initialized");
    fetchDebitNote();
    fetchCreditNote();
  }

  Future<void> fetchDebitNote() async {
    try {
      debugPrint("Fetching Debit Notes...");
      isLoading.value = true;

      final debitNote = await AccountingRepository().getDebitNote();

      debugPrint("Debit Note API Response: $debitNote");

      debitNoteList.assignAll(debitNote.debitNoteData);

      debugPrint("Debit Note List Length: ${debitNoteList.length}");

      totalPages.value = debitNote.state.totalPages;
      totalItems.value = debitNote.totalData;

      debugPrint(
        "Debit Notes Pagination -> Total Pages: ${totalPages.value}, Total Items: ${totalItems.value}",
      );
    } catch (e, stackTrace) {
      debugPrint("Error fetching debit notes: $e");
      debugPrint("StackTrace: $stackTrace");
    } finally {
      isLoading.value = false;
      debugPrint("Finished fetching Debit Notes");
    }
  }

  Future<void> fetchCreditNote() async {
    try {
      debugPrint("Fetching Credit Notes...");
      isLoading.value = true;

      final creditNote = await AccountingRepository().getCreditNote();

      debugPrint("Credit Note API Response: $creditNote");

      creditNoteList.assignAll(creditNote.creditNoteData);

      debugPrint("Credit Note List Length: ${creditNoteList.length}");

      totalPages.value = creditNote.state.totalPages;
      totalItems.value = creditNote.totalData;

      debugPrint(
        "Credit Notes Pagination -> Total Pages: ${totalPages.value}, Total Items: ${totalItems.value}",
      );
    } catch (e, stackTrace) {
      debugPrint("Error fetching credit notes: $e");
      debugPrint("StackTrace: $stackTrace");
    } finally {
      isLoading.value = false;
      debugPrint("Finished fetching Credit Notes");
    }
  }
}
