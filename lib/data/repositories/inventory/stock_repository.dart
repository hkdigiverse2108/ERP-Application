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
    String? categoryFilter,
    String? subCategoryFilter,
    String? brandFilter,
    String? subBrandFilter,
  }) async {
    final ResModel response = await _api.get(
      ApiConstants.getAllStock(
        page: page,
        limit: limit,
        search: search,
        activeFilter: activeFilter,
        categoryFilter: categoryFilter,
        subCategoryFilter: subCategoryFilter,
        brandFilter: brandFilter,
        subBrandFilter: subBrandFilter,
      ),
    );
    if (response.status == 200) {
      final items = List<StockItemModel>.from(
        (response.data['stock_data'] as List).map(
          (x) => StockItemModel.fromMap(x as Map<String, dynamic>),
        ),
      );
      return PaginationModel.fromMap(response.data, items);
    }

    throw Exception(response.message ?? 'Failed to load product stock');
  }

  Future<StockModel> getStockById(String id) async {
    final ResModel response = await _api.get(ApiConstants.getStockById(id));

    if (response.status == 200 && response.data != null) {
      return StockModel.fromMap(response.data as Map<String, dynamic>);
    }

    throw Exception(response.message ?? 'Failed to load product');
  }

  Future<bool> deleteStock(String id) async {
    final ResModel response = await _api.delete(ApiConstants.deleteStock(id));
    return response.status == 200;
  }
}
