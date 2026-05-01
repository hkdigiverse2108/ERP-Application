import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/crm/coupon_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class CouponRepository {
  final _api = ApiService.to;

  Future<PaginationModel<CouponModel>> getAllCoupon({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? activeFilter,
    String? branchId,
  }) async {
    final url = ApiConstants.getAllCoupon(
      page: page,
      limit: limit,
      search: search,
      fromDate: fromDate,
      toDate: toDate,
      activeFilter: activeFilter,
      branchId: branchId,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      final items = (res.data['coupon_data'] as List)
          .map((e) => CouponModel.fromJson(e))
          .toList();
      return PaginationModel.fromMap(res.data, items);
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<ResModel> addCoupon(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addCoupon, body: data);
  }

  Future<ResModel> updateCoupon(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updateCoupon, body: data);
  }

  Future<CouponModel> getCouponById(String id) async {
    final ResModel res = await _api.get(ApiConstants.getCouponById(id));
    if (res.status == 200 && res.data != null) {
      return CouponModel.fromJson(res.data);
    }
    throw Exception(res.message ?? "Failed to fetch coupon details");
  }
}
