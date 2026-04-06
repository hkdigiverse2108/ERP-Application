import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class SalesRepository {
  final ApiService _api = ApiService.to;

  Future<ResModel> getEstimate({
    int page = 1,
    int limit = 10,
    String? fromDate,
    String? toDate,
  }) async {
    final Map<String, dynamic> query = {"page": page, "limit": limit};
    if (fromDate != null) query["fromDate"] = fromDate;
    if (toDate != null) query["toDate"] = toDate;

    final String url = ApiConstants.buildUrl(ApiConstants.getAllEstimate, query);
    final ResModel res = await _api.get(url);
    if (res.status == 200 && res.data != null) return res;
    throw Exception(res.message ?? 'Failed to fetch estimate');
  }

  Future<ResModel> getSalesOrder({
    int page = 1,
    int limit = 10,
    String? fromDate,
    String? toDate,
  }) async {
    final Map<String, dynamic> query = {"page": page, "limit": limit};
    if (fromDate != null) query["fromDate"] = fromDate;
    if (toDate != null) query["toDate"] = toDate;

    final String url = ApiConstants.buildUrl(
      ApiConstants.getAllSalesOrder,
      query,
    );
    final ResModel res = await _api.get(url);
    if (res.status == 200 && res.data != null) return res;
    throw Exception(res.message ?? 'Failed to fetch sales order');
  }

  Future<ResModel> getInvoice({
    int page = 1,
    int limit = 10,
    String? fromDate,
    String? toDate,
  }) async {
    final Map<String, dynamic> query = {"page": page, "limit": limit};
    if (fromDate != null) query["fromDate"] = fromDate;
    if (toDate != null) query["toDate"] = toDate;

    final String url = ApiConstants.buildUrl(ApiConstants.getAllInvoice, query);
    final ResModel res = await _api.get(url);
    if (res.status == 200 && res.data != null) return res;
    throw Exception(res.message ?? 'Failed to fetch invoice');
  }

  Future<ResModel> getDeliveryChallan({
    int page = 1,
    int limit = 10,
    String? fromDate,
    String? toDate,
  }) async {
    final Map<String, dynamic> query = {"page": page, "limit": limit};
    if (fromDate != null) query["fromDate"] = fromDate;
    if (toDate != null) query["toDate"] = toDate;

    final String url = ApiConstants.buildUrl(
      ApiConstants.getAllDeliveryChallan,
      query,
    );
    final ResModel res = await _api.get(url);
    if (res.status == 200 && res.data != null) return res;
    throw Exception(res.message ?? 'Failed to fetch delivery challan');
  }

  Future<ResModel> getCreditNote({
    int page = 1,
    int limit = 10,
    String? fromDate,
    String? toDate,
  }) async {
    final Map<String, dynamic> query = {"page": page, "limit": limit};
    if (fromDate != null) query["fromDate"] = fromDate;
    if (toDate != null) query["toDate"] = toDate;

    final String url = ApiConstants.buildUrl(
      ApiConstants.getAllSalesCreditNote,
      query,
    );
    final ResModel res = await _api.get(url);
    if (res.status == 200 && res.data != null) return res;
    throw Exception(res.message ?? 'Failed to fetch credit note');
  }
}
