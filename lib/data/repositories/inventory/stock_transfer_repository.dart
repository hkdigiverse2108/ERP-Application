import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/invetory/stock_transfer_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class StockTransferRepository {
  final ApiService _api = ApiService.to;

  Future<PaginationModel<StockTransferModel>> getStockTransferList({
    int? page,
    int? limit,
    String? search,
    String? branchId,
    String? fromDate,
    String? toDate,
    String? activeFilter,
    String? typeFilter,
    String? statusFilter,
  }) async {
    final ResModel response = await _api.get(
      ApiConstants.getAllStockTransfer(
        page: page,
        limit: limit,
        search: search,
        branchId: branchId,
        fromDate: fromDate,
        toDate: toDate,
        activeFilter: activeFilter,
        typeFilter: typeFilter,
        statusFilter: statusFilter,
      ),
    );
    if (response.status == 200) {
      final items = List<StockTransferModel>.from(
        (response.data['stock_transfer'] as List).map(
          (x) => StockTransferModel.fromMap(x as Map<String, dynamic>),
        ),
      );
      return PaginationModel.fromMap(response.data, items);
    }

    throw Exception(response.message ?? 'Failed to load stock transfers');
  }

  Future<StockTransferModel> getStockTransferById(String id) async {
    final ResModel response = await _api.get(
      ApiConstants.getStockTransferById(id),
    );

    if (response.status == 200 && response.data != null) {
      return StockTransferModel.fromMap(response.data as Map<String, dynamic>);
    }

    throw Exception(response.message ?? 'Failed to load stock transfer');
  }

  Future<bool> deleteStockTransfer(String id) async {
    final ResModel response = await _api.delete(
      ApiConstants.deleteStockTransfer(id),
    );
    return response.status == 200;
  }

  Future<bool> addStockTransfer(Map<String, dynamic> data) async {
    final ResModel response = await _api.post(
      ApiConstants.addStockTransfer,
      body: data,
    );
    return response.status == 200;
  }

  Future<bool> updateStockTransfer(Map<String, dynamic> data) async {
    final ResModel response = await _api.put(
      ApiConstants.updateStockTransfer,
      body: data,
    );
    return response.status == 200;
  }
}
