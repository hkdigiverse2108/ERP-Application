import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/bank_cash/expense_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class ExpenseRepository {
  final ApiService _api = ApiService.to;

  Future<PaginationModel<ExpenseModel>> getAllExpenses({
    int? page,
    int? limit,
    String? fromDate,
    String? toDate,
    String? search,
    String? typeFilter,
    bool? avoidSalary,
    String? activeFilter,
    String? branchId,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllExpense(
        page: page,
        limit: limit,
        fromDate: fromDate,
        toDate: toDate,
        search: search,
        typeFilter: typeFilter,
        avoidSalary: avoidSalary,
        activeFilter: activeFilter,
        branchId: branchId,
      ),
    );

    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data['expense_data'];
      final items = dataList != null
          ? dataList
                .map((e) => ExpenseModel.fromMap(e as Map<String, dynamic>))
                .toList()
          : <ExpenseModel>[];
      return PaginationModel.fromMap(res.data, items);
    }

    throw Exception(res.message ?? 'Failed to fetch expenses');
  }

  Future<ResModel> addExpense(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addExpense, body: data);
  }

  Future<ResModel> updateExpense(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updateExpense, body: data);
  }

  Future<ExpenseModel> getExpenseById(String id) async {
    final ResModel res = await _api.get(ApiConstants.getExpenseById(id));
    if (res.status == 200 && res.data != null) {
      return ExpenseModel.fromMap(res.data);
    }
    throw Exception(res.message ?? 'Failed to fetch expense');
  }
}
