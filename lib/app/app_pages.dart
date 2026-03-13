import 'package:ai_setu/modules/auth/bindings/sign_in_bindings.dart';
import 'package:ai_setu/modules/auth/views/sign_in.dart';
import 'package:ai_setu/modules/home/bindings/home_bindings.dart';
import 'package:ai_setu/modules/home/views/home.dart';
import 'package:ai_setu/modules/user/bindings/user_binding.dart';
import 'package:ai_setu/modules/user/views/user.dart';
import 'package:get/get.dart';
import 'package:ai_setu/app/app_routes.dart';

class AppPages {
  static const initial = Routes.user;

  static final routes = [
    GetPage(
      name: Routes.user,
      page: () => const User(),
      binding: UserBinding(),
    ),
    GetPage(
      name: Routes.signIn,
      page: () => SignIn(),
      binding: SignInBindings(),
    ),
    GetPage(name: Routes.home, page: () => Home(), binding: HomeBindings()),
  ];
}
