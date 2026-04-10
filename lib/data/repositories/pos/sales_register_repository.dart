import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/pos/sales_register_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class SalesRegisterRepository {
  final _api = ApiService.to;

  Future<PaginationModel<SalesRegisterModel>> getAllSalesRegister({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? salesManFilter,
    String? statusFilter,
    String? activeFilter,
  }) async {
    final url = ApiConstants.getAllPosCashRegister(
      page: page,
      limit: limit,
      search: search,
      fromDate: fromDate,
      toDate: toDate,
      salesManFilter: salesManFilter,
      statusFilter: statusFilter,
      activeFilter: activeFilter,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      final items = (res.data['posCashRegister_data'] as List)
          .map((e) => SalesRegisterModel.fromJson(e))
          .toList();
      return PaginationModel.fromJson(res.data, items);
    } else {
      throw Exception(res.message);
    }
  }
}
