class ApiConstants {
  static const String baseUrl = "http://192.168.29.26:4001";

  // Helper method to build URLs with query parameters
  static String buildUrl(String path, Map<String, dynamic> params) {
    final List<String> queryParts = [];
    params.forEach((key, value) {
      if (value != null && value.toString().isNotEmpty) {
        queryParts.add('$key=${Uri.encodeComponent(value.toString())}');
      }
    });

    if (queryParts.isEmpty) return path;
    return '$path?${queryParts.join('&')}';
  }

  // Auth
  static const String login = "/auth/login";

  // Dashboard
  static const String transactions = "/dashboard/transactions";
  static const String topCustomers = "/dashboard/top-customers";
  static const String categoryWiseCustomers =
      "/dashboard/category-wise-customers";
  static const String categoryWiseCustomersCount =
      "/dashboard/category-wise-customers-count";
  static const String bestSellingProducts = "/dashboard/best-selling-products";
  static const String leastSellingProducts =
      "/dashboard/least-selling-products";
  static const String topExpenses = "/dashboard/top-expenses";
  static const String topCoupons = "/dashboard/top-coupons";
  static const String receivable = "/dashboard/receivable";
  static const String payable = "/dashboard/payable";
  static const String salesAndPurchaseGraph =
      "/dashboard/sales-and-purchase-graph";
  static const String transactionGraph = "/dashboard/transaction-graph";
  static const String categorySales = "/dashboard/category-sales";
  static const String loginLog = "/login-log/all";
}
