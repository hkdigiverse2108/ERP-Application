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
  final estimateList = <EstimateDatum>[].obs;
  final isLoadingEstimate = false.obs;
  final estimateCurrentPage = 1.obs;
  final estimateTotalPages = 1.obs;
  final estimateTotalItems = 0.obs;

  // Sales Orders
  final salesOrderList = <SalesOrderDatum>[].obs;
  final isLoadingSalesOrder = false.obs;
  final salesOrderCurrentPage = 1.obs;
  final salesOrderTotalPages = 1.obs;
  final salesOrderTotalItems = 0.obs;

  // Invoices
  final invoiceList = <InvoiceDatum>[].obs;
  final isLoadingInvoice = false.obs;
  final invoiceCurrentPage = 1.obs;
  final invoiceTotalPages = 1.obs;
  final invoiceTotalItems = 0.obs;

  // Delivery Challans
  final deliveryChallanList = <DeliveryChallanDatum>[].obs;
  final isLoadingDeliveryChallan = false.obs;
  final deliveryChallanCurrentPage = 1.obs;
  final deliveryChallanTotalPages = 1.obs;
  final deliveryChallanTotalItems = 0.obs;

  // Credit Notes
  final creditNoteList = <SalesCreditNoteDatum>[].obs;
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
    fetchEstimates();
    fetchSalesOrders();
    fetchInvoices();
    fetchDeliveryChallans();
    fetchCreditNotes();
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
        final model = EstimateModel.fromJson(res.data);
        estimateList.value = model.estimateData;
        estimateCurrentPage.value = page;
        estimateTotalPages.value = model.state.totalPages;
        estimateTotalItems.value = model.totalData;
        
        currentPage.value = page;
        totalPages.value = model.state.totalPages;
        totalItems.value = model.totalData;
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
        final model = SalesOrderModel.fromJson(res.data);
        salesOrderList.value = model.salesOrderData;
        salesOrderCurrentPage.value = page;
        salesOrderTotalPages.value = model.state.totalPages;
        salesOrderTotalItems.value = model.totalData;

        currentPage.value = page;
        totalPages.value = model.state.totalPages;
        totalItems.value = model.totalData;
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
        final model = InvoiceModel.fromJson(res.data);
        invoiceList.value = model.invoiceData;
        invoiceCurrentPage.value = page;
        invoiceTotalPages.value = model.state.totalPages;
        invoiceTotalItems.value = model.totalData;

        currentPage.value = page;
        totalPages.value = model.state.totalPages;
        totalItems.value = model.totalData;
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
        final model = DeliveryChallanModel.fromJson(res.data);
        deliveryChallanList.value = model.deliveryChallanData;
        deliveryChallanCurrentPage.value = page;
        deliveryChallanTotalPages.value = model.state.totalPages;
        deliveryChallanTotalItems.value = model.totalData;

        currentPage.value = page;
        totalPages.value = model.state.totalPages;
        totalItems.value = model.totalData;
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
        final model = SalesCreditNoteModel.fromJson(res.data);
        creditNoteList.value = model.salesCreditNoteData;
        creditNoteCurrentPage.value = page;
        creditNoteTotalPages.value = model.state.totalPages;
        creditNoteTotalItems.value = model.totalData;

        currentPage.value = page;
        totalPages.value = model.state.totalPages;
        totalItems.value = model.totalData;
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
