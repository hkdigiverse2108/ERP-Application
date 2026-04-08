import 'package:ai_setu/data/model/res/res_model.dart';
import 'package:ai_setu/data/model/selas/delivery_challan_model.dart';
import 'package:ai_setu/data/model/selas/estimate_model.dart';
import 'package:ai_setu/data/model/selas/Invoice_model.dart';
import 'package:ai_setu/data/model/selas/sales_credit_note_model.dart';
import 'package:ai_setu/data/model/selas/sales_order_model.dart';
import 'package:ai_setu/data/repositories/selas_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesController extends GetxController {
  final SalesRepository _repository = SalesRepository();

  final selectedDateRange = Rxn<DateTimeRange>();
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalItems = 0.obs;

  final isLoading = false.obs;

  // Estimates
  final estimateList = <EstimateModel>[].obs;
  final isLoadingEstimate = false.obs;
  final estimateCurrentPage = 1.obs;
  final estimateTotalPages = 1.obs;
  final estimateTotalItems = 0.obs;

  // Sales Orders
  final salesOrderList = <SalesOrderModel>[].obs;
  final isLoadingSalesOrder = false.obs;
  final salesOrderCurrentPage = 1.obs;
  final salesOrderTotalPages = 1.obs;
  final salesOrderTotalItems = 0.obs;

  // Invoices
  final invoiceList = <InvoiceModel>[].obs;
  final isLoadingInvoice = false.obs;
  final invoiceCurrentPage = 1.obs;
  final invoiceTotalPages = 1.obs;
  final invoiceTotalItems = 0.obs;

  // Delivery Challans
  final deliveryChallanList = <DeliveryChallanModel>[].obs;
  final isLoadingDeliveryChallan = false.obs;
  final deliveryChallanCurrentPage = 1.obs;
  final deliveryChallanTotalPages = 1.obs;
  final deliveryChallanTotalItems = 0.obs;

  // Credit Notes
  final creditNoteList = <SalesCreditNoteModel>[].obs;
  final isLoadingCreditNote = false.obs;
  final creditNoteCurrentPage = 1.obs;
  final creditNoteTotalPages = 1.obs;
  final creditNoteTotalItems = 0.obs;

  // Date Filtering
  final estimateFromDate = Rxn<String>();
  final estimateToDate = Rxn<String>();

  final salesOrderFromDate = Rxn<String>();
  final salesOrderToDate = Rxn<String>();

  final invoiceFromDate = Rxn<String>();
  final invoiceToDate = Rxn<String>();

  final deliveryChallanFromDate = Rxn<String>();
  final deliveryChallanToDate = Rxn<String>();

  final creditNoteFromDate = Rxn<String>();
  final creditNoteToDate = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
  }

  // Estimates
  Future<void> fetchEstimates({int page = 1}) async {
    isLoadingEstimate.value = true;
    isLoading.value = true;
    try {
      final ResModel res = await _repository.getEstimate(
        page: page,
        fromDate: estimateFromDate.value,
        toDate: estimateToDate.value,
      );
      if (res.status == 200 && res.data != null) {
        final List? dataList = res.data["estimate_data"];
        if (dataList != null) {
          estimateList.value = dataList
              .map((e) => EstimateModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        
        estimateCurrentPage.value = page;
        estimateTotalPages.value = res.data["state"]?["totalPages"] ?? 1;
        estimateTotalItems.value = res.data["totalData"] ?? 0;

        currentPage.value = page;
        totalPages.value = estimateTotalPages.value;
        totalItems.value = estimateTotalItems.value;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingEstimate.value = false;
      isLoading.value = false;
    }
  }

  // Sales Orders
  Future<void> fetchSalesOrders({int page = 1}) async {
    isLoadingSalesOrder.value = true;
    isLoading.value = true;
    try {
      final ResModel res = await _repository.getSalesOrder(
        page: page,
        fromDate: salesOrderFromDate.value,
        toDate: salesOrderToDate.value,
      );
      if (res.status == 200 && res.data != null) {
        final List? dataList = res.data["salesOrder_data"];
        if (dataList != null) {
          salesOrderList.value = dataList
              .map((e) => SalesOrderModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }

        salesOrderCurrentPage.value = page;
        salesOrderTotalPages.value = res.data["state"]?["totalPages"] ?? 1;
        salesOrderTotalItems.value = res.data["totalData"] ?? 0;

        currentPage.value = page;
        totalPages.value = salesOrderTotalPages.value;
        totalItems.value = salesOrderTotalItems.value;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingSalesOrder.value = false;
      isLoading.value = false;
    }
  }

  // Invoices
  Future<void> fetchInvoices({int page = 1}) async {
    isLoadingInvoice.value = true;
    isLoading.value = true;
    try {
      final ResModel res = await _repository.getInvoice(
        page: page,
        fromDate: invoiceFromDate.value,
        toDate: invoiceToDate.value,
      );
      if (res.status == 200 && res.data != null) {
        final List? dataList = res.data["invoice_data"];
        if (dataList != null) {
          invoiceList.value = dataList
              .map((e) => InvoiceModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }

        invoiceCurrentPage.value = page;
        invoiceTotalPages.value = res.data["state"]?["totalPages"] ?? 1;
        invoiceTotalItems.value = res.data["totalData"] ?? 0;

        currentPage.value = page;
        totalPages.value = invoiceTotalPages.value;
        totalItems.value = invoiceTotalItems.value;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingInvoice.value = false;
      isLoading.value = false;
    }
  }

  // Delivery Challans
  Future<void> fetchDeliveryChallans({int page = 1}) async {
    isLoadingDeliveryChallan.value = true;
    isLoading.value = true;
    try {
      final ResModel res = await _repository.getDeliveryChallan(
        page: page,
        fromDate: deliveryChallanFromDate.value,
        toDate: deliveryChallanToDate.value,
      );
      if (res.status == 200 && res.data != null) {
        final List? dataList = res.data["deliveryChallan_data"];
        if (dataList != null) {
          deliveryChallanList.value = dataList
              .map((e) => DeliveryChallanModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }

        deliveryChallanCurrentPage.value = page;
        deliveryChallanTotalPages.value = res.data["state"]?["totalPages"] ?? 1;
        deliveryChallanTotalItems.value = res.data["totalData"] ?? 0;

        currentPage.value = page;
        totalPages.value = deliveryChallanTotalPages.value;
        totalItems.value = deliveryChallanTotalItems.value;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingDeliveryChallan.value = false;
      isLoading.value = false;
    }
  }

  // Credit Notes
  Future<void> fetchCreditNotes({int page = 1}) async {
    isLoadingCreditNote.value = true;
    isLoading.value = true;
    try {
      final ResModel res = await _repository.getCreditNote(
        page: page,
        fromDate: creditNoteFromDate.value,
        toDate: creditNoteToDate.value,
      );
      if (res.status == 200 && res.data != null) {
        final List? dataList = res.data["salesCreditNote_data"];
        if (dataList != null) {
          creditNoteList.value = dataList
              .map((e) => SalesCreditNoteModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }

        creditNoteCurrentPage.value = page;
        creditNoteTotalPages.value = res.data["state"]?["totalPages"] ?? 1;
        creditNoteTotalItems.value = res.data["totalData"] ?? 0;

        currentPage.value = page;
        totalPages.value = creditNoteTotalPages.value;
        totalItems.value = creditNoteTotalItems.value;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingCreditNote.value = false;
      isLoading.value = false;
    }
  }

  // Date Update Handlers
  void updateEstimateDate(String? from, String? to) {
    estimateFromDate.value = from;
    estimateToDate.value = to;
    fetchEstimates(page: 1);
  }

  void updateSalesOrderDate(String? from, String? to) {
    salesOrderFromDate.value = from;
    salesOrderToDate.value = to;
    fetchSalesOrders(page: 1);
  }

  void updateInvoiceDate(String? from, String? to) {
    invoiceFromDate.value = from;
    invoiceToDate.value = to;
    fetchInvoices(page: 1);
  }

  void updateDeliveryChallanDate(String? from, String? to) {
    deliveryChallanFromDate.value = from;
    deliveryChallanToDate.value = to;
    fetchDeliveryChallans(page: 1);
  }

  void updateCreditNoteDate(String? from, String? to) {
    creditNoteFromDate.value = from;
    creditNoteToDate.value = to;
    fetchCreditNotes(page: 1);
  }
}
