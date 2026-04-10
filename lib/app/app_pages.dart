import 'package:ai_setu/modules/contact/bindings/contact_binding.dart';
import 'package:ai_setu/modules/accounting/credit/bindings/credit_binding.dart';
import 'package:ai_setu/modules/accounting/credit/views/credit.dart';
import 'package:ai_setu/modules/accounting/debit/bindings/debit_binding.dart';
import 'package:ai_setu/modules/accounting/debit/views/debit.dart';
import 'package:ai_setu/modules/auth/bindings/sign_in_bindings.dart';
import 'package:ai_setu/modules/auth/views/sign_in.dart';
import 'package:ai_setu/modules/bank_cash/bank/bindings/bank_binding.dart';
import 'package:ai_setu/modules/bank_cash/bank/views/bank.dart';
import 'package:ai_setu/modules/bank_cash/bank_transaction/bindings/bank_transaction_binding.dart';
import 'package:ai_setu/modules/bank_cash/bank_transaction/views/bank_transaction.dart';
import 'package:ai_setu/modules/bank_cash/expense/bindings/expense_binding.dart';
import 'package:ai_setu/modules/bank_cash/expense/views/expense.dart';
import 'package:ai_setu/modules/bank_cash/payment/bindings/payment_binding.dart';
import 'package:ai_setu/modules/bank_cash/payment/views/payment.dart';
import 'package:ai_setu/modules/bank_cash/salary/bindings/salary_binding.dart';
import 'package:ai_setu/modules/bank_cash/salary/views/salary.dart';
import 'package:ai_setu/modules/bank_cash/receipt/bindings/receipt_binding.dart';
import 'package:ai_setu/modules/bank_cash/receipt/views/receipt.dart';
import 'package:ai_setu/modules/sales/estimate/bindings/estimate_binding.dart';

import 'package:ai_setu/modules/contact/views/contact_page.dart';
import 'package:ai_setu/modules/home/bindings/home_bindings.dart';
import 'package:ai_setu/modules/home/views/home.dart';
import 'package:ai_setu/modules/crm/coupon/bindings/coupon_binding.dart';
import 'package:ai_setu/modules/crm/coupon/views/coupon.dart';
import 'package:ai_setu/modules/crm/discount/bindings/discount_binding.dart';
import 'package:ai_setu/modules/crm/discount/views/discount.dart';
import 'package:ai_setu/modules/crm/loyalty/bindings/loyalty_binding.dart';
import 'package:ai_setu/modules/crm/loyalty/views/loyalty.dart';
import 'package:ai_setu/modules/inventory/product/bindings/product_binding.dart';
import 'package:ai_setu/modules/inventory/recipe/bindings/recipe_binding.dart';
import 'package:ai_setu/modules/inventory/recipe/views/recipe.dart';
import 'package:ai_setu/modules/inventory/stock/bindings/stock_bindings.dart';
import 'package:ai_setu/modules/inventory/stock_verification/bindings/stock_verification_binding.dart';
import 'package:ai_setu/modules/inventory/bill_of_live_product/bindings/bill_of_live_product_binding.dart';
import 'package:ai_setu/modules/inventory/bill_of_live_product/views/bill_of_live_product.dart';
import 'package:ai_setu/modules/inventory/material_consumption/bindings/material_consumption_binding.dart';
import 'package:ai_setu/modules/inventory/material_consumption/views/material_consumption.dart';
import 'package:ai_setu/modules/inventory/product/views/product.dart';
import 'package:ai_setu/modules/inventory/stock/views/stock.dart';
import 'package:ai_setu/modules/inventory/stock_verification/views/stock_verification.dart';
import 'package:ai_setu/modules/pos/credit_note/bindings/credit_note_binding.dart';
import 'package:ai_setu/modules/pos/credit_note/views/credit_note.dart';
import 'package:ai_setu/modules/pos/order_list/bindings/order_list_binding.dart';
import 'package:ai_setu/modules/pos/order_list/views/order_list.dart';
import 'package:ai_setu/modules/pos/sales_register/bindings/sales_register_binding.dart';
import 'package:ai_setu/modules/pos/sales_register/views/sales_register.dart';

import 'package:ai_setu/modules/sales/delivery_challan/bindings/delivery_challan_binding.dart';
import 'package:ai_setu/modules/sales/delivery_challan/views/delivery_challan.dart';
import 'package:ai_setu/modules/sales/estimate/views/estimate.dart';
import 'package:ai_setu/modules/sales/invoice/bindings/invoice_binding.dart';
import 'package:ai_setu/modules/sales/invoice/views/invoice.dart';
import 'package:ai_setu/modules/sales/sales_credit_note/bindings/sales_credit_note_binding.dart';
import 'package:ai_setu/modules/sales/sales_credit_note/views/sales_credit_note.dart';
import 'package:ai_setu/modules/sales/sales_order/bindings/sales_order_binding.dart';
import 'package:ai_setu/modules/sales/sales_order/views/sales_order.dart';
import 'package:ai_setu/modules/user/bindings/user_binding.dart';
import 'package:ai_setu/modules/user/views/edit_user.dart';
import 'package:ai_setu/modules/user/views/user.dart';
import 'package:get/get.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/modules/splash/views/splash.dart';
import 'package:ai_setu/modules/splash/bindings/splash_bindings.dart';
import 'package:ai_setu/modules/purchase/purchase_debit_note/bindings/purchase_debit_note_binding.dart';
import 'package:ai_setu/modules/purchase/purchase_debit_note/views/purchase_debit_note.dart';
import 'package:ai_setu/modules/purchase/purchase_order/bindings/purchase_order_binding.dart';
import 'package:ai_setu/modules/purchase/purchase_order/views/purchase_order.dart';
import 'package:ai_setu/modules/purchase/supplier_bill/bindings/supplier_bill_binding.dart';
import 'package:ai_setu/modules/purchase/supplier_bill/views/supplier_bill.dart';

class AppPages {
  // static const initial = Routes.user;
  static const initial = Routes.splash;
  // static const initial = Routes.inventory;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const Splash(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: Routes.editUser,
      page: () => EditUser(),
      binding: UserBinding(),
    ),
    GetPage(
      name: Routes.signIn,
      page: () => SignIn(),
      binding: SignInBindings(),
    ),
    GetPage(
      name: Routes.product,
      page: () => Product(),
      binding: ProductBinding(),
    ),
    GetPage(name: Routes.stock, page: () => Stock(), binding: StockBindings()),
    GetPage(
      name: Routes.stockVarification,
      page: () => const StockVerification(),
      binding: StockVerificationBinding(),
    ),
    GetPage(
      name: Routes.recipt,
      page: () => const Recipe(),
      binding: RecipeBinding(),
    ),
    GetPage(
      name: Routes.billOfLive,
      page: () => const BillOfLive(),
      binding: BillOfLiveProductBinding(),
    ),
    GetPage(
      name: Routes.materialConsumption,
      page: () => const MaterialConsumption(),
      binding: MaterialConsumptionBinding(),
    ),
    GetPage(
      name: Routes.debit,
      page: () => const DebitPage(),
      binding: DebitBinding(),
    ),
    GetPage(
      name: Routes.credit,
      page: () => const CreditPage(),
      binding: CreditBinding(),
    ),
    GetPage(
      name: Routes.contact,
      page: () => const Contact(),
      binding: ContactBinding(),
    ),

    GetPage(name: Routes.user, page: () => User(), binding: UserBinding()),
    GetPage(name: Routes.home, page: () => Home(), binding: HomeBindings()),

    // bank
    GetPage(
      name: Routes.bank,
      page: () => const BankPage(),
      binding: BankBinding(),
    ),
    GetPage(
      name: Routes.bankTransaction,
      page: () => const BankTransactionPage(),
      binding: BankTransactionBinding(),
    ),
    GetPage(
      name: Routes.posPayment,
      page: () => const PaymentPage(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: Routes.receipt,
      page: () => const ReceiptPage(),
      binding: ReceiptBinding(),
    ),
    GetPage(
      name: Routes.expense,
      page: () => const ExpensePage(),
      binding: ExpenseBinding(),
    ),
    GetPage(
      name: Routes.salary,
      page: () => const SalaryPage(),
      binding: SalaryBinding(),
    ),
    // sales
    GetPage(
      name: Routes.estimate,
      page: () => const EstimatePage(),
      binding: EstimateBinding(),
    ),
    GetPage(
      name: Routes.salesCreditNote,
      page: () => const SalesCreditNotePage(),
      binding: SalesCreditNoteBinding(),
    ),
    GetPage(
      name: Routes.salesOrder,
      page: () => const SalesOrderPage(),
      binding: SalesOrderBinding(),
    ),
    GetPage(
      name: Routes.invoice,
      page: () => const InvoicePage(),
      binding: InvoiceBinding(),
    ),
    GetPage(
      name: Routes.deliveryChallan,
      page: () => const DeliveryChallanPage(),
      binding: DeliveryChallanBinding(),
    ),
    GetPage(
      name: Routes.purchaseOrder,
      page: () => const PurchaseOrderPage(),
      binding: PurchaseOrderBinding(),
    ),
    GetPage(
      name: Routes.supplierBill,
      page: () => const SupplierBillPage(),
      binding: SupplierBillBinding(),
    ),
    GetPage(
      name: Routes.purchaseReturn,
      page: () => const PurchaseDebitNotePage(),
      binding: PurchaseDebitNoteBinding(),
    ),
    // pos
    GetPage(
      name: Routes.posSalesRegister,
      page: () => const SalesRegisterPage(),
      binding: SalesRegisterBinding(),
    ),
    GetPage(
      name: Routes.posOrderList,
      page: () => const OrderListPage(),
      binding: OrderListBinding(),
    ),
    GetPage(
      name: Routes.posCreditNote,
      page: () => const CreditNotePage(),
      binding: CreditNoteBinding(),
    ),
    // crm
    GetPage(
      name: Routes.coupon,
      page: () => const CouponPage(),
      binding: CouponBinding(),
    ),
    GetPage(
      name: Routes.discount,
      page: () => const DiscountPage(),
      binding: DiscountBinding(),
    ),
    GetPage(
      name: Routes.loyalty,
      page: () => const LoyaltyPage(),
      binding: LoyaltyBinding(),
    ),
  ];
}
