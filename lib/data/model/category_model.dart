class CategoryModel {
  final String categoryName;
  final String noofBill;
  final String salesQty;
  final String salesAmount;
  final String profit;
  final String salePer;

  CategoryModel({
    required this.categoryName,
    required this.noofBill,
    required this.salesQty,
    required this.salesAmount,
    required this.profit,
    required this.salePer,
  });
  double get salesQtyAsDouble => double.parse(salesQty);
  double get salesAmountAsDouble => double.parse(salesAmount);
  double get profitAsDouble => double.parse(profit);
  double get salePerAsDouble => double.parse(salePer);
}
