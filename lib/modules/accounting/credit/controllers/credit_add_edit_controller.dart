import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/accounting/cradit_note_model.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/repositories/accounting/accounting_repository.dart';
import 'package:ai_setu/data/repositories/bank_cash/bank_repository.dart';
import 'package:ai_setu/modules/accounting/credit/controllers/credit_controller.dart';
import 'package:ai_setu/shared/widgets/media_picker/views/media_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditAddEditController extends GetxController {
  final AccountingRepository _repo = AccountingRepository();
  final BankRepository _bankRepo = BankRepository();

  final formKey = GlobalKey<FormState>();

  final personNameController = TextEditingController();
  final countryCodeController = TextEditingController(text: "+91");
  final phoneNoController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxList<IdNameModel> bankAccounts = <IdNameModel>[].obs;
  final RxnString selectedBankAccountId = RxnString();
  final RxnString selectedImageUrl = RxnString();
  final RxBool isSaving = false.obs;

  bool isEdit = false;
  CreditNoteModel? existingNote;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is CreditNoteModel) {
      isEdit = true;
      existingNote = args;
      _initializeData();
    }
    _fetchBankAccounts();
  }

  void _initializeData() {
    if (existingNote == null) return;
    personNameController.text = existingNote!.personName ?? '';
    countryCodeController.text = existingNote!.phoneNo.countryCode;
    phoneNoController.text = existingNote!.phoneNo.phoneNo.toString();
    amountController.text = existingNote!.amount.toString();
    descriptionController.text = existingNote!.description ?? '';
    selectedBankAccountId.value = existingNote!.bankAccountId.id;
    selectedImageUrl.value = existingNote!.image;
    selectedDate.value = existingNote!.date;
    dateController.text =
        "${selectedDate.value!.day}/${selectedDate.value!.month}/${selectedDate.value!.year}";
  }

  Future<void> _fetchBankAccounts() async {
    try {
      final accounts = await _bankRepo.getBankDropdown();
      bankAccounts.assignAll(accounts);
    } catch (e) {
      AppSnackbar.error('Failed to load bank accounts: $e');
    }
  }

  void onDateSelected(DateTime date) {
    selectedDate.value = date;
    dateController.text = "${date.day}/${date.month}/${date.year}";
  }

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;

    isSaving.value = true;
    try {
      final Map<String, dynamic> data = {
        if (isEdit) 'creditNoteId': existingNote!.id,
        'personName': personNameController.text,
        'phoneNo': {
          'countryCode': countryCodeController.text,
          'phoneNo': phoneNoController.text,
        },
        'amount': double.tryParse(amountController.text) ?? 0.0,
        'description': descriptionController.text,
        'type': 'payin',
        'bankAccountId': selectedBankAccountId.value,
        'date': selectedDate.value?.toIso8601String(),
        'image': selectedImageUrl.value,
      };

      ResModel res;
      if (isEdit) {
        res = await _repo.updateCreditNote(data);
      } else {
        res = await _repo.addCreditNote(data);
      }

      if (res.status == 200) {
        await _refreshAndBack();
        AppSnackbar.success(res.message ?? "Credit Note Added Successfully");
      } else {
        AppSnackbar.error(res.message ?? "Something went wrong");
      }
    } catch (e) {
      AppSnackbar.error('Something went wrong: $e');
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> pickImage() async {
    await MediaPickerDialog.show(
      onMediaSelected: (selected) {
        if (selected.isNotEmpty) {
          selectedImageUrl.value = selected.first.url;
        }
      },
    );
  }

  void removeImage() {
    selectedImageUrl.value = null;
  }

  @override
  void onClose() {
    personNameController.dispose();
    countryCodeController.dispose();
    phoneNoController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.onClose();
  }

  Future<void> _refreshAndBack() async {
    final creditController = Get.isRegistered<CreditController>()
        ? Get.find<CreditController>()
        : null;

    if (creditController != null) {
      await creditController.refreshData();
    }
    Get.back();
  }
}

