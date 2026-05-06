import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/model/selas/delivery_challan_model.dart';
import 'package:ai_setu/data/model/selas/estimate_model.dart';
import 'package:ai_setu/data/model/selas/invoice_model.dart';
import 'package:ai_setu/data/model/selas/sales_credit_note_model.dart';
import 'package:ai_setu/data/model/selas/sales_order_model.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:intl/intl.dart';

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
                  (e) =>
                      SalesCreditNoteModel.fromMap(e as Map<String, dynamic>),
                )
                .toList()
          : <SalesCreditNoteModel>[];
      return PaginationModel.fromMap(res.data, items);
    }
    throw Exception(res.message ?? 'Failed to fetch credit note');
  }

  Future<ResModel> addEstimate(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addEstimate, body: data);
  }

  Future<ResModel> updateEstimate(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updateEstimate, body: data);
  }

  Future<EstimateModel> getEstimateById(String id) async {
    final ResModel res = await _api.get(ApiConstants.getEstimateById(id));
    if (res.status == 200 && res.data != null) {
      return EstimateModel.fromMap(res.data as Map<String, dynamic>);
    }
    throw Exception(res.message ?? 'Failed to fetch estimate details');
  }

  Future<SalesOrderModel> getSalesOrderById(String id) async {
    final ResModel res = await _api.get(
      "${ApiConstants.getSalesOrderById}/$id",
    );
    if (res.status == 200 && res.data != null) {
      return SalesOrderModel.fromMap(res.data as Map<String, dynamic>);
    }
    throw Exception(res.message ?? 'Failed to fetch sales order details');
  }

  Future<ResModel> addSalesOrder(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addSalesOrder, body: data);
  }

  Future<ResModel> updateSalesOrder(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updateSalesOrder, body: data);
  }

  Future<List<IdNameModel>> getEstimateDropdown({
    String? customerFilter,
    String? statusFilter,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.estimateDropdown(
        customerFilter: customerFilter,
        statusFilter: statusFilter,
      ),
    );
    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data as List?;
      return dataList != null
          ? dataList.map((e) {
              final map = e as Map<String, dynamic>;
              final String id = map["_id"]?.toString() ?? "";
              final String estimateNo = map["estimateNo"]?.toString() ?? "";
              String dateStr = "";
              if (map["date"] != null) {
                try {
                  final date = DateTime.parse(map["date"].toString());
                  dateStr = " (${DateFormat('dd-MM-yyyy').format(date)})";
                } catch (_) {}
              }
              return IdNameModel(id: id, name: "$estimateNo$dateStr");
            }).toList()
          : <IdNameModel>[];
    }
    return [];
  }

  Future<ResModel> addInvoice(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addInvoice, body: data);
  }

  Future<ResModel> updateInvoice(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updateInvoice, body: data);
  }

  Future<InvoiceModel> getInvoiceById(String id) async {
    final ResModel res = await _api.get(ApiConstants.getInvoiceById(id));
    if (res.status == 200 && res.data != null) {
      return InvoiceModel.fromMap(res.data as Map<String, dynamic>);
    }
    throw Exception(res.message ?? 'Failed to fetch invoice details');
  }

  Future<List<IdNameModel>> getInvoiceDropdown({
    String? customerFilter,
    String? statusFilter,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.invoiceDropdown(
        customerFilter: customerFilter,
        statusFilter: statusFilter,
      ),
    );
    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data as List?;
      return dataList != null
          ? dataList.map((e) {
              final map = e as Map<String, dynamic>;
              final String id = map["_id"]?.toString() ?? "";
              final String no = map["invoiceNo"]?.toString() ?? "";
              String dateStr = "";
              if (map["date"] != null) {
                try {
                  final date = DateTime.parse(map["date"].toString());
                  dateStr = " (${DateFormat('dd-MM-yyyy').format(date)})";
                } catch (_) {}
              }
              return IdNameModel(id: id, name: "$no$dateStr");
            }).toList()
          : <IdNameModel>[];
    }
    return [];
  }

  Future<List<IdNameModel>> getSalesOrderDropdown({
    String? customerFilter,
    String? statusFilter,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.salesOrderDropdown(
        customerFilter: customerFilter,
        statusFilter: statusFilter,
      ),
    );
    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data as List?;
      return dataList != null
          ? dataList.map((e) {
              final map = e as Map<String, dynamic>;
              final String id = map["_id"]?.toString() ?? "";
              final String no = map["salesOrderNo"]?.toString() ?? "";
              String dateStr = "";
              if (map["date"] != null) {
                try {
                  final date = DateTime.parse(map["date"].toString());
                  dateStr = " (${DateFormat('dd-MM-yyyy').format(date)})";
                } catch (_) {}
              }
              return IdNameModel(id: id, name: "$no$dateStr");
            }).toList()
          : <IdNameModel>[];
    }
    return [];
  }

  Future<List<IdNameModel>> getDeliveryChallanDropdown({
    String? customerFilter,
    String? statusFilter,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.deliveryChallanDropdown(
        customerFilter: customerFilter,
        statusFilter: statusFilter,
      ),
    );
    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data as List?;
      return dataList != null
          ? dataList.map((e) {
              final map = e as Map<String, dynamic>;
              final String id = map["_id"]?.toString() ?? "";
              final String no = map["deliveryChallanNo"]?.toString() ?? "";
              String dateStr = "";
              if (map["date"] != null) {
                try {
                  final date = DateTime.parse(map["date"].toString());
                  dateStr = " (${DateFormat('dd-MM-yyyy').format(date)})";
                } catch (_) {}
              }
              return IdNameModel(id: id, name: "$no$dateStr");
            }).toList()
          : <IdNameModel>[];
    }
    return [];
  }

  Future<DeliveryChallanModel> getDeliveryChallanById(String id) async {
    final ResModel res = await _api.get(
      ApiConstants.getDeliveryChallanById(id),
    );
    if (res.status == 200 && res.data != null) {
      return DeliveryChallanModel.fromMap(res.data as Map<String, dynamic>);
    }
    throw Exception(res.message ?? 'Failed to fetch delivery challan details');
  }

  Future<ResModel> addDeliveryChallan(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addDeliveryChallan, body: data);
  }

  Future<ResModel> updateDeliveryChallan(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updateDeliveryChallan, body: data);
  }

  Future<ResModel> addSalesCreditNote(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addSalesCreditNote, body: data);
  }

  Future<ResModel> updateSalesCreditNote(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updateSalesCreditNote, body: data);
  }

  Future<SalesCreditNoteModel> getSalesCreditNoteById(String id) async {
    final ResModel res = await _api.get(
      ApiConstants.getSalesCreditNoteById(id),
    );
    if (res.status == 200 && res.data != null) {
      return SalesCreditNoteModel.fromMap(res.data as Map<String, dynamic>);
    }
    throw Exception(res.message ?? 'Failed to fetch sales credit note details');
  }

  Future<ResModel> deleteEstimate(String id) async {
    return await _api.delete(ApiConstants.deleteEstimate(id));
  }

  Future<ResModel> deleteSalesOrder(String id) async {
    return await _api.delete(ApiConstants.deleteSalesOrder(id));
  }

  Future<ResModel> deleteInvoice(String id) async {
    return await _api.delete(ApiConstants.deleteInvoice(id));
  }

  Future<ResModel> deleteDeliveryChallan(String id) async {
    return await _api.delete(ApiConstants.deleteDeliveryChallan(id));
  }

  Future<ResModel> deleteSalesCreditNote(String id) async {
    return await _api.delete(ApiConstants.deleteSalesCreditNote(id));
  }
}
