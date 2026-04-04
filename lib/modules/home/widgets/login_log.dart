import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/dashboard/login_log_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LoginLog extends StatelessWidget {
  LoginLog({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        ThemeService().isDarkMode;
        final items = homeController.loginLogs;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: homeController.selectedDateRange.value,
                onChanged: (range) {
                  homeController.selectedDateRange.value = range;
                  homeController.loginLogsPage.value = 1; // Reset page
                  homeController.financeLoaded.value = false;
                  homeController.loadFinance();
                },
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<LoginLogModel>(
                items: items
                    .skip((homeController.loginLogsPage.value - 1) * 5)
                    .take(5)
                    .toList(),
                columns: [
                  TableColumn(
                    title: 'User',
                    width: 140,
                    cellBuilder: (context, item, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.user,
                          style: TextHelper.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  TableColumn(
                    title: 'Date',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) {
                      final date = DateTime.tryParse(item.createdAt);
                      return Text(
                        date != null ? DateFormat('dd MMM yyyy').format(date) : item.createdAt,
                        style: TextHelper.bodySmall,
                      );
                    },
                  ),
                  TableColumn(
                    title: 'Event',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) =>
                        Text(item.eventType, style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'System',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.systemDetails,
                      style: TextHelper.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'IP Address',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.ip,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                ],
                currentPage: homeController.loginLogsPage.value,
                totalPages: (items.length / 5).ceil(),
                totalItems: items.length,
                pageSize: 5,
                onPageChanged: (page) =>
                    homeController.loginLogsPage.value = page,
              ),
            ],
          ),
        );
      }),
    );
  }
}
