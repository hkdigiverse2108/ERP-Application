import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class BankTransactionModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final BankTransactionUser? createdBy;
  final BankTransactionUser? updatedBy;
  final IdNameModel? companyId;
  final dynamic branchId;
  final String voucherNo;
  final DateTime transactionDate;
  final String transactionType;
  final IdNameModel? fromAccount;
  final IdNameModel? toAccount;
  final double amount;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BankTransactionModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    this.branchId,
    required this.voucherNo,
    required this.transactionDate,
    required this.transactionType,
    this.fromAccount,
    this.toAccount,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  BankTransactionModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    BankTransactionUser? createdBy,
    BankTransactionUser? updatedBy,
    IdNameModel? companyId,
    dynamic branchId,
    String? voucherNo,
    DateTime? transactionDate,
    String? transactionType,
    IdNameModel? fromAccount,
    IdNameModel? toAccount,
    double? amount,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BankTransactionModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      branchId: branchId ?? this.branchId,
      voucherNo: voucherNo ?? this.voucherNo,
      transactionDate: transactionDate ?? this.transactionDate,
      transactionType: transactionType ?? this.transactionType,
      fromAccount: fromAccount ?? this.fromAccount,
      toAccount: toAccount ?? this.toAccount,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory BankTransactionModel.fromJson(String json) =>
      BankTransactionModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory BankTransactionModel.fromMap(
    Map<String, dynamic> map,
  ) => BankTransactionModel(
    id: map["_id"]?.toString() ?? "",
    isDeleted: map["isDeleted"] as bool? ?? false,
    isActive: map["isActive"] as bool? ?? true,
    createdBy: map["createdBy"] == null
        ? null
        : BankTransactionUser.fromMap(map["createdBy"] as Map<String, dynamic>),
    updatedBy: map["updatedBy"] == null
        ? null
        : BankTransactionUser.fromMap(map["updatedBy"] as Map<String, dynamic>),
    companyId: map["companyId"] == null
        ? null
        : IdNameModel.fromMap(map["companyId"]),
    branchId: map["branchId"],
    voucherNo: map["voucherNo"]?.toString() ?? "",
    transactionDate: map["transactionDate"] != null
        ? DateTime.parse(map["transactionDate"].toString())
        : DateTime.now(),
    transactionType: map["transactionType"]?.toString() ?? "",
    fromAccount: map["fromAccount"] == null
        ? null
        : IdNameModel.fromMap(map["fromAccount"]),
    toAccount: map["toAccount"] == null
        ? null
        : IdNameModel.fromMap(map["toAccount"]),
    amount: (map["amount"] as num? ?? 0).toDouble(),
    description: map["description"]?.toString() ?? "",
    createdAt: map["createdAt"] != null
        ? DateTime.parse(map["createdAt"].toString())
        : DateTime.now(),
    updatedAt: map["updatedAt"] != null
        ? DateTime.parse(map["updatedAt"].toString())
        : DateTime.now(),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy?.toMap(),
    "updatedBy": updatedBy?.toMap(),
    "companyId": companyId?.toMap(),
    "branchId": branchId,
    "voucherNo": voucherNo,
    "transactionDate": transactionDate.toIso8601String(),
    "transactionType": transactionType,
    "fromAccount": fromAccount?.toMap(),
    "toAccount": toAccount?.toMap(),
    "amount": amount,
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };

  @override
  List<Object?> get props => [
    id,
    isDeleted,
    isActive,
    createdBy,
    updatedBy,
    companyId,
    branchId,
    voucherNo,
    transactionDate,
    transactionType,
    fromAccount,
    toAccount,
    amount,
    description,
    createdAt,
    updatedAt,
  ];

  @override
  bool get stringify => true;
}

class BankTransactionUser extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const BankTransactionUser({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  BankTransactionUser copyWith({
    String? id,
    String? fullName,
    String? userType,
  }) {
    return BankTransactionUser(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory BankTransactionUser.fromJson(String json) =>
      BankTransactionUser.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory BankTransactionUser.fromMap(Map<String, dynamic> map) =>
      BankTransactionUser(
        id: map["_id"]?.toString() ?? "",
        fullName: map["fullName"]?.toString() ?? "",
        userType: map["userType"]?.toString() ?? "",
      );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };

  @override
  List<Object?> get props => [id, fullName, userType];

  @override
  bool get stringify => true;
}
