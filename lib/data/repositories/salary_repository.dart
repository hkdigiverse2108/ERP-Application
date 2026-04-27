import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/bank_cash/salary_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class SalaryRepository {
  final ApiService _api = ApiService.to;

  Future<PaginationModel<SalaryModel>> getAllSalaries({
    int? page,
    int? limit,
    String? fromDate,
    String? toDate,
    String? search,
    String? activeFilter,
    String? branchId,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllSalary(
        page: page,
        limit: limit,
        fromDate: fromDate,
        toDate: toDate,
        search: search,
        activeFilter: activeFilter,
        branchId: branchId,
      ),
    );

    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data['salary_data'];
      final items = dataList != null
          ? dataList
                .map((e) => SalaryModel.fromMap(e as Map<String, dynamic>))
                .toList()
          : <SalaryModel>[];
      return PaginationModel.fromMap(res.data, items);
    }

    throw Exception(res.message ?? 'Failed to fetch salary');
  }

  Future<ResModel> addSalary(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addSalary, body: data);
  }

  Future<ResModel> updateSalary(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updateSalary, body: data);
  }

  Future<SalaryModel> getSalaryById(String id) async {
    final ResModel res = await _api.get(ApiConstants.getSalaryById(id));
    if (res.status == 200 && res.data != null) {
      return SalaryModel.fromMap(res.data);
    }
    throw Exception(res.message ?? 'Failed to fetch salary');
  }
}
