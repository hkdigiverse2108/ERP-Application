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
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllSalary(
        page: page,
        limit: limit,
        fromDate: fromDate,
        toDate: toDate,
        search: search,
        activeFilter: activeFilter,
      ),
    );

    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data['salary_data'];
      final items = dataList != null
          ? dataList
                .map((e) => SalaryModel.fromJson(e as Map<String, dynamic>))
                .toList()
          : <SalaryModel>[];
      return PaginationModel.fromJson(res.data, items);
    }

    throw Exception(res.message ?? 'Failed to fetch salary');
  }
}
