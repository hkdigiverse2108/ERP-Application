import 'dart:convert';
import 'package:ai_setu/data/model/accounting/cradit_note_model.dart';
import 'package:ai_setu/data/model/accounting/debit_note_model.dart';
import 'package:ai_setu/data/repositories/accounting_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountingController extends GetxController {
  final isLoading = false.obs;
  final debitNoteList = <DebitNoteModel>[].obs;
  final creditNoteList = <CreditNoteModel>[].obs;
  final repo = AccountingRepository();

  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalItems = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchDebitNote() async {
    try {
      isLoading.value = true;
      final res = await repo.getDebitNote();
      
      final dynamic rawData = res.data;
      List<dynamic> targetList = [];
      if (rawData is List) {
        targetList = rawData;
      } else if (rawData is Map) {
        if (rawData.containsKey("data") && rawData["data"] is List) {
          targetList = rawData["data"];
        } else if (rawData.containsKey("debitNote_data") && rawData["debitNote_data"] is List) {
          targetList = rawData["debitNote_data"];
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

      debitNoteList.assignAll(targetList.map((e) => DebitNoteModel.fromJson(e)).toList());
    } catch (e) {
      debugPrint("Error fetching debit notes: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCreditNote() async {
    try {
      isLoading.value = true;
      final res = await repo.getCreditNote();
      
      final dynamic rawData = res.data;
      List<dynamic> targetList = [];
      if (rawData is List) {
        targetList = rawData;
      } else if (rawData is Map) {
        if (rawData.containsKey("data") && rawData["data"] is List) {
          targetList = rawData["data"];
        } else if (rawData.containsKey("creditNote_data") && rawData["creditNote_data"] is List) {
          targetList = rawData["creditNote_data"];
        } else if (rawData.containsKey("purchaseCreditNote_data") && rawData["purchaseCreditNote_data"] is List) {
          targetList = rawData["purchaseCreditNote_data"];
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

      creditNoteList.assignAll(targetList.map((e) => CreditNoteModel.fromJson(e)).toList());
    } catch (e) {
      debugPrint("Error fetching credit notes: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
