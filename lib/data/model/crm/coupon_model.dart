class CouponModel {
  // ✅ REQUIRED — these must always exist
  final String id;
  final String name;
  final bool isActive;
  final bool isDeleted;
  final String status;
  final String redemptionType;
  final int redeemValue;
  final bool singleTimeUse;
  final int usedCount;
  final DateTime createdAt;
  final List<dynamic> customerIds;

  // ✅ NULLABLE — genuinely optional from the API
  final CreatedBy? createdBy;
  final Company? companyId;
  final String? updatedBy;
  final int? couponPrice;
  final int? usageLimit;
  final int? expiryDays;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? updatedAt;

  CouponModel({
    required this.id,
    required this.name,
    required this.isActive,
    required this.isDeleted,
    required this.status,
    required this.redemptionType,
    required this.redeemValue,
    required this.singleTimeUse,
    required this.usedCount,
    required this.createdAt,
    required this.customerIds,
    this.createdBy,
    this.companyId,
    this.updatedBy,
    this.couponPrice,
    this.usageLimit,
    this.expiryDays,
    this.startDate,
    this.endDate,
    this.updatedAt,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      isActive: json["isActive"] ?? false,
      isDeleted: json["isDeleted"] ?? false,
      status: json["status"] ?? 'inactive',
      redemptionType: json["redemptionType"] ?? '',
      redeemValue: json["redeemValue"] ?? 0,
      singleTimeUse: json["singleTimeUse"] ?? false,
      usedCount: json["usedCount"] ?? 0,
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : DateTime.now(),
      customerIds: json["customerIds"] ?? [],
      // nullable
      createdBy: json["createdBy"] != null
          ? CreatedBy.fromJson(json["createdBy"])
          : null,
      companyId: json["companyId"] != null
          ? Company.fromJson(json["companyId"])
          : null,
      updatedBy: json["updatedBy"],
      couponPrice: json["couponPrice"],
      usageLimit: json["usageLimit"],
      expiryDays: json["expiryDays"],
      startDate: json["startDate"] != null
          ? DateTime.parse(json["startDate"])
          : null,
      endDate: json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
      updatedAt: json["updatedAt"] != null
          ? DateTime.parse(json["updatedAt"])
          : null,
    );
  }
}

class CreatedBy {
  String? id;
  String? fullName;
  String? userType;

  CreatedBy({this.id, this.fullName, this.userType});

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json["_id"],
      fullName: json["fullName"],
      userType: json["userType"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"_id": id, "fullName": fullName, "userType": userType};
  }
}

class Company {
  String? id;
  String? name;

  Company({this.id, this.name});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(id: json["_id"], name: json["name"]);
  }

  Map<String, dynamic> toJson() {
    return {"_id": id, "name": name};
  }
}
