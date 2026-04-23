import 'dart:convert';

class AnnouncementResponseModel {
  final int status;
  final String message;
  final AnnouncementDataModel data;

  AnnouncementResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AnnouncementResponseModel.fromRawJson(String str) =>
      AnnouncementResponseModel.fromJson(json.decode(str));

  factory AnnouncementResponseModel.fromJson(Map<String, dynamic> json) =>
      AnnouncementResponseModel(
        status: json["status"],
        message: json["message"],
        data: AnnouncementDataModel.fromJson(json["data"]),
      );
}

class AnnouncementDataModel {
  final List<AnnouncementModel> announcementData;
  final int totalData;
  final StateModel state;

  AnnouncementDataModel({
    required this.announcementData,
    required this.totalData,
    required this.state,
  });

  factory AnnouncementDataModel.fromJson(Map<String, dynamic> json) =>
      AnnouncementDataModel(
        announcementData: List<AnnouncementModel>.from(
          json["announcement_data"].map((x) => AnnouncementModel.fromJson(x)),
        ),
        totalData: json["totalData"],
        state: StateModel.fromJson(json["state"]),
      );
}

class AnnouncementModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedByModel? createdBy;
  final String? updatedBy;
  final String? version;
  final String desc;
  final DateTime createdAt;
  final DateTime updatedAt;

  AnnouncementModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.version,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      AnnouncementModel(
        id: json["_id"],
        isDeleted: json["isDeleted"] ?? false,
        isActive: json["isActive"] ?? true,
        createdBy: json["createdBy"] != null
            ? CreatedByModel.fromJson(json["createdBy"])
            : null,
        updatedBy: json["updatedBy"],
        version: json["version"],
        desc: json["desc"] ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}

class CreatedByModel {
  final String id;
  final String fullName;
  final String userType;

  CreatedByModel({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  factory CreatedByModel.fromJson(Map<String, dynamic> json) => CreatedByModel(
    id: json["_id"],
    fullName: json["fullName"] ?? '',
    userType: json["userType"] ?? '',
  );
}

class StateModel {
  final int totalPages;

  StateModel({required this.totalPages});

  factory StateModel.fromJson(Map<String, dynamic> json) =>
      StateModel(totalPages: json["totalPages"] ?? 1);
}
