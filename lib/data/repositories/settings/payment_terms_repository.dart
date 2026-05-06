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
      return PaginationModel.fromMap(response.data, items);
    }
    throw Exception(response.message ?? "Failed to load payment terms");
  }

  Future<ResModel> createPaymentTerm(Map<String, dynamic> data) async {
    final ResModel response = await _api.post(
      ApiConstants.addPaymentTerm,
      body: data,
    );
    if (response.status == 201) {
      return response;
    }
    throw Exception(response.message ?? "Failed to create payment term");
  }

  Future<ResModel> updatePaymentTerm(Map<String, dynamic> data) async {
    final ResModel response = await _api.put(
      ApiConstants.updatePaymentTerm,
      body: data,
    );
    if (response.status == 200) {
      return response;
    }
    throw Exception(response.message ?? "Failed to update payment term");
  }

  Future<PaymentTermsModel> getPaymentTermById(String id) async {
    final ResModel response = await _api.get(
      ApiConstants.getPaymentTermById(id),
    );
    if (response.status == 200) {
      return PaymentTermsModel.fromJson(response.data);
    }
    throw Exception(response.message ?? "Failed to load payment term");
  }

  Future<ResModel> deletePaymentTerm(String id) async {
    final ResModel response = await _api.delete(
      ApiConstants.deletePaymentTerm(id),
    );
    if (response.status == 200) {
      return response;
    }
    throw Exception(response.message ?? "Failed to delete payment term");
  }
}
