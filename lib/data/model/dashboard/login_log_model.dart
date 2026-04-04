import 'dart:convert';

import 'package:ai_setu/core/helper/model_helper.dart';

class LoginLogModel {
  final String id;
  final String company;
  final String branch;
  final String user;
  final String email;
  final String message;
  final String ip;
  final String systemDetails;
  final String eventType;
  final String createdAt;
  final String updatedAt;

  LoginLogModel({
    required this.id,
    required this.company,
    required this.branch,
    required this.user,
    required this.email,
    required this.message,
    required this.ip,
    required this.eventType,
    required this.systemDetails,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LoginLogModel.empty() => LoginLogModel(
    id: '',
    company: '',
    branch: '',
    user: '',
    email: '',
    message: '',
    ip: '',
    eventType: '',
    systemDetails: '',
    createdAt: '',
    updatedAt: '',
  );

  factory LoginLogModel.fromRawJson(String str) =>
      LoginLogModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginLogModel.fromJson(Map<String, dynamic> json) => LoginLogModel(
    id: json["_id"] ?? '',
    company:
        ModelHelper.getNestedField<String>(json, ["companyId", "name"]) ?? "",
    branch:
        ModelHelper.getNestedField<String>(json, ["branchId", "name"]) ?? "",
    user:
        ModelHelper.getNestedField<String>(json, ["userId", "fullName"]) ?? "",
    email: ModelHelper.getNestedField<String>(json, ["userId", "email"]) ?? "",
    message: json["message"] ?? '-',
    ip: json["ipAddress"] ?? json["ip"] ?? '-',
    eventType: json["eventType"] ?? '-',
    systemDetails: json["systemDetails"] ?? '-',
    createdAt: json["createdAt"] ?? '-',
    updatedAt: json["updatedAt"] ?? '-',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "company": company,
    "branch": branch,
    "user": user,
    "message": message,
    "ip": ip,
    "eventType": eventType,
    "systemDetails": systemDetails,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
