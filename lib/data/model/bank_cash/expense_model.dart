
class ExpenseModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final CompanyId companyId;
  final int amount;
  final String? image;
  final String? description;
  final bool isSalary;
  final PartyId partyId;
  final String type; // ✅ FIXED
  final DateTime fromDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BranchId branchId;
  final int? incentive;
  final DateTime? toDate;
  final int? total;

  ExpenseModel({
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
    required this.fromDate,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
    this.incentive,
    this.toDate,
    this.total,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json["_id"] ?? "",
      isDeleted: json["isDeleted"] ?? false,
      isActive: json["isActive"] ?? false,

      createdBy: json["createdBy"] != null
          ? CreatedBy.fromJson(json["createdBy"])
          : CreatedBy.empty(),

      updatedBy: json["updatedBy"] ?? "",

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

      fromDate: json["fromDate"] != null
          ? DateTime.tryParse(json["fromDate"]) ?? DateTime.now()
          : DateTime.now(),

      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
          : DateTime.now(),

      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"]) ?? DateTime.now()
          : DateTime.now(),

      branchId: json["branchId"] is Map
          ? BranchId.fromJson(json["branchId"])
          : BranchId.empty(),

      incentive: json["incentive"] != null ? (json["incentive"]).toInt() : null,

      toDate: json["toDate"] != null ? DateTime.tryParse(json["toDate"]) : null,

      total: json["total"] != null ? (json["total"]).toInt() : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "amount": amount,
    "image": image,
    "description": description,
    "isSalary": isSalary,
    "partyId": partyId.toJson(),
    "type": type,
    "fromDate": fromDate.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "branchId": branchId.toJson(),
    "incentive": incentive,
    "toDate": toDate?.toIso8601String(),
    "total": total,
  };
}

class BranchId {
  final String id;
  final String name;

  BranchId({required this.id, required this.name});

  factory BranchId.fromJson(Map<String, dynamic> json) =>
      BranchId(id: json["_id"] ?? "", name: json["name"] ?? "");

  factory BranchId.empty() => BranchId(id: "", name: "");

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
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

class CreatedBy {
  final String id;
  final String fullName;
  final String userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["_id"] ?? "",
    fullName: json["fullName"] ?? "",
    userType: json["userType"] ?? "",
  );

  factory CreatedBy.empty() => CreatedBy(id: "", fullName: "", userType: "");

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
