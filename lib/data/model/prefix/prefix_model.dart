import 'dart:convert';

class PrefixModel {
  final String id;
  final String prefixType;
  final CompanyId companyId;
  final bool isDeleted;
  final DateTime createdAt;
  final AtedBy? createdBy;
  final bool isActive;
  final String prefix;
  final int sequenceNumber;
  final DateTime updatedAt;
  final AtedBy? updatedBy;

  PrefixModel({
    required this.id,
    required this.prefixType,
    required this.companyId,
    required this.isDeleted,
    required this.createdAt,
    required this.createdBy,
    required this.isActive,
    required this.prefix,
    required this.sequenceNumber,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory PrefixModel.fromRawJson(String str) =>
      PrefixModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrefixModel.fromJson(Map<String, dynamic> json) => PrefixModel(
    id: json["_id"],
    prefixType: json["prefixType"],
    companyId: CompanyId.fromJson(json["companyId"]),
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    createdBy: json["createdBy"] == null
        ? null
        : AtedBy.fromJson(json["createdBy"]),
    isActive: json["isActive"],
    prefix: json["prefix"],
    sequenceNumber: json["sequenceNumber"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    updatedBy: json["updatedBy"] == null
        ? null
        : AtedBy.fromJson(json["updatedBy"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "prefixType": prefixType,
    "companyId": companyId.toJson(),
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "createdBy": createdBy?.toJson(),
    "isActive": isActive,
    "prefix": prefix,
    "sequenceNumber": sequenceNumber,
    "updatedAt": updatedAt.toIso8601String(),
    "updatedBy": updatedBy?.toJson(),
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

class AtedBy {
  final String id;
  final String fullName;
  final String userType;

  AtedBy({required this.id, required this.fullName, required this.userType});

  factory AtedBy.fromRawJson(String str) => AtedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AtedBy.fromJson(Map<String, dynamic> json) => AtedBy(
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
