import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class BankCashRepository {
  final ApiService _api = ApiService.to;

  Future<ResModel> getBankCash() async {
    final String url = ApiConstants.buildUrl(ApiConstants.getAllBank, {
      "type": "bank",
      "page": 1,
      "limit": 10,
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    }

    throw Exception(res.message ?? 'Failed to fetch bank cash');
  }

  Future<ResModel> getBankCashTransaction({
    int page = 1,
    int limit = 10,
    String? fromDate,
    String? toDate,
  }) async {
    final Map<String, dynamic> query = {
      "type": "bank",
      "page": page,
      "limit": limit,
    };
    if (fromDate != null) query["fromDate"] = fromDate;
    if (toDate != null) query["toDate"] = toDate;

    final String url = ApiConstants.buildUrl(
      ApiConstants.getAllBankTransaction,
      query,
    );
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    }

    throw Exception(res.message ?? 'Failed to fetch bank transactions');
  }

  Future<ResModel> getPaymentTerms({
    int page = 1,
    int limit = 10,
    String? fromDate,
    String? toDate,
  }) async {
    final Map<String, dynamic> query = {
      "type": "bank",
      "page": page,
      "limit": limit,
    };
    if (fromDate != null) query["fromDate"] = fromDate;
    if (toDate != null) query["toDate"] = toDate;

    final String url = ApiConstants.buildUrl(
      ApiConstants.getAllPosPayment,
      query,
    );
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return res;
    }

    throw Exception(res.message ?? 'Failed to fetch bank transactions');
  }
}
