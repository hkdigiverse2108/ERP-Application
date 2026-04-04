import 'package:ai_setu/core/constants/api_constants.dart';
import 'package:ai_setu/core/services/api_servicess.dart';
import 'package:ai_setu/data/model/dashboard/category_sales_model.dart';
import 'package:ai_setu/data/model/dashboard/category_wise_customers_count_model.dart';
import 'package:ai_setu/data/model/dashboard/category_wise_customers_model.dart';
import 'package:ai_setu/data/model/dashboard/payable_model.dart';
import 'package:ai_setu/data/model/dashboard/receivable_model.dart';
import 'package:ai_setu/data/model/dashboard/sales_and_purchase_graph_model.dart';
import 'package:ai_setu/data/model/dashboard/sellings_model.dart';
import 'package:ai_setu/data/model/dashboard/top_coupons_model.dart';
import 'package:ai_setu/data/model/dashboard/top_customer_model.dart';
import 'package:ai_setu/data/model/dashboard/top_expenses_model.dart';
import 'package:ai_setu/data/model/dashboard/transaction_graph_model.dart';
import 'package:ai_setu/data/model/dashboard/login_log_model.dart';
import 'package:ai_setu/data/model/dashboard/transactions_model.dart';
import 'package:ai_setu/data/model/res/res_model.dart';

class DashboardRepository {
  final ApiService _api = ApiService.to;

  Future<TransactionsModel> getTransactions({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final String url = ApiConstants.buildUrl(ApiConstants.transactions, {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return TransactionsModel.fromJson(res.data);
    }

    throw Exception(res.message ?? 'Failed to fetch transactions');
  }

  Future<List<TopCustomerModel>> getTopCustomers({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final String url = ApiConstants.buildUrl(ApiConstants.topCustomers, {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return (res.data as List)
          .map((e) => TopCustomerModel.fromJson(e))
          .toList();
    }

    throw Exception(res.message ?? 'Failed to fetch top customers');
  }

  Future<List<SellingsModel>> getBestSellingProducts({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final String url = ApiConstants.buildUrl(ApiConstants.bestSellingProducts, {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return (res.data as List).map((e) => SellingsModel.fromJson(e)).toList();
    }

    throw Exception(res.message ?? 'Failed to fetch best selling products');
  }

  Future<List<SellingsModel>> getLeastSellingProducts({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final String url = ApiConstants.buildUrl(ApiConstants.leastSellingProducts, {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return (res.data as List).map((e) => SellingsModel.fromJson(e)).toList();
    }

    throw Exception(res.message ?? 'Failed to fetch least selling products');
  }

  Future<List<CategoryWiseCustomersModel>> getCategoryWiseCustomers({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final String url = ApiConstants.buildUrl(ApiConstants.categoryWiseCustomers, {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return (res.data as List)
          .map((e) => CategoryWiseCustomersModel.fromJson(e))
          .toList();
    }

    throw Exception(res.message ?? 'Failed to fetch category wise customers');
  }

  Future<List<CategoryWiseCustomersCountModel>> getCategoryWiseCustomersCount({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final String url =
        ApiConstants.buildUrl(ApiConstants.categoryWiseCustomersCount, {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return (res.data as List)
          .map((e) => CategoryWiseCustomersCountModel.fromJson(e))
          .toList();
    }

    throw Exception(
      res.message ?? 'Failed to fetch category wise customers count',
    );
  }

  Future<List<TransactionGraphModel>> getTransactionGraph({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final String url = ApiConstants.buildUrl(ApiConstants.transactionGraph, {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return (res.data as List)
          .map((e) => TransactionGraphModel.fromJson(e))
          .toList();
    }

    throw Exception(res.message ?? 'Failed to fetch transaction graph');
  }

  Future<List<SalesAndPurchaseGraphModel>> getSalesAndPurchaseGraph({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final String url = ApiConstants.buildUrl(ApiConstants.salesAndPurchaseGraph, {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return (res.data as List)
          .map((e) => SalesAndPurchaseGraphModel.fromJson(e))
          .toList();
    }

    throw Exception(res.message ?? 'Failed to fetch sales and purchase graph');
  }

  Future<List<CategorySalesModel>> getCategorySales({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final String url = ApiConstants.buildUrl(ApiConstants.categorySales, {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return (res.data as List)
          .map((e) => CategorySalesModel.fromJson(e))
          .toList();
    }

    throw Exception(res.message ?? 'Failed to fetch category sales');
  }

  Future<List<TopExpensesModel>> getTopExpenses({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final String url = ApiConstants.buildUrl(ApiConstants.topExpenses, {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return (res.data as List)
          .map((e) => TopExpensesModel.fromJson(e))
          .toList();
    }

    throw Exception(res.message ?? 'Failed to fetch top expenses');
  }

  Future<List<TopCouponsModel>> getTopCoupons({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final String url = ApiConstants.buildUrl(ApiConstants.topCoupons, {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return (res.data as List)
          .map((e) => TopCouponsModel.fromJson(e))
          .toList();
    }

    throw Exception(res.message ?? 'Failed to fetch top coupons');
  }

  Future<List<ReceivableModel>> getReceivables({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final String url = ApiConstants.buildUrl(ApiConstants.receivable, {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return (res.data as List)
          .map((e) => ReceivableModel.fromJson(e))
          .toList();
    }

    throw Exception(res.message ?? 'Failed to fetch receivables');
  }

  Future<List<PayableModel>> getPayables({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final String url = ApiConstants.buildUrl(ApiConstants.payable, {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return (res.data as List).map((e) => PayableModel.fromJson(e)).toList();
    }

    throw Exception(res.message ?? 'Failed to fetch payables');
  }

  Future<List<LoginLogModel>> getLoginLogs({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final String url = ApiConstants.buildUrl(ApiConstants.loginLog, {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    });
    final ResModel res = await _api.get(url);

    if (res.status == 200 && res.data != null) {
      return (res.data as List).map((e) => LoginLogModel.fromJson(e)).toList();
    }

    throw Exception(res.message ?? 'Failed to fetch login logs');
  }
}
