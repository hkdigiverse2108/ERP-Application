class ApiConstants {
  static const String baseUrl = "http://192.168.1.67:4001";

  // Helper method to build URLs with query parameters
  static String _buildUrl(String path, Map<String, dynamic> params) {
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

  // User aad filter
  static String getAllUser(String typeFilter) =>
      _buildUrl("/user/all", {"typeFilter": typeFilter});
  static const String addUser = "/user/add";
  static String deleteUser(String id) => "/user/$id";
  static String getUserById(String id) => "/user/$id";
  static String userDropdown(String typeFilter) =>
      _buildUrl("user/dropdown", {"typeFilter": typeFilter});
  static String permissionAdmin(String id) => "/user/$id/permission";

  // Role
  static const String getAllRole = "/role/all";
  static const String addRole = "/role/add";
  static String getRoleById(String id) => "/role/$id";
  static const String updateRole = "/role/edit";
  static String deleteRole(String id) => "/role/$id";
  static String roleDropdown(String id) =>
      _buildUrl("role/dropdown", {"companyFilter": id});
  static String rolePermission(String id) => "/role/$id/permission";

  // Dashboard
  static String getWiseCustomer(String typeFilter) => _buildUrl(
    "/dashboard/category-wise-customers",
    {"typeFilter": typeFilter},
  );
  static String topCustomer = "/dashboard/top-customers";
  static String transaction = "/dashboard/all";
  static String customerCount = "/dashboard/category-wise-customers-count";
  static String loginLogAll = "/login-log/all";

  // Product
  static const String addProduct = "/product/add";
  static const String updateProduct = "/product/edit";
  static String deleteProduct(String id) => "/product/$id";
  static String getAllProduct(String page, String limit) =>
      _buildUrl("/product/all", {"page": page, "limit": limit});
  static String getProductById(String id) => "/product/$id";
  static const String productDropdown = "/product/dropdown";

  // Stock
  static String getAllStock(String activeFilter) =>
      _buildUrl("/stock/all", {"activeFilter": activeFilter});
  static const String addStock = "/stock/add";
  static const String updateStock = "/stock/edit";
  static String deleteStock(String id) => "/stock/$id";
  static String getStockById(String id) => "/stock/$id";
  static const String bulkStock = "/stock/bulk-adjustment";

  // Stock Verification
  static const String getAllStockVerification = "/stock-verification/all";
  static const String addStockVerification = "/stock-verification/add";
  static const String updateStockVerification = "/stock-verification/edit";
  static String deleteStockVerification(String id) => "/stock-verification/$id";
  static String getStockVerificationById(String id) =>
      "/stock-verification/$id";

  // Receipt
  static const String getAllReceipt = "/receipt/all";
  static const String addReceipt = "/receipt/add";
  static const String getReceiptById = "/receipt/getById";
  static const String updateReceipt = "/receipt/edit";
  static const String receiptDropdown = "/receipt/dropdown";

  // Payment
  static const String getAllPayment = "/payment/all";
  static const String addPayment = "/payment/add";
  static const String getPaymentById = "/payment/getById";
  static const String updatePayment = "/payment/edit";
  static const String paymentDropdown = "/payment/dropdown";

  // Material Consumption
  static const String getAllMaterialConsumption = "/materialConsumption/all";
  static const String addMaterialConsumption = "/materialConsumption/add";
  static const String getMaterialConsumptionById =
      "/materialConsumption/getById";
  static const String updateMaterialConsumption = "/materialConsumption/edit";
  static const String materialConsumptionDropdown =
      "/materialConsumption/dropdown";

  // Debit
  static const String getAllDebit = "/debit/all";
  static const String addDebit = "/debit/add";
  static const String getDebitById = "/debit/getById";
  static const String updateDebit = "/debit/edit";
  static const String debitDropdown = "/debit/dropdown";

  // Credit
  static const String getAllCredit = "/credit/all";
  static const String addCredit = "/credit/add";
  static const String getCreditById = "/credit/getById";
  static const String updateCredit = "/credit/edit";
  static const String creditDropdown = "/credit/dropdown";

  // Contact
  static const String getAllContact = "/contact/all";
  static const String addContact = "/contact/add";
  static const String getContactById = "/contact/getById";
  static const String updateContact = "/contact/edit";
  static const String contactDropdown = "/contact/dropdown";

  // Purchase Order
  static const String getAllPurchaseOrder = "/purchaseOrder/all";
  static const String addPurchaseOrder = "/purchaseOrder/add";
  static const String getPurchaseOrderById = "/purchaseOrder/getById";
  static const String updatePurchaseOrder = "/purchaseOrder/edit";
  static const String purchaseOrderDropdown = "/purchaseOrder/dropdown";

  // Sales Order
  static const String getAllSalesOrder = "/salesOrder/all";
  static const String addSalesOrder = "/salesOrder/add";
  static const String getSalesOrderById = "/salesOrder/getById";
  static const String updateSalesOrder = "/salesOrder/edit";
  static const String salesOrderDropdown = "/salesOrder/dropdown";

  // Production Order
  static const String getAllProductionOrder = "/productionOrder/all";
  static const String addProductionOrder = "/productionOrder/add";
  static const String getProductionOrderById = "/productionOrder/getById";
  static const String updateProductionOrder = "/productionOrder/edit";
  static const String productionOrderDropdown = "/productionOrder/dropdown";

  // Production
  static const String getAllProduction = "/production/all";
  static const String addProduction = "/production/add";
  static const String getProductionById = "/production/getById";
  static const String updateProduction = "/production/edit";
  static const String productionDropdown = "/production/dropdown";
}
