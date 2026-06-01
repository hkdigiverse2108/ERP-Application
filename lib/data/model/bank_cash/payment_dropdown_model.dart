import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';

class PendingPaymentDropdownModel extends Equatable {
  final String id;
  final String name;
  final String docNo;
  final String docType;
  final double paidAmount;
  final double balanceAmount;
  final String customerId;

  const PendingPaymentDropdownModel({
    required this.id,
    required this.name,
    required this.docNo,
    required this.docType,
    required this.paidAmount,
    required this.balanceAmount,
    required this.customerId,
  });

  PendingPaymentDropdownModel copyWith({
    String? id,
    String? name,
    String? docNo,
    String? docType,
    double? paidAmount,
    double? balanceAmount,
    String? customerId,
  }) {
    return PendingPaymentDropdownModel(
      id: id ?? this.id,
      name: name ?? this.name,
      docNo: docNo ?? this.docNo,
      docType: docType ?? this.docType,
      paidAmount: paidAmount ?? this.paidAmount,
      balanceAmount: balanceAmount ?? this.balanceAmount,
      customerId: customerId ?? this.customerId,
    );
  }

  factory PendingPaymentDropdownModel.fromJson(String json) =>
      PendingPaymentDropdownModel.fromMap(
        jsonDecode(json) as Map<String, dynamic>,
      );

  String toJson() => jsonEncode(toMap());

  factory PendingPaymentDropdownModel.fromMap(Map<String, dynamic> map) =>
      PendingPaymentDropdownModel(
        id: map["_id"]?.toString() ?? "",
        name: map["name"]?.toString() ?? "",
        docNo: map["docNo"]?.toString() ?? "",
        docType: map["docType"]?.toString() ?? "",
        paidAmount: (map["paidAmount"] as num? ?? 0).toDouble(),
        balanceAmount: (map["balanceAmount"] as num? ?? 0).toDouble(),
        customerId: map["customerId"]?.toString() ?? "",
      );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
    "docNo": docNo,
    "docType": docType,
    "paidAmount": paidAmount,
    "balanceAmount": balanceAmount,
    "customerId": customerId,
  };

  @override
  List<Object?> get props => [
    id,
    name,
    docNo,
    docType,
    paidAmount,
    balanceAmount,
    customerId,
  ];

  @override
  bool get stringify => true;
}

class PendingCreditDropdownModel extends Equatable {
  final String id;
  final String name;
  final String docNo;
  final String docType;
  final double totalAmount;
  final double balanceAmount;
  final String customerId;

  const PendingCreditDropdownModel({
    required this.id,
    required this.name,
    required this.docNo,
    required this.docType,
    required this.totalAmount,
    required this.balanceAmount,
    required this.customerId,
  });

  PendingCreditDropdownModel copyWith({
    String? id,
    String? name,
    String? docNo,
    String? docType,
    double? totalAmount,
    double? balanceAmount,
    String? customerId,
  }) {
    return PendingCreditDropdownModel(
      id: id ?? this.id,
      name: name ?? this.name,
      docNo: docNo ?? this.docNo,
      docType: docType ?? this.docType,
      totalAmount: totalAmount ?? this.totalAmount,
      balanceAmount: balanceAmount ?? this.balanceAmount,
      customerId: customerId ?? this.customerId,
    );
  }

  factory PendingCreditDropdownModel.fromJson(String json) =>
      PendingCreditDropdownModel.fromMap(
        jsonDecode(json) as Map<String, dynamic>,
      );

  String toJson() => jsonEncode(toMap());

  factory PendingCreditDropdownModel.fromMap(Map<String, dynamic> map) =>
      PendingCreditDropdownModel(
        id: map["_id"]?.toString() ?? "",
        name: map["name"]?.toString() ?? "",
        docNo: map["docNo"]?.toString() ?? "",
        docType: map["docType"]?.toString() ?? "",
        totalAmount: (map["totalAmount"] as num? ?? 0).toDouble(),
        balanceAmount: (map["balanceAmount"] as num? ?? 0).toDouble(),
        customerId: map["customerId"]?.toString() ?? "",
      );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
    "docNo": docNo,
    "docType": docType,
    "totalAmount": totalAmount,
    "balanceAmount": balanceAmount,
    "customerId": customerId,
  };

  @override
  List<Object?> get props => [
    id,
    name,
    docNo,
    docType,
    totalAmount,
    balanceAmount,
    customerId,
  ];

  @override
  bool get stringify => true;
}
