import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/accounting/cradit_note_model.dart';
import 'package:ai_setu/data/model/accounting/debit_note_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class AccountingRepository {
  final ApiService _api = ApiService();

  Future<DebitNoteModel> getDebitNote() async {
    final ResModel res = await _api.post(
      ApiConstants.getAllDebitNote,
      body: {},
    );
    if (res.status == 200 && res.data != null) {
      return DebitNoteModel.fromJson(res.data);
    } else {
      throw Exception(res.message);
    }
  }

  Future<CreditNoteModel> getCreditNote() async {
    final ResModel res = await _api.post(
      ApiConstants.getAllCreditNote,
      body: {},
    );
    if (res.status == 200 && res.data != null) {
      return CreditNoteModel.fromJson(res.data);
    } else {
      throw Exception(res.message);
    }
  }
}
