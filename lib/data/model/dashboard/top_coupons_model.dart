import 'dart:convert';

class TopCouponsModel {
  final String id;
  final String name;
  final double totalDiscountGiven;
  final int usageCount;
  final int uniqueCustomersCount;

  TopCouponsModel({
    required this.id,
    required this.name,
    required this.totalDiscountGiven,
    required this.usageCount,
    required this.uniqueCustomersCount,
  });

  factory TopCouponsModel.empty() => TopCouponsModel(
    id: '',
    name: '',
    totalDiscountGiven: 0,
    usageCount: 0,
    uniqueCustomersCount: 0,
  );

  factory TopCouponsModel.fromRawJson(String str) =>
      TopCouponsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopCouponsModel.fromJson(Map<String, dynamic> json) =>
      TopCouponsModel(
        id: json["_id"],
        name: json["name"],
        totalDiscountGiven: json["totalDiscountGiven"]?.toDouble(),
        usageCount: json["usageCount"],
        uniqueCustomersCount: json["uniqueCustomersCount"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "totalDiscountGiven": totalDiscountGiven,
    "usageCount": usageCount,
    "uniqueCustomersCount": uniqueCustomersCount,
  };
}
