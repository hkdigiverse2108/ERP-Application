import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';

import 'package:ai_setu/data/model/res/res_model.dart';

class AccountingRepository {
  final ApiService _api = ApiService();

  Future<ResModel> getCreditNote({
    int page = 1,
    int limit = 10,
    String? search,
    String? activeFilter,
    String? branchId,
  }) async {
    final String url = ApiConstants.getAllCreditNote(
      page: page,
      limit: limit,
      search: search,
      activeFilter: activeFilter,
      branchId: branchId,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    } else {
      throw Exception(res.message);
    }
  }

  Future<ResModel> getDebitNote({
    int page = 1,
    int limit = 10,
    String? search,
    String? activeFilter,
    String? branchId,
  }) async {
    final String url = ApiConstants.getAllDebitNote(
      page: page,
      limit: limit,
      search: search,
      activeFilter: activeFilter,
      branchId: branchId,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    } else {
      throw Exception(res.message);
    }
  }

  Future<ResModel> addCreditNote(Map<String, dynamic> data) async {
    final ResModel res = await _api.post(
      ApiConstants.addCreditNote,
      body: data,
    );
    return res;
  }

  Future<ResModel> updateCreditNote(Map<String, dynamic> data) async {
    final ResModel res = await _api.put(
      ApiConstants.updateCreditNote,
      body: data,
    );
    return res;
  }

  Future<ResModel> addDebitNote(Map<String, dynamic> data) async {
    final ResModel res = await _api.post(ApiConstants.addDebitNote, body: data);
    return res;
  }

  Future<ResModel> updateDebitNote(Map<String, dynamic> data) async {
    final ResModel res = await _api.put(
      ApiConstants.updateDebitNote,
      body: data,
    );
    return res;
  }

  Future<bool> deleteDebitNote({required String id}) async {
    final ResModel response = await _api.delete(
      ApiConstants.deleteDebitNote(id: id),
    );
    return response.status == 200;
  }

  Future<bool> deleteCreditNote({required String id}) async {
    final ResModel response = await _api.delete(
      ApiConstants.deleteCreditNote(id: id),
    );
    return response.status == 200;
  }
}
