import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/login_log_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class LoginLog extends StatelessWidget {
  LoginLog({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        ThemeService().isDarkMode;
        return BorderContainer(
          child: Column(
            children: [
              RangedDatePicker(
                initialDateRange: homeController.selectedDateRange.value,
                onChanged: (range) =>
                    homeController.selectedDateRange.value = range,
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<LoginLogModel>(
                items: [
                  LoginLogModel(
                    userName: 'Electronics',
                    date: '2022-01-01',
                    time: '10:00 AM',
                    device: 'Mobile',
                    ipAddress: '[IP_ADDRESS]',
                  ),
                  LoginLogModel(
                    userName: 'Clothing',
                    date: '2022-01-01',
                    time: '10:00 AM',
                    device: 'Mobile',
                    ipAddress: '[IP_ADDRESS]',
                  ),
                ],
                columns: [
                  TableColumn(
                    title: 'User Name',
                    width: 140,
                    cellBuilder: (context, item, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.userName ?? '',
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
                    cellBuilder: (context, item, index) =>
                        Text(item.date ?? '', style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'Time',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) =>
                        Text(item.time ?? '', style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'Device',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.device ?? '',
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'IP Address',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.ipAddress ?? '',
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                currentPage: homeController.currentPage.value,
                totalPages: 5,
                totalItems: 43,
                onPageChanged: (page) =>
                    homeController.currentPage.value = page,
              ),
            ],
          ),
        );
      }),
    );
  }
}
