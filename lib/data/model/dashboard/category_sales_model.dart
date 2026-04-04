import 'dart:convert';

class CategorySalesModel {
  final String id;
  final String categoryName;
  final int noOfBills;
  final int totalSalesQty;
  final double totalSalesValue;
  final double totalProfit;
  final double salesPercentage;

  CategorySalesModel({
    required this.id,
    required this.categoryName,
    required this.noOfBills,
    required this.totalSalesQty,
    required this.totalSalesValue,
    required this.totalProfit,
    required this.salesPercentage,
  });

  factory CategorySalesModel.empty() => CategorySalesModel(
    id: '',
    categoryName: '',
    noOfBills: 0,
    totalSalesQty: 0,
    totalSalesValue: 0,
    totalProfit: 0,
    salesPercentage: 0,
  );

  factory CategorySalesModel.fromRawJson(String str) =>
      CategorySalesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategorySalesModel.fromJson(Map<String, dynamic> json) =>
      CategorySalesModel(
        id: json["_id"],
        categoryName: json["categoryName"],
        noOfBills: json["noOfBills"],
        totalSalesQty: json["totalSalesQty"],
        totalSalesValue: json["totalSalesValue"]?.toDouble(),
        totalProfit: json["totalProfit"]?.toDouble(),
        salesPercentage: json["salesPercentage"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "categoryName": categoryName,
    "noOfBills": noOfBills,
    "totalSalesQty": totalSalesQty,
    "totalSalesValue": totalSalesValue,
    "totalProfit": totalProfit,
    "salesPercentage": salesPercentage,
  };
}
