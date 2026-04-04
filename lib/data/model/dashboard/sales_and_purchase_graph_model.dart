import 'dart:convert';

class SalesAndPurchaseGraphModel {
  final String date;
  final double sales;
  final double salesReturn;
  final double purchase;
  final double purchaseReturn;

  SalesAndPurchaseGraphModel({
    required this.date,
    required this.sales,
    required this.salesReturn,
    required this.purchase,
    required this.purchaseReturn,
  });

  factory SalesAndPurchaseGraphModel.empty() => SalesAndPurchaseGraphModel(
    date: '',
    sales: 0,
    salesReturn: 0,
    purchase: 0,
    purchaseReturn: 0,
  );

  factory SalesAndPurchaseGraphModel.fromRawJson(String str) =>
      SalesAndPurchaseGraphModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesAndPurchaseGraphModel.fromJson(Map<String, dynamic> json) =>
      SalesAndPurchaseGraphModel(
        date: json["date"],
        sales: json["sales"]?.toDouble(),
        salesReturn: json["salesReturn"]?.toDouble(),
        purchase: json["purchase"]?.toDouble(),
        purchaseReturn: json["purchaseReturn"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "date": date,
    "sales": sales,
    "salesReturn": salesReturn,
    "purchase": purchase,
    "purchaseReturn": purchaseReturn,
  };
}
