import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/bank_cash/bank_model.dart';
import 'package:ai_setu/data/model/bank_cash/bank_transaction_model.dart';
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
          .map((e) => BankModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginationModel.fromJson(res.data, items);
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

      final items =
          dataList != null
              ? dataList
                  .map(
                    (e) =>
                        BankTransactionModel.fromJson(e as Map<String, dynamic>),
                  )
                  .toList()
              : <BankTransactionModel>[];
              
      return PaginationModel.fromJson(res.data, items);
    }

    throw Exception(res.message ?? 'Failed to fetch bank transactions');
  }
}
