import 'dart:convert';

class ConsumptionTypeModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final UpdatedBy updatedBy;
  final String name;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CompanyId? companyId;

  ConsumptionTypeModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.name,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    this.companyId,
  });

  factory ConsumptionTypeModel.fromRawJson(String str) =>
      ConsumptionTypeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConsumptionTypeModel.fromJson(Map<String, dynamic> json) =>
      ConsumptionTypeModel(
        id: json["_id"],
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        updatedBy: UpdatedBy.fromJson(json["updatedBy"]),
        name: json["name"],
        isDefault: json["isDefault"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        companyId: json["companyId"] == null
            ? null
            : CompanyId.fromJson(json["companyId"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy.toJson(),
    "name": name,
    "isDefault": isDefault,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "companyId": companyId?.toJson(),
  };
}

class CompanyId {
  final String id;
  final String name;

  CompanyId({required this.id, required this.name});

  factory CompanyId.fromRawJson(String str) =>
      CompanyId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyId.fromJson(Map<String, dynamic> json) =>
      CompanyId(id: json["_id"], name: json["name"]);

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

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["_id"],
    fullName: json["fullName"],
    userType: json["userType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };
}

class UpdatedBy {
  final String id;
  final String userType;

  UpdatedBy({required this.id, required this.userType});

  factory UpdatedBy.fromRawJson(String str) =>
      UpdatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdatedBy.fromJson(Map<String, dynamic> json) =>
      UpdatedBy(id: json["_id"], userType: json["userType"]);

  Map<String, dynamic> toJson() => {"_id": id, "userType": userType};
}
