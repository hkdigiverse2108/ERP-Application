import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/modules/home/widgets/dashboard_stat_widget.dart';
import 'package:ai_setu/modules/home/widgets/report_cart.dart';
import 'package:ai_setu/modules/home/widgets/bestselling_product.dart';
import 'package:ai_setu/modules/home/widgets/category_sales.dart';
import 'package:ai_setu/modules/home/widgets/least_selling_product.dart';
import 'package:ai_setu/modules/home/widgets/login_log.dart';
import 'package:ai_setu/modules/home/widgets/to_pay.dart';
import 'package:ai_setu/modules/home/widgets/to_receive.dart';
import 'package:ai_setu/modules/home/widgets/todays_payable.dart';
import 'package:ai_setu/modules/home/widgets/todays_receivable.dart';
import 'package:ai_setu/modules/home/widgets/top_coupons.dart';
import 'package:ai_setu/modules/home/widgets/top_customers.dart';
import 'package:ai_setu/modules/home/widgets/top_expenses.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/charts/app_bar_chart.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/section_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const DefAppBar(),
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: context.appColors.background,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const QuickAction(),
                Obx(() {
                  if (!homeController.isLoaded.value) {
                    return const SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Section 1: Summary ──
                      Padding(
                        padding: EdgeInsets.all(Sizes.paddingM),
                        child: BorderContainer(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Row(
                                        children: [
                                          Gap(10),
                                          Expanded(
                                            child: Text(
                                              "Select Location",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                              PhosphorIconsLight.caretDown,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Gap(Sizes.smallSpace),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Row(
                                        children: [
                                          Gap(10),
                                          Expanded(
                                            child: Text(
                                              "Select Channel",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                              PhosphorIconsLight.caretDown,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(Sizes.defHorizontalSpace),
                              Obx(
                                () => RangedDatePicker(
                                  initialDateRange:
                                      homeController.selectedDateRange.value,
                                  onChanged: (range) {
                                    homeController.selectedDateRange.value =
                                        range;
                                    homeController.getTopSectionData();
                                  },
                                ),
                              ),
                              Gap(Sizes.defHorizontalSpace),
                              const DashboardStatWidget(),
                            ],
                          ),
                        ),
                      ),

                      // ── Section 2: Graphs ──
                      VisibilityDetector(
                        key: const Key('graphs-section'),
                        onVisibilityChanged: (info) {
                          if (info.visibleFraction > 0.1) {
                            homeController.loadGraphs();
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('Sales and Purchase'),
                            Padding(
                              padding: EdgeInsets.all(Sizes.paddingM),
                              child: Obx(() {
                                if (homeController
                                    .salesAndPurchaseGraphLoading
                                    .value) {
                                  return const SectionShimmer(height: 300);
                                }
                                return BorderContainer(
                                  child: Column(
                                    children: [
                                      RangedDatePicker(
                                        initialDateRange: homeController
                                            .selectedDateRange
                                            .value,
                                        onChanged: (range) {
                                          homeController
                                                  .selectedDateRange
                                                  .value =
                                              range;
                                          homeController
                                              .getSalesAndPurchaseGraph();
                                        },
                                      ),
                                      Gap(Sizes.lgHorizontalSpace),
                                      const AppBarChart(
                                        values: [45, 80, 65, 30, 90, 50, 70],
                                        labels: [
                                          'Mon',
                                          'Tue',
                                          'Wed',
                                          'Thu',
                                          'Fri',
                                          'Sat',
                                          'Sun',
                                        ],
                                      ),
                                      Gap(Sizes.lgVerticalSpace),
                                    ],
                                  ),
                                );
                              }),
                            ),
                            _buildSectionTitle('Transaction'),
                            Padding(
                              padding: EdgeInsets.all(Sizes.paddingM),
                              child: Obx(() {
                                if (homeController
                                    .transactionGraphLoading
                                    .value) {
                                  return const SectionShimmer(height: 300);
                                }
                                return BorderContainer(
                                  child: Column(
                                    children: [
                                      RangedDatePicker(
                                        initialDateRange: homeController
                                            .selectedDateRange
                                            .value,
                                        onChanged: (range) {
                                          homeController
                                                  .selectedDateRange
                                                  .value =
                                              range;
                                          homeController.getTransactionGraph();
                                        },
                                      ),
                                      Gap(Sizes.lgHorizontalSpace),
                                      const AppBarChart(
                                        values: [15, 60, 65, 45, 62, 20, 40],
                                        labels: [
                                          '1 Mar',
                                          '5 Mar',
                                          '10 Mar',
                                          '15 Mar',
                                          '20 Mar',
                                          '25 Mar',
                                        ],
                                      ),
                                      Gap(Sizes.lgVerticalSpace),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),

                      // ── Section 3: Customers ──
                      VisibilityDetector(
                        key: const Key('customers-section'),
                        onVisibilityChanged: (info) {
                          if (info.visibleFraction > 0.1) {
                            homeController.loadCustomers();
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('Top Customers'),
                            TopCustomers(),
                            _buildSectionTitle("Customer Report"),
                            Padding(
                              padding: EdgeInsets.all(Sizes.paddingM),
                              child: BorderContainer(
                                child: Column(children: [const ReportCart()]),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ── Section 4: Products ──
                      VisibilityDetector(
                        key: const Key('products-section'),
                        onVisibilityChanged: (info) {
                          if (info.visibleFraction > 0.1) {
                            homeController.loadProducts();
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('Category Sales'),
                            CategorySales(),
                            _buildSectionTitle('Best Selling Product'),
                            BestsellingProduct(),
                            _buildSectionTitle('Least Selling Product'),
                            LeastSellingProduct(),
                          ],
                        ),
                      ),

                      // ── Section 5: Finance & Logs ──
                      VisibilityDetector(
                        key: const Key('finance-section'),
                        onVisibilityChanged: (info) {
                          if (info.visibleFraction > 0.1) {
                            homeController.loadFinance();
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('Top Expenses'),
                            TopExpenses(),
                            _buildSectionTitle('Top Coupons'),
                            TopCoupons(),
                            _buildSectionTitle("Today's Receivable"),
                            TodaysReceivable(),
                            _buildSectionTitle("Today's Payable"),
                            TodaysPayable(),
                            _buildSectionTitle("To Receive"),
                            ToReceive(),
                            _buildSectionTitle('To Pay'),
                            ToPay(),
                            _buildSectionTitle('Login Log'),
                            LoginLog(),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
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
