import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/pos/order_list_model.dart';

import 'package:ai_setu/data/model/res/res_model.dart';

class OrderListRepository {
  final _api = ApiService.to;

  Future<PaginationModel<OrderListModel>> getAllOrderList({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? statusFilter,
    String? activeFilter,
  }) async {
    final url = ApiConstants.getAllPosOrder(
      page: page,
      limit: limit,
      search: search,
      fromDate: fromDate,
      toDate: toDate,
      statusFilter: statusFilter,
      activeFilter: activeFilter,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      final items = (res.data['posOrder_data'] as List)
          .map((e) => OrderListModel.fromJson(e))
          .toList();
      return PaginationModel.fromMap(res.data, items);
    } else {
      throw Exception(res.message);
    }
  }
}
