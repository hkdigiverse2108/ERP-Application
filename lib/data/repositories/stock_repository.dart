import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/invetory/stock_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class StockRepository {
  final ApiService _api = ApiService.to;

  Future<PaginationModel<StockItemModel>> getStockList({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) async {
    final ResModel response = await _api.get(
      ApiConstants.getAllStock(
        page: page,
        limit: limit,
        search: search,
        activeFilter: activeFilter,
      ),
    );
    if (response.status == 200) {
      final items = (response.data['stock_data'] as List)
          .map((x) => StockItemModel.fromJson(x))
          .toList();
      return PaginationModel.fromJson(response.data, items);
    }

    throw Exception(response.message ?? 'Failed to load product stock');
  }

  Future<StockModel> getStockById(String id) async {
    final ResModel response = await _api.get(ApiConstants.getStockById(id));

    if (response.status == 200 && response.data != null) {
      return StockModel.fromJson(response.data as Map<String, dynamic>);
    }

    throw Exception(response.message ?? 'Failed to load product');
  }
}
