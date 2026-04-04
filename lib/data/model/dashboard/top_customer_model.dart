import 'dart:convert';

class TopCustomerModel {
  final int noOfBill;
  final double salesValue;
  final CustomerId customerId;

  TopCustomerModel({
    required this.noOfBill,
    required this.salesValue,
    required this.customerId,
  });

  factory TopCustomerModel.fromRawJson(String str) =>
      TopCustomerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopCustomerModel.fromJson(Map<String, dynamic> json) =>
      TopCustomerModel(
        noOfBill: json["noOfBill"] ?? 0,
        salesValue: json["salesValue"]?.toDouble() ?? 0,
        customerId: CustomerId.fromJson(json["customerId"]),
      );

  Map<String, dynamic> toJson() => {
    "noOfBill": noOfBill,
    "salesValue": salesValue,
    "customerId": customerId.toJson(),
  };
}

class CustomerId {
  final String id;
  final String name;

  CustomerId({required this.id, required this.name});

  factory CustomerId.fromRawJson(String str) =>
      CustomerId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerId.fromJson(Map<String, dynamic> json) =>
      CustomerId(id: json["_id"], name: json["name"] ?? "Unknown Customer");

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}
