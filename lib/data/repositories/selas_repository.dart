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
    String? search,
    String? activeFilter,
    String? customerFilter,
    String? statusFilter,
  }) async {
    final String url = ApiConstants.getAllEstimate(
      page: page,
      limit: limit,
      fromDate: fromDate,
      toDate: toDate,
      search: search,
      activeFilter: activeFilter,
      customerFilter: customerFilter,
      statusFilter: statusFilter,
    );
    final ResModel res = await _api.get(url);
    if (res.status == 200 && res.data != null) return res;
    throw Exception(res.message ?? 'Failed to fetch estimate');
  }

  Future<ResModel> getSalesOrder({
    int page = 1,
    int limit = 10,
    String? fromDate,
    String? toDate,
    String? search,
    String? activeFilter,
    String? customerFilter,
    String? statusFilter,
  }) async {
    final String url = ApiConstants.getAllSalesOrder(
      page: page,
      limit: limit,
      fromDate: fromDate,
      toDate: toDate,
      search: search,
      activeFilter: activeFilter,
      customerFilter: customerFilter,
      statusFilter: statusFilter,
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
    String? search,
    String? activeFilter,
    String? customerFilter,
    String? statusFilter,
  }) async {
    final String url = ApiConstants.getAllInvoice(
      page: page,
      limit: limit,
      fromDate: fromDate,
      toDate: toDate,
      search: search,
      activeFilter: activeFilter,
      customerFilter: customerFilter,
      statusFilter: statusFilter,
    );
    final ResModel res = await _api.get(url);
    if (res.status == 200 && res.data != null) return res;
    throw Exception(res.message ?? 'Failed to fetch invoice');
  }

  Future<ResModel> getDeliveryChallan({
    int page = 1,
    int limit = 10,
    String? fromDate,
    String? toDate,
    String? search,
    String? activeFilter,
    String? customerFilter,
    String? statusFilter,
  }) async {
    final String url = ApiConstants.getAllDeliveryChallan(
      page: page,
      limit: limit,
      fromDate: fromDate,
      toDate: toDate,
      search: search,
      activeFilter: activeFilter,
      customerFilter: customerFilter,
      statusFilter: statusFilter,
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
    String? search,
    String? activeFilter,
    String? customerFilter,
    String? statusFilter,
  }) async {
    final String url = ApiConstants.getAllSalesCreditNote(
      page: page,
      limit: limit,
      fromDate: fromDate,
      toDate: toDate,
      search: search,
      activeFilter: activeFilter,
      customerFilter: customerFilter,
      statusFilter: statusFilter,
    );
    final ResModel res = await _api.get(url);
    if (res.status == 200 && res.data != null) return res;
    throw Exception(res.message ?? 'Failed to fetch credit note');
  }
}
