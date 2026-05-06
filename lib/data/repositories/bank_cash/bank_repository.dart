import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/bank_cash/bank_model.dart';
import 'package:ai_setu/data/model/bank_cash/bank_transaction_model.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/data/model/pagination_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class BankRepository {
  final ApiService _api = ApiService.to;

  Future<PaginationModel<BankModel>> getAllBanks({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllBank(
        page: page,
        limit: limit,
        search: search,
        activeFilter: activeFilter,
      ),
    );

    if (res.status == 200 && res.data != null) {
      final items = (res.data['bank_data'] as List)
          .map((e) => BankModel.fromMap(e as Map<String, dynamic>))
          .toList();
      return PaginationModel.fromMap(res.data, items);
    }

    throw Exception(res.message ?? 'Failed to fetch bank cash');
  }

  Future<PaginationModel<BankTransactionModel>> getAllBankTransactions({
    int? page,
    int? limit,
    String? fromDate,
    String? toDate,
    String? search,
    String? activeFilter,
  }) async {
    final ResModel res = await _api.get(
      ApiConstants.getAllBankTransaction(
        page: page,
        limit: limit,
        fromDate: fromDate,
        toDate: toDate,
        search: search,
        activeFilter: activeFilter,
      ),
    );

    if (res.status == 200 && res.data != null) {
      final List? dataList =
          res.data['transaction_data'] ??
          res.data['bank_transaction_data'] ??
          res.data['bankTransaction_data'];

      final items = dataList != null
          ? dataList
                .map(
                  (e) =>
                      BankTransactionModel.fromMap(e as Map<String, dynamic>),
                )
                .toList()
          : <BankTransactionModel>[];

      return PaginationModel.fromMap(res.data, items);
    }

    throw Exception(res.message ?? 'Failed to fetch bank transactions');
  }

  Future<BankModel> getBankById(String id) async {
    final ResModel res = await _api.get(ApiConstants.bankById(id));

    if (res.status == 200 && res.data != null) {
      return BankModel.fromMap(res.data as Map<String, dynamic>);
    }

    throw Exception(res.message ?? 'Failed to fetch bank details');
  }

  Future<bool> addBank(Map<String, dynamic> data) async {
    final ResModel res = await _api.post(ApiConstants.addBank, body: data);
    return res.status == 200 || res.status == 201;
  }

  Future<bool> updateBank(Map<String, dynamic> data) async {
    final ResModel res = await _api.put(ApiConstants.editBank, body: data);
    return res.status == 200;
  }

  Future<List<IdNameModel>> getBankDropdown() async {
    final ResModel res = await _api.get(ApiConstants.bankDropdown);

    if (res.status == 200 && res.data != null) {
      return (res.data as List)
          .map((e) => IdNameModel.fromMap(e as Map<String, dynamic>))
          .toList();
    }

    throw Exception(res.message ?? 'Failed to fetch bank dropdown');
  }

  Future<BankTransactionModel> getBankTransactionById(String id) async {
    final ResModel res = await _api.get(ApiConstants.getBankTransactionById(id));

    if (res.status == 200 && res.data != null) {
      return BankTransactionModel.fromMap(res.data as Map<String, dynamic>);
    }

    throw Exception(res.message ?? 'Failed to fetch bank transaction details');
  }

  Future<bool> addBankTransaction(Map<String, dynamic> data) async {
    final ResModel res =
        await _api.post(ApiConstants.addBankTransaction, body: data);
    return res.status == 200 || res.status == 201;
  }

  Future<bool> updateBankTransaction(Map<String, dynamic> data) async {
    final ResModel res =
        await _api.put(ApiConstants.updateBankTransaction, body: data);
    return res.status == 200;
  }

  Future<ResModel> deleteBank(String id) async {
    return await _api.delete(ApiConstants.deleteBank(id));
  }

  Future<ResModel> deleteBankTransaction(String id) async {
    return await _api.delete(ApiConstants.deleteBankTransaction(id));
  }
}
