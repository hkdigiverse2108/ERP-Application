class ApiConstants {
  // static const String baseUrl = "http://192.168.29.26:4001";
  static const String baseUrl = "https://api.ai-setu.com";

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
  static const String forgotPassword = "/auth/forgot-password";
  static const String verifyOtp = "/auth/verify-otp";
  static const String resendOtp = "/auth/resend-otp";
  static const String updatePassword = "/auth/update-password";

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

  // User aad filter
  static String getAllUser({
    String? typeFilter,
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) => buildUrl("/user/all", {
    "typeFilter": typeFilter,
    "page": page,
    "limit": limit,
    "search": search,
    "activeFilter": activeFilter,
  });
  static const String addUser = "/user/add";
  static const String updateUser = "/user/edit";
  static String deleteUser(String id) => "/user/$id";
  static String getUserById(String id) => "/user/$id";
  static String userDropdown({String? typeFilter}) =>
      buildUrl("/user/dropdown", {"typeFilter": typeFilter});
  static String permissionAdmin(String id) => "/user/$id/permission";

  // Upload
  static const String getUpload = "/upload/images";
  static const String upload = "/upload";
  static const String uploadPdf = "/upload/pdf";
  static const String deleteUpload = "/upload";

  // Role
  static String getAllRole({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) => buildUrl("/role/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "activeFilter": activeFilter,
  });
  static const String addRole = "/role/add";
  static String getRoleById(String id) => "/role/$id";
  static const String updateRole = "/role/edit";
  static String deleteRole(String id) => "/role/$id";
  static String roleDropdown({String? companyFilter}) =>
      buildUrl("/role/dropdown", {"companyFilter": companyFilter});
  static String rolePermission(String id) => "/role/$id/permission";

  // Account Group
  static String accountGroupDropdown(String natureFilter, String purchase) =>
      buildUrl("account/dropdown", {
        "natureFilter": natureFilter,
        "purchase": purchase,
      });

  // Product
  static const String addProduct = "/product/add";
  static const String updateProduct = "/product/edit";
  static String deleteProduct(String id) => "/product/$id";
  static String getAllProduct({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
    String? categoryFilter,
    String? subCategoryFilter,
    String? brandFilter,
    String? subBrandFilter,
    String? hsnCodeFilter,
    String? purchaseTaxFilter,
    String? salesTaxIdFilter,
    String? productTypeFilter,
    String? productTypeIdFilter,
  }) => buildUrl("/product/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "activeFilter": activeFilter,
    "categoryFilter": categoryFilter,
    "subCategoryFilter": subCategoryFilter,
    "brandFilter": brandFilter,
    "subBrandFilter": subBrandFilter,
    "hsnCodeFilter": hsnCodeFilter,
    "purchaseTaxFilter": purchaseTaxFilter,
    "salesTaxIdFilter": salesTaxIdFilter,
    "productTypeFilter": productTypeFilter,
    "productTypeIdFilter": productTypeIdFilter,
  });
  static String getProductById(String id) => "/product/$id";
  static const String productDropdownNew =
      "/product/dropdown?isNewProduct=true";

  // Product Category
  static const String getAllProductCategory = "/product-category/all";
  static const String addProductCategory = "/product-category/add";
  static const String updateProductCategory = "/product-category/edit";
  static String deleteProductCategory(String id) => "/product-category/$id";
  static String getProductCategoryById(String id) => "/product-category/$id";
  static const String productCategoryDropdown = "/product-category/dropdown";

  // Product Type
  static String getAllProductType(String page, String limit) =>
      buildUrl("/product-type/add", {"page": page, "limit": limit});
  static const String addProductType = "/product-type/add";
  static const String updateProductType = "/product-type/edit";
  static String deleteProductType(String id) => "/product-type/$id";
  static String getProductTypeById(String id) => "/product-type/$id";
  static const String productTypeDropdown = "/product-type/dropdown";

  // Product Request
  static String getAllProductRequest({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
    String? statusFilter,
  }) => buildUrl("/product-request/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "activeFilter": activeFilter,
    "statusFilter": statusFilter,
  });
  static const String addProductRequest = "/product-request/add";
  static const String updateProductRequest = "/product-request/edit";
  static String deleteProductRequest(String id) => "/product-request/$id";
  static String getProductRequestById(String id) => "/product-request/$id";

  // Company
  static const String getAllCompany = "/company/all";
  static const String addCompany = "/company/add";
  static const String updateCompany = "/company/edit";
  static String deleteCompany(String id) => "/company/$id";
  static String getCompanyById(String id) => "/company/$id";
  static const String companyDropdown = "/company/dropdown";

  // Stock
  static String getAllStock({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
    String? categoryFilter,
    String? subCategoryFilter,
    String? brandFilter,
    String? subBrandFilter,
  }) => buildUrl("/stock/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "activeFilter": activeFilter,
    "categoryFilter": categoryFilter,
    "subCategoryFilter": subCategoryFilter,
    "brandFilter": brandFilter,
    "subBrandFilter": subBrandFilter,
  });
  static const String addStock = "/stock/add";
  static const String updateStock = "/stock/edit";
  static String deleteStock(String id) => "/stock/$id";
  static String getStockById(String id) => "/stock/$id";
  static const String bulkStock = "/stock/bulk-adjustment";

  // Bill of Live Product
  static String getAllBillOfLiveProduct({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) => buildUrl("/bill-of-live-product/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "activeFilter": activeFilter,
  });
  static const String addBillOfLiveProduct = "/bill-of-live-product/add";
  static const String updateBillOfLiveProduct = "/bill-of-live-product/edit";
  static String deleteBillOfLiveProduct(String id) =>
      "/bill-of-live-product/$id";
  static String getBillOfLiveProductById(String id) =>
      "/bill-of-live-product/$id";
  static String billOfLiveProductDropdown(String companyFilter, String id) =>
      buildUrl("/bill-of-live-product/dropdown", {
        "companyFilter": companyFilter,
        "id": id,
      });

  // Stock Verification
  static String getAllStockVerification({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
    String? statusFilter,
  }) => buildUrl("/stock-verification/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "activeFilter": activeFilter,
    "statusFilter": statusFilter,
  });
  static const String addStockVerification = "/stock-verification/add";
  static const String updateStockVerification = "/stock-verification/edit";
  static String deleteStockVerification(String id) => "/stock-verification/$id";
  static String getStockVerificationById(String id) =>
      "/stock-verification/$id";

  // Recipe
  static String getAllRecipe({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) => buildUrl("/recipe/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "activeFilter": activeFilter,
  });
  static const String addRecipe = "/recipe/add";
  static String getRecipeById(String id) => "/recipe/$id";
  static const String updateRecipe = "/recipe/edit";
  static String deleteRecipe(String id) => "/recipe/$id";
  static String recipeDropdown(String companyFilter, String id) =>
      buildUrl("/recipe/dropdown", {"companyFilter": companyFilter, "id": id});

  // POS Payment
  static String getAllPosPayment({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? activeFilter,
    String? partyFilter,
    String? paymentTypeFilter,
    String? voucherTypeFilter,
  }) => buildUrl("/pos-payment/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "activeFilter": activeFilter,
    "partyFilter": partyFilter,
    "paymentTypeFilter": paymentTypeFilter,
    "voucherTypeFilter": voucherTypeFilter,
  });

  static const String addPosPayment = "/pos-payment/add";
  static String getPosPaymentById(String id) => "/pos-payment/$id";
  static const String updatePosPayment = "/pos-payment/edit";

  // Voucher
  static const String getAllVoucher = "/voucher/alll";
  static const String addVoucher = "/voucher/add";
  static const String updateVoucher = "/voucher/edit";
  static String deleteVoucher(String id) => "/voucher/$id";
  static const String getAllPaymentVoucher = "/voucher/payment/all";
  static const String addPaymentVoucher = "/voucher/payment/add";
  static const String getAllReceiptVoucher = "/voucher/receipt/all";
  static const String addReceiptVoucher = "/voucher/receipt/add";
  static const String updatePaymentVoucher = "/voucher/payment/edit";
  static const String getExpense = "/voucher/expense/all";
  static const String addExpenseVoucher = "/voucher/expense/add";

  // Payment Term
  static String getAllPaymentTerm({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) => buildUrl("/payment-term/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "activeFilter": activeFilter,
  });
  static const String paymentTermDropdown = "/payment-term/dropdown";
  static String getPaymentTermById(String id) => "/payment-term/$id";
  static const String addPaymentTerm = "/payment-term/add";
  static const String updatePaymentTerm = "/payment-term/edit";
  static String deletePaymentTerm(String id) => "/payment-term/$id";

  // Material
  static const String getAllMaterial = "/material/all";
  static const String addMaterial = "/material/add";
  static String getMaterialById(String id) => "/material/$id";
  static const String updateMaterial = "/material/edit";
  static String deleteMaterial(String id) => "/material/$id";

  // Material Consumption
  static String getAllMaterialConsumption({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
    String? branchFilter,
  }) => buildUrl("/material-consumption/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "activeFilter": activeFilter,
    "branchFilter": branchFilter,
  });
  static const String addMaterialConsumption = "/material-consumption/add";
  static const String getMaterialConsumptionById =
      "/material-consumption/getById";
  static const String updateMaterialConsumption = "/material-consumption/edit";
  static const String materialConsumptionDropdown =
      "/material-consumption/dropdown";

  // Announcement
  static const String getAllAnnouncement = "/announcement/all";
  static const String addAnnouncement = "/announcement/add";
  static String getAnnouncementById(String id) => "/announcement/$id";
  static const String updateAnnouncement = "/announcement/edit";
  static String deleteAnnouncement(String id) => "/announcement/$id";

  // Consumption Type
  static String getAllConsumptionType({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) => buildUrl("/consumption-type/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "activeFilter": activeFilter,
  });
  static const String addConsumptionType = "/consumption-type/add";
  static String getConsumptionTypeById(String id) => "/consumption-type/$id";
  static const String updateConsumptionType = "/consumption-type/edit";
  static String deleteConsumptionType(String id) => "/consumption-type/$id";

  // Bank
  static String getAllBank({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) => buildUrl("/bank/all", {
    "type": "bank",
    "page": page,
    "limit": limit,
    "search": search,
    "activeFilter": activeFilter,
  });

  static const String addBank = "/bank/add";
  static const String editBank = "/bank/edit";
  static String deleteBank(String id) => "/bank/$id";
  static String bankById(String id) => "/bank/$id";
  static const String bankDropdown = "/bank/dropdown";

  // Bank Transaction
  static String getAllBankTransaction({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? activeFilter,
  }) => buildUrl("/bank-transaction/all", {
    "type": "bank",
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "activeFilter": activeFilter,
  });

  static const String addBankTransaction = "/bank-transaction/add";
  static const String updateBankTransaction = "/bank-transaction/edit";
  static String deleteBankTransaction(String id) => "/bank-transaction/$id";
  static String getBankTransactionById(String id) => "/bank-transaction/$id";

  //Debit Note
  static const String getAllDebitNote = "/debit-note/all";
  static const String addDebitNote = "/debit-note/add";
  static const String updateDebitNote = "/debit-note/edit";
  static String deleteDebitNote(String id) => "/debit-note/$id";
  static String getDebitNoteById(String id) => "/debit-note/$id";

  // Sales Debit Note
  static const String getAllSalesDebitNote = "/sales-debit-note/all";
  static const String addSalesDebitNote = "/sales-debit-note/add";
  static const String updateSalesDebitNote = "/sales-debit-note/edit";
  static String deleteSalesDebitNote(String id) => "/sales-debit-note/$id";
  static String getSalesDebitNoteById(String id) => "/sales-debit-note/$id";

  // POS Credit Note
  static String getAllPosCreditNote({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? customerFilter,
    String? statusFilter,
    String? activeFilter,
  }) => buildUrl("/pos-credit-note/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "customerFilter": customerFilter,
    "statusFilter": statusFilter,
    "activeFilter": activeFilter,
  });

  static const String redeemPosCreditNote = "/pos-credit-note/redeem";

  static String deletePosCreditNote(String id) => "/pos-credit-note/$id";
  static String getPosCreditNoteById(String id) => "/pos-credit-note/$id";

  //Credit Note
  static const String getAllCreditNote = "/credit-note/all";
  static const String addCreditNote = "/credit-note/add";
  static const String updateCreditNote = "/credit-note/edit";
  static String deleteCreditNote(String id) => "/credit-note/$id";
  static String getCreditNoteById(String id) => "/credit-note/$id";

  // Sales Credit Note
  static String getAllSalesCreditNote({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? customerFilter,
    String? statusFilter,
    String? activeFilter,
  }) => buildUrl("/sales-credit-note/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "customerFilter": customerFilter,
    "statusFilter": statusFilter,
    "activeFilter": activeFilter,
  });
  static const String addSalesCreditNote = "/sales-credit-note/add";
  static const String updateSalesCreditNote = "/sales-credit-note/edit";
  static String deleteSalesCreditNote(String id) => "/sales-credit-note/$id";
  static String getSalesCreditNoteById(String id) => "/sales-credit-note/$id";

  // POS Order
  static String getAllPosOrder({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? statusFilter,
    String? activeFilter,
  }) => buildUrl("/pos-order/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "startDate": fromDate,
    "endDate": toDate,
    "statusFilter": statusFilter,
    "activeFilter": activeFilter,
  });

  static String posOrderDropdown(String duePaymentFilter) =>
      buildUrl("/pos-order/dropdown", {"duePaymentFilter": duePaymentFilter});
  static String getPosOrderById(String branchId) =>
      "/pos-order/cash-control/$branchId";
  static String updatePosOrder(String id) => "/pos-order/hold/$id";
  static const String addPosOrder = "/pos-order/add";
  static const String quickAddProduct = "/pos-order/quick-add-product";
  static const String editPosOrder = "/pos-order/edit";
  static const String posOrderCashControl = "/pos-order/cash-control";
  static const String posOrderHold = "/pos-order/hold";
  static const String posOrderRelease = "/pos-order/release";
  static const String posOrderConvertToInvoice =
      "/pos-order/convert-to-invoice";
  static const String deletePosOrder = "/pos-order";
  static String posOrderCustomer(String id) => "/pos-order/customer/$id";
  static String posOrderById(String id) => "/pos-order/$id";

  // Supplier Bill
  static String getAllSupplierBill({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? supplierFilter,
    String? paymentStatus,
    String? activeFilter,
  }) => buildUrl("/supplier-bill/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "supplierFilter": supplierFilter,
    "paymentStatus": paymentStatus,
    "activeFilter": activeFilter,
  });
  static const String addSupplierBill = "/supplier-bill/add";
  static String getSupplierBillById(String id) => "/supplier-bill/$id";
  static const String updateSupplierBill = "/supplier-bill/edit";
  static String deleteSupplierBill(String id) => "/supplier-bill/$id";
  static const String supplierBillDropdown = "/supplier-bill/dropdown";

  // Cash Control
  static String getAllCashControl(String registerFilter) =>
      buildUrl("/cash-control/all", {"registerFilter": registerFilter});
  static const String addCashControl = "/cash-control/add";
  static String getCashControlById(String id) => "/cash-control/$id";
  static const String updateCashControl = "/cash-control/edit";
  static String deleteCashControl(String id) => "/cash-control/$id";
  static String cashControlDropdown(String registerFilter) =>
      buildUrl("/cash-control/dropdown", {"registerFilter": registerFilter});

  // POS Cash Register
  static String getAllPosCashRegister({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? salesManFilter,
    String? statusFilter,
    String? activeFilter,
  }) => buildUrl("/pos-cash-register/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "startDate": fromDate,
    "endDate": toDate,
    "salesManFilter": salesManFilter,
    "statusFilter": statusFilter,
    "activeFilter": activeFilter,
  });

  static const String addPosCashRegister = "/pos-cash-register/add";
  static String getPosCashRegisterById(String id) => "/pos-cash-register/$id";
  static const String updatePosCashRegister = "/pos-cash-register/edit";
  static String deletePosCashRegister(String id) => "/pos-cash-register/$id";
  static const String posCashRegisterDropdown = "/pos-cash-register/dropdown";

  // Pay Later
  static const String getAllPayLater = "/pay-later/all";
  static const String addPayLater = "/pay-later/add";
  static String getPayLaterById(String id) => "/pay-later/$id";
  static const String updatePayLater = "/pay-later/edit";
  static String deletePayLater(String id) => "/pay-later/$id";

  // Return POS Order
  static const String getAllReturnPosOrder = "/return-pos-order/all";
  static const String addReturnPosOrder = "/return-pos-order/add";
  static String getReturnPosOrderById(String id) => "/return-pos-order/$id";
  static const String updateReturnPosOrder = "/return-pos-order/edit";
  static String deleteReturnPosOrder(String id) => "/return-pos-order/$id";

  // Call Request
  static const String getAllCallRequest = "/call-request/all";
  static const String getAllCallRequestByBranchId = "/call-request/all";
  static const String addCallRequest = "/call-request/add";
  static String getCallRequestById(String id) => "/call-request/$id";
  static String updateCallRequest(String id) => "/call-request/$id";
  static String deleteCallRequest(String id) => "/call-request/$id";

  // Contacts
  static const String getAllContact = "/contacts/all";
  static const String addContact = "/contacts/add";
  static String getContactById(String id) => "/contacts/$id";
  static const String updateContact = "/contacts/edit";
  static String singleContactById(String id) => "/contacts/single/$id";
  static String deleteContact(String id) => "/contacts/$id";
  static String contactDropdown({String? typeFilter, String? activeFilter}) =>
      buildUrl("/contacts/dropdown", {
        "typeFilter": typeFilter,
        "activeFilter": activeFilter,
      });

  // Purchase Order
  static String getAllPurchaseOrder({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? supplierFilter,
    String? statusFilter,
    String? activeFilter,
  }) => buildUrl("/purchase-order/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "supplierFilter": supplierFilter,
    "statusFilter": statusFilter,
    "activeFilter": activeFilter,
  });
  static const String addPurchaseOrder = "/purchase-order/add";
  static String getPurchaseOrderById(String id) => "/purchase-order/$id";
  static const String updatePurchaseOrder = "/purchase-order/edit";
  static String deletePurchaseOrder(String id) => "/purchase-order/$id";
  static const String purchaseOrderDropdown = "/purchase-order/dropdown";

  // Sales Order
  static String getAllSalesOrder({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? customerFilter,
    String? statusFilter,
    String? activeFilter,
  }) => buildUrl("/sales-order/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "customerFilter": customerFilter,
    "statusFilter": statusFilter,
    "activeFilter": activeFilter,
  });
  static const String addSalesOrder = "/sales-order/add";
  static const String getSalesOrderById = "/sales-order/getById";
  static const String updateSalesOrder = "/sales-order/edit";
  static String deleteSalesOrder(String id) => "/sales-order/$id";
  static const String salesOrderDropdown = "/sales-order/dropdown";

  // Purchase Request
  static const String getAllPurchaseRequest = "/purchase-request/all";
  static const String addPurchaseRequest = "/purchase-request/add";
  static String getPurchaseRequestById(String id) => "/purchase-request/$id";
  static const String updatePurchaseRequest = "/purchase-request/edit";
  static String deletePurchaseRequest(String id) => "/purchase-request/$id";
  static const String purchaseRequestDropdown = "/purchase-request/dropdown";

  // Branch
  static const String getAllBranch = "/branch/all";
  static const String addBranch = "/branch/add";
  static String getBranchById(String id) => "/branch/$id";
  static const String updateBranch = "/branch/edit";
  static String deleteBranch(String id) => "/branch/$id";
  static String branchDropdown({String? companyFilter, String? id}) =>
      buildUrl("/branch/dropdown", {"companyFilter": companyFilter, "id": id});

  // Brand
  static const String getAllBrand = "/brand/all";
  static const String addBrand = "/brand/add";
  static String getBrandById(String id) => "/brand/$id";
  static const String updateBrand = "/brand/edit";
  static String deleteBrand(String id) => "/brand/$id";
  static String brandDropdown({
    String? parentBrandFilter,
    String? typeFilter,
  }) => buildUrl("/brand/dropdown", {
    "parentBrandFilter": parentBrandFilter,
    "typeFilter": typeFilter,
  });
  static const String getAllBrandTree = "brand/tree/all";

  // Category
  static const String getAllCategory = "/category/all";
  static const String addCategory = "/category/add";
  static String getCategoryById(String id) => "/category/$id";
  static const String updateCategory = "/category/edit";
  static String deleteCategory(String id) => "/category/$id";
  static String categoryDropdown({
    String? parentCategoryFilter,
    String? typeFilter,
  }) => buildUrl("/category/dropdown", {
    "parentCategoryFilter": parentCategoryFilter,
    "typeFilter": typeFilter,
  });
  static const String getAllCategoryTree = "category/tree/all";

  // Additional Charge
  static String getAllAdditionalCharge({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) => buildUrl("/additional-charge/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "activeFilter": activeFilter,
  });
  static const String addAdditionalCharge = "/additional-charge/add";
  static String getAdditionalChargeById(String id) => "/additional-charge/$id";
  static const String updateAdditionalCharge = "/additional-charge/edit";
  static String deleteAdditionalCharge(String id) => "/additional-charge/$id";
  static const String additionalChargeDropdown = "/additional-charge/dropdown";

  // Terms and Condition
  static const String getAllTermsAndCondition = "/terms-and-condition/all";
  static const String addTermsAndCondition = "/terms-and-condition/add";
  static String getTermsAndConditionById(String id) =>
      "/terms-and-condition/$id";
  static const String updateTermsAndCondition = "/terms-and-condition/edit";
  static String deleteTermsAndCondition(String id) =>
      "/terms-and-condition/$id";
  static const String termsAndConditionDropdown =
      "/terms-and-condition/dropdown";

  // Purchase Debit Note
  static String getAllPurchaseDebitNote({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? supplierFilter,
    String? statusFilter,
    String? activeFilter,
  }) => buildUrl("/purchase-debit-note/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "supplierFilter": supplierFilter,
    "statusFilter": statusFilter,
    "activeFilter": activeFilter,
  });
  static const String addPurchaseDebitNote = "/purchase-debit-note/add";
  static String getPurchaseDebitNoteById(String id) =>
      "/purchase-debit-note/$id";
  static const String updatePurchaseDebitNote = "/purchase-debit-note/edit";
  static String deletePurchaseDebitNote(String id) =>
      "/purchase-debit-note/$id";
  static const String purchaseDebitNoteDropdown =
      "/purchase-debit-note/dropdown";

  // Estimate
  static String getAllEstimate({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? customerFilter,
    String? statusFilter,
    String? activeFilter,
  }) => buildUrl("/estimate/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "customerFilter": customerFilter,
    "statusFilter": statusFilter,
    "activeFilter": activeFilter,
  });
  static const String addEstimate = "/estimate/add";
  static String getEstimateById(String id) => "/estimate/$id";
  static const String updateEstimate = "/estimate/edit";
  static String deleteEstimate(String id) => "/estimate/$id";
  static const String estimateDropdown = "/estimate/dropdown";

  // Invoice
  static String getAllInvoice({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? customerFilter,
    String? statusFilter,
    String? activeFilter,
  }) => buildUrl("/invoice/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "customerFilter": customerFilter,
    "statusFilter": statusFilter,
    "activeFilter": activeFilter,
  });
  static const String addInvoice = "/invoice/add";
  static String getInvoiceById(String id) => "/invoice/$id";
  static const String updateInvoice = "/invoice/edit";
  static String deleteInvoice(String id) => "/invoice/$id";
  static const String invoiceDropdown = "/invoice/dropdown";

  // Delivery Challan
  static String getAllDeliveryChallan({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? customerFilter,
    String? statusFilter,
    String? activeFilter,
  }) => buildUrl("/delivery-challan/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "customerFilter": customerFilter,
    "statusFilter": statusFilter,
    "activeFilter": activeFilter,
  });
  static const String addDeliveryChallan = "/delivery-challan/add";
  static String getDeliveryChallanById(String id) => "/delivery-challan/$id";
  static const String updateDeliveryChallan = "/delivery-challan/edit";
  static String deleteDeliveryChallan(String id) => "/delivery-challan/$id";

  // Location
  static const String getCountry = "/location/country";
  static String getState({String? id}) =>
      (id == null) ? "/location/state" : "/location/state/$id";
  static String getCity({String? id}) =>
      (id == null) ? "/location/city" : "/location/city/$id";
  static const String addLocation = "/location/add";
  static String getAllLocation(String parentFilter, String typeFilter) =>
      "/location/all?parentFilter=$parentFilter&typeFilter=$typeFilter";
  static String updateLocation(String id) => "/location/edit";
  static String deleteLocation(String id) => "/location/$id";
  static String locationById(String id) => "/location/dropdown?id=$id";

  // UOM
  static String getAllUOM(String page, String limit) =>
      "/uom/all?page=$page&limit=$limit";
  static const String addUOM = "/uom/add";
  static String getUOMById(String id) => "/uom/$id";
  static const String updateUOM = "/uom/edit";
  static String deleteUOM(String id) => "/uom/$id";
  static const String uomDropdown = "/uom/dropdown";

  // Tax
  static String getAllTax({
    int? page,
    int? limit,
    String? search,
    String? activeFilter,
  }) => buildUrl("/tax/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "activeFilter": activeFilter,
  });
  static const String addTax = "/tax/add";
  static String getTaxById(String id) => "/tax/$id";
  static const String updateTax = "/tax/edit";
  static String deleteTax(String id) => "/tax/$id";
  static const String taxDropdown = "/tax/dropdown";

  // Setting
  static const String updateSetting = "/settings/updatet";
  static const String getAllSetting = "/settings/all";

  // Coupon
  static String getAllCoupon({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? activeFilter,
  }) => buildUrl("/coupon/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "activeFilter": activeFilter,
  });
  static const String addCoupon = "/coupon/add";
  static String getCouponById(String id) => "/coupon/$id";
  static const String updateCoupon = "/coupon/edit";
  static String deleteCoupon(String id) => "/coupon/$id";
  static const String removeCoupon = "/coupon/remove";
  static const String couponDropdown = "/coupon/dropdown";

  // Discount
  static String getAllDiscount({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? activeFilter,
  }) => buildUrl("/discount/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "activeFilter": activeFilter,
  });
  static const String addDiscount = "/discount/add";
  static const String updateDiscount = "/discount/edit";
  static String getDiscountById(String id) => "/discount/$id";
  static String deleteDiscount(String id) => "/discount/delete/$id";
  static const String removeDiscount = "/discount/remove";
  static const String discountDropdown = "/discount/dropdown";
  static const String discountVerify = "/discount/verify";
  static const String discountApply = "/discount/apply";

  // Feedback
  static const String getAllFeedback = "/feedback/all";
  static const String addFeedback = "/feedback/add";
  static String getFeedbackById(String id) => "/feedback/$id";
  static const String updateFeedback = "/feedback/edit";
  static String deleteFeedback(String id) => "/feedback/$id";

  // Loyalty
  static String getAllLoyalty({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? activeFilter,
  }) => buildUrl("/loyalty/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "activeFilter": activeFilter,
  });
  static const String loyaltyDropdown = "/loyalty/dropdown";
  static const String loyaltyPointsAll = "loyalty-points/";
  static const String loyaltyRemove = "/loyalty/remove";
  static const String loyaltyRedeem = "/loyalty/redeem";
  static const String loyaltyAdd = "/loyalty/add";
  static const String loyaltyPoints = "/loyalty-points/";
  static const String loyaltyEdit = "/loyalty/edit";
  static String loyaltyDelete(String id) => "/loyalty/delete/$id";
  static String loyaltyPointsById(String id) => "/loyalty-points/$id";

  // Prefix
  static String getAllPrefix({int? page, int? limit, String? search}) =>
      buildUrl("/prefix/all", {"page": page, "limit": limit, "search": search});
  static const String addPrefix = "/prefix/add";
  static String getPrefixById(String id) => "/prefix/$id";
  static String getPrefixByModule(String module) => "/prefix/module/$module";
  static const String updatePrefix = "/prefix/edit";
  static String deletePrefix(String id) => "/prefix/$id";
  static const String prefixDropdown = "/prefix/dropdown";

  // Module
  static const String getAllModule = "/module/all";
  static const String addModule = "/module/add";
  static String getModuleById(String id) => "/module/$id";
  static const String updateModule = "/module/edit";
  static String deleteModule(String id) => "/module/$id";
  static const String moduleBulkEdit = "/module/bulk/edit";
  static String moduleUserPermissions(String moduleId) =>
      "/module/user/permissions/$moduleId";

  // Company Drivers
  static const String getAllCompanyDrivers = "/company-drivers/all";
  static const String addCompanyDrivers = "/company-drivers/add";
  static String getCompanyDriversById(String id) => "/company-drivers/$id";
  static const String updateCompanyDrivers = "/company-drivers/edit";
  static String deleteCompanyDrivers(String id) => "/company-drivers/$id";

  // Journal Voucher
  static const String getAllJournalVoucher = "/journal-voucher/all";
  static const String addJournalVoucher = "/journal-voucher/add";
  static String getJournalVoucherById(String id) => "/journal-voucher/$id";
  static const String updateJournalVoucher = "/journal-voucher/edit";
  static String deleteJournalVoucher(String id) => "/journal-voucher/$id";

  // Expense
  static String getAllExpense({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? typeFilter,
    String? activeFilter,
  }) => buildUrl("/expense/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "typeFilter": typeFilter,
    "activeFilter": activeFilter,
  });

  static const String addExpense = "/expense/add";
  static String getExpenseById(String id) => "/expense/$id";
  static const String updateExpense = "/expense/edit";
  static String deleteExpense(String id) => "/expense/$id";

  // Salary
  static String getAllSalary({
    int? page,
    int? limit,
    String? search,
    String? fromDate,
    String? toDate,
    String? activeFilter,
  }) => buildUrl("/salary/all", {
    "page": page,
    "limit": limit,
    "search": search,
    "fromDate": fromDate,
    "toDate": toDate,
    "activeFilter": activeFilter,
  });

  static const String addSalary = "/salary/add";
  static String getSalaryById(String id) => "/salary/$id";
  static const String updateSalary = "/salary/edit";
  static String deleteSalary(String id) => "/salary/$id";

  // permission
  static String getPermitionById(String id) => "/permission/details?userId=$id";
  static String getPermitionTabs(String id) =>
      "/permission/child/details?userId=$id";
}
