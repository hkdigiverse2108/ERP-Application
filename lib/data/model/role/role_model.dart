import 'dart:convert';

class RoleModel {
  final String id;
  final String name;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final CompanyId companyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  RoleModel({
    required this.id,
    required this.name,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoleModel.fromRawJson(String str) =>
      RoleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
    id: json["_id"],
    name: json["name"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    createdBy: CreatedBy.fromJson(json["createdBy"]),
    updatedBy: json["updatedBy"],
    companyId: CompanyId.fromJson(json["companyId"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
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
