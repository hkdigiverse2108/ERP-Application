import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/services/permission_service.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PermissionMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // 1. Allow bypass for public/auth routes
    if (route == Routes.splash ||
        route == Routes.signIn ||
        route == Routes.accessDenied) {
      return null;
    }

    // 2. Check Authentication (redundant if handled elsewhere, but safe)
    final token = StorageService.instance.read<String>(StorageKeys.accessToken);
    if (token == null || token.isEmpty) {
      return const RouteSettings(name: Routes.signIn);
    }

    // 3. Check Permissions
    final permissionService = PermissionService.to;

    // If permissions are still loading (e.g., first app load, splash should handle it)
    // but if we are manually hitting a route, we check current list
    if (permissionService.permittedTabs.isEmpty) {
      // If we have no permissions loaded, something is wrong
      // But we shouldn't block yet, because Splash might still be doing its job.
      // However, if we're past Splash/SignIn, we MUST have permissions.
      return null;
    }

    if (!permissionService.isRoutePermitted(route)) {
      return const RouteSettings(name: Routes.accessDenied);
    }

    return null;
  }
}
