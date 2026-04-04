import 'dart:convert';

// for both best and least selling products
class SellingsModel {
  final String id;
  final String productName;
  final int totalSalesQty;
  final double totalSalesValue;
  final int noOfBills;
  final double totalProfit;
  final double salesPercentage;

  SellingsModel({
    required this.id,
    required this.productName,
    required this.totalSalesQty,
    required this.totalSalesValue,
    required this.noOfBills,
    required this.totalProfit,
    required this.salesPercentage,
  });

  factory SellingsModel.empty() => SellingsModel(
    id: '',
    productName: '',
    totalSalesQty: 0,
    totalSalesValue: 0,
    noOfBills: 0,
    totalProfit: 0,
    salesPercentage: 0,
  );

  factory SellingsModel.fromRawJson(String str) =>
      SellingsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellingsModel.fromJson(Map<String, dynamic> json) => SellingsModel(
    id: json["_id"],
    productName: json["productName"],
    totalSalesQty: json["totalSalesQty"],
    totalSalesValue: json["totalSalesValue"]?.toDouble(),
    noOfBills: json["noOfBills"],
    totalProfit: json["totalProfit"]?.toDouble(),
    salesPercentage: json["salesPercentage"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productName": productName,
    "totalSalesQty": totalSalesQty,
    "totalSalesValue": totalSalesValue,
    "noOfBills": noOfBills,
    "totalProfit": totalProfit,
    "salesPercentage": salesPercentage,
  };
}
