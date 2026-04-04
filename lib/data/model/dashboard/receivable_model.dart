import 'dart:convert';

class ReceivableModel {
  final String id;
  final String customerName;
  final String invoiceNo;
  final double pendingAmount;
  final DateTime date;
  final String type;

  ReceivableModel({
    required this.id,
    required this.customerName,
    required this.invoiceNo,
    required this.pendingAmount,
    required this.date,
    required this.type,
  });

  factory ReceivableModel.empty() => ReceivableModel(
    id: '',
    customerName: '',
    invoiceNo: '',
    pendingAmount: 0,
    date: DateTime.now(),
    type: '',
  );

  factory ReceivableModel.fromRawJson(String str) =>
      ReceivableModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReceivableModel.fromJson(Map<String, dynamic> json) =>
      ReceivableModel(
        id: json["_id"] ?? '',
        customerName: json["customerName"] ?? '',
        invoiceNo: json["invoiceNo"] ?? '-',
        pendingAmount: json["pendingAmount"]?.toDouble() ?? 0.0,
        date: json["date"] != null
            ? DateTime.parse(json["date"])
            : DateTime.now(),
        type: json["type"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customerName": customerName,
    "invoiceNo": invoiceNo,
    "pendingAmount": pendingAmount,
    "date": date.toIso8601String(),
    "type": type,
  };
}
