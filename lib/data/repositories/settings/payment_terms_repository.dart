import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/payment_terms/payment_terms_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class PaymentTermsRepository {
  final _api = ApiService.to;

  Future<PaginationModel<PaymentTermsModel>> getPaymentTerms({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) async {
    final ResModel response = await _api.get(
      ApiConstants.getAllPaymentTerm(
        page: page,
        limit: limit,
        search: search,
        activeFilter: activeFilter,
      ),
    );
    if (response.status == 200) {
      final items = (response.data['paymentTerm_data'] as List)
          .map((e) => PaymentTermsModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginationModel.fromJson(response.data, items);
    }
    throw Exception(response.message ?? "Failed to load payment terms");
  }
}
