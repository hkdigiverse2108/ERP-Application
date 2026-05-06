import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final _items = [
    (PhosphorIconsLight.user, 'User Profile', Routes.settingsUserProfile),
    (
      PhosphorIconsLight.buildings,
      'Company Profile',
      Routes.settingsCompanyProfile,
    ),
    (PhosphorIconsLight.percent, 'Taxes', Routes.settingsTaxes),
    (PhosphorIconsLight.usersThree, 'User Roles', Routes.settingsUserRoles),
    (PhosphorIconsLight.hash, 'Prefix', Routes.settingsPrefix),
    (
      PhosphorIconsLight.handshake,
      'Payment Terms',
      Routes.settingsPaymentTerms,
    ),
    (
      PhosphorIconsLight.plusCircle,
      'Additional Charge',
      Routes.settingsAdditionalCharge,
    ),
    (
      PhosphorIconsLight.chartBar,
      'Consumption Type',
      Routes.settingsConsumptionType,
    ),
    (
      PhosphorIconsLight.lockKey,
      'Change Password',
      Routes.settingsChangePassword,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefAppBar(),
      drawer: AppDrawer(),
      body: Column(
        children: [
          QuickAction(),
          Expanded(
            child: ListView.separated(
              itemCount: _items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final (icon, label, route) = _items[i];
                return ListTile(
                  leading: Icon(icon),
                  title: Text(label),
                  trailing: const Icon(PhosphorIconsLight.caretRight),
                  onTap: () => Get.toNamed(route),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
