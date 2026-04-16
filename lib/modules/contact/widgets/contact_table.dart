import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/modules/contact/controllers/contact_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactTable extends StatelessWidget {
  ContactTable({super.key});

  final contactController = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (contactController.isLoading.value &&
            contactController.contactList.isEmpty) {
          return const TableShimmer();
        }

        final items = contactController.contactList;
        return BorderContainer(
          child: Column(
            children: [
              // RangedDatePicker(
              //   initialDateRange: contactController.selectedDateRange.value,
              //   onChanged: (range) {
              //     contactController.selectedDateRange.value = range;
              //     contactController.currentPage.value = 1;
              //     contactController.fetchContacts();
              //   },
              // ),
              // Gap(Sizes.defHorizontalSpace),
              CommonTable<ContactModel>(
                isLoading: contactController.isLoading.value,
                items: items,
                onRowTap: (item) =>
                    Get.toNamed(Routes.contactDetails, arguments: item),
                columns: [
                  TableColumn(
                    title: 'Name',
                    width: 140,
                    cellBuilder: (context, item, index) => Text(
                      "${item.firstName} ${item.lastName}",
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Phone No',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "${item.phoneNo?.phoneNo ?? '-'}",
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Whatsapp No',
                    width: 120,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      "${item.whatsappNo?.phoneNo ?? '-'}",
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall,
                    ),
                  ),
                  TableColumn(
                    title: 'Loyalty Points',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.loyaltyPoints.toStringAsFixed(0),
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TableColumn(
                    title: 'Status',
                    width: 100,
                    alignment: TextAlign.center,
                    cellBuilder: (context, item, index) => Text(
                      item.status,
                      textAlign: TextAlign.center,
                      style: TextHelper.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                currentPage: contactController.currentPage.value,
                totalPages: contactController.totalPages.value,
                totalItems: contactController.totalItems.value,
                pageSize: contactController.limit.value,
                onPageChanged: (page) => contactController.goToPage(page),
              ),
            ],
          ),
        );
      }),
    );
  }
}
