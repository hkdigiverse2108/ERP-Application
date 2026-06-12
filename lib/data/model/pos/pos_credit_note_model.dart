import 'dart:convert';

class PosCreditNoteModel {
  final String id;
  final String creditNoteNo;
  final PosCustomerId customerId;
  final PosReturnOrderId returnPosOrderId;
  final double totalAmount;
  final double creditsUsed;
  final double refundedAmount;
  final double creditsRemaining;
  final List<dynamic> usedOnOrderIds;
  final String status;
  final bool isDeleted;
  final bool isActive;
  final PosCreatedBy createdBy;
  final String updatedBy;
  final PosCompanyId companyId;
  final PosBranchId branchId;
  final DateTime createdAt;
  final DateTime updatedAt;

  PosCreditNoteModel({
    required this.id,
    required this.creditNoteNo,
    required this.customerId,
    required this.returnPosOrderId,
    required this.totalAmount,
    required this.creditsUsed,
    required this.refundedAmount,
    required this.creditsRemaining,
    required this.usedOnOrderIds,
    required this.status,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.branchId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PosCreditNoteModel.fromRawJson(String str) =>
      PosCreditNoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PosCreditNoteModel.fromJson(Map<String, dynamic> json) =>
      PosCreditNoteModel(
        id: json["_id"]?.toString() ?? "",
        creditNoteNo: json["creditNoteNo"]?.toString() ?? "",
        customerId: PosCustomerId.fromJson(json["customerId"] ?? {}),
        returnPosOrderId: PosReturnOrderId.fromJson(
          json["returnPosOrderId"] ?? {},
        ),
        totalAmount: json["totalAmount"]?.toDouble() ?? 0.0,
        creditsUsed: json["creditsUsed"]?.toDouble() ?? 0.0,
        refundedAmount: json["refundedAmount"]?.toDouble() ?? 0.0,
        creditsRemaining: json["creditsRemaining"]?.toDouble() ?? 0.0,
        usedOnOrderIds: List<dynamic>.from(
          json["usedOnOrderIds"]?.map((x) => x) ?? [],
        ),
        status: json["status"]?.toString() ?? "",
        isDeleted: json["isDeleted"] ?? false,
        isActive: json["isActive"] ?? true,
        createdBy: PosCreatedBy.fromJson(json["createdBy"] ?? {}),
        updatedBy: json["updatedBy"]?.toString() ?? "",
        companyId: PosCompanyId.fromJson(json["companyId"] ?? {}),
        branchId: PosBranchId.fromJson(json["branchId"] ?? {}),
        createdAt:
            DateTime.tryParse(json["createdAt"]?.toString() ?? "") ??
            DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updatedAt"]?.toString() ?? "") ??
            DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "creditNoteNo": creditNoteNo,
    "customerId": customerId.toJson(),
    "returnPosOrderId": returnPosOrderId.toJson(),
    "totalAmount": totalAmount,
    "creditsUsed": creditsUsed,
    "refundedAmount": refundedAmount,
    "creditsRemaining": creditsRemaining,
    "usedOnOrderIds": List<dynamic>.from(usedOnOrderIds.map((x) => x)),
    "status": status,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "branchId": branchId.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class PosBranchId {
  final String id;
  final String name;

  PosBranchId({required this.id, required this.name});

  factory PosBranchId.fromJson(Map<String, dynamic> json) => PosBranchId(
    id: json["_id"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

class PosCompanyId {
  final String id;
  final String name;

  PosCompanyId({required this.id, required this.name});

  factory PosCompanyId.fromJson(Map<String, dynamic> json) => PosCompanyId(
    id: json["_id"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

class PosCreatedBy {
  final String id;
  final String fullName;
  final String userType;

  PosCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  factory PosCreatedBy.fromJson(Map<String, dynamic> json) => PosCreatedBy(
    id: json["_id"]?.toString() ?? "",
    fullName: json["fullName"]?.toString() ?? "User",
    userType: json["userType"]?.toString() ?? "admin",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };
}

class PosCustomerId {
  final String id;
  final String firstName;
  final String lastName;
  final PosPhoneNo phoneNo;

  PosCustomerId({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
  });

  factory PosCustomerId.fromJson(Map<String, dynamic> json) => PosCustomerId(
    id: json["_id"]?.toString() ?? "",
    firstName: json["firstName"]?.toString() ?? "",
    lastName: json["lastName"]?.toString() ?? "",
    phoneNo: PosPhoneNo.fromJson(json["phoneNo"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "phoneNo": phoneNo.toJson(),
  };
}

class PosPhoneNo {
  final int phoneNo;
  final String countryCode;

  PosPhoneNo({required this.phoneNo, required this.countryCode});

  factory PosPhoneNo.fromJson(Map<String, dynamic> json) => PosPhoneNo(
    phoneNo: int.tryParse(json["phoneNo"]?.toString() ?? "0") ?? 0,
    countryCode: json["countryCode"]?.toString() ?? "91",
  );

  Map<String, dynamic> toJson() => {
    "phoneNo": phoneNo,
    "countryCode": countryCode,
  };
}

class PosReturnOrderId {
  final String id;
  final String returnOrderNo;
  final PosOrderId posOrderId;
  final List<PosItem> items;
  final double total;

  PosReturnOrderId({
    required this.id,
    required this.returnOrderNo,
    required this.posOrderId,
    required this.items,
    required this.total,
  });

  factory PosReturnOrderId.fromJson(Map<String, dynamic> json) =>
      PosReturnOrderId(
        id: json["_id"]?.toString() ?? "",
        returnOrderNo: json["returnOrderNo"]?.toString() ?? "",
        posOrderId: PosOrderId.fromJson(json["posOrderId"] ?? {}),
        items: List<PosItem>.from(
          json["items"]?.map((x) => PosItem.fromJson(x)) ?? [],
        ),
        total: json["total"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "returnOrderNo": returnOrderNo,
    "posOrderId": posOrderId.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "total": total,
  };
}

class PosItem {
  final PosProductId productId;
  final String? variantId;
  final double qty;
  final double mrp;
  final double discountAmount;
  final double additionalDiscountAmount;
  final double unitCost;
  final double netAmount;
  final double returnedQty;

  PosItem({
    required this.productId,
    this.variantId,
    required this.qty,
    required this.mrp,
    required this.discountAmount,
    required this.additionalDiscountAmount,
    required this.unitCost,
    required this.netAmount,
    required this.returnedQty,
  });

  factory PosItem.fromJson(Map<String, dynamic> json) => PosItem(
    productId: PosProductId.fromJson(json["productId"] ?? {}),
    variantId: json["variantId"]?.toString(),
    qty: json["qty"]?.toDouble() ?? 0.0,
    mrp: json["mrp"]?.toDouble() ?? 0.0,
    discountAmount: json["discountAmount"]?.toDouble() ?? 0.0,
    additionalDiscountAmount:
        json["additionalDiscountAmount"]?.toDouble() ?? 0.0,
    unitCost: json["unitCost"]?.toDouble() ?? 0.0,
    netAmount: json["netAmount"]?.toDouble() ?? 0.0,
    returnedQty: json["returnedQty"]?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    "productId": productId.toJson(),
    "variantId": variantId,
    "qty": qty,
    "mrp": mrp,
    "discountAmount": discountAmount,
    "additionalDiscountAmount": additionalDiscountAmount,
    "unitCost": unitCost,
    "netAmount": netAmount,
    "returnedQty": returnedQty,
  };

  PosItem copyWith({
    PosProductId? productId,
    String? variantId,
    double? qty,
    double? mrp,
    double? discountAmount,
    double? additionalDiscountAmount,
    double? unitCost,
    double? netAmount,
    double? returnedQty,
  }) {
    return PosItem(
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      qty: qty ?? this.qty,
      mrp: mrp ?? this.mrp,
      discountAmount: discountAmount ?? this.discountAmount,
      additionalDiscountAmount:
          additionalDiscountAmount ?? this.additionalDiscountAmount,
      unitCost: unitCost ?? this.unitCost,
      netAmount: netAmount ?? this.netAmount,
      returnedQty: returnedQty ?? this.returnedQty,
    );
  }
}

class PosOrderId {
  final String id;
  final String orderNo;

  PosOrderId({required this.id, required this.orderNo});

  factory PosOrderId.fromJson(Map<String, dynamic> json) => PosOrderId(
    id: json["_id"]?.toString() ?? "",
    orderNo: json["orderNo"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {"_id": id, "orderNo": orderNo};
}

class PosProductId {
  final String id;
  final String name;

  PosProductId({required this.id, required this.name});

  factory PosProductId.fromJson(Map<String, dynamic> json) => PosProductId(
    id: json["_id"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "Product",
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}
