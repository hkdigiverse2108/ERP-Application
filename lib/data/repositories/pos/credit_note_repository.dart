import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/pos/credit_note_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class CreditNoteRepository {
  final _api = ApiService.to;

  Future<PaginationModel<CreditNoteModel>> getAllCreditNote({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? statusFilter,
    String? activeFilter,
  }) async {
    final url = ApiConstants.getAllPosCreditNote(
      page: page,
      limit: limit,
      search: search,
      fromDate: fromDate,
      toDate: toDate,
      statusFilter: statusFilter,
      activeFilter: activeFilter,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      final items = (res.data['posCreditNote_data'] as List)
          .map((e) => CreditNoteModel.fromJson(e))
          .toList();
      return PaginationModel.fromMap(res.data, items);
    } else {
      throw Exception(res.message);
    }
  }

  Future<List<dynamic>> getRedeemDropdown({
    String? typeFilter,
    String? customerFilter,
  }) async {
    final url = ApiConstants.getPosCreditNoteDropdown(
      typeFilter: typeFilter,
      customerFilter: customerFilter,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res.data as List;
    } else {
      return [];
    }
  }

  Future<ResModel> redeemCreditNote(Map<String, dynamic> payload) async {
    final res = await _api.post(
      ApiConstants.redeemPosCreditNote,
      body: payload,
    );
    return res;
  }
}
