import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:intl/intl.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/services/showcase_service.dart';
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
import 'package:ai_setu/shared/widgets/dialogs/quit_confirmation_dialog.dart';
import 'package:ai_setu/shared/widgets/drawer.dart';
import 'package:ai_setu/shared/widgets/section_shimmer.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:showcaseview/showcaseview.dart';
// ignore: implementation_imports
import 'package:showcaseview/src/showcase/showcase_service.dart' as sp;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeBody();
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody();

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  @override
  void initState() {
    super.initState();

    final homeController = Get.find<HomeController>();

    ShowcaseView.register(
      scope: ShowcaseService.homeScope,
      onFinish: () {
        ShowcaseService.to.startProductTour();
        Get.toNamed(Routes.product);
      },
      blurValue: 1,
      autoPlay: false,
      onComplete: (index, key) {
        debugPrint('Showcase step $index complete: $key');
      },
    );

    // Watch for data loading before starting the tour
    // This ensures DashboardStatWidget targets (salesKey, purchaseKey) are in the tree
    ever(homeController.isLoaded, (bool loaded) {
      if (loaded && !ShowcaseService.to.hasSeenTour && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ShowcaseView.getNamed(ShowcaseService.homeScope).startShowCase([
            ShowcaseService.to.drawerKey,
            ShowcaseService.to.searchKey,
            ShowcaseService.to.themeKey,
            ShowcaseService.to.yearSelectionKey,
            ShowcaseService.to.salesKey,
            ShowcaseService.to.purchaseKey,
          ]);
        });
      }
    });

    // Check if data was already loaded (in case ever doesn't trigger for initial true)
    if (homeController.isLoaded.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!ShowcaseService.to.hasSeenTour && mounted) {
          ShowcaseView.getNamed(ShowcaseService.homeScope).startShowCase([
            ShowcaseService.to.drawerKey,
            ShowcaseService.to.searchKey,
            ShowcaseService.to.themeKey,
            ShowcaseService.to.yearSelectionKey,
            ShowcaseService.to.salesKey,
            ShowcaseService.to.purchaseKey,
          ]);
        }
      });
    }
  }

  @override
  void dispose() {
    ShowcaseView.getNamed(ShowcaseService.homeScope).unregister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sync the current scope to this page to ensure shared widgets (QuickAction)
    // find the correct tour controllers during rebuilds or back-navigation.
    sp.ShowcaseService.instance.updateCurrentScope(ShowcaseService.homeScope);

    final homeController = Get.find<HomeController>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        QuitConfirmationDialog.show();
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: const DefAppBar(),
          drawer: const AppDrawer(),
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
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: Container(
                                //         decoration: BoxDecoration(
                                //           border: Border.all(color: Colors.grey),
                                //           borderRadius: BorderRadius.circular(8),
                                //         ),
                                //         child: const Row(
                                //           children: [
                                //             Gap(10),
                                //             Expanded(
                                //               child: Text(
                                //                 "Select Location",
                                //                 overflow: TextOverflow.ellipsis,
                                //               ),
                                //             ),
                                //             IconButton(
                                //               onPressed: null,
                                //               icon: Icon(
                                //                 PhosphorIconsLight.caretDown,
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //     Gap(Sizes.smallSpace),
                                //     Expanded(
                                //       child: Container(
                                //         decoration: BoxDecoration(
                                //           border: Border.all(color: Colors.grey),
                                //           borderRadius: BorderRadius.circular(8),
                                //         ),
                                //         child: const Row(
                                //           children: [
                                //             Gap(10),
                                //             Expanded(
                                //               child: Text(
                                //                 "Select Channel",
                                //                 overflow: TextOverflow.ellipsis,
                                //               ),
                                //             ),
                                //             IconButton(
                                //               onPressed: null,
                                //               icon: Icon(
                                //                 PhosphorIconsLight.caretDown,
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Gap(Sizes.defHorizontalSpace),
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
                                        AppBarChart(
                                          values: homeController
                                              .salesAndPurchaseGraph
                                              .map(
                                                (e) => [
                                                  e.sales,
                                                  e.salesReturn,
                                                  e.purchase,
                                                  e.purchaseReturn,
                                                ],
                                              )
                                              .toList(),
                                          labels: homeController
                                              .salesAndPurchaseGraph
                                              .map((e) => e.date)
                                              .toList(),
                                          labelFormatter: _formatChartDate,
                                          colors: [
                                            context.appColors.sectionSell,
                                            Colors.redAccent,
                                            context
                                                .appColors
                                                .sectionSellPurchase,
                                            Colors.orangeAccent,
                                          ],
                                          seriesNames: const [
                                            'Sales',
                                            'Sales Return',
                                            'Purchase',
                                            'Purchase Return',
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
                                            homeController
                                                .getTransactionGraph();
                                          },
                                        ),
                                        const Gap(8),
                                        Obx(
                                          () => CustomDropdown(
                                            label: 'Type',
                                            isFilter: true,
                                            items: homeController
                                                .transactionGraphTypes
                                                .map((e) => e.capitalizeFirst!)
                                                .toList(),
                                            value: homeController
                                                .transactionGraphType
                                                .value
                                                .capitalizeFirst,
                                            onChanged: (value) {
                                              homeController
                                                  .transactionGraphType
                                                  .value = value
                                                  .toLowerCase();
                                              homeController
                                                  .getTransactionGraph();
                                            },
                                          ),
                                        ),
                                        Gap(Sizes.lgHorizontalSpace),
                                        AppBarChart(
                                          values: homeController
                                              .transactionGraph
                                              .map(
                                                (e) => [
                                                  e.cash,
                                                  e.upi,
                                                  e.bank,
                                                  e.card,
                                                  e.cheque,
                                                  e.other,
                                                ],
                                              )
                                              .toList(),
                                          labels: homeController
                                              .transactionGraph
                                              .map((e) => e.date)
                                              .toList(),
                                          labelFormatter: _formatChartDate,
                                          colors: const [
                                            Colors.green,
                                            Colors.blue,
                                            Colors.orange,
                                            Colors.purple,
                                            Colors.teal,
                                            Colors.grey,
                                          ],
                                          seriesNames: const [
                                            'Cash',
                                            'UPI',
                                            'Bank',
                                            'Card',
                                            'Cheque',
                                            'Other',
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

  String _formatChartDate(String rawDate, double visibleRange) {
    final date = DateTime.tryParse(rawDate);
    if (date == null) return rawDate;

    if (visibleRange >= 300) {
      return DateFormat('MMM yy').format(date);
    } else if (visibleRange > 180) {
      return DateFormat('d MMM yy').format(date);
    } else {
      return DateFormat('d MMM').format(date);
    }
  }
}
