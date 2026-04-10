import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/bank_cash/pos_payment_model.dart';
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
      ),
    );

    if (res.status == 200 && res.data != null) {
      final List? dataList = res.data['posPayment_data'];
      final items = dataList != null
          ? dataList
                .map((e) => PosPaymentModel.fromJson(e as Map<String, dynamic>))
                .toList()
          : <PosPaymentModel>[];
      return PaginationModel.fromJson(res.data, items);
    }

    throw Exception(res.message ?? 'Failed to fetch payment terms');
  }
}
