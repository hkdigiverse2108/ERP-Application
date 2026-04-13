import 'dart:convert';

class TaxItemModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy? createdBy;
  final UpdatedBy? updatedBy;
  final String name;
  final int percentage;
  final DateTime createdAt;
  final DateTime updatedAt;

  TaxItemModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.name,
    required this.percentage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaxItemModel.fromRawJson(String str) =>
      TaxItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxItemModel.fromJson(Map<String, dynamic> json) => TaxItemModel(
    id: json["_id"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    createdBy: json["createdBy"] == null
        ? null
        : CreatedBy.fromJson(json["createdBy"]),
    updatedBy: json["updatedBy"] == null
        ? null
        : UpdatedBy.fromJson(json["updatedBy"]),
    name: json["name"],
    percentage: json["percentage"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy?.toJson(),
    "updatedBy": updatedBy?.toJson(),
    "name": name,
    "percentage": percentage,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
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

class TaxDropdownModel {
  final String id;
  final String name;
  final dynamic percentage;

  TaxDropdownModel({
    required this.id,
    required this.name,
    required this.percentage,
  });

  factory TaxDropdownModel.fromRawJson(String str) =>
      TaxDropdownModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxDropdownModel.fromJson(Map<String, dynamic> json) =>
      TaxDropdownModel(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        percentage: json["percentage"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "percentage": percentage,
  };
}
