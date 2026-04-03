import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/user_model.dart';
import 'package:ai_setu/modules/user/controllers/user_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class UserTable extends StatelessWidget {
  UserTable({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        ThemeService().isDarkMode;
        return BorderContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RangedDatePicker(
                initialDateRange: userController.selectedDateRange.value,
                onChanged: (range) =>
                    userController.selectedDateRange.value = range,
              ),
              Gap(Sizes.defHorizontalSpace),
              CommonTable<UserModel>(
                items: [],
                columns: [
                  TableColumn(
                    title: 'User Name',
                    width: 140,
                    cellBuilder: (context, item, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.fullName ?? '',
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
                    title: 'Full Name',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) =>
                        Text(item.fullName ?? '', style: TextHelper.bodySmall),
                  ),
                  TableColumn(
                    title: 'Designation',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.designation ?? '',
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Email',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.email ?? '',
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Phone No',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.phoneNo.phoneNo.toString(),
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'PAN No',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.panNumber ?? '',
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Wages',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.wages.toString(),
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Extra Wages',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.extraWages.toString(),
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Commission',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Text(
                      item.commission.toString(),
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Action',
                    width: 100,
                    alignment: TextAlign.right,
                    cellBuilder: (context, item, index) => Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.toNamed(Routes.editUser);
                          },
                          icon: const Icon(PhosphorIconsLight.pencil),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(PhosphorIconsLight.trash),
                        ),
                      ],
                    ),
                  ),
                ],
                currentPage: userController.currentPage.value,
                totalPages: 5,
                totalItems: 43,
                onPageChanged: (page) =>
                    userController.currentPage.value = page,
              ),
            ],
          ),
        );
      }),
    );
  }
}
