import 'dart:convert';

class TopExpensesModel {
  final String id;
  final String accountName;
  final double totalAmount;
  final int expenseCount;

  TopExpensesModel({
    required this.id,
    required this.accountName,
    required this.totalAmount,
    required this.expenseCount,
  });

  factory TopExpensesModel.empty() => TopExpensesModel(
    id: '',
    accountName: '',
    totalAmount: 0,
    expenseCount: 0,
  );

  factory TopExpensesModel.fromRawJson(String str) =>
      TopExpensesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopExpensesModel.fromJson(Map<String, dynamic> json) =>
      TopExpensesModel(
        id: json["_id"],
        accountName: json["accountName"],
        totalAmount: json["totalAmount"]?.toDouble(),
        expenseCount: json["expenseCount"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "accountName": accountName,
    "totalAmount": totalAmount,
    "expenseCount": expenseCount,
  };
}
