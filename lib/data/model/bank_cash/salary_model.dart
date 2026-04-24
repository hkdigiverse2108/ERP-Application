import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class SalaryModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final SalaryUser? createdBy;
  final SalaryUser? updatedBy;
  final IdNameModel? companyId;
  final double amount;
  final String? image;
  final String? description;
  final bool isSalary;
  final SalaryParty? partyId;
  final String type;
  final double incentive;
  final DateTime fromDate;
  final DateTime toDate;
  final double total;
  final DateTime createdAt;
  final DateTime updatedAt;
  final IdNameModel branchId;

  const SalaryModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    required this.amount,
    this.image,
    this.description,
    required this.isSalary,
    this.partyId,
    required this.type,
    required this.incentive,
    required this.fromDate,
    required this.toDate,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
  });

  SalaryModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    SalaryUser? createdBy,
    SalaryUser? updatedBy,
    IdNameModel? companyId,
    double? amount,
    String? image,
    String? description,
    bool? isSalary,
    SalaryParty? partyId,
    String? type,
    double? incentive,
    DateTime? fromDate,
    DateTime? toDate,
    double? total,
    DateTime? createdAt,
    DateTime? updatedAt,
    IdNameModel? branchId,
  }) {
    return SalaryModel(
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
      incentive: incentive ?? this.incentive,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      branchId: branchId ?? this.branchId,
    );
  }

  factory SalaryModel.fromJson(String json) =>
      SalaryModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalaryModel.fromMap(Map<String, dynamic> map) {
    return SalaryModel(
      id: map["_id"]?.toString() ?? "",
      isDeleted: map["isDeleted"] as bool? ?? false,
      isActive: map["isActive"] as bool? ?? true,
      createdBy: map["createdBy"] == null
          ? null
          : SalaryUser.fromMap(map["createdBy"] as Map<String, dynamic>),
      updatedBy: map["updatedBy"] == null
          ? null
          : SalaryUser.fromMap(map["updatedBy"] as Map<String, dynamic>),
      companyId:
          map["companyId"] == null ? null : IdNameModel.fromMap(map["companyId"]),
      amount: (map["amount"] as num? ?? 0).toDouble(),
      image: map["image"]?.toString(),
      description: map["description"]?.toString(),
      isSalary: map["isSalary"] as bool? ?? false,
      partyId: map["partyId"] == null
          ? null
          : SalaryParty.fromMap(map["partyId"] as Map<String, dynamic>),
      type: map["type"]?.toString() ?? "",
      incentive: (map["incentive"] as num? ?? 0).toDouble(),
      fromDate: map["fromDate"] != null
          ? DateTime.parse(map["fromDate"].toString())
          : DateTime.now(),
      toDate: map["toDate"] != null
          ? DateTime.parse(map["toDate"].toString())
          : DateTime.now(),
      total: (map["total"] as num? ?? 0).toDouble(),
      createdAt: map["createdAt"] != null
          ? DateTime.parse(map["createdAt"].toString())
          : DateTime.now(),
      updatedAt: map["updatedAt"] != null
          ? DateTime.parse(map["updatedAt"].toString())
          : DateTime.now(),
      branchId: IdNameModel.fromMap(map["branchId"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy?.toMap(),
        "updatedBy": updatedBy?.toMap(),
        "companyId": companyId?.toMap(),
        "amount": amount,
        "image": image,
        "description": description,
        "isSalary": isSalary,
        "partyId": partyId?.toMap(),
        "type": type,
        "incentive": incentive,
        "fromDate": fromDate.toIso8601String(),
        "toDate": toDate.toIso8601String(),
        "total": total,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "branchId": branchId.toMap(),
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
        incentive,
        fromDate,
        toDate,
        total,
        createdAt,
        updatedAt,
        branchId,
      ];

  @override
  bool get stringify => true;
}

class SalaryUser extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const SalaryUser({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  SalaryUser copyWith({
    String? id,
    String? fullName,
    String? userType,
  }) {
    return SalaryUser(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory SalaryUser.fromJson(String json) =>
      SalaryUser.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalaryUser.fromMap(Map<String, dynamic> map) => SalaryUser(
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

class SalaryParty extends Equatable {
  final String id;
  final String fullName;

  const SalaryParty({required this.id, required this.fullName});

  SalaryParty copyWith({String? id, String? fullName}) {
    return SalaryParty(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
    );
  }

  factory SalaryParty.fromJson(String json) =>
      SalaryParty.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalaryParty.fromMap(Map<String, dynamic> map) => SalaryParty(
        id: map["_id"]?.toString() ?? "",
        fullName: map["fullName"]?.toString() ?? "",
      );

  Map<String, dynamic> toMap() => {"_id": id, "fullName": fullName};

  @override
  List<Object?> get props => [id, fullName];

  @override
  bool get stringify => true;
}
