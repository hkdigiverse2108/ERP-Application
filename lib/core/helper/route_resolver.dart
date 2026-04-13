import 'package:ai_setu/app/app_pages.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/data/model/permission_model.dart';

/// Resolves API tabs to the correct internal GetX route.
///
/// WHY THIS EXISTS:
/// The backend can send the same `tabUrl` for multiple tabs:
///   - Accounting "credit note"  → tabUrl: /credit-note
///   - Sales "sales credit note" → tabUrl: /credit-note  (collision!)
/// `tabName` alone also collides:
///   - POS      "credit note"    → tabUrl: /pos-credit-note
///   - Accounting "credit note"  → tabUrl: /credit-note
///
/// The stable, environment-independent key is: "parentTabName/tabName"
/// This is always the same across dev/staging/prod because it is semantic,
/// not a database ID. MongoDB _id values differ per environment/database.
///
/// HOW TO ADD A NEW COLLISION:
///   1. Note the tab's tabName and its parent's tabName from the API.
///   2. Add a unique route constant in app_routes.dart.
///   3. Register a GetPage for it in app_pages.dart.
///   4. Add the entry below using the format: 'parentTabName/tabName'.
///
/// HOW TO ADD A NEW PAGE (no collision):
///   1. Add route constant in app_routes.dart.
///   2. Register a GetPage in app_pages.dart.
///   → Automatically appears in the drawer. No entry needed here.
class RouteResolver {
  RouteResolver._();

  /// Key format: 'parentTabName/tabName'  (both lowercased, trimmed)
  /// Value: the GetX route string to navigate to.
  /// Only tabs that COLLIDE on tabUrl need an entry here.
  /// All other tabs fall through to their tabUrl directly.
  static const Map<String, String> _compositeKeyToRoute = {
    'accounting/credit note': Routes.credit,
    'sales/sales credit note': Routes.salesCreditNote,

    'accounting/debit note': Routes.debit,
    'purchase/purchase debit note': Routes.purchaseReturn,

    'pos/credit note': Routes.posCreditNote,
  };

  /// Builds the composite key for a tab: "parentTabName/tabName"
  /// Root-level tabs (no parent) use just their tabName: "/tabName"
  static String _keyOf(PermissionModel tab) {
    final parent = tab.parentName.trim().toLowerCase();
    final name = tab.tabName.trim().toLowerCase();
    return parent.isEmpty ? name : '$parent/$name';
  }

  /// The set of all route names currently registered in AppPages.
  /// Built once and cached.
  /// A tab is shown in the drawer ONLY if its resolved route is in this set.
  static final Set<String> _registeredRoutes = {
    for (final page in AppPages.routes) page.name,
  };

  /// Returns the correct GetX route to navigate to for this tab.
  /// Resolution order:
  ///   1. If "parentTabName/tabName" is in the map → use mapped route (handles collisions).
  ///   2. Otherwise → fall back to tab.tabUrl (works for all non-colliding tabs).
  static String resolve(PermissionModel tab) {
    return _compositeKeyToRoute[_keyOf(tab)] ?? tab.tabUrl;
  }

  /// Returns true only if this tab has a page actually registered in AppPages.
  /// Hides two categories from the drawer:
  ///   1. Tabs the backend sends that we haven't built yet
  ///   2. Parent/group-only nodes with empty tabUrl and no map entry
  static bool isNavigable(PermissionModel tab) {
    final resolvedRoute = resolve(tab);
    if (resolvedRoute.isEmpty) return false;
    return _registeredRoutes.contains(resolvedRoute);
  }
}
