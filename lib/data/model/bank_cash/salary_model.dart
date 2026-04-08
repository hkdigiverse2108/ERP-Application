import 'dart:convert';

class SalaryModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final AtedBy createdBy;
  final AtedBy updatedBy;
  final CompanyId companyId;
  final int amount;
  final String? image;
  final String? description;
  final bool isSalary;
  final PartyId partyId;
  final String type;
  final int incentive;
  final DateTime fromDate;
  final DateTime toDate;
  final int total;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String branchId;

  SalaryModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.amount,
    this.image,
    this.description,
    required this.isSalary,
    required this.partyId,
    required this.type,
    required this.incentive,
    required this.fromDate,
    required this.toDate,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
  });

  factory SalaryModel.fromJson(Map<String, dynamic> json) {
    return SalaryModel(
      id: json["_id"] ?? "",

      isDeleted: json["isDeleted"] ?? false,
      isActive: json["isActive"] ?? false,

      createdBy: json["createdBy"] != null
          ? AtedBy.fromJson(json["createdBy"])
          : AtedBy.empty(),

      updatedBy: json["updatedBy"] != null
          ? AtedBy.fromJson(json["updatedBy"])
          : AtedBy.empty(),

      companyId: json["companyId"] != null
          ? CompanyId.fromJson(json["companyId"])
          : CompanyId.empty(),

      amount: (json["amount"] ?? 0).toInt(),

      image: json["image"],
      description: json["description"],

      isSalary: json["isSalary"] ?? false,

      partyId: json["partyId"] != null
          ? PartyId.fromJson(json["partyId"])
          : PartyId.empty(),

      type: json["type"] ?? "",

      incentive: (json["incentive"] ?? 0).toInt(),

      fromDate: json["fromDate"] != null
          ? DateTime.tryParse(json["fromDate"]) ?? DateTime.now()
          : DateTime.now(),

      toDate: json["toDate"] != null
          ? DateTime.tryParse(json["toDate"]) ?? DateTime.now()
          : DateTime.now(),

      total: (json["total"] ?? 0).toInt(),

      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
          : DateTime.now(),

      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"]) ?? DateTime.now()
          : DateTime.now(),

      branchId: json["branchId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy.toJson(),
    "companyId": companyId.toJson(),
    "amount": amount,
    "image": image,
    "description": description,
    "isSalary": isSalary,
    "partyId": partyId.toJson(),
    "type": type,
    "incentive": incentive,
    "fromDate": fromDate.toIso8601String(),
    "toDate": toDate.toIso8601String(),
    "total": total,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "branchId": branchId,
  };
}

class CompanyId {
  final String id;
  final String name;

  CompanyId({required this.id, required this.name});

  factory CompanyId.fromJson(Map<String, dynamic> json) =>
      CompanyId(id: json["_id"] ?? "", name: json["name"] ?? "");

  factory CompanyId.empty() => CompanyId(id: "", name: "");

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

class AtedBy {
  final String id;
  final String fullName;
  final String userType;

  AtedBy({required this.id, required this.fullName, required this.userType});

  factory AtedBy.fromJson(Map<String, dynamic> json) => AtedBy(
    id: json["_id"] ?? "",
    fullName: json["fullName"] ?? "",
    userType: json["userType"] ?? "",
  );

  factory AtedBy.empty() => AtedBy(id: "", fullName: "", userType: "");

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };
}

class PartyId {
  final String id;
  final String fullName;

  PartyId({required this.id, required this.fullName});

  factory PartyId.fromJson(Map<String, dynamic> json) =>
      PartyId(id: json["_id"] ?? "", fullName: json["fullName"] ?? "");

  factory PartyId.empty() => PartyId(id: "", fullName: "");

  Map<String, dynamic> toJson() => {"_id": id, "fullName": fullName};
}
