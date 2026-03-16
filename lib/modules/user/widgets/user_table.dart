import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/data/model/user_model.dart';
import 'package:ai_setu/modules/user/controllers/user_controller.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
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
    return Scaffold(
      appBar: DefAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            QuickAction(),

            _buildSectionTitle("User"),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(Sizes.paddingM),
                child: Obx(() {
                  ThemeService().isDarkMode;
                  return BorderContainer(
                    child: Column(
                      children: [
                        RangedDatePicker(
                          initialDateRange:
                              userController.selectedDateRange.value,
                          onChanged: (range) =>
                              userController.selectedDateRange.value = range,
                        ),
                        Gap(Sizes.defHorizontalSpace),
                        CommonTable<UserModel>(
                          items: [
                            UserModel(
                              userName: 'Aman',
                              fullName: 'Aman',
                              designation: 'Manager',
                              email: 'aman@gmail.com',
                              phoneNo: '1234567890',
                              panNo: '1234567890',
                              wages: '1000',
                              extraWages: '100',
                              commission: '10',
                              action: 'Edit',
                            ),
                            UserModel(
                              userName: 'Bharat',
                              fullName: 'Bharat',
                              designation: 'Manager',
                              email: 'bharat@gmail.com',
                              phoneNo: '1234567890',
                              panNo: '1234567890',
                              wages: '1000',
                              extraWages: '100',
                              commission: '10',
                              action: 'Edit',
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
                              title: 'Full Name',
                              width: 100,
                              alignment: TextAlign.center,
                              cellBuilder: (context, item, index) => Text(
                                item.fullName ?? '',
                                style: TextHelper.bodySmall,
                              ),
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
                                item.phoneNo ?? '',
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
                                item.panNo ?? '',
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
                                item.wages ?? '',
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
                                item.extraWages ?? '',
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
                                item.commission ?? '',
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
                                    icon: const Icon(PhosphorIconsBold.pencil),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(PhosphorIconsBold.trash),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
        top: Sizes.paddingS,
        left: Sizes.paddingM,
        right: Sizes.paddingM,
      ),
      child: Text(
        title,
        style: TextHelper.h4.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
