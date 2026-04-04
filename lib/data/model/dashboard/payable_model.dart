import 'dart:convert';

class PayableModel {
  final String id;
  final String supplierName;
  final String billNo;
  final double pendingAmount;
  final DateTime date;

  PayableModel({
    required this.id,
    required this.supplierName,
    required this.billNo,
    required this.pendingAmount,
    required this.date,
  });

  factory PayableModel.empty() => PayableModel(
    id: '',
    supplierName: '',
    billNo: '',
    pendingAmount: 0,
    date: DateTime.now(),
  );

  factory PayableModel.fromRawJson(String str) =>
      PayableModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PayableModel.fromJson(Map<String, dynamic> json) => PayableModel(
    id: json["_id"] ?? '',
    supplierName: json["supplierName"] ?? '',
    billNo: json["billNo"] ?? '-',
    pendingAmount: json["pendingAmount"]?.toDouble() ?? 0.0,
    date: json["date"] != null ? DateTime.parse(json["date"]) : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "supplierName": supplierName,
    "billNo": billNo,
    "pendingAmount": pendingAmount,
    "date": date.toIso8601String(),
  };
}
