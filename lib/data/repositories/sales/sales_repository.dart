import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/model/selas/delivery_challan_model.dart';
import 'package:ai_setu/data/model/selas/estimate_model.dart';
import 'package:ai_setu/data/model/selas/invoice_model.dart';
import 'package:ai_setu/data/model/selas/sales_credit_note_model.dart';
import 'package:ai_setu/data/model/selas/sales_order_model.dart';

class SalesRepository {
  final ApiService _api = ApiService.to;

  Future<PaginationModel<EstimateModel>> getEstimate({
    int page = 1,
    int limit = 10,
    String? fromDate,
    String? toDate,
    String? search,
    String? activeFilter,
    String? customerFilter,
    String? statusFilter,
    String? branchId,
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
      branchId: branchId,
    );
    final ResModel res = await _api.get(url);
    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data["estimate_data"];
      final items = dataList != null
          ? dataList
                .map((e) => EstimateModel.fromMap(e as Map<String, dynamic>))
                .toList()
          : <EstimateModel>[];
      return PaginationModel.fromMap(res.data, items);
    }
    throw Exception(res.message ?? 'Failed to fetch estimate');
  }

  Future<PaginationModel<SalesOrderModel>> getSalesOrder({
    int page = 1,
    int limit = 10,
    String? fromDate,
    String? toDate,
    String? search,
    String? activeFilter,
    String? customerFilter,
    String? statusFilter,
    String? branchId,
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
      branchId: branchId,
    );
    final ResModel res = await _api.get(url);
    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data["salesOrder_data"];
      final items = dataList != null
          ? dataList
                .map((e) => SalesOrderModel.fromMap(e as Map<String, dynamic>))
                .toList()
          : <SalesOrderModel>[];
      return PaginationModel.fromMap(res.data, items);
    }
    throw Exception(res.message ?? 'Failed to fetch sales order');
  }

  Future<PaginationModel<InvoiceModel>> getInvoice({
    int page = 1,
    int limit = 10,
    String? fromDate,
    String? toDate,
    String? search,
    String? activeFilter,
    String? customerFilter,
    String? statusFilter,
    String? branchId,
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
      branchId: branchId,
    );
    final ResModel res = await _api.get(url);
    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data["invoice_data"];
      final items = dataList != null
          ? dataList
                .map((e) => InvoiceModel.fromMap(e as Map<String, dynamic>))
                .toList()
          : <InvoiceModel>[];
      return PaginationModel.fromMap(res.data, items);
    }
    throw Exception(res.message ?? 'Failed to fetch invoice');
  }

  Future<PaginationModel<DeliveryChallanModel>> getDeliveryChallan({
    int page = 1,
    int limit = 10,
    String? fromDate,
    String? toDate,
    String? search,
    String? activeFilter,
    String? customerFilter,
    String? statusFilter,
    String? branchId,
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
      branchId: branchId,
    );
    final ResModel res = await _api.get(url);
    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data["deliveryChallan_data"];
      final items = dataList != null
          ? dataList
                .map(
                  (e) =>
                      DeliveryChallanModel.fromMap(e as Map<String, dynamic>),
                )
                .toList()
          : <DeliveryChallanModel>[];
      return PaginationModel.fromMap(res.data, items);
    }
    throw Exception(res.message ?? 'Failed to fetch delivery challan');
  }

  Future<PaginationModel<SalesCreditNoteModel>> getCreditNote({
    int page = 1,
    int limit = 10,
    String? fromDate,
    String? toDate,
    String? search,
    String? activeFilter,
    String? customerFilter,
    String? statusFilter,
    String? branchId,
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
      branchId: branchId,
    );
    final ResModel res = await _api.get(url);
    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data["salesCreditNote_data"];
      final items = dataList != null
          ? dataList
                .map(
                  (e) => SalesCreditNoteModel.fromMap(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList()
          : <SalesCreditNoteModel>[];
      return PaginationModel.fromMap(res.data, items);
    }
    throw Exception(res.message ?? 'Failed to fetch credit note');
  }
}
