import 'dart:convert';

class CategoryWiseCustomersModel {
  final String id;
  final double totalPurchaseValue;
  final int noOfBill;
  final String name;
  final int contactNo;
  final String customerType;
  final String category;

  CategoryWiseCustomersModel({
    required this.id,
    required this.totalPurchaseValue,
    required this.noOfBill,
    required this.name,
    required this.contactNo,
    required this.customerType,
    required this.category,
  });

  factory CategoryWiseCustomersModel.empty() => CategoryWiseCustomersModel(
    id: '',
    totalPurchaseValue: 0,
    noOfBill: 0,
    name: '',
    contactNo: 0,
    customerType: '',
    category: '',
  );

  factory CategoryWiseCustomersModel.fromRawJson(String str) =>
      CategoryWiseCustomersModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryWiseCustomersModel.fromJson(Map<String, dynamic> json) =>
      CategoryWiseCustomersModel(
        id: json["_id"],
        totalPurchaseValue: json["totalPurchaseValue"]?.toDouble(),
        noOfBill: json["noOfBill"],
        name: json["name"],
        contactNo: json["contactNo"],
        customerType: json["customerType"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "totalPurchaseValue": totalPurchaseValue,
    "noOfBill": noOfBill,
    "name": name,
    "contactNo": contactNo,
    "customerType": customerType,
    "category": category,
  };
}
