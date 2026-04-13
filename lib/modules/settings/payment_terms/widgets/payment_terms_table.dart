import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/payment_terms/payment_terms_model.dart';
import 'package:ai_setu/modules/settings/payment_terms/controllers/payment_terms_controller.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentTermsTable extends StatelessWidget {
  const PaymentTermsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PaymentTermsController.instance;

    // // Get current user role for authorization
    // final userData =
    //     StorageService.instance.read<Map<String, dynamic>>(StorageKeys.userData);
    // final currentUserType = userData?['userType'] ?? 'admin';

    // bool isAuthorized(PaymentTermsModel item) {
    //   if (item.createdBy.userType == 'super-admin') {
    //     return currentUserType == 'super-admin';
    //   }
    //   return true;
    // }

    return Padding(
      padding: EdgeInsets.all(Sizes.paddingM),
      child: Obx(() {
        if (controller.isLoading.value && controller.paymentTerms.isEmpty) {
          return const TableShimmer();
        }
        context.isDarkMode;
        return BorderContainer(
          child: CommonTable<PaymentTermsModel>(
            isLoading: controller.isLoading.value,
            rowPadding: 5.0,
            items: controller.paymentTerms,
            currentPage: controller.currentPage.value,
            totalPages: controller.totalPages.value,
            totalItems: controller.totalItems.value,
            onPageChanged: (page) => controller.goToPage(page),
            onEditItem: (item) {
              Get.snackbar("Edit", "Edit Payment Term: ${item.name}");
            },
            onRemoveItem: (item) {
              Get.snackbar("Delete", "Delete Payment Term: ${item.name}");
            },
            // canEdit: isAuthorized,
            // canDelete: isAuthorized,
            columns: [
              TableColumn(
                title: "Name",
                width: 200,
                cellBuilder: (context, item, index) => Text(
                  item.name,
                  style: TextHelper.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TableColumn(
                title: "Days",
                width: 100,
                cellBuilder: (context, item, index) =>
                    Text("${item.day} Days", style: TextHelper.bodyMedium),
              ),
              TableColumn(
                title: "Default",
                width: 100,
                cellBuilder: (context, item, index) => item.isDefault
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        child: Text(
                          "Default",
                          style: TextHelper.bodySmall.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              TableColumn(
                title: "Status",
                width: 100,
                cellBuilder: (context, item, index) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (item.isActive ? Colors.green : Colors.red)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    item.isActive ? "Active" : "Inactive",
                    style: TextHelper.bodySmall.copyWith(
                      color: item.isActive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TableColumn(
                title: "Created Date",
                width: 150,
                cellBuilder: (context, item, index) => Text(
                  DateFormat('dd MMM yyyy').format(item.createdAt),
                  style: TextHelper.bodySmall,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
