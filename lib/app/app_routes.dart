abstract class Routes {
  static const splash = '/splash';
  static const signIn = '/sign-in';
  static const dashboard = '/dashboard';
  static const editUser = '/edit-user';
  static const user = '/users';

  // inventory
  static const product = '/product';
  static const addUpdateProduct = '/add-update-product';
  static const addItem = '/add-item';
  static const stock = '/stock';
  static const billOfLive = '/bill-of-materials';
  static const stockVerification = '/stock-verification';
  static const recipe = '/recipe';
  static const materialConsumption = '/material-consumption';

  // accounting
  static const debit = '/debit-note'; // Accounting Debit Note
  static const credit = '/credit-note'; // Accounting Credit Note
  static const contact = '/contact';

  // bank
  static const bank = '/bank';
  static const bankTransaction = '/bank-transaction';
  static const posPayment = '/payment';
  static const receipt = '/receipt';
  static const expense = '/expense';
  static const salary = '/salary';

  // sales
  static const estimate = '/estimate';
  static const salesOrder = '/sales-order';
  static const invoice = '/invoice';
  static const deliveryChallan = '/delivery-challan';
  static const salesCreditNote =
      '/sales-credit-note'; // ← FIX: was '/credit-note' (duplicate of Routes.credit)

  // purchase
  static const purchaseOrder = '/purchase-order';
  static const supplierBill = '/supplier-bill';
  static const purchaseReturn = '/purchase-debit-note'; // Purchase Debit Note

  // pos
  static const posSalesRegister = '/sales-register';
  static const posOrderList = '/order-list';
  static const posCreditNote = '/pos-credit-note';

  // CRM
  static const coupon = '/coupon';
  static const discount = '/discount';
  static const loyalty = '/loyalty';

  // Settings
  static const settings = '/setting/general';
  static const settingsUserProfile = '/setting/user-profile';
  static const settingsCompanyProfile = '/setting/company-profile';
  static const settingsTaxes = '/setting/taxes';
  static const settingsUserRoles = '/setting/user-roles';
  static const settingsPrefix = '/setting/prefix';
  static const settingsPaymentTerms = '/setting/payment-terms';
  static const settingsAdditionalCharge = '/setting/additional-charge';
  static const settingsConsumptionType = '/setting/consumption-type';

  static const accessDenied = '/access-denied';
}
