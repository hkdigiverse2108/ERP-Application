import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/bank_cash/payment_dropdown_model.dart';
import 'package:ai_setu/data/model/bank_cash/pos_payment_model.dart';
import 'package:ai_setu/data/model/contact_model/customer_pos_details_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class PaymentRepository {
  final ApiService _api = ApiService.to;

  Future<PaginationModel<PosPaymentModel>> getAllPayments({
    int? page,
    int? limit,
    String? fromDate,
    String? toDate,
    String? search,
    String? activeFilter,
    String? partyFilter,
    String? paymentTypeFilter,
    String? voucherTypeFilter,
    String? branchId,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllPosPayment(
        page: page,
        limit: limit,
        fromDate: fromDate,
        toDate: toDate,
        search: search,
        activeFilter: activeFilter,
        partyFilter: partyFilter,
        paymentTypeFilter: paymentTypeFilter,
        voucherTypeFilter: voucherTypeFilter,
        branchId: branchId,
      ),
    );

    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data['posPayment_data'];
      final items = dataList != null
          ? dataList
                .map((e) => PosPaymentModel.fromMap(e as Map<String, dynamic>))
                .toList()
          : <PosPaymentModel>[];
      return PaginationModel.fromMap(res.data, items);
    }

    throw Exception(res.message ?? 'Failed to fetch payment terms');
  }

  Future<ResModel> addPosPayment(Map<String, dynamic> data) async {
    return await _api.post(ApiConstants.addPosPayment, body: data);
  }

  Future<ResModel> updatePosPayment(Map<String, dynamic> data) async {
    return await _api.put(ApiConstants.updatePosPayment, body: data);
  }

  Future<PosPaymentModel> getPosPaymentById(String id) async {
    final ResModel res = await _api.get(ApiConstants.getPosPaymentById(id));
    if (res.status == 200 && res.data != null) {
      return PosPaymentModel.fromMap(res.data);
    }
    throw Exception(res.message ?? 'Failed to fetch payment details');
  }

  Future<CustomerPosDetailsModel?> getCustomerPosDetails(String partyId) async {
    final ResModel res = await _api.get(ApiConstants.posOrderCustomer(partyId));
    if (res.status == 200 && res.data != null) {
      return CustomerPosDetailsModel.fromMap(res.data as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<PosPaymentOrder>> getDueVouchers(String partyId) async {
    final ResModel res = await _api.get(ApiConstants.posOrderCustomer(partyId));
    if (res.status == 200 && res.data != null) {
      final data = res.data as Map<String, dynamic>;
      if (data.containsKey('dueVouchers') && data['dueVouchers'] is List) {
        final List dataList = data['dueVouchers'];
        return dataList
            .map((e) => PosPaymentOrder.fromMap(e as Map<String, dynamic>))
            .toList();
      }
    }
    return [];
  }

  Future<ResModel> deleteVoucher(String id) async {
    return await _api.delete(ApiConstants.deleteVoucher(id));
  }

  Future<List<PendingPaymentDropdownModel>> getPendingPaymentDropDown({
    String? customerId,
    String? includeId,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.pendingPaymentDropdown(
        customerId: customerId,
        includeId: includeId,
      ),
    );
    if (res.status == 200 && res.data != null) {
      final List dataList = res.data is List
          ? res.data
          : res.data['pendingPayment_data'];
      return dataList
          .map(
            (e) =>
                PendingPaymentDropdownModel.fromMap(e as Map<String, dynamic>),
          )
          .toList();
    }
    throw Exception(res.message ?? 'Failed to fetch pending payment');
  }

  Future<List<PendingCreditDropdownModel>> getPendingCreditDropDown({
    String? customerId,
    String? includeId,
    String? search,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.pendingCreditDropdown(
        customerId: customerId,
        includeId: includeId,
        search: search,
      ),
    );
    if (res.status == 200 && res.data != null) {
      final List dataList = res.data is List
          ? res.data
          : res.data['pendingCredit_data'];
      return dataList
          .map(
            (e) =>
                PendingCreditDropdownModel.fromMap(e as Map<String, dynamic>),
          )
          .toList();
    }
    throw Exception(res.message ?? 'Failed to fetch pending credit');
  }

  Future<List<PendingPaymentDropdownModel>> getSupplierBillDropdown({
    String? supplierId,
    String? includeId,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.supplierBillDropdown(
        supplierId: supplierId,
        includeId: includeId,
      ),
    );
    if (res.status == 200 && res.data != null) {
      final List dataList = res.data is List
          ? res.data
          : res.data['supplierBill_data'];
      return dataList.map((e) {
        final map = e as Map<String, dynamic>;
        final double balance = (map["balanceAmount"] as num? ?? 0).toDouble();
        final double netAmount =
            (map["netAmount"] as num? ?? map["totalAmount"] as num? ?? 0)
                .toDouble();
        final double paid = (map["paidAmount"] as num? ?? (netAmount - balance))
            .toDouble()
            .clamp(0, double.infinity);

        return PendingPaymentDropdownModel(
          id: map["_id"]?.toString() ?? "",
          name: map["name"]?.toString() ?? "",
          docNo: map["supplierBillNo"]?.toString() ?? "",
          docType: "SUPPLIER_BILL",
          paidAmount: paid,
          balanceAmount: balance,
          customerId: supplierId ?? "",
        );
      }).toList();
    }
    throw Exception(res.message ?? 'Failed to fetch supplier bill');
  }
}
