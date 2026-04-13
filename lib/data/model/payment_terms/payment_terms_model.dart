import 'dart:convert';

class PaymentTermsModel {
  final String id;
  final String name;
  final CompanyId companyId;
  final DateTime createdAt;
  final CreatedBy createdBy;
  final int day;
  final bool isActive;
  final bool isDefault;
  final bool isDeleted;
  final DateTime updatedAt;
  final String updatedBy;

  PaymentTermsModel({
    required this.id,
    required this.name,
    required this.companyId,
    required this.createdAt,
    required this.createdBy,
    required this.day,
    required this.isActive,
    required this.isDefault,
    required this.isDeleted,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory PaymentTermsModel.fromRawJson(String str) =>
      PaymentTermsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentTermsModel.fromJson(Map<String, dynamic> json) =>
      PaymentTermsModel(
        id: json["_id"],
        name: json["name"],
        companyId: CompanyId.fromJson(json["companyId"]),
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        day: json["day"],
        isActive: json["isActive"],
        isDefault: json["isDefault"],
        isDeleted: json["isDeleted"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "companyId": companyId.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "createdBy": createdBy.toJson(),
    "day": day,
    "isActive": isActive,
    "isDefault": isDefault,
    "isDeleted": isDeleted,
    "updatedAt": updatedAt.toIso8601String(),
    "updatedBy": updatedBy,
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
