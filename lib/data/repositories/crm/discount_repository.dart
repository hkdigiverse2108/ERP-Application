import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/crm/discount_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class DiscountRepository {
  final _api = ApiService.to;

  Future<PaginationModel<DiscountModel>> getAllDiscount({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? activeFilter,
  }) async {
    final url = ApiConstants.getAllDiscount(
      page: page,
      limit: limit,
      search: search,
      fromDate: fromDate,
      toDate: toDate,
      activeFilter: activeFilter,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      final items = (res.data['discount_data'] as List)
          .map((e) => DiscountModel.fromJson(e))
          .toList();
      return PaginationModel.fromMap(res.data, items);
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<DiscountModel> getDiscountById(String id) async {
    final res = await _api.get(ApiConstants.getDiscountById(id));
    if (res.status == 200 && res.data != null) {
      return DiscountModel.fromJson(res.data);
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<void> addDiscount(Map<String, dynamic> data) async {
    final res = await _api.post(ApiConstants.addDiscount, body: data);
    if (res.status != 200) {
      throw Exception(res.message ?? "Something went wrong");
    }
  }

  Future<void> updateDiscount(Map<String, dynamic> data) async {
    final res = await _api.put(ApiConstants.updateDiscount, body: data);
    if (res.status != 200) {
      throw Exception(res.message ?? "Something went wrong");
    }
  }

  Future<ResModel> deleteDiscount(String id) async {
    return await _api.delete(ApiConstants.deleteDiscount(id));
  }

  Future<ResModel> getDiscountDropdown() async {
    return await _api.get(ApiConstants.discountDropdown);
  }

  Future<ResModel> verifyDiscount(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.discountVerify, body: data);
  }
}
