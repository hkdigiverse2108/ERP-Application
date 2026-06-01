import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/additional_charge/additional_charge_model.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class AdditionalChargeRepository {
  final _api = ApiService.to;

  Future<PaginationModel<AdditionalChargeModel>> getAdditionalCharges({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
    String? typeFilter,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllAdditionalCharge(
        page: page,
        limit: limit,
        search: search,
        activeFilter: activeFilter,
        typeFilter: typeFilter,
      ),
    );
    if (res.status == 200) {
      final items = (res.data['additional_charge_data'] as List)
          .map((e) => AdditionalChargeModel.fromJson(e))
          .toList();

      return PaginationModel.fromMap(res.data, items);
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<AdditionalChargeModel> getAdditionalChargeById(String id) async {
    final ResModel res = await _api.get(
      ApiConstants.getAdditionalChargeById(id),
    );
    if (res.status == 200) {
      return AdditionalChargeModel.fromJson(res.data);
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<ResModel> createAdditionalCharge(Map<String, dynamic> data) async {
    final ResModel res = await _api.post(
      ApiConstants.addAdditionalCharge,
      body: data,
    );
    if (res.status == 201) {
      return res;
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<ResModel> updateAdditionalCharge(Map<String, dynamic> data) async {
    final ResModel res = await _api.put(
      ApiConstants.updateAdditionalCharge,
      body: data,
    );
    if (res.status == 200) {
      return res;
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<ResModel> deleteAdditionalCharge(String id) async {
    final ResModel res = await _api.delete(
      ApiConstants.deleteAdditionalCharge(id),
    );
    if (res.status == 200) {
      return res;
    }
    throw Exception(res.message ?? "Something went wrong");
  }

  Future<List<IdNameModel>> getAccountGroupDropdown() async {
    final ResModel res = await _api.get(
      ApiConstants.accountGroupDropdown("", "", null),
    );
    if (res.status == 200) {
      return (res.data as List).map((e) => IdNameModel.fromMap(e)).toList();
    }
    throw Exception(res.message ?? "Something went wrong");
  }
}
