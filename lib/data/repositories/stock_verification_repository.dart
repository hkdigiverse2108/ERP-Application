import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/invetory/stock_verification_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class StockVerificationRepository {
  final ApiService _api = ApiService.to;

  Future<PaginationModel<StockVerificationModel>> getStockVerificationList({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
    Map<String, dynamic>? filter,
  }) async {
    final ResModel response = await _api.get(
      ApiConstants.getAllStockVerification(
        page: page,
        limit: limit,
        search: search,
        activeFilter: activeFilter,
        statusFilter: filter?['statusFilter'],
      ),
    );

    if (response.status == 200) {
      final items = (response.data['stockVerification_data'] as List)
          .map((x) => StockVerificationModel.fromMap(x as Map<String, dynamic>))
          .toList();
      return PaginationModel.fromMap(response.data, items);
    }

    throw Exception(response.message ?? 'Failed to load stock verification');
  }

  Future<StockVerificationModel> getStockVerificationById(String id) async {
    final ResModel response = await _api.get(
      ApiConstants.getStockVerificationById(id),
    );

    if (response.status == 200 && response.data != null) {
      return StockVerificationModel.fromMap(
        response.data as Map<String, dynamic>,
      );
    }

    throw Exception(
      response.message ?? 'Failed to load stock verification detail',
    );
  }
}
