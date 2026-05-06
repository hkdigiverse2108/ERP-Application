import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/bank_cash/expense_model.dart';
import 'package:ai_setu/data/model/bank_cash/salary_model.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/data/repositories/contact/contact_repository.dart';
import 'package:ai_setu/data/repositories/bank_cash/expense_repository.dart';
import 'package:ai_setu/data/repositories/bank_cash/salary_repository.dart';
import 'package:ai_setu/data/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:ai_setu/shared/widgets/media_picker/views/media_picker_dialog.dart';
import 'package:ai_setu/modules/bank_cash/expense/controllers/expense_controller.dart';
import 'package:ai_setu/modules/bank_cash/salary/controllers/salary_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpenseAddEditController extends GetxController {
  final _expenseRepo = ExpenseRepository();
  final _salaryRepo = SalaryRepository();
  final _contactRepo = ContactRepository();
  final _userRepo = UserRepository();

  final isSalary = false.obs;
  final isEdit = false.obs;
  final isLoading = false.obs;
  final isSaving = false.obs;

  // Form Fields
  final selectedPartyId = Rxn<String>();
  final selectedType = Rxn<String>();
  final fromDate = DateTime.now().obs;
  final toDate = DateTime.now().obs;
  final amountController = TextEditingController();
  final incentiveController = TextEditingController();
  final totalController = TextEditingController();
  final descriptionController = TextEditingController();
  final isActive = true.obs;
  final selectedImageUrl = Rxn<String>();

  // Dropdown Data
  final parties = <IdNameModel>[].obs;
  final expenseTypes = <String>['income', 'expense'].obs;
  final salaryTypes = <String>['expense'].obs;

  String? expenseId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      isSalary.value = args['isSalary'] ?? false;
      if (isSalary.value) {
        selectedType.value = 'expense';
      }
      if (args['expense'] != null) {
        isEdit.value = true;
        _populateData(args['expense']);
      } else if (args['salary'] != null) {
        isEdit.value = true;
        _populateData(args['salary']);
      }
    }

    _loadDropdownData();

    // Auto-calculate total for salary
    amountController.addListener(_updateTotal);
    incentiveController.addListener(_updateTotal);
  }

  void _populateData(dynamic item) {
    if (item is ExpenseModel) {
      expenseId = item.id;
      selectedPartyId.value = item.partyId?.id;
      selectedType.value = item.type;
      fromDate.value = item.fromDate;
      toDate.value = item.toDate ?? DateTime.now();
      amountController.text = item.amount.toString();
      incentiveController.text = (item.incentive ?? 0).toString();
      descriptionController.text = item.description ?? '';
      isActive.value = item.isActive;
      selectedImageUrl.value = item.image;
    } else if (item is SalaryModel) {
      expenseId = item.id;
      selectedPartyId.value = item.partyId?.id;
      selectedType.value = 'expense'; // Always expense for salary
      fromDate.value = item.fromDate;
      toDate.value = item.toDate;
      amountController.text = item.amount.toString();
      incentiveController.text = item.incentive.toString();
      descriptionController.text = item.description ?? '';
      isActive.value = item.isActive;
      selectedImageUrl.value = item.image;
    }
    _updateTotal();
  }

  void _updateTotal() {
    if (!isSalary.value) return;
    final amount = double.tryParse(amountController.text) ?? 0;
    final incentive = double.tryParse(incentiveController.text) ?? 0;
    totalController.text = (amount + incentive).toStringAsFixed(2);
  }

  Future<void> _loadDropdownData() async {
    try {
      isLoading.value = true;
      if (isSalary.value) {
        // For salary, parties come from users
        final userDropdown = await _userRepo.getUserDropDown();
        parties.value = userDropdown
            .map((e) => IdNameModel(id: e.id, name: e.fullName))
            .toList();
      } else {
        // For expense, parties come from contacts
        final contactDropdown = await _contactRepo.getContactDropdown();
        parties.value = contactDropdown
            .map((e) => IdNameModel(id: e.id, name: e.name))
            .toList();
      }
    } catch (e) {
      AppSnackbar.error('Error loading dropdown data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> save() async {
    if (selectedPartyId.value == null) {
      AppSnackbar.error('Please select a party');
      return;
    }
    if (selectedType.value == null) {
      AppSnackbar.error('Please select a type');
      return;
    }
    if (amountController.text.isEmpty) {
      AppSnackbar.error('Please enter amount');
      return;
    }

    try {
      isSaving.value = true;
      final data = {
        if (isEdit.value && isSalary.value == false) 'expenseId': expenseId,
        if (isEdit.value && isSalary.value == true) 'salaryId': expenseId,
        'partyId': selectedPartyId.value,
        'type': selectedType.value,
        'fromDate': DateFormat('yyyy-MM-dd').format(fromDate.value),
        'amount': double.tryParse(amountController.text) ?? 0,
        'description': descriptionController.text,
        'isActive': isActive.value,
        'branchId': BranchController.to.selectedBranch.value?.id,
        'image': selectedImageUrl.value,
      };

      if (isSalary.value) {
        data['toDate'] = DateFormat('yyyy-MM-dd').format(toDate.value);
        data['incentive'] = double.tryParse(incentiveController.text) ?? 0;
        data['total'] = double.tryParse(totalController.text) ?? 0;

        if (isEdit.value) {
          await _salaryRepo.updateSalary(data);
        } else {
          await _salaryRepo.addSalary(data);
        }
      } else {
        if (isEdit.value) {
          await _expenseRepo.updateExpense(data);
        } else {
          await _expenseRepo.addExpense(data);
        }
      }
      _refreshAndBack();
      AppSnackbar.success(
        '${isSalary.value ? "Salary" : "Expense"} saved successfully',
      );
    } catch (e) {
      AppSnackbar.error('Error saving: $e');
    } finally {
      isSaving.value = false;
    }
  }

  void _refreshAndBack() {
    if (isSalary.value) {
      if (Get.isRegistered<SalaryController>()) {
        SalaryController.instance.refreshData();
      }
    } else {
      if (Get.isRegistered<ExpenseController>()) {
        ExpenseController.instance.refreshData();
      }
    }
    Get.back();
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
    amountController.dispose();
    incentiveController.dispose();
    totalController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}

