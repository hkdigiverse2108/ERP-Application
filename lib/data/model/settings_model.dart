import 'dart:convert';

class SettingsModel {
  final String id;
  final SettingsPhone phoneNo;
  final String email;
  final String address;
  final WorkingHours workingHours;
  final List<SettingsLink> links;
  final bool isDeleted;
  final bool isActive;
  final AdminUserInfo? createdBy;
  final AdminUserInfo? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SettingsModel({
    required this.id,
    required this.phoneNo,
    required this.email,
    required this.address,
    required this.workingHours,
    required this.links,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory SettingsModel.fromRawJson(String str) =>
      SettingsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
    id: json["_id"] ?? '',
    phoneNo: SettingsPhone.fromJson(json["phoneNo"] ?? {}),
    email: json["email"] ?? '',
    address: json["address"] ?? '',
    workingHours: WorkingHours.fromJson(json["workingHours"] ?? {}),
    links: json["links"] == null
        ? []
        : List<SettingsLink>.from(
            json["links"].map((x) => SettingsLink.fromJson(x))),
    isDeleted: json["isDeleted"] ?? false,
    isActive: json["isActive"] ?? true,
    createdBy: json["createdBy"] != null
        ? AdminUserInfo.fromJson(json["createdBy"])
        : null,
    updatedBy: json["updatedBy"] != null
        ? AdminUserInfo.fromJson(json["updatedBy"])
        : null,
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : null,
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "phoneNo": phoneNo.toJson(),
    "email": email,
    "address": address,
    "workingHours": workingHours.toJson(),
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy?.toJson(),
    "updatedBy": updatedBy?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class SettingsPhone {
  final String countryCode;
  final dynamic phoneNo;

  SettingsPhone({required this.countryCode, required this.phoneNo});

  factory SettingsPhone.fromJson(Map<String, dynamic> json) => SettingsPhone(
    countryCode: json["countryCode"]?.toString() ?? '',
    phoneNo: json["phoneNo"],
  );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "phoneNo": phoneNo,
  };

  @override
  String toString() => "+$countryCode $phoneNo";
}

class WorkingHours {
  final String startTime;
  final String endTime;
  final String timezone;

  WorkingHours({
    required this.startTime,
    required this.endTime,
    required this.timezone,
  });

  factory WorkingHours.fromJson(Map<String, dynamic> json) => WorkingHours(
    startTime: json["startTime"] ?? '',
    endTime: json["endTime"] ?? '',
    timezone: json["timezone"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "startTime": startTime,
    "endTime": endTime,
    "timezone": timezone,
  };
}

class SettingsLink {
  final String title;
  final String link;
  final String icon;
  final bool isActive;
  final String id;

  SettingsLink({
    required this.title,
    required this.link,
    required this.icon,
    required this.isActive,
    required this.id,
  });

  factory SettingsLink.fromJson(Map<String, dynamic> json) => SettingsLink(
    title: json["title"] ?? '',
    link: json["link"] ?? '',
    icon: json["icon"] ?? '',
    isActive: json["isActive"] ?? true,
    id: json["_id"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "link": link,
    "icon": icon,
    "isActive": isActive,
    "_id": id,
  };
}

class AdminUserInfo {
  final String id;
  final String? fullName;
  final String userType;

  AdminUserInfo({required this.id, this.fullName, required this.userType});

  factory AdminUserInfo.fromJson(Map<String, dynamic> json) => AdminUserInfo(
    id: json["_id"] ?? '',
    fullName: json["fullName"],
    userType: json["userType"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    if (fullName != null) "fullName": fullName,
    "userType": userType,
  };
}
