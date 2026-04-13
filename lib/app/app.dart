import 'package:ai_setu/app/app_bindings.dart';
import 'package:ai_setu/core/services/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/theme/light_theme.dart';
import 'package:ai_setu/core/theme/dark_theme.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/app/app_pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AI Setu',
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      theme: LightTheme.theme,
      darkTheme: DarkTheme.theme,
      themeMode: ThemeService().theme,
      getPages: AppPages.routes,
      initialRoute: AppPages.initial,
      transitionDuration: Duration(milliseconds: 500),
      defaultTransition: Transition.fadeIn,
      routingCallback: (routing) {
        if (routing != null) {
          PermissionService.to.validateActiveTab(routing.current);
        }
      },
      builder: (context, child) {
        return child!;
      },
    );
  }
}
