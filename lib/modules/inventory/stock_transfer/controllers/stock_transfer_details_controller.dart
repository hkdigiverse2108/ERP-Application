import 'dart:convert';
import 'dart:ui';
import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/core/services/branch_controller.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/invetory/stock_transfer_model.dart';
import 'package:ai_setu/data/repositories/inventory/stock_transfer_repository.dart';
import 'package:ai_setu/modules/inventory/stock_transfer/controllers/stock_transfer_controller.dart';
import 'package:ai_setu/shared/widgets/details/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/constants/sizes.dart';

class StockTransferDetailsController extends GetxController {
  final _repository = StockTransferRepository();

  final Rxn<StockTransferModel> transfer = Rxn<StockTransferModel>();
  final RxBool isLoading = false.obs;
  final RxBool isActionLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is StockTransferModel) {
      transfer.value = Get.arguments as StockTransferModel;
    }
    if (transfer.value != null) {
      fetchTransferDetails();
    }
  }

  Future<void> fetchTransferDetails() async {
    try {
      isLoading.value = true;
      final id = transfer.value!.id;
      final data = await _repository.getStockTransferById(id);
      transfer.value = data;
    } catch (e) {
      Log.e("Error fetching stock transfer details", e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshTransfer() async {
    await fetchTransferDetails();
    // Also refresh the main table/list controller if active
    if (Get.isRegistered<StockTransferController>()) {
      Get.find<StockTransferController>().getStockTransfers();
    }
  }

  String? getCurrentBranchId() {
    // 1. Try selectedBranch from BranchController
    if (Get.isRegistered<BranchController>()) {
      final selectedId = BranchController.to.selectedBranch.value?.id;
      if (selectedId != null && selectedId.isNotEmpty) {
        return selectedId;
      }
    }
    // 2. Fall back to userData in StorageService
    final userData = StorageService.instance.read(StorageKeys.userData);
    if (userData != null) {
      if (userData is Map<String, dynamic>) {
        return userData['branchId'] is Map
            ? userData['branchId']['_id']?.toString()
            : userData['branchId']?.toString();
      } else if (userData is String) {
        try {
          final decoded = jsonDecode(userData) as Map<String, dynamic>;
          return decoded['branchId'] is Map
              ? decoded['branchId']['_id']?.toString()
              : decoded['branchId']?.toString();
        } catch (_) {}
      }
    }
    return null;
  }

  List<DetailAction> getActions(BuildContext context) {
    final currentStatus = transfer.value?.status.toLowerCase() ?? '';
    final actions = <DetailAction>[];

    final currentBranchId = getCurrentBranchId();
    final isRequestedToBranch =
        currentBranchId != null &&
        transfer.value?.requestedToBranchId?.id == currentBranchId;

    final isRequestedFromBranch =
        currentBranchId != null &&
        transfer.value?.requestedByBranchId?.id == currentBranchId;

    if (currentStatus == 'pending' && isRequestedToBranch) {
      actions.add(
        DetailAction(
          label: 'Approve',
          icon: PhosphorIconsFill.checkCircle,
          color: Colors.green,
          onTap: () => _showApproveDialog(context),
        ),
      );
      actions.add(
        DetailAction(
          label: 'Reject',
          icon: PhosphorIconsFill.xCircle,
          color: Colors.red,
          onTap: () => _showRejectDialog(context),
        ),
      );
    } else if (currentStatus == 'approved' && isRequestedToBranch) {
      actions.add(
        DetailAction(
          label: 'Dispatch',
          icon: PhosphorIconsFill.truck,
          color: Colors.blue,
          onTap: () => _showDispatchDialog(context),
        ),
      );
    } else if (currentStatus == 'dispatched' && isRequestedFromBranch) {
      actions.add(
        DetailAction(
          label: 'Complete',
          icon: PhosphorIconsFill.house,
          color: Colors.teal,
          onTap: () => _showCompleteDialog(context),
        ),
      );
    }

    return actions;
  }

  // --- ACTIONS IMPLEMENTATIONS ---

  void _showApproveDialog(BuildContext context) {
    final noteController = TextEditingController();
    final items = transfer.value?.items ?? [];
    final qtyControllers = <String, TextEditingController>{};

    for (var item in items) {
      final id = item.productId?.id ?? '';
      qtyControllers[id] = TextEditingController(
        text: item.requestedQty.toString(),
      );
    }

    final colors = context.appColors;

    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Dialog(
          backgroundColor: colors.surface,
          elevation: 10,
          shadowColor: Colors.black.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusXL),
            side: BorderSide(color: colors.border.withValues(alpha: 0.5)),
          ),
          child: Container(
            width: Get.width * 0.9,
            constraints: BoxConstraints(
              maxWidth: 480,
              maxHeight: Get.height * 0.8,
            ),
            padding: const EdgeInsets.all(Sizes.paddingXL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Approve Stock Transfer",
                        style: TextHelper.h3Style(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: Sizes.paddingS),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: colors.textSecondary,
                        size: 22,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: Sizes.paddingM),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Set Approved Quantities",
                          style: TextHelper.bodyMediumStyle(context).copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: Sizes.paddingM),
                        ...items.map((item) {
                          final id = item.productId?.id ?? '';
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: Sizes.paddingM,
                            ),
                            padding: const EdgeInsets.all(Sizes.paddingM),
                            decoration: BoxDecoration(
                              color: colors.background.withValues(alpha: 0.4),
                              border: Border.all(
                                color: colors.border.withValues(alpha: 0.5),
                              ),
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusL,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.productId?.name ?? '-',
                                  style: TextHelper.bodyMediumStyle(context)
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colors.textPrimary,
                                      ),
                                ),
                                const SizedBox(height: Sizes.paddingS),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Requested: ${item.requestedQty}",
                                        style:
                                            TextHelper.bodySmallStyle(
                                              context,
                                            ).copyWith(
                                              color: colors.textSecondary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(width: Sizes.paddingM),
                                    Expanded(
                                      child: TextField(
                                        controller: qtyControllers[id],
                                        keyboardType:
                                            const TextInputType.numberWithOptions(
                                              decimal: true,
                                            ),
                                        style: TextHelper.bodyMediumStyle(
                                          context,
                                        ).copyWith(color: colors.textPrimary),
                                        decoration: InputDecoration(
                                          labelText: "Approved Qty",
                                          labelStyle: TextStyle(
                                            color: colors.textSecondary,
                                          ),
                                          floatingLabelStyle: TextStyle(
                                            color: colors.primary,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 10,
                                              ),
                                          filled: true,
                                          fillColor: colors.background
                                              .withValues(alpha: 0.2),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              Sizes.borderRadiusM,
                                            ),
                                            borderSide: BorderSide(
                                              color: colors.border,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              Sizes.borderRadiusM,
                                            ),
                                            borderSide: BorderSide(
                                              color: colors.border.withValues(
                                                alpha: 0.5,
                                              ),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              Sizes.borderRadiusM,
                                            ),
                                            borderSide: BorderSide(
                                              color: colors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: Sizes.paddingM),
                        TextField(
                          controller: noteController,
                          maxLines: 3,
                          style: TextHelper.bodyMediumStyle(
                            context,
                          ).copyWith(color: colors.textPrimary),
                          decoration: InputDecoration(
                            labelText: "Approval Note",
                            labelStyle: TextStyle(color: colors.textSecondary),
                            floatingLabelStyle: TextStyle(
                              color: colors.primary,
                            ),
                            alignLabelWithHint: true,
                            filled: true,
                            fillColor: colors.background.withValues(alpha: 0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusL,
                              ),
                              borderSide: BorderSide(color: colors.border),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusL,
                              ),
                              borderSide: BorderSide(
                                color: colors.border.withValues(alpha: 0.5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusL,
                              ),
                              borderSide: BorderSide(color: colors.primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.paddingL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: colors.border),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                        ),
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        "Cancel",
                        style: TextHelper.bodyMediumStyle(context).copyWith(
                          color: colors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: Sizes.paddingM),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.success,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        // Validate and extract quantities
                        final itemsPayload = <Map<String, dynamic>>[];
                        for (var item in items) {
                          final id = item.productId?.id ?? '';
                          final enteredText = qtyControllers[id]?.text ?? '0';
                          final double? enteredQty = double.tryParse(
                            enteredText,
                          );
                          if (enteredQty == null || enteredQty < 0) {
                            AppSnackbar.error(
                              "Please enter a valid positive quantity for ${item.productId?.name}",
                            );
                            return;
                          }
                          if (enteredQty > item.requestedQty) {
                            AppSnackbar.error(
                              "Approved quantity cannot exceed requested quantity for ${item.productId?.name}",
                            );
                            return;
                          }
                          itemsPayload.add({
                            "productId": id,
                            "approvedQty": enteredQty,
                            "price": item.price,
                          });
                        }

                        Get.back(); // close dialog
                        await _updateStatus(
                          status: "approved",
                          approvalNote: noteController.text,
                          items: itemsPayload,
                        );
                      },
                      child: Text(
                        "Approve",
                        style: TextHelper.bodyMediumStyle(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRejectDialog(BuildContext context) {
    final noteController = TextEditingController();
    final colors = context.appColors;

    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Dialog(
          backgroundColor: colors.surface,
          elevation: 10,
          shadowColor: Colors.black.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusXL),
            side: BorderSide(color: colors.border.withValues(alpha: 0.5)),
          ),
          child: Container(
            width: Get.width * 0.9,
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(Sizes.paddingXL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Reject Stock Transfer",
                        style: TextHelper.h3Style(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: colors.textSecondary,
                        size: 22,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: Sizes.paddingM),
                Text(
                  "Are you sure you want to reject this stock transfer? Please provide a reason below.",
                  style: TextHelper.bodyMediumStyle(
                    context,
                  ).copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: Sizes.paddingM),
                TextField(
                  controller: noteController,
                  maxLines: 3,
                  style: TextHelper.bodyMediumStyle(
                    context,
                  ).copyWith(color: colors.textPrimary),
                  decoration: InputDecoration(
                    labelText: "Rejection Reason *",
                    labelStyle: TextStyle(color: colors.textSecondary),
                    floatingLabelStyle: TextStyle(color: colors.error),
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: colors.background.withValues(alpha: 0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
                      borderSide: BorderSide(color: colors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
                      borderSide: BorderSide(
                        color: colors.border.withValues(alpha: 0.5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
                      borderSide: BorderSide(color: colors.error),
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.paddingL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: colors.border),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                        ),
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        "Cancel",
                        style: TextHelper.bodyMediumStyle(context).copyWith(
                          color: colors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: Sizes.paddingM),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.error,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (noteController.text.trim().isEmpty) {
                          AppSnackbar.error(
                            "Please enter a reason for rejection",
                          );
                          return;
                        }
                        Get.back();
                        await _updateStatus(
                          status: "rejected",
                          approvalNote: noteController.text,
                        );
                      },
                      child: Text(
                        "Reject",
                        style: TextHelper.bodyMediumStyle(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDispatchDialog(BuildContext context) {
    final colors = context.appColors;

    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Dialog(
          backgroundColor: colors.surface,
          elevation: 10,
          shadowColor: Colors.black.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusXL),
            side: BorderSide(color: colors.border.withValues(alpha: 0.5)),
          ),
          child: Container(
            width: Get.width * 0.9,
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(Sizes.paddingXL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Dispatch Stock Transfer",
                        style: TextHelper.h3Style(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: colors.textSecondary,
                        size: 22,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: Sizes.paddingM),
                Text(
                  "Are you sure you want to dispatch this stock transfer? This will mark the goods as in-transit.",
                  style: TextHelper.bodyMediumStyle(
                    context,
                  ).copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: Sizes.paddingL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: colors.border),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                        ),
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        "Cancel",
                        style: TextHelper.bodyMediumStyle(context).copyWith(
                          color: colors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: Sizes.paddingM),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.info,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        Get.back();
                        await _updateStatus(status: "dispatched");
                      },
                      child: Text(
                        "Dispatch",
                        style: TextHelper.bodyMediumStyle(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCompleteDialog(BuildContext context) {
    final items = transfer.value?.items ?? [];
    final qtyControllers = <String, TextEditingController>{};
    final noteController = TextEditingController();

    for (var item in items) {
      final id = item.productId?.id ?? '';
      qtyControllers[id] = TextEditingController(
        text: item.approvedQty.toString(),
      );
    }

    final colors = context.appColors;

    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Dialog(
          backgroundColor: colors.surface,
          elevation: 10,
          shadowColor: Colors.black.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusXL),
            side: BorderSide(color: colors.border.withValues(alpha: 0.5)),
          ),
          child: Container(
            width: Get.width * 0.9,
            constraints: BoxConstraints(
              maxWidth: 480,
              maxHeight: Get.height * 0.8,
            ),
            padding: const EdgeInsets.all(Sizes.paddingXL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Receive/Complete Transfer",
                        style: TextHelper.h3Style(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: Sizes.paddingS),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: colors.textSecondary,
                        size: 22,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: Sizes.paddingM),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Set Received Quantities",
                          style: TextHelper.bodyMediumStyle(context).copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: Sizes.paddingM),
                        ...items.map((item) {
                          final id = item.productId?.id ?? '';
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: Sizes.paddingM,
                            ),
                            padding: const EdgeInsets.all(Sizes.paddingM),
                            decoration: BoxDecoration(
                              color: colors.background.withValues(alpha: 0.4),
                              border: Border.all(
                                color: colors.border.withValues(alpha: 0.5),
                              ),
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusL,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.productId?.name ?? '-',
                                  style: TextHelper.bodyMediumStyle(context)
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colors.textPrimary,
                                      ),
                                ),
                                const SizedBox(height: Sizes.paddingS),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Approved: ${item.approvedQty}",
                                        style:
                                            TextHelper.bodySmallStyle(
                                              context,
                                            ).copyWith(
                                              color: colors.textSecondary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(width: Sizes.paddingM),
                                    Expanded(
                                      child: TextField(
                                        controller: qtyControllers[id],
                                        keyboardType:
                                            const TextInputType.numberWithOptions(
                                              decimal: true,
                                            ),
                                        style: TextHelper.bodyMediumStyle(
                                          context,
                                        ).copyWith(color: colors.textPrimary),
                                        decoration: InputDecoration(
                                          labelText: "Received Qty",
                                          labelStyle: TextStyle(
                                            color: colors.textSecondary,
                                          ),
                                          floatingLabelStyle: TextStyle(
                                            color: colors.primary,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 10,
                                              ),
                                          filled: true,
                                          fillColor: colors.background
                                              .withValues(alpha: 0.2),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              Sizes.borderRadiusM,
                                            ),
                                            borderSide: BorderSide(
                                              color: colors.border,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              Sizes.borderRadiusM,
                                            ),
                                            borderSide: BorderSide(
                                              color: colors.border.withValues(
                                                alpha: 0.5,
                                              ),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              Sizes.borderRadiusM,
                                            ),
                                            borderSide: BorderSide(
                                              color: colors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: Sizes.paddingM),
                        TextField(
                          controller: noteController,
                          maxLines: 3,
                          style: TextHelper.bodyMediumStyle(
                            context,
                          ).copyWith(color: colors.textPrimary),
                          decoration: InputDecoration(
                            labelText: "Receipt Note",
                            labelStyle: TextStyle(color: colors.textSecondary),
                            floatingLabelStyle: TextStyle(
                              color: colors.primary,
                            ),
                            alignLabelWithHint: true,
                            filled: true,
                            fillColor: colors.background.withValues(alpha: 0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusL,
                              ),
                              borderSide: BorderSide(color: colors.border),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusL,
                              ),
                              borderSide: BorderSide(
                                color: colors.border.withValues(alpha: 0.5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.borderRadiusL,
                              ),
                              borderSide: BorderSide(color: colors.primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.paddingL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: colors.border),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                        ),
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        "Cancel",
                        style: TextHelper.bodyMediumStyle(context).copyWith(
                          color: colors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: Sizes.paddingM),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.success,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.borderRadiusM,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        final itemsPayload = <Map<String, dynamic>>[];
                        for (var item in items) {
                          final id = item.productId?.id ?? '';
                          final enteredText = qtyControllers[id]?.text ?? '0';
                          final double? enteredQty = double.tryParse(
                            enteredText,
                          );
                          if (enteredQty == null || enteredQty < 0) {
                            AppSnackbar.error(
                              "Please enter a valid positive quantity for ${item.productId?.name}",
                            );
                            return;
                          }
                          if (enteredQty > item.approvedQty) {
                            AppSnackbar.error(
                              "Received quantity cannot exceed approved quantity for ${item.productId?.name}",
                            );
                            return;
                          }
                          itemsPayload.add({
                            "productId": id,
                            "receivedQty": enteredQty,
                          });
                        }

                        Get.back();
                        await _updateStatus(
                          status: "completed",
                          approvalNote: noteController.text,
                          items: itemsPayload,
                        );
                      },
                      child: Text(
                        "Complete",
                        style: TextHelper.bodyMediumStyle(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateStatus({
    required String status,
    String? approvalNote,
    List<Map<String, dynamic>>? items,
  }) async {
    try {
      isActionLoading.value = true;

      bool success;
      if (status == "approved") {
        final approvePayload = <String, dynamic>{
          "stockTransferId": transfer.value!.id,
          "approvalNote": approvalNote ?? "",
          "items": items ?? [],
        };
        success = await _repository.approveStockTransfer(approvePayload);
      } else if (status == "rejected") {
        final rejectPayload = <String, dynamic>{
          "stockTransferId": transfer.value!.id,
          "approvalNote": approvalNote ?? "",
        };
        success = await _repository.rejectStockTransfer(rejectPayload);
      } else if (status == "dispatched") {
        final dispatchPayload = <String, dynamic>{
          "stockTransferId": transfer.value!.id,
        };
        success = await _repository.dispatchStockTransfer(dispatchPayload);
      } else if (status == "completed") {
        final confirmPayload = <String, dynamic>{
          "stockTransferId": transfer.value!.id,
          "receiptNote": approvalNote ?? "",
          "items": items ?? [],
        };
        success = await _repository.confirmReceiptStockTransfer(confirmPayload);
      } else {
        // Build payload containing the stockTransferId
        final payload = <String, dynamic>{
          "stockTransferId": transfer.value!.id,
          "status": status,
        };

        if (approvalNote != null) {
          payload["approvalNote"] = approvalNote;
        }

        // If items payload is provided, use it. Otherwise map existing items so we don't lose data.
        if (items != null) {
          payload["items"] = items;
        } else if (transfer.value?.items != null) {
          payload["items"] = transfer.value!.items
              .map(
                (item) => {
                  "productId": item.productId?.id,
                  "price": item.price,
                  "requestedQty": item.requestedQty,
                  "approvedQty": item.approvedQty,
                  "receivedQty": item.receivedQty,
                },
              )
              .toList();
        }

        success = await _repository.updateStockTransfer(payload);
      }

      if (success) {
        AppSnackbar.success(
          "Stock transfer marked as ${status.capitalizeFirst} successfully",
        );
        await refreshTransfer();
      } else {
        AppSnackbar.error("Failed to update stock transfer status");
      }
    } catch (e) {
      Log.e("Error updating stock transfer status", e);
      AppSnackbar.error("An error occurred while updating status");
    } finally {
      isActionLoading.value = false;
    }
  }
}
