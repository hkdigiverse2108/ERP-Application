import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class ExpenseModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final ExpenseCreatedBy? createdBy;
  final String updatedBy;
  final IdNameModel? companyId;
  final double amount;
  final String? image;
  final String? description;
  final bool isSalary;
  final ExpenseParty? partyId;
  final String type;
  final DateTime fromDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final IdNameModel? branchId;
  final double? incentive;
  final DateTime? toDate;
  final double? total;

  const ExpenseModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    required this.updatedBy,
    this.companyId,
    required this.amount,
    this.image,
    this.description,
    required this.isSalary,
    this.partyId,
    required this.type,
    required this.fromDate,
    required this.createdAt,
    required this.updatedAt,
    this.branchId,
    this.incentive,
    this.toDate,
    this.total,
  });

  ExpenseModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    ExpenseCreatedBy? createdBy,
    String? updatedBy,
    IdNameModel? companyId,
    double? amount,
    String? image,
    String? description,
    bool? isSalary,
    ExpenseParty? partyId,
    String? type,
    DateTime? fromDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    IdNameModel? branchId,
    double? incentive,
    DateTime? toDate,
    double? total,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      amount: amount ?? this.amount,
      image: image ?? this.image,
      description: description ?? this.description,
      isSalary: isSalary ?? this.isSalary,
      partyId: partyId ?? this.partyId,
      type: type ?? this.type,
      fromDate: fromDate ?? this.fromDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      branchId: branchId ?? this.branchId,
      incentive: incentive ?? this.incentive,
      toDate: toDate ?? this.toDate,
      total: total ?? this.total,
    );
  }

  factory ExpenseModel.fromJson(String json) =>
      ExpenseModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory ExpenseModel.fromMap(Map<String, dynamic> map) => ExpenseModel(
        id: map["_id"]?.toString() ?? "",
        isDeleted: map["isDeleted"] as bool? ?? false,
        isActive: map["isActive"] as bool? ?? true,
        createdBy: map["createdBy"] == null
            ? null
            : ExpenseCreatedBy.fromMap(map["createdBy"] as Map<String, dynamic>),
        updatedBy: map["updatedBy"]?.toString() ?? "",
        companyId: map["companyId"] == null
            ? null
            : IdNameModel.fromMap(map["companyId"]),
        amount: (map["amount"] as num? ?? 0).toDouble(),
        image: map["image"]?.toString(),
        description: map["description"]?.toString(),
        isSalary: map["isSalary"] as bool? ?? false,
        partyId: map["partyId"] == null
            ? null
            : ExpenseParty.fromMap(map["partyId"] as Map<String, dynamic>),
        type: map["type"]?.toString() ?? "",
        fromDate: map["fromDate"] != null
            ? DateTime.parse(map["fromDate"].toString())
            : DateTime.now(),
        createdAt: map["createdAt"] != null
            ? DateTime.parse(map["createdAt"].toString())
            : DateTime.now(),
        updatedAt: map["updatedAt"] != null
            ? DateTime.parse(map["updatedAt"].toString())
            : DateTime.now(),
        branchId: map["branchId"] == null
            ? null
            : IdNameModel.fromMap(map["branchId"]),
        incentive: (map["incentive"] as num?)?.toDouble(),
        toDate: map["toDate"] != null
            ? DateTime.parse(map["toDate"].toString())
            : null,
        total: (map["total"] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy?.toMap(),
        "updatedBy": updatedBy,
        "companyId": companyId?.toMap(),
        "amount": amount,
        "image": image,
        "description": description,
        "isSalary": isSalary,
        "partyId": partyId?.toMap(),
        "type": type,
        "fromDate": fromDate.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "branchId": branchId?.toMap(),
        "incentive": incentive,
        "toDate": toDate?.toIso8601String(),
        "total": total,
      };

  @override
  List<Object?> get props => [
        id,
        isDeleted,
        isActive,
        createdBy,
        updatedBy,
        companyId,
        amount,
        image,
        description,
        isSalary,
        partyId,
        type,
        fromDate,
        createdAt,
        updatedAt,
        branchId,
        incentive,
        toDate,
        total,
      ];

  @override
  bool get stringify => true;
}

class ExpenseCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const ExpenseCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  ExpenseCreatedBy copyWith({
    String? id,
    String? fullName,
    String? userType,
  }) {
    return ExpenseCreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory ExpenseCreatedBy.fromJson(String json) =>
      ExpenseCreatedBy.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory ExpenseCreatedBy.fromMap(Map<String, dynamic> map) => ExpenseCreatedBy(
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

class ExpenseParty extends Equatable {
  final String id;
  final String fullName;

  const ExpenseParty({required this.id, required this.fullName});

  ExpenseParty copyWith({String? id, String? fullName}) {
    return ExpenseParty(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
    );
  }

  factory ExpenseParty.fromJson(String json) =>
      ExpenseParty.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory ExpenseParty.fromMap(Map<String, dynamic> map) => ExpenseParty(
        id: map["_id"]?.toString() ?? "",
        fullName: map["fullName"]?.toString() ?? "",
      );

  Map<String, dynamic> toMap() => {"_id": id, "fullName": fullName};

  @override
  List<Object?> get props => [id, fullName];

  @override
  bool get stringify => true;
}
