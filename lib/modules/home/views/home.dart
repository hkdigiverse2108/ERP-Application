import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/model/category_model.dart';
import 'package:ai_setu/data/model/coupons_model.dart';
import 'package:ai_setu/data/model/customers_model.dart';
import 'package:ai_setu/data/model/expenses_model.dart';
import 'package:ai_setu/data/model/login_log_model.dart';
import 'package:ai_setu/data/model/payable_model.dart';
import 'package:ai_setu/modules/home/controllers/home_controller.dart';
import 'package:ai_setu/modules/home/widgets/dashboard_stat_widget.dart';
import 'package:ai_setu/modules/home/widgets/report_section.dart';
import 'package:ai_setu/modules/home/widgets/report_cart.dart';
import 'package:ai_setu/shared/quick_action/views/quick_action.dart';
import 'package:ai_setu/data/model/product_item_model.dart';
import 'package:ai_setu/shared/widgets/appbar.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:ai_setu/shared/widgets/charts/app_bar_chart.dart';
import 'package:ai_setu/shared/widgets/date_section.dart';
import 'package:ai_setu/shared/widgets/table/common_table.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const DefAppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QuickAction(),

              // Main Filtering and Dashboard Stats
              Padding(
                padding: const EdgeInsets.all(Sizes.paddingM),
                child: BorderContainer(
                  child: Column(
                    children: [
                      _buildMainFilters(),
                      const Gap(Sizes.defHorizontalSpace),
                      Obx(
                        () => RangedDatePicker(
                          initialDateRange:
                              homeController.selectedDateRange.value,
                          onChanged: (range) =>
                              homeController.selectedDateRange.value = range,
                        ),
                      ),
                      const Gap(Sizes.defHorizontalSpace),
                      const DashboardStatWidget(),
                    ],
                  ),
                ),
              ),

              ReportSection(
                title: 'Sales and Purchase',
                initialDateRange: homeController.selectedDateRange,
                onDateChanged: (range) =>
                    homeController.selectedDateRange.value = range,
                child: const AppBarChart(
                  values: [45, 80, 65, 30, 90, 50, 70],
                  labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                ),
              ),

              ReportSection(
                title: 'Transaction',
                initialDateRange: homeController.selectedDateRange,
                onDateChanged: (range) =>
                    homeController.selectedDateRange.value = range,
                child: const AppBarChart(
                  values: [15, 50, 25, 10, 40, 50, 50, 90],
                  labels: [
                    '1 Mar',
                    '5 Mar',
                    '10 Mar',
                    '15 Mar',
                    '20 Mar',
                    '25 Mar',
                    '28 Mar',
                    '31 Mar',
                  ],
                ),
              ),

              ReportSection(
                title: 'Top Selling Items',
                initialDateRange: homeController.selectedDateRange,
                onDateChanged: (range) =>
                    homeController.selectedDateRange.value = range,
                child: CommonTable<ProductItemModel>(
                  items: [
                    ProductItemModel(
                      name: 'Wireless Mouse',
                      sku: 'MS-001',
                      price: 500,
                      quantity: 2,
                      discount: 10,
                      tax: 18,
                    ),
                    ProductItemModel(
                      name: 'Mechanical Keyboard',
                      sku: 'KB-002',
                      price: 2500,
                      quantity: 1,
                      discount: 5,
                      tax: 18,
                    ),
                  ],
                  columns: _buildProductColumns(),
                  currentPage: homeController.currentPage.value,
                  totalPages: 5,
                  totalItems: 43,
                  onPageChanged: (page) =>
                      homeController.currentPage.value = page,
                ),
              ),

              ReportSection(
                title: 'Top 05 Customers',
                initialDateRange: homeController.selectedDateRange,
                onDateChanged: (range) =>
                    homeController.selectedDateRange.value = range,
                child: CommonTable<CustomersModel>(
                  items: [
                    CustomersModel(
                      customerName: 'Aman Gupta',
                      noofBill: '2',
                      totalAmount: '500',
                    ),
                    CustomersModel(
                      customerName: 'Rahul Sharma',
                      noofBill: '17',
                      totalAmount: '2500',
                    ),
                    CustomersModel(
                      customerName: 'Amit Shah',
                      noofBill: '11',
                      totalAmount: '2500',
                    ),
                    CustomersModel(
                      customerName: 'Riya',
                      noofBill: '15',
                      totalAmount: '2500',
                    ),
                    CustomersModel(
                      customerName: 'Priya',
                      noofBill: '5',
                      totalAmount: '2500',
                    ),
                  ],
                  columns: _buildCustomerColumns(),
                  currentPage: homeController.currentPage.value,
                  totalPages: 5,
                  totalItems: 43,
                  onPageChanged: (page) =>
                      homeController.currentPage.value = page,
                ),
              ),

              const ReportSection(
                title: "Customer Report",
                child: ReportCart(),
              ),

              ReportSection(
                title: "Category Sales",
                initialDateRange: homeController.selectedDateRange,
                onDateChanged: (range) =>
                    homeController.selectedDateRange.value = range,
                child: CommonTable<CategoryModel>(
                  items: _buildMockCategories(),
                  columns: _buildCategoryColumns(),
                  currentPage: homeController.currentPage.value,
                  totalPages: 5,
                  totalItems: 43,
                  onPageChanged: (page) =>
                      homeController.currentPage.value = page,
                ),
              ),

              // Reusing CategoryModel and columns for Best/Least selling since they follow same structure in the original request
              ReportSection(
                title: 'Best Selling Product',
                initialDateRange: homeController.selectedDateRange,
                onDateChanged: (range) =>
                    homeController.selectedDateRange.value = range,
                child: CommonTable<CategoryModel>(
                  items: _buildMockCategories(),
                  columns: _buildCategoryColumns(),
                  currentPage: homeController.currentPage.value,
                  totalPages: 5,
                  totalItems: 43,
                  onPageChanged: (page) =>
                      homeController.currentPage.value = page,
                ),
              ),

              ReportSection(
                title: 'Least Selling Products',
                initialDateRange: homeController.selectedDateRange,
                onDateChanged: (range) =>
                    homeController.selectedDateRange.value = range,
                child: CommonTable<CategoryModel>(
                  items: _buildMockCategories(),
                  columns: _buildCategoryColumns(),
                  currentPage: homeController.currentPage.value,
                  totalPages: 5,
                  totalItems: 43,
                  onPageChanged: (page) =>
                      homeController.currentPage.value = page,
                ),
              ),

              ReportSection(
                title: 'Top Expenses',
                initialDateRange: homeController.selectedDateRange,
                onDateChanged: (range) =>
                    homeController.selectedDateRange.value = range,
                child: CommonTable<ExpensesModel>(
                  items: [
                    ExpensesModel(
                      expensename: 'Electronics',
                      expansescount: '2',
                      expansesamount: '2500',
                    ),
                    ExpensesModel(
                      expensename: 'Clothing',
                      expansescount: '17',
                      expansesamount: '2500',
                    ),
                    ExpensesModel(
                      expensename: 'Books',
                      expansescount: '11',
                      expansesamount: '2500',
                    ),
                  ],
                  columns: _buildExpenseColumns(),
                  currentPage: homeController.currentPage.value,
                  totalPages: 5,
                  totalItems: 43,
                  onPageChanged: (page) =>
                      homeController.currentPage.value = page,
                ),
              ),

              ReportSection(
                title: 'Top Coupons',
                initialDateRange: homeController.selectedDateRange,
                onDateChanged: (range) =>
                    homeController.selectedDateRange.value = range,
                child: CommonTable<CouponsModel>(
                  items: [
                    CouponsModel(
                      couponname: 'Coupon 1',
                      noOfBills: '10',
                      uniqueCouponsCount: '5',
                      totalAmount: '1000',
                    ),
                    CouponsModel(
                      couponname: 'Coupon 2',
                      noOfBills: '20',
                      uniqueCouponsCount: '10',
                      totalAmount: '2000',
                    ),
                    CouponsModel(
                      couponname: 'Coupon 3',
                      noOfBills: '30',
                      uniqueCouponsCount: '15',
                      totalAmount: '3000',
                    ),
                  ],
                  columns: _buildCouponColumns(),
                  currentPage: homeController.currentPage.value,
                  totalPages: 5,
                  totalItems: 43,
                  onPageChanged: (page) =>
                      homeController.currentPage.value = page,
                ),
              ),

              ReportSection(
                title: "Today's Receivable",
                initialDateRange: homeController.selectedDateRange,
                onDateChanged: (range) =>
                    homeController.selectedDateRange.value = range,
                child: CommonTable<CustomersModel>(
                  items: [
                    CustomersModel(
                      customerName: 'Customer 1',
                      invoiceNo: '1234567890',
                      pendingAmount: '1000',
                    ),
                    CustomersModel(
                      customerName: 'Customer 2',
                      invoiceNo: '1234567890',
                      pendingAmount: '2000',
                    ),
                    CustomersModel(
                      customerName: 'Customer 3',
                      invoiceNo: '1234567890',
                      pendingAmount: '3000',
                    ),
                  ],
                  columns: _buildReceivableColumns(),
                  currentPage: homeController.currentPage.value,
                  totalPages: 5,
                  totalItems: 43,
                  onPageChanged: (page) =>
                      homeController.currentPage.value = page,
                ),
              ),

              ReportSection(
                title: "Today's Payable",
                initialDateRange: homeController.selectedDateRange,
                onDateChanged: (range) =>
                    homeController.selectedDateRange.value = range,
                child: CommonTable<PayableModel>(
                  items: [
                    PayableModel(
                      vendorName: 'Expense 1',
                      noOfBills: '10',
                      pendingAmount: '1000',
                    ),
                  ],
                  columns: _buildTodayPayableColumns(),
                  currentPage: homeController.currentPage.value,
                  totalPages: 5,
                  totalItems: 43,
                  onPageChanged: (page) =>
                      homeController.currentPage.value = page,
                ),
              ),

              ReportSection(
                title: "To Receivables",
                initialDateRange: homeController.selectedDateRange,
                onDateChanged: (range) =>
                    homeController.selectedDateRange.value = range,
                child: CommonTable<CustomersModel>(
                  items: [
                    CustomersModel(
                      customerName: 'Customer 1',
                      invoiceNo: '1234567890',
                      pendingAmount: '1000',
                      date: '2022-01-01',
                    ),
                  ],
                  columns: _buildToReceivablesColumns(),
                  currentPage: homeController.currentPage.value,
                  totalPages: 5,
                  totalItems: 43,
                  onPageChanged: (page) =>
                      homeController.currentPage.value = page,
                ),
              ),

              ReportSection(
                title: "To Pay",
                initialDateRange: homeController.selectedDateRange,
                onDateChanged: (range) =>
                    homeController.selectedDateRange.value = range,
                child: CommonTable<PayableModel>(
                  items: [
                    PayableModel(
                      vendorName: 'Customer 1',
                      pendingAmount: '1000',
                      date: '2022-01-01',
                    ),
                  ],
                  columns: _buildToPayColumns(),
                  currentPage: homeController.currentPage.value,
                  totalPages: 5,
                  totalItems: 43,
                  onPageChanged: (page) =>
                      homeController.currentPage.value = page,
                ),
              ),

              ReportSection(
                title: "Login Log",
                initialDateRange: homeController.selectedDateRange,
                onDateChanged: (range) =>
                    homeController.selectedDateRange.value = range,
                child: CommonTable<LoginLogModel>(
                  items: [
                    LoginLogModel(
                      userName: 'Customer 1',
                      date: '2022-01-01',
                      time: '12:00 PM',
                      device: 'Mobile',
                      ipAddress: '[IP_ADDRESS]',
                    ),
                  ],
                  columns: _buildLoginLogColumns(),
                  currentPage: homeController.currentPage.value,
                  totalPages: 5,
                  totalItems: 43,
                  onPageChanged: (page) =>
                      homeController.currentPage.value = page,
                ),
              ),

              const Gap(Sizes.lgVerticalSpace),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildMainFilters() {
    return Row(
      children: [
        _buildFilterDropdown("Select Location"),
        const Gap(Sizes.smallSpace),
        _buildFilterDropdown("Select Channel"),
      ],
    );
  }

  Widget _buildFilterDropdown(String hint) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Gap(10),
            Text(hint),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(PhosphorIconsLight.caretDown),
            ),
          ],
        ),
      ),
    );
  }

  // --- Table Column Builders ---

  List<TableColumn<ProductItemModel>> _buildProductColumns() {
    return [
      TableColumn(
        title: 'Item',
        width: 140,
        cellBuilder: (context, item, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (item.sku.isNotEmpty)
              Text(
                item.sku,
                style: TextHelper.caption,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
      TableColumn(
        title: 'Qty',
        width: 80,
        alignment: TextAlign.center,
        cellBuilder: (context, item, index) => Text(
          '${item.quantity} ${item.unit}',
          textAlign: TextAlign.center,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Price',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          '₹${item.price.toStringAsFixed(2)}',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Amount',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          '₹${item.subtotal.toStringAsFixed(2)}',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Discount',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.discount > 0 ? '${item.discount.toStringAsFixed(1)}%' : '-',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall.copyWith(
            color: item.discount > 0 ? AppColors.success : null,
          ),
        ),
      ),
      TableColumn(
        title: 'Tax',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.tax > 0 ? '${item.tax.toStringAsFixed(1)}%' : '-',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Total',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          '₹${item.total.toStringAsFixed(2)}',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    ];
  }

  List<TableColumn<CustomersModel>> _buildCustomerColumns() {
    return [
      TableColumn(
        title: 'Customer Name',
        width: 140,
        cellBuilder: (context, item, index) => Text(
          item.customerName ?? '',
          style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      TableColumn(
        title: 'No of Bill',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.noofBill ?? ' ',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Total Amount',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          '₹${item.totalAmount}',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    ];
  }

  List<TableColumn<CategoryModel>> _buildCategoryColumns() {
    return [
      TableColumn(
        title: 'Category Name',
        width: 140,
        cellBuilder: (context, item, index) => Text(
          item.categoryName,
          style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      TableColumn(
        title: 'No of Bill',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.noofBill,
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Sales Qty',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.salesQty,
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Sales Amount',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          '₹${item.salesAmount}',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      TableColumn(
        title: 'Profit',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          '₹${item.profit}',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      TableColumn(
        title: 'Sale %',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.salePer,
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
    ];
  }

  List<TableColumn<ExpensesModel>> _buildExpenseColumns() {
    return [
      TableColumn(
        title: 'Expense Name',
        width: 140,
        cellBuilder: (context, item, index) => Text(
          item.expensename,
          style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      TableColumn(
        title: 'Expense Count',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.expansescount,
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Expense Amount',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.expansesamount,
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
    ];
  }

  List<TableColumn<CouponsModel>> _buildCouponColumns() {
    return [
      TableColumn(
        title: 'Coupon Name',
        width: 140,
        cellBuilder: (context, item, index) => Text(
          item.couponname,
          style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      TableColumn(
        title: 'No of Bills',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.noOfBills,
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Unique Coupons Count',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.uniqueCouponsCount,
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Total Amount',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.totalAmount,
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
    ];
  }

  List<TableColumn<CustomersModel>> _buildReceivableColumns() {
    return [
      TableColumn(
        title: 'Customer Name',
        width: 140,
        cellBuilder: (context, item, index) => Text(
          item.customerName ?? '',
          style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      TableColumn(
        title: 'Invoice No',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.invoiceNo ?? '',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Pending Amount',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.pendingAmount ?? '',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
    ];
  }

  List<TableColumn<PayableModel>> _buildTodayPayableColumns() {
    return [
      TableColumn(
        title: 'Supplier Name',
        width: 140,
        cellBuilder: (context, item, index) => Text(
          item.vendorName ?? '',
          style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      TableColumn(
        title: 'bill No',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.noOfBills ?? '',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Pending Amount',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.pendingAmount ?? '',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
    ];
  }

  List<TableColumn<CustomersModel>> _buildToReceivablesColumns() {
    return [
      TableColumn(
        title: 'Customer Name',
        width: 140,
        cellBuilder: (context, item, index) => Text(
          item.customerName ?? '',
          style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      TableColumn(
        title: 'Date',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.date ?? '',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Invoice No',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.invoiceNo ?? '',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Pending Amount',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.pendingAmount ?? '',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
    ];
  }

  List<TableColumn<PayableModel>> _buildToPayColumns() {
    return [
      TableColumn(
        title: 'Supplier Name',
        width: 140,
        cellBuilder: (context, item, index) => Text(
          item.vendorName ?? '',
          style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      TableColumn(
        title: 'Date',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.date ?? '',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Pending Amount',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.pendingAmount ?? '',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
    ];
  }

  List<TableColumn<LoginLogModel>> _buildLoginLogColumns() {
    return [
      TableColumn(
        title: 'User Name',
        width: 140,
        cellBuilder: (context, item, index) => Text(
          item.userName ?? '',
          style: TextHelper.bodySmall.copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      TableColumn(
        title: 'Date',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.date ?? '',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Time',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.time ?? '',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'Device',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.device ?? '',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
      TableColumn(
        title: 'IP Address',
        width: 100,
        alignment: TextAlign.right,
        cellBuilder: (context, item, index) => Text(
          item.ipAddress ?? '',
          textAlign: TextAlign.right,
          style: TextHelper.bodySmall,
        ),
      ),
    ];
  }

  // --- Mock Data ---

  List<CategoryModel> _buildMockCategories() {
    return [
      CategoryModel(
        categoryName: 'Electronics',
        noofBill: '2',
        salesQty: '500',
        salesAmount: '2500',
        profit: '2500',
        salePer: '2500',
      ),
      CategoryModel(
        categoryName: 'Clothing',
        noofBill: '17',
        salesQty: '2500',
        salesAmount: '2500',
        profit: '2500',
        salePer: '2500',
      ),
      CategoryModel(
        categoryName: 'Books',
        noofBill: '11',
        salesQty: '2500',
        salesAmount: '2500',
        profit: '2500',
        salePer: '2500',
      ),
      CategoryModel(
        categoryName: 'Toys',
        noofBill: '15',
        salesQty: '2500',
        salesAmount: '2500',
        profit: '2500',
        salePer: '2500',
      ),
      CategoryModel(
        categoryName: 'Furniture',
        noofBill: '5',
        salesQty: '2500',
        salesAmount: '2500',
        profit: '2500',
        salePer: '2500',
      ),
    ];
  }
}
