import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';

import 'package:ai_setu/data/model/res/res_model.dart';

class AccountingRepository {
  final ApiService _api = ApiService();

  Future<ResModel> getCreditNote() async {
    final String url = ApiConstants.buildUrl(ApiConstants.getAllCreditNote, {
      "page": 1,
      "limit": 10,
    });

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    } else {
      throw Exception(res.message);
    }
  }

  Future<ResModel> getDebitNote() async {
    final String url = ApiConstants.buildUrl(ApiConstants.getAllDebitNote, {
      "page": 1,
      "limit": 10,
    });

    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    } else {
      throw Exception(res.message);
    }
  }
}
