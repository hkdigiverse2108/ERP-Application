import 'dart:convert';

class AdditionalChargeModel {
  final String id;
  final String type;
  final String name;
  final int defaultValue;
  final Id taxId;
  final bool isTaxIncluding;
  final String accountGroupId;
  final String? hsnSac;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final Id companyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Id? branchId;

  AdditionalChargeModel({
    required this.id,
    required this.type,
    required this.name,
    required this.defaultValue,
    required this.taxId,
    required this.isTaxIncluding,
    required this.accountGroupId,
    this.hsnSac,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
    this.branchId,
  });

  factory AdditionalChargeModel.fromRawJson(String str) =>
      AdditionalChargeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdditionalChargeModel.fromJson(
    Map<String, dynamic> json,
  ) => AdditionalChargeModel(
    id: json["_id"]?.toString() ?? "",
    type: json["type"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
    defaultValue: int.tryParse(json["defaultValue"]?.toString() ?? "0") ?? 0,
    taxId: Id.fromJson(json["taxId"]),
    isTaxIncluding:
        json["isTaxIncluding"] == true ||
        json["isTaxIncluding"]?.toString() == "true",
    accountGroupId: json["accountGroupId"]?.toString() ?? "",
    hsnSac: json["hsnSac"]?.toString(),
    isDeleted:
        json["isDeleted"] == true || json["isDeleted"]?.toString() == "true",
    isActive:
        json["isActive"] == true || json["isActive"]?.toString() == "true",
    createdBy: CreatedBy.fromJson(json["createdBy"]),
    updatedBy: json["updatedBy"]?.toString() ?? "",
    companyId: Id.fromJson(json["companyId"]),
    createdAt: json["createdAt"] != null
        ? DateTime.tryParse(json["createdAt"].toString()) ?? DateTime.now()
        : DateTime.now(),
    updatedAt: json["updatedAt"] != null
        ? DateTime.tryParse(json["updatedAt"].toString()) ?? DateTime.now()
        : DateTime.now(),
    branchId: json["branchId"] != null ? Id.fromJson(json["branchId"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "type": type,
    "name": name,
    "defaultValue": defaultValue,
    "taxId": taxId.toJson(),
    "isTaxIncluding": isTaxIncluding,
    "accountGroupId": accountGroupId,
    "hsnSac": hsnSac,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "branchId": branchId?.toJson(),
  };
}

class Id {
  final String id;
  final String name;

  Id({required this.id, required this.name});

  factory Id.fromRawJson(String str) => Id.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Id.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return Id(id: json["_id"] ?? "", name: json["name"] ?? "");
    }
    return Id(id: "", name: "");
  }

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

class CreatedBy {
  final String id;
  final String fullName;
  final String userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromRawJson(String str) =>
      CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return CreatedBy(
        id: json["_id"] ?? "",
        fullName: json["fullName"] ?? "",
        userType: json["userType"] ?? "",
      );
    }
    return CreatedBy(id: "", fullName: "", userType: "");
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };
}
