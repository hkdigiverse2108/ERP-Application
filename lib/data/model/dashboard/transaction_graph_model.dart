import 'dart:convert';

class TransactionGraphModel {
  final String date;
  final double cash;
  final double bank;
  final double upi;
  final double card;
  final double cheque;
  final double other;

  TransactionGraphModel({
    required this.date,
    required this.cash,
    required this.bank,
    required this.upi,
    required this.card,
    required this.cheque,
    required this.other,
  });

  factory TransactionGraphModel.empty() => TransactionGraphModel(
    date: '',
    cash: 0,
    bank: 0,
    upi: 0,
    card: 0,
    cheque: 0,
    other: 0,
  );

  factory TransactionGraphModel.fromRawJson(String str) =>
      TransactionGraphModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionGraphModel.fromJson(Map<String, dynamic> json) =>
      TransactionGraphModel(
        date: json["date"],
        cash: (json["cash"] ?? 0).toDouble(),
        bank: (json["bank"] ?? 0).toDouble(),
        upi: (json["upi"] ?? 0).toDouble(),
        card: (json["card"] ?? 0).toDouble(),
        cheque: (json["cheque"] ?? 0).toDouble(),
        other: (json["other"] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "date": date,
    "cash": cash,
    "bank": bank,
    "upi": upi,
    "card": card,
    "cheque": cheque,
    "other": other,
  };
}
