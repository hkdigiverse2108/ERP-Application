import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/pos/pos_credit_note_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class PosCreditNoteRepository {
  final _api = ApiService.to;

  Future<PaginationModel<PosCreditNoteModel>> getAllPosCreditNotes({
    int? page,
    int? limit,
    String? search,
    String? startDate,
    String? endDate,
    String? statusFilter,
    String? activeFilter,
  }) async {
    final url = ApiConstants.getAllPosCreditNote(
      page: page,
      limit: limit,
      search: search,
      fromDate: startDate,
      toDate: endDate,
      statusFilter: statusFilter,
      activeFilter: activeFilter,
    );

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      final items = (res.data['posCreditNote_data'] as List)
          .map((e) => PosCreditNoteModel.fromJson(e))
          .toList();
      return PaginationModel.fromMap(res.data, items);
    } else {
      throw Exception(res.message);
    }
  }
}
