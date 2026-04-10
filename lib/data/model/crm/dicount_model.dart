class DiscountModel {
  // Required
  final String id;
  final String title;
  final String discountCode;
  final bool isActive;
  final bool isDeleted;
  final bool autoApply;
  final bool excludeAlreadyDiscounted;
  final bool applyToEntireSelection;
  final bool usageLimitPerCustomer;
  final bool hasEndDate;
  final String discountApplicable;
  final String discountMode;
  final String discountType;
  final double discountValue;
  final String minimumRequirement;
  final String status;
  final int usedCount;
  final int orders;
  final double revenue;
  final DateTime startDateTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<RangeWiseRule> rangeWiseRules;
  final List<DiscountIdName> categoryIds;
  final List<DiscountIdName> subcategoryIds;
  final List<DiscountIdName> brandIds;
  final List<DiscountIdName> productIds;
  final List<DiscountIdName> excludedProductIds;
  final List<DiscountIdName> branchIds;

  // Nullable
  final DiscountUser? createdBy;
  final DiscountUser? updatedBy;
  final DiscountIdName? companyId;
  final BuyXGetY? buyXGetY;
  final String? appliesTo;
  final double? minimumPurchaseAmount;
  final int? minimumQuantity;
  final int? usageLimitTotal;
  final DateTime? endDateTime;
  final String? branchId;

  DiscountModel({
    required this.id,
    required this.title,
    required this.discountCode,
    required this.isActive,
    required this.isDeleted,
    required this.autoApply,
    required this.excludeAlreadyDiscounted,
    required this.applyToEntireSelection,
    required this.usageLimitPerCustomer,
    required this.hasEndDate,
    required this.discountApplicable,
    required this.discountMode,
    required this.discountType,
    required this.discountValue,
    required this.minimumRequirement,
    required this.status,
    required this.usedCount,
    required this.orders,
    required this.revenue,
    required this.startDateTime,
    required this.createdAt,
    required this.updatedAt,
    required this.rangeWiseRules,
    required this.categoryIds,
    required this.subcategoryIds,
    required this.brandIds,
    required this.productIds,
    required this.excludedProductIds,
    required this.branchIds,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    this.buyXGetY,
    this.appliesTo,
    this.minimumPurchaseAmount,
    this.minimumQuantity,
    this.usageLimitTotal,
    this.endDateTime,
    this.branchId,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      id: json["_id"] ?? '',
      title: json["title"] ?? '',
      discountCode: json["discountCode"] ?? '',
      isActive: json["isActive"] ?? false,
      isDeleted: json["isDeleted"] ?? false,
      autoApply: json["autoApply"] ?? false,
      excludeAlreadyDiscounted: json["excludeAlreadyDiscounted"] ?? false,
      applyToEntireSelection: json["applyToEntireSelection"] ?? false,
      usageLimitPerCustomer: json["usageLimitPerCustomer"] ?? false,
      hasEndDate: json["hasEndDate"] ?? false,
      discountApplicable: json["discountApplicable"] ?? '',
      discountMode: json["discountMode"] ?? 'normal',
      discountType: json["discountType"] ?? '',
      discountValue: (json["discountValue"] ?? 0).toDouble(),
      minimumRequirement: json["minimumRequirement"] ?? 'none',
      status: json["status"] ?? '',
      usedCount: json["usedCount"] ?? 0,
      orders: json["orders"] ?? 0,
      revenue: (json["revenue"] ?? 0).toDouble(),
      startDateTime: DateTime.parse(json["startDateTime"]),
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      rangeWiseRules:
          (json["rangeWiseRules"] as List<dynamic>?)
              ?.map((e) => RangeWiseRule.fromJson(e))
              .toList() ??
          [],
      categoryIds:
          (json["categoryIds"] as List<dynamic>?)
              ?.map((e) => DiscountIdName.fromJson(e))
              .toList() ??
          [],
      subcategoryIds:
          (json["subcategoryIds"] as List<dynamic>?)
              ?.map((e) => DiscountIdName.fromJson(e))
              .toList() ??
          [],
      brandIds:
          (json["brandIds"] as List<dynamic>?)
              ?.map((e) => DiscountIdName.fromJson(e))
              .toList() ??
          [],
      productIds:
          (json["productIds"] as List<dynamic>?)
              ?.map((e) => DiscountIdName.fromJson(e))
              .toList() ??
          [],
      excludedProductIds:
          (json["excludedProductIds"] as List<dynamic>?)
              ?.map((e) => DiscountIdName.fromJson(e))
              .toList() ??
          [],
      branchIds:
          (json["branchIds"] as List<dynamic>?)
              ?.map((e) => DiscountIdName.fromJson(e))
              .toList() ??
          [],
      createdBy: json["createdBy"] != null
          ? DiscountUser.fromJson(json["createdBy"])
          : null,
      updatedBy: json["updatedBy"] != null && json["updatedBy"] is Map
          ? DiscountUser.fromJson(json["updatedBy"])
          : null,
      companyId: json["companyId"] != null
          ? DiscountIdName.fromJson(json["companyId"])
          : null,
      buyXGetY: json["buyXGetY"] != null
          ? BuyXGetY.fromJson(json["buyXGetY"])
          : null,
      appliesTo: json["appliesTo"],
      minimumPurchaseAmount: json["minimumPurchaseAmount"] != null
          ? (json["minimumPurchaseAmount"]).toDouble()
          : null,
      minimumQuantity: json["minimumQuantity"],
      usageLimitTotal: json["usageLimitTotal"],
      endDateTime: json["endDateTime"] != null
          ? DateTime.parse(json["endDateTime"])
          : null,
      branchId: json["branchId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "discountCode": discountCode,
      "isActive": isActive,
      "isDeleted": isDeleted,
      "autoApply": autoApply,
      "excludeAlreadyDiscounted": excludeAlreadyDiscounted,
      "applyToEntireSelection": applyToEntireSelection,
      "usageLimitPerCustomer": usageLimitPerCustomer,
      "hasEndDate": hasEndDate,
      "discountApplicable": discountApplicable,
      "discountMode": discountMode,
      "discountType": discountType,
      "discountValue": discountValue,
      "minimumRequirement": minimumRequirement,
      "status": status,
      "usedCount": usedCount,
      "orders": orders,
      "revenue": revenue,
      "startDateTime": startDateTime.toIso8601String(),
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "rangeWiseRules": rangeWiseRules.map((e) => e.toJson()).toList(),
      "categoryIds": categoryIds.map((e) => e.toJson()).toList(),
      "subcategoryIds": subcategoryIds.map((e) => e.toJson()).toList(),
      "brandIds": brandIds.map((e) => e.toJson()).toList(),
      "productIds": productIds.map((e) => e.toJson()).toList(),
      "excludedProductIds": excludedProductIds.map((e) => e.toJson()).toList(),
      "branchIds": branchIds.map((e) => e.toJson()).toList(),
      "createdBy": createdBy?.toJson(),
      "updatedBy": updatedBy?.toJson(),
      "companyId": companyId?.toJson(),
      "buyXGetY": buyXGetY?.toJson(),
      "appliesTo": appliesTo,
      "minimumPurchaseAmount": minimumPurchaseAmount,
      "minimumQuantity": minimumQuantity,
      "usageLimitTotal": usageLimitTotal,
      "endDateTime": endDateTime?.toIso8601String(),
      "branchId": branchId,
    };
  }
}

// ---------------------------------------------------

class DiscountUser {
  final String id;
  final String fullName;
  final String userType;

  DiscountUser({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  factory DiscountUser.fromJson(Map<String, dynamic> json) {
    return DiscountUser(
      id: json["_id"] ?? '',
      fullName: json["fullName"] ?? '',
      userType: json["userType"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };
}

// ---------------------------------------------------

class DiscountIdName {
  final String id;
  final String name;

  DiscountIdName({required this.id, required this.name});

  factory DiscountIdName.fromJson(Map<String, dynamic> json) {
    return DiscountIdName(id: json["_id"] ?? '', name: json["name"] ?? '');
  }

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

// ---------------------------------------------------

class BuyXGetY {
  final int buyQty;
  final int getQty;
  final String getDiscountType;
  final double getDiscountValue;
  final List<DiscountIdName> getProductIds;

  BuyXGetY({
    required this.buyQty,
    required this.getQty,
    required this.getDiscountType,
    required this.getDiscountValue,
    required this.getProductIds,
  });

  factory BuyXGetY.fromJson(Map<String, dynamic> json) {
    return BuyXGetY(
      buyQty: json["buyQty"] ?? 0,
      getQty: json["getQty"] ?? 0,
      getDiscountType: json["getDiscountType"] ?? '',
      getDiscountValue: (json["getDiscountValue"] ?? 0).toDouble(),
      getProductIds:
          (json["getProductIds"] as List<dynamic>?)
              ?.map((e) => DiscountIdName.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    "buyQty": buyQty,
    "getQty": getQty,
    "getDiscountType": getDiscountType,
    "getDiscountValue": getDiscountValue,
    "getProductIds": getProductIds.map((e) => e.toJson()).toList(),
  };
}

// ---------------------------------------------------

class RangeWiseRule {
  final int minQty;
  final int maxQty;
  final String discountType;
  final double discountValue;

  RangeWiseRule({
    required this.minQty,
    required this.maxQty,
    required this.discountType,
    required this.discountValue,
  });

  factory RangeWiseRule.fromJson(Map<String, dynamic> json) {
    return RangeWiseRule(
      minQty: json["minQty"] ?? 0,
      maxQty: json["maxQty"] ?? 0,
      discountType: json["discountType"] ?? '',
      discountValue: (json["discountValue"] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "minQty": minQty,
    "maxQty": maxQty,
    "discountType": discountType,
    "discountValue": discountValue,
  };
}
