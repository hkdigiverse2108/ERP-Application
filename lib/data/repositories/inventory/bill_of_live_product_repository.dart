import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/invetory/bill_live_product_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class BillOfLiveProductRepository {
  final ApiService _api = ApiService.to;

  Future<PaginationModel<BillOfLiveProductModel>> getBillOfLiveProductList({
    int? page,
    int? limit,
    String? search,
    Map<String, dynamic>? filter,
  }) async {
    final ResModel response = await _api.get(
      ApiConstants.getAllBillOfLiveProduct(
        page: page,
        limit: limit,
        search: search,
        branchId: filter?['branchFilter'],
        startDate: filter?['startDate'],
        endDate: filter?['endDate'],
        activeFilter: filter?['statusFilter'],
      ),
    );

    if (response.status == 200) {
      final items = (response.data['billOfLiveProduct_data'] as List)
          .map((x) => BillOfLiveProductModel.fromMap(x as Map<String, dynamic>))
          .toList();
      return PaginationModel.fromMap(response.data, items);
    }

    throw Exception(response.message ?? 'Failed to load bill of live products');
  }

  Future<ResModel> addBillOfLiveProduct(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addBillOfLiveProduct,body: data);
  }

  Future<ResModel> updateBillOfLiveProduct(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updateBillOfLiveProduct, body: data);
  }

  Future<BillOfLiveProductModel> getBillOfLiveProductById(String id) async {
    final ResModel response = await _api.get(ApiConstants.getBillOfLiveProductById(id));

    if (response.status == 200 && response.data != null) {
      return BillOfLiveProductModel.fromMap(response.data as Map<String, dynamic>);
    }

    throw Exception(response.message ?? 'Failed to load bill of live product detail');
  }
}
