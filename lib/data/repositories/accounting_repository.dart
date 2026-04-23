import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';

import 'package:ai_setu/data/model/res/res_model.dart';

class AccountingRepository {
  final ApiService _api = ApiService();

  Future<ResModel> getCreditNote({
    int page = 1,
    int limit = 10,
    String? search,
    String? activeFilter,
    String? branchId,
  }) async {
    final String url = ApiConstants.getAllCreditNote(
      page: page,
      limit: limit,
      search: search,
      activeFilter: activeFilter,
      branchId: branchId,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    } else {
      throw Exception(res.message);
    }
  }

  Future<ResModel> getDebitNote({
    int page = 1,
    int limit = 10,
    String? search,
    String? activeFilter,
    String? branchId,
  }) async {
    final String url = ApiConstants.getAllDebitNote(
      page: page,
      limit: limit,
      search: search,
      activeFilter: activeFilter,
      branchId: branchId,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    } else {
      throw Exception(res.message);
    }
  }
}
