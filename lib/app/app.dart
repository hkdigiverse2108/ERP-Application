import 'package:ai_setu/app/app_bindings.dart';
import 'package:ai_setu/core/services/permission_service.dart';
import 'package:ai_setu/core/services/theme_animation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/theme/light_theme.dart';
import 'package:ai_setu/core/theme/dark_theme.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/app/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = ThemeService().isDarkModeObs.value;
      return GetMaterialApp(
        title: 'AI Setu',
        initialBinding: AppBindings(),
        debugShowCheckedModeBanner: false,
        theme: LightTheme.theme,
        darkTheme: DarkTheme.theme,
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        getPages: AppPages.routes,
        initialRoute: AppPages.initial,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FlutterQuillLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US'), Locale('hi', 'IN')],
        transitionDuration: const Duration(milliseconds: 500),
        defaultTransition: Transition.fadeIn,
        routingCallback: (routing) {
          if (routing != null) {
            PermissionService.to.validateActiveTab(routing.current);
          }
        },
        // Wrap the entire app in an explicit RepaintBoundary with a stable key.
        // ThemeAnimationService captures this boundary for its screenshot —
        // it always reflects exactly what is on screen, regardless of active route.
        builder: (context, child) {
          return RepaintBoundary(
            key: ThemeAnimationService.repaintKey,
            child: child!,
          );
        },
      );
    });
  }
}
