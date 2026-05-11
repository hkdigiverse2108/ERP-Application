import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/pos/pos_payment/controllers/pos_payment_controller.dart';
import 'package:ai_setu/modules/pos/pos_payment/widgets/pos_payment_widgets.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/text_fields/search_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PosPaymentView extends GetView<PosPaymentController> {
  const PosPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: context.appColors.background,
        appBar: DefAppBar(),
        body: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [_buildSalesTab(context), _buildExpenseTab(context)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Sizes.paddingM),
            child: Row(
              children: [
                Expanded(
                  child: AppSearchBar(
                    hint: 'Search by voucher no, party...',
                    onChanged: controller.onSearch,
                  ),
                ),
                const Gap(12),
                _buildFilterButton(context),
              ],
            ),
          ),
          TabBar(
            controller: controller.tabController,
            labelColor: context.appColors.primary,
            unselectedLabelColor: context.appColors.textSecondary,
            indicatorColor: context.appColors.primary,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
            tabs: const [
              Tab(text: 'SALES PAYMENTS'),
              Tab(text: 'EXPENSES'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.background,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
        border: Border.all(
          color: context.appColors.border.withValues(alpha: 0.5),
        ),
      ),
      child: IconButton(
        onPressed: () {
          // Future: Show date range picker or other filters
        },
        icon: Icon(
          PhosphorIconsLight.funnel,
          color: context.appColors.textPrimary,
          size: 20,
        ),
        tooltip: 'Filters',
      ),
    );
  }

  Widget _buildSalesTab(BuildContext context) {
    return Obx(() {
      if (controller.isSalesLoading.value && controller.salesPayments.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.salesPayments.isEmpty) {
        return _buildEmptyState(context, 'No Sales Payments Found');
      }

      return Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => controller.refreshCurrentTab(),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: controller.salesPayments.length,
                itemBuilder: (context, index) {
                  final payment = controller.salesPayments[index];
                  return PosPaymentCard(payment: payment);
                },
              ),
            ),
          ),
          _buildPaginationFooter(
            context,
            controller.salesCurrentPage.value,
            controller.salesTotalPages.value,
            controller.salesTotalItems.value,
            (page) => controller.goToSalesPage(page),
          ),
        ],
      );
    });
  }

  Widget _buildExpenseTab(BuildContext context) {
    return Obx(() {
      if (controller.isExpenseLoading.value && controller.expenses.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.expenses.isEmpty) {
        return _buildEmptyState(context, 'No Expenses Found');
      }

      return Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => controller.refreshCurrentTab(),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: controller.expenses.length,
                itemBuilder: (context, index) {
                  final expense = controller.expenses[index];
                  return ExpensePaymentCard(expense: expense);
                },
              ),
            ),
          ),
          _buildPaginationFooter(
            context,
            controller.expenseCurrentPage.value,
            controller.expenseTotalPages.value,
            controller.expenseTotalItems.value,
            (page) => controller.goToExpensePage(page),
          ),
        ],
      );
    });
  }

  Widget _buildPaginationFooter(
    BuildContext context,
    int currentPage,
    int totalPages,
    int totalItems,
    Function(int) onPageChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        border: Border(
          top: BorderSide(
            color: context.appColors.border.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Total: $totalItems',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: context.appColors.textSecondary,
            ),
          ),
          const Spacer(),
          if (totalPages > 1) ...[
            _PageButton(
              onTap: currentPage > 1
                  ? () => onPageChanged(currentPage - 1)
                  : null,
              icon: PhosphorIconsLight.caretLeft,
            ),
            const Gap(8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: context.appColors.background,
                borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
              ),
              child: Text(
                '$currentPage / $totalPages',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.textPrimary,
                ),
              ),
            ),
            const Gap(8),
            _PageButton(
              onTap: currentPage < totalPages
                  ? () => onPageChanged(currentPage + 1)
                  : null,
              icon: PhosphorIconsLight.caretRight,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: context.appColors.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              PhosphorIconsLight.magnifyingGlass,
              size: 48,
              color: context.appColors.textSecondary.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            message,
            style: TextStyle(
              color: context.appColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              color: context.appColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => controller.refreshCurrentTab(),
            icon: const Icon(PhosphorIconsLight.arrowsClockwise, size: 18),
            label: const Text('Refresh'),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.appColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusL),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;

  const _PageButton({this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onTap != null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isEnabled
                ? context.appColors.primary.withValues(alpha: 0.5)
                : context.appColors.border.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
          color: isEnabled
              ? context.appColors.primary.withValues(alpha: 0.05)
              : null,
        ),
        child: Icon(
          icon,
          size: 16,
          color: isEnabled
              ? context.appColors.primary
              : context.appColors.textSecondary,
        ),
      ),
    );
  }
}
