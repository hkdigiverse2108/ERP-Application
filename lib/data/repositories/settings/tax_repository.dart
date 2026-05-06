import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/model/tax/tax_model.dart';

class TaxRepository {
  final ApiService _api = ApiService.to;

  Future<PaginationModel<TaxItemModel>> getTaxesForTable({
    int? page,
    int? limit,
    String? search,
    Map<String, dynamic>? filters,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllTax(
        page: page,
        limit: limit,
        search: search,
        activeFilter: filters?['activeFilter'],
      ),
    );

    if (res.status == 200 && res.data != null) {
      final items = (res.data['tax_data'] as List)
          .map((e) => TaxItemModel.fromMap(e as Map<String, dynamic>))
          .toList();
      return PaginationModel.fromMap(res.data, items);
    }

    throw Exception(res.message ?? 'Failed to load taxes');
  }

  Future<List<TaxDropdownModel>> getTaxes() async {
    final ResModel response = await _api.get(ApiConstants.taxDropdown);
    if (response.status == 200) {
      return List<TaxDropdownModel>.from(
        (response.data as List).map((x) => TaxDropdownModel.fromMap(x)),
      );
    }
    throw Exception(response.message ?? "Failed to load taxes");
  }

  Future<ResModel> addTax(Map<String, dynamic> data) async {
    final ResModel response = await _api.post(ApiConstants.addTax, body: data);
    if (response.status == 201) {
      return response;
    }
    throw Exception(response.message ?? "Failed to add tax");
  }

  Future<ResModel> updateTax(Map<String, dynamic> data) async {
    final ResModel response = await _api.put(
      ApiConstants.updateTax,
      body: data,
    );
    if (response.status == 200) {
      return response;
    }
    throw Exception(response.message ?? "Failed to update tax");
  }

  Future<TaxItemModel> getTaxById(String id) async {
    final ResModel response = await _api.get(ApiConstants.getTaxById(id));
    if (response.status == 200) {
      return TaxItemModel.fromMap(response.data);
    }
    throw Exception(response.message ?? "Failed to load tax");
  }

  Future<ResModel> deleteTax(String id) async {
    final ResModel response = await _api.delete(ApiConstants.deleteTax(id));
    if (response.status == 200) {
      return response;
    }
    throw Exception(response.message ?? "Failed to delete tax");
  }
}
