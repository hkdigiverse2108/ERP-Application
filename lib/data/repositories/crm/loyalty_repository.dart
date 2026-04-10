import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/crm/loyalty_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class LoyaltyRepository {
  final _api = ApiService.to;

  Future<PaginationModel<LoyaltyModel>> getAllLoyalty({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? activeFilter,
  }) async {
    final url = ApiConstants.getAllLoyalty(
      page: page,
      limit: limit,
      search: search,
      fromDate: fromDate,
      toDate: toDate,
      activeFilter: activeFilter,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      final items = (res.data['loyalty_data'] as List)
          .map((e) => LoyaltyModel.fromJson(e))
          .toList();
      return PaginationModel.fromJson(res.data, items);
    }
    throw Exception(res.message ?? "Something went wrong");
  }
}
