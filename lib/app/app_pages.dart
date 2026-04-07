import 'package:ai_setu/modules/accounting/views/cradit_page.dart';
import 'package:ai_setu/modules/accounting/views/dabit_page.dart';
import 'package:ai_setu/modules/auth/bindings/sign_in_bindings.dart';
import 'package:ai_setu/modules/auth/views/sign_in.dart';
import 'package:ai_setu/modules/bank_cash/bindings/bank_cash_binding.dart';
import 'package:ai_setu/modules/bank_cash/views/bank_page.dart';
import 'package:ai_setu/modules/bank_cash/views/bank_transaction_page.dart';
import 'package:ai_setu/modules/bank_cash/views/expense_page.dart';
import 'package:ai_setu/modules/bank_cash/views/payment_page.dart';
import 'package:ai_setu/modules/bank_cash/views/receipt_page.dart';
import 'package:ai_setu/modules/bank_cash/views/salary_page.dart';
import 'package:ai_setu/modules/contact/views/contact_page.dart';
import 'package:ai_setu/modules/home/bindings/home_bindings.dart';
import 'package:ai_setu/modules/home/views/home.dart';
import 'package:ai_setu/modules/inventory/bindings/inventory_binfings.dart';
import 'package:ai_setu/modules/inventory/product/bindings/product_binding.dart';
import 'package:ai_setu/modules/inventory/recipe/bindings/recipe_binding.dart';
import 'package:ai_setu/modules/inventory/stock/bindings/stock_bindings.dart';
import 'package:ai_setu/modules/inventory/stock_verification/bindings/stock_verification_binding.dart';
import 'package:ai_setu/modules/inventory/views/bill_of_live.dart';
import 'package:ai_setu/modules/inventory/views/material_consumption.dart';
import 'package:ai_setu/modules/inventory/product/views/product.dart';
import 'package:ai_setu/modules/inventory/recipe/views/recipe.dart';
import 'package:ai_setu/modules/inventory/stock/views/stock.dart';
import 'package:ai_setu/modules/inventory/stock_verification/views/stock_verification.dart';
import 'package:ai_setu/modules/user/bindings/user_binding.dart';
import 'package:ai_setu/modules/user/views/edit_user.dart';
import 'package:ai_setu/modules/user/views/user.dart';
import 'package:get/get.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/modules/splash/views/splash.dart';
import 'package:ai_setu/modules/splash/bindings/splash_bindings.dart';

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
      binding: InventoryBindings(),
    ),
    GetPage(
      name: Routes.materialConsumption,
      page: () => const MaterialConsumption(),
      binding: InventoryBindings(),
    ),
    GetPage(
      name: Routes.debit,
      page: () => const DebitPage(),
      // binding: InventoryBindings(),
    ),
    GetPage(
      name: Routes.credit,
      page: () => const CraditPage(),
      // binding: InventoryBindings(),
    ),
    GetPage(
      name: Routes.contact,
      page: () => const Contact(),
      // binding: InventoryBindings(),
    ),

    GetPage(name: Routes.user, page: () => User(), binding: UserBinding()),
    GetPage(name: Routes.home, page: () => Home(), binding: HomeBindings()),

    GetPage(
      name: Routes.bank,
      page: () => const BankPage(),
      binding: BankCashBinding(),
    ),
    GetPage(
      name: Routes.bankTransaction,
      page: () => const BankTransactionPage(),
      binding: BankCashBinding(),
    ),
    GetPage(
      name: Routes.posPayment,
      page: () => const PaymentPage(),
      binding: BankCashBinding(),
    ),
    GetPage(
      name: Routes.receipt,
      page: () => const ReceiptPage(),
      binding: BankCashBinding(),
    ),
    GetPage(
      name: Routes.expense,
      page: () => const ExpensePage(),
      binding: BankCashBinding(),
    ),
    GetPage(
      name: Routes.salary,
      page: () => const SalaryPage(),
      binding: BankCashBinding(),
    ),
  ];
}
