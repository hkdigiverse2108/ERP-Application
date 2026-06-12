import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:ai_setu/shared/widgets/dialogs/confirm_dialog.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/model/user_model.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/pos/pos_new/controllers/pos_new_controller.dart';
import 'package:ai_setu/modules/pos/pos_new/widgets/pos_widgets.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:ai_setu/modules/pos/pos_new/widgets/pos_action_drawer.dart';
import 'package:ai_setu/modules/pos/pos_new/widgets/close_register_dialog.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PosNewPage extends GetView<PosNewController> {
  const PosNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: DefAppBar(),
        drawer: const AppDrawer(),
        endDrawer: const PosActionDrawer(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: Sizes.paddingXL),
            child: Column(
              children: [
                const QuickAction(),
                Padding(
                  padding: EdgeInsets.all(Sizes.paddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Type Toggle & Action Icons ---
                      Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => PosToggle(
                                selectedIndex: controller.orderType.value,
                                onSelected: (val) =>
                                    controller.updateOrderType(val),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(16),
                      _buildActionIcons(context),
                      const Gap(16),

                      // --- Selection Section ---
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropdown<ProductDropdownModel>(
                              label: "Product",
                              items: controller.products,
                              value: controller.selectedProduct.value,
                              onChanged: (val) {
                                controller.addItemToCart(val);
                              },
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: CustomDropdown<UserDropDownModel>(
                              label: "Salesman",
                              items: controller.salesmen,
                              value: controller.selectedSalesman.value,
                              onChanged: (val) =>
                                  controller.selectedSalesman.value = val,
                            ),
                          ),
                        ],
                      ),
                      const Gap(12),
                      Obx(() {
                        final bool hasSelection =
                            controller.selectedCustomer.value != null;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: CustomDropdown<ContactDropdownModel>(
                                label: "Customer",
                                items: controller.customers,
                                value: controller.selectedCustomer.value,
                                onChanged: (val) =>
                                    controller.selectedCustomer.value = val,
                              ),
                            ),
                            const Gap(8),
                            if (hasSelection) ...[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.shade400,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  onPressed: () =>
                                      controller.unselectCustomer(),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Gap(8),
                            ],
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff536DFE),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                onPressed: () => controller.openCustomerSheet(),
                                icon: Icon(
                                  hasSelection ? Icons.edit : Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      const Gap(20),

                      // --- Table Header ---
                      _buildCartTable(context),
                      const Gap(16),

                      // --- Remark Section ---
                      EditTextField(
                        label: "Remark",
                        controller: controller.remarkController,
                        hintText: "Remark.....",
                        maxLines: 3,
                      ),
                      const Gap(20),

                      // --- Flat Discount & Round Off ---
                      Row(
                        children: [
                          Expanded(
                            child: EditTextField(
                              label: "Flat Discount",
                              controller: controller.flatDiscountController,
                              prefixIcon: const Icon(
                                Icons.currency_rupee,
                                size: 16,
                              ),
                            ),
                          ),
                          const Gap(16),
                          Expanded(
                            child: EditTextField(
                              label: "Round of",
                              controller: controller.roundOffController,
                            ),
                          ),
                        ],
                      ),
                      const Gap(20),
                      // --- Summary Grid ---
                      _buildSummaryGrid(context),
                      const Gap(12),
                      _buildDiscountBreakdown(context),

                      // --- Action Buttons ---
                      const Gap(16),
                      _buildActionButtonGrid(context),
                      const Gap(16),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildActionIcons(BuildContext context) {
    return Builder(
      builder: (innerContext) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCircularIcon(
              context,
              Icons.add_a_photo,
              context.appColors.success,
              onTap: () => controller.showImageOptions(context),
            ),
            _buildCircularIcon(
              context,
              Icons.print_outlined,
              context.appColors.textSecondary,
            ),
            _buildCircularIcon(
              context,
              Icons.delete_outline,
              Colors.red,
              onTap: () {
                if (controller.cartItems.isNotEmpty) {
                  ConfirmDialog.show(
                    title: "Clear Cart",
                    message:
                        "Are you sure you want to discard all products and reset the cart?",
                    confirmText: "Discard",
                    confirmColor: Colors.red,
                    onConfirm: () => controller.clearCart(),
                  );
                } else {
                  controller.clearCart();
                }
              },
            ),
            _buildCircularIcon(
              context,
              Icons.grid_view_rounded,
              context.appColors.textSecondary,
              onTap: () {
                Scaffold.of(innerContext).openEndDrawer();
              },
            ),
            _buildCircularIcon(
              context,
              Icons.fullscreen_rounded,
              context.appColors.textSecondary,
            ),
            _buildCircularIcon(
              context,
              Icons.close_rounded,
              Colors.red,
              onTap: () async {
                final registerData = await controller
                    .getLatestRegisterDetails();
                if (registerData != null) {
                  Get.dialog(
                    CloseRegisterDialog(registerData: registerData),
                    barrierDismissible: true,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCircularIcon(
    BuildContext context,
    IconData? icon,
    Color color, {
    File? imageFile,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: context.appColors.border),
        ),
        child: imageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  imageFile,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              )
            : Icon(icon, color: color, size: 22),
      ),
    );
  }

  Widget _buildCartTable(BuildContext context) {
    return CommonTable<Map<String, dynamic>>(
      items: controller.cartItems,
      showSerial: true,
      onRemoveItem: (item) => controller.removeItemFromCart(item),
      confirmDelete: false,
      columns: [
        TableColumn(
          title: 'Product',
          width: 150,
          cellBuilder: (context, item, index) => Text(
            item['name'] ?? "",
            style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        TableColumn(
          title: 'Available Qty',
          width: 100,
          alignment: TextAlign.center,
          cellBuilder: (context, item, index) =>
              Text("${item['availableQty']}", style: TextHelper.bodySmall),
        ),
        TableColumn(
          title: 'Qty',
          width: 120,
          alignment: TextAlign.center,
          cellBuilder: (context, item, index) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _qtyBtn(Icons.remove, () => controller.updateQuantity(index, -1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  controller.formatQty(item),
                  style: TextHelper.bodySmall,
                ),
              ),
              _qtyBtn(Icons.add, () => controller.updateQuantity(index, 1)),
            ],
          ),
        ),
        TableColumn(
          title: 'MRP',
          width: 100,
          alignment: TextAlign.center,
          cellBuilder: (context, item, index) =>
              Text("₹${item['mrp']}", style: TextHelper.bodySmall),
        ),
        TableColumn(
          title: 'Unit Cost',
          width: 100,
          alignment: TextAlign.center,
          cellBuilder: (context, item, index) => Text(
            "₹${(item['unitCost'] as double).toStringAsFixed(2)}",
            style: TextHelper.bodySmall,
          ),
        ),
        TableColumn(
          title: 'Discount',
          width: 100,
          alignment: TextAlign.center,
          cellBuilder: (context, item, index) => SizedBox(
            height: 35,
            child: TextField(
              onChanged: (v) => controller.updateItemDiscount(index, v),
              decoration: InputDecoration(
                prefixText: "₹",
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: context.appColors.border),
                ),
              ),
              style: TextHelper.bodySmall,
              keyboardType: TextInputType.number,
              controller: controller.getDiscountController(
                index,
                item['id'],
                item['discount'],
              ),
            ),
          ),
        ),
        TableColumn(
          title: 'Net Amount',
          width: 120,
          alignment: TextAlign.right,
          cellBuilder: (context, item, index) => Text(
            "₹${(item['netAmount'] as double).toStringAsFixed(2)}",
            style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff536DFE).withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 14, color: const Color(0xff536DFE)),
      ),
    );
  }

  Widget _buildSummaryGrid(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        SummaryCard(
          label: "Quantity",
          value: controller.totalQuantity.value.toStringAsFixed(2),
          bgColor: context.responsive(
            light: const Color(0xffE3F2FD),
            dark: context.appColors.sectionSell.withValues(alpha: 0.1),
          ),
          textColor: context.appColors.textPrimary,
        ),
        SummaryCard(
          label: "MRP",
          value: "₹${controller.totalMRP.value.toStringAsFixed(2)}",
          bgColor: context.responsive(
            light: const Color(0xffFFF3E0),
            dark: context.appColors.sectionSellPurchase.withValues(alpha: 0.1),
          ),
          textColor: context.appColors.textPrimary,
        ),
        SummaryCard(
          label: "Tax Amount",
          value: "₹${controller.taxAmount.value.toStringAsFixed(2)}",
          bgColor: context.responsive(
            light: const Color(0xffF3E5F5),
            dark: context.appColors.sectionSell.withValues(alpha: 0.1),
          ),
          textColor: context.appColors.textPrimary,
        ),
        SummaryCard(
          label: "Add Charges+",
          value: controller.addCharges.value.toStringAsFixed(2),
          bgColor: context.responsive(
            light: const Color(0xffFFEBEE),
            dark: context.appColors.sectionProfit.withValues(alpha: 0.1),
          ),
          textColor: context.appColors.textPrimary,
        ),
        SummaryCard(
          label: "Discount",
          value: "₹${controller.totalDiscount.value.toStringAsFixed(2)}",
          bgColor: context.responsive(
            light: const Color(0xffE0F7FA),
            dark: context.appColors.sectionSellPurchase.withValues(alpha: 0.1),
          ),
          textColor: context.appColors.textPrimary,
        ),
        SummaryCard(
          label: "Amount",
          value: "₹${controller.totalAmount.value.toStringAsFixed(2)}",
          bgColor: context.responsive(
            light: const Color(0xffE8F5E9),
            dark: context.appColors.success.withValues(alpha: 0.1),
          ),
          textColor: context.appColors.textPrimary,
        ),
      ],
    );
  }

  Widget _buildAppliedRedemption(BuildContext context) {
    return Obx(() {
      if (controller.appliedRedemption.value == null) {
        return const SizedBox.shrink();
      }
      final redemption = controller.appliedRedemption.value!;
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: context.appColors.success.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.appColors.success.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: context.appColors.success,
              size: 20,
            ),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Applied ${redemption.type == 'credit_note' ? 'Credit Note' : 'Advance Payment'}",
                    style: TextHelper.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${redemption.code} • ₹${redemption.amount.toStringAsFixed(2)}",
                    style: TextHelper.bodySmall.copyWith(
                      fontSize: 10,
                      color: context.appColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => controller.removeRedemption(),
              icon: const Icon(Icons.close, size: 18),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAppliedCoupon(BuildContext context) {
    return Obx(() {
      if (controller.appliedCoupon.value == null) {
        return const SizedBox.shrink();
      }
      final coupon = controller.appliedCoupon.value!;
      final discountLabel =
          "₹${controller.promoDiscountAmount.value.toStringAsFixed(2)}";

      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: context.appColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.appColors.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.confirmation_num,
              color: context.appColors.primary,
              size: 20,
            ),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Applied Coupon: ${coupon.name}",
                    style: TextHelper.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.appColors.primary,
                    ),
                  ),
                  Text(
                    "Discount: $discountLabel",
                    style: TextHelper.bodySmall.copyWith(
                      fontSize: 10,
                      color: context.appColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => controller.removeCoupon(),
              icon: const Icon(Icons.close, size: 18),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAppliedDiscount(BuildContext context) {
    return Obx(() {
      if (controller.appliedDiscount.value == null) {
        return const SizedBox.shrink();
      }
      final discount = controller.appliedDiscount.value!;
      final discountLabel =
          "₹${controller.promoDiscountAmount.value.toStringAsFixed(2)}";

      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: context.appColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.appColors.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.tag, color: context.appColors.primary, size: 20),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Applied Discount: ${discount.title}",
                    style: TextHelper.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.appColors.primary,
                    ),
                  ),
                  Text(
                    "Discount: $discountLabel",
                    style: TextHelper.bodySmall.copyWith(
                      fontSize: 10,
                      color: context.appColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => controller.removeDiscount(),
              icon: const Icon(Icons.close, size: 18),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAppliedLoyalty(BuildContext context) {
    return Obx(() {
      if (controller.appliedLoyalty.value == null) {
        return const SizedBox.shrink();
      }
      final loyalty = controller.appliedLoyalty.value!;
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: context.appColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.appColors.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.card_giftcard,
              color: context.appColors.primary,
              size: 20,
            ),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Applied Loyalty: ${loyalty.name}",
                    style: TextHelper.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.appColors.primary,
                    ),
                  ),
                  Text(
                    "Discount: ₹${loyalty.discountValue.toStringAsFixed(2)}",
                    style: TextHelper.bodySmall.copyWith(
                      fontSize: 10,
                      color: context.appColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                controller.appliedLoyalty.value = null;
                controller.calculateTotals();
              },
              icon: const Icon(Icons.close, size: 18),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDiscountBreakdown(BuildContext context) {
    return Obx(() {
      final discountTotal = controller.productDiscountTotal.value;
      final flatDisc = controller.flatDiscount.value;
      final couponDisc = controller.promoDiscountAmount.value;
      final loyaltyDisc = controller.appliedLoyalty.value?.discountValue ?? 0.0;
      final redemptionDisc = controller.appliedRedemption.value?.amount ?? 0.0;

      if (discountTotal == 0 &&
          flatDisc == 0 &&
          couponDisc == 0 &&
          loyaltyDisc == 0 &&
          redemptionDisc == 0) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.appColors.sectionSellPurchase.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.appColors.sectionSellPurchase.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Discount Breakdown",
              style: TextHelper.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const Gap(8),
            if (discountTotal > 0)
              _breakdownRow(
                "Items Discount",
                "₹${discountTotal.toStringAsFixed(2)}",
              ),
            if (flatDisc > 0)
              _breakdownRow("Flat Discount", "₹${flatDisc.toStringAsFixed(2)}"),
            if (couponDisc > 0)
              _breakdownRow(
                "Coupon Discount",
                "₹${couponDisc.toStringAsFixed(2)}",
              ),
            if (loyaltyDisc > 0)
              _breakdownRow(
                "Loyalty Discount",
                "₹${loyaltyDisc.toStringAsFixed(2)}",
              ),
            if (redemptionDisc > 0)
              _breakdownRow(
                "Credit Redemption",
                "₹${redemptionDisc.toStringAsFixed(2)}",
              ),
            const Divider(height: 16),
            _breakdownRow(
              "Total Discount",
              "₹${controller.totalDiscount.value.toStringAsFixed(2)}",
              isTotal: true,
            ),
          ],
        ),
      );
    });
  }

  Widget _breakdownRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextHelper.bodySmall.copyWith(
              fontSize: 11,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextHelper.bodySmall.copyWith(
              fontSize: 11,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.red : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtonGrid(BuildContext context) {
    return Column(
      children: [
        _buildAppliedCoupon(context),
        _buildAppliedDiscount(context),
        _buildAppliedRedemption(context),
        _buildAppliedLoyalty(context),
        _btnRow(
          "MULTIPLE PAY",
          Icons.keyboard,
          "",
          () => controller.goToMultiplePay(),
          "REDEEM CREDIT",
          Icons.credit_card,
          "",
          () => controller.redeemCredit(),
        ),
        const Gap(8),
        _btnRow(
          "HOLD",
          Icons.pause,
          "",
          () => controller.holdOrder(),
          "UPI",
          Icons.qr_code,
          "",
          () => controller.submitUpiOrder(),
        ),
        const Gap(8),
        _btnRow(
          "CARD",
          Icons.payment,
          "",
          () => controller.openCardPaymentSheet(),
          "CASH",
          Icons.money,
          "",
          () => controller.submitCashOrder(),
        ),
        const Gap(8),
        _btnRow(
          "APPLY COUPON",
          Icons.card_giftcard,
          "",
          () => controller.openCouponSheet(),
          "PAY LATER",
          Icons.calendar_month,
          "",
          () => controller.openPayLaterSheet(),
        ),
        const Gap(8),
        _btnRow(
          "HOLD & PRINT",
          Icons.print_outlined,
          "",
          () => controller.holdOrder(shouldPrint: true),
          "UPI & PRINT",
          Icons.qr_code_scanner,
          "",
          () => controller.submitUpiOrder(shouldPrint: true),
        ),
        const Gap(8),
        _btnRow(
          "CARD & PRINT",
          Icons.payment,
          "",
          () => controller.openCardPaymentSheet(shouldPrint: true),
          "CASH & PRINT",
          Icons.print,
          "",
          () => controller.submitCashOrder(shouldPrint: true),
        ),
      ],
    );
  }

  Widget _btnRow(
    String l1,
    IconData i1,
    String k1,
    VoidCallback t1,
    String l2,
    IconData i2,
    String k2,
    VoidCallback t2,
  ) {
    return Row(
      children: [
        Expanded(
          child: PosGridButton(
            label: l1,
            icon: i1,
            hotkey: k1.isEmpty ? null : k1,
            onTap: t1,
          ),
        ),
        const Gap(12),
        Expanded(
          child: PosGridButton(
            label: l2,
            icon: i2,
            hotkey: k2.isEmpty ? null : k2,
            onTap: t2,
          ),
        ),
      ],
    );
  }
}
