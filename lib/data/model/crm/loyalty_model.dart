class LoyaltyModel {
  // Required fields
  final String id;
  final String name;
  final String description;
  final String type;
  final bool isActive;
  final bool isDeleted;
  final bool singleTimeUse;
  final int discountValue;
  final int redemptionPoints;
  final int minimumPurchaseAmount;
  final int usedCount;
  final int usageLimit;
  final DateTime campaignLaunchDate;
  final DateTime campaignExpiryDate;
  final DateTime createdAt;
  final List<Customer> customerIds;

  // Nullable fields
  final CreatedBy? createdBy;
  final Company? companyId;
  final Branch? branchId;
  final String? updatedBy;
  final DateTime? updatedAt;

  LoyaltyModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.isActive,
    required this.isDeleted,
    required this.singleTimeUse,
    required this.discountValue,
    required this.redemptionPoints,
    required this.minimumPurchaseAmount,
    required this.usedCount,
    required this.usageLimit,
    required this.campaignLaunchDate,
    required this.campaignExpiryDate,
    required this.createdAt,
    required this.customerIds,
    this.createdBy,
    this.companyId,
    this.branchId,
    this.updatedBy,
    this.updatedAt,
  });

  factory LoyaltyModel.fromJson(Map<String, dynamic> json) {
    return LoyaltyModel(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      description: json["description"] ?? '',
      type: json["type"] ?? '',
      isActive: json["isActive"] ?? false,
      isDeleted: json["isDeleted"] ?? false,
      singleTimeUse: json["singleTimeUse"] ?? false,
      discountValue: json["discountValue"] ?? 0,
      redemptionPoints: json["redemptionPoints"] ?? 0,
      minimumPurchaseAmount: json["minimumPurchaseAmount"] ?? 0,
      usedCount: json["usedCount"] ?? 0,
      usageLimit: json["usageLimit"] ?? 0,
      campaignLaunchDate: DateTime.parse(json["campaignLaunchDate"]),
      campaignExpiryDate: DateTime.parse(json["campaignExpiryDate"]),
      createdAt: DateTime.parse(json["createdAt"]),
      customerIds:
          (json["customerIds"] as List<dynamic>?)
              ?.map((e) => Customer.fromJson(e))
              .toList() ??
          [],
      createdBy: json["createdBy"] != null
          ? CreatedBy.fromJson(json["createdBy"])
          : null,
      companyId: json["companyId"] != null
          ? Company.fromJson(json["companyId"])
          : null,
      branchId: json["branchId"] != null
          ? Branch.fromJson(json["branchId"])
          : null,
      updatedBy: json["updatedBy"],
      updatedAt: json["updatedAt"] != null
          ? DateTime.parse(json["updatedAt"])
          : null,
    );
  }

  String get typeDisplayName {
    switch (type.toLowerCase()) {
      case 'discount':
        return 'Discount';
      case 'free_product':
        return 'Free Product';
      default:
        return type;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "description": description,
      "type": type,
      "isActive": isActive,
      "isDeleted": isDeleted,
      "singleTimeUse": singleTimeUse,
      "discountValue": discountValue,
      "redemptionPoints": redemptionPoints,
      "minimumPurchaseAmount": minimumPurchaseAmount,
      "usedCount": usedCount,
      "usageLimit": usageLimit,
      "campaignLaunchDate": campaignLaunchDate.toIso8601String(),
      "campaignExpiryDate": campaignExpiryDate.toIso8601String(),
      "createdAt": createdAt.toIso8601String(),
      "customerIds": customerIds.map((e) => e.toJson()).toList(),
      "createdBy": createdBy?.toJson(),
      "companyId": companyId?.toJson(),
      "branchId": branchId?.toJson(),
      "updatedBy": updatedBy,
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }
}

// ---------------------------------------------------

class Customer {
  final CampaignCustomerDetail? id;
  final int count;

  Customer({this.id, required this.count});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json["id"] != null
          ? CampaignCustomerDetail.fromJson(json["id"])
          : null,
      count: json["count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id?.toJson(), "count": count};
  }
}

// ---------------------------------------------------

class CampaignCustomerDetail {
  final String id;
  final String firstName;
  final String lastName;

  CampaignCustomerDetail({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  String get fullName => '$firstName $lastName';

  factory CampaignCustomerDetail.fromJson(Map<String, dynamic> json) {
    return CampaignCustomerDetail(
      id: json["_id"] ?? '',
      firstName: json["firstName"] ?? '',
      lastName: json["lastName"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"_id": id, "firstName": firstName, "lastName": lastName};
  }
}

// ---------------------------------------------------

class CreatedBy {
  final String id;
  final String fullName;
  final String userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json["_id"] ?? '',
      fullName: json["fullName"] ?? '',
      userType: json["userType"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"_id": id, "fullName": fullName, "userType": userType};
  }
}

// ---------------------------------------------------

class Company {
  final String id;
  final String name;

  Company({required this.id, required this.name});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(id: json["_id"] ?? '', name: json["name"] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {"_id": id, "name": name};
  }
}

// ---------------------------------------------------

class Branch {
  final String id;
  final String name;

  Branch({required this.id, required this.name});

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(id: json["_id"] ?? '', name: json["name"] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {"_id": id, "name": name};
  }
}
