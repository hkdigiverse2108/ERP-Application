import 'dart:convert';

class CreditNoteModel {
  final String id;
  final String creditNoteNo;
  final CustomerId customerId;
  final ReturnPosOrderId returnPosOrderId;
  final double totalAmount;
  final double creditsUsed;
  final int? refundedAmount;
  final double creditsRemaining;
  final List<OrderId>? usedOnOrderIds;
  final String status;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final CompanyId companyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String branchId;

  CreditNoteModel({
    required this.id,
    required this.creditNoteNo,
    required this.customerId,
    required this.returnPosOrderId,
    required this.totalAmount,
    required this.creditsUsed,
    this.refundedAmount,
    required this.creditsRemaining,
    this.usedOnOrderIds,
    required this.status,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
  });

  factory CreditNoteModel.fromRawJson(String str) =>
      CreditNoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreditNoteModel.fromJson(Map<String, dynamic> json) =>
      CreditNoteModel(
        id: json["_id"]?.toString() ?? "",
        creditNoteNo: json["creditNoteNo"]?.toString() ?? "",
        customerId: CustomerId.fromJson(json["customerId"] ?? {}),
        returnPosOrderId: ReturnPosOrderId.fromJson(
          json["returnPosOrderId"] ?? {},
        ),
        totalAmount: json["totalAmount"]?.toDouble() ?? 0.0,
        creditsUsed: json["creditsUsed"]?.toDouble() ?? 0.0,
        refundedAmount: int.tryParse(json["refundedAmount"]?.toString() ?? "0"),
        creditsRemaining: json["creditsRemaining"]?.toDouble() ?? 0.0,
        usedOnOrderIds: json["usedOnOrderIds"] == null
            ? []
            : List<OrderId>.from(
                json["usedOnOrderIds"]!.map((x) => OrderId.fromJson(x)),
              ),
        status: json["status"]?.toString() ?? "",
        isDeleted: json["isDeleted"] ?? false,
        isActive: json["isActive"] ?? true,
        createdBy: CreatedBy.fromJson(json["createdBy"] ?? {}),
        updatedBy: json["updatedBy"]?.toString() ?? "",
        companyId: CompanyId.fromJson(json["companyId"] ?? {}),
        createdAt:
            DateTime.tryParse(json["createdAt"]?.toString() ?? "") ??
            DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updatedAt"]?.toString() ?? "") ??
            DateTime.now(),
        branchId: json["branchId"]?.toString() ?? "",
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
    "usedOnOrderIds": usedOnOrderIds == null
        ? []
        : List<dynamic>.from(usedOnOrderIds!.map((x) => x.toJson())),
    "status": status,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "branchId": branchId,
  };
}

class CompanyId {
  final String id;
  final String name;

  CompanyId({required this.id, required this.name});

  factory CompanyId.fromJson(Map<String, dynamic> json) => CompanyId(
    id: json["_id"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

class CreatedBy {
  final String id;
  final String fullName;
  final String userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
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

class CustomerId {
  final String id;
  final String firstName;
  final String lastName;
  final PhoneNo phoneNo;
  final String? companyName;

  CustomerId({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    this.companyName,
  });

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
    id: json["_id"]?.toString() ?? "",
    firstName: json["firstName"]?.toString() ?? "",
    lastName: json["lastName"]?.toString() ?? "",
    phoneNo: PhoneNo.fromJson(json["phoneNo"] ?? {}),
    companyName: json["companyName"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "phoneNo": phoneNo.toJson(),
    "companyName": companyName,
  };
}

class PhoneNo {
  final String countryCode;
  final int phoneNo;

  PhoneNo({required this.countryCode, required this.phoneNo});

  factory PhoneNo.fromJson(Map<String, dynamic> json) => PhoneNo(
    countryCode: json["countryCode"]?.toString() ?? "+91",
    phoneNo: int.tryParse(json["phoneNo"]?.toString() ?? "0") ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "phoneNo": phoneNo,
  };
}

class ReturnPosOrderId {
  final String id;
  final String returnOrderNo;
  final OrderId posOrderId;
  final List<Item> items;
  final double total;

  ReturnPosOrderId({
    required this.id,
    required this.returnOrderNo,
    required this.posOrderId,
    required this.items,
    required this.total,
  });

  factory ReturnPosOrderId.fromJson(Map<String, dynamic> json) =>
      ReturnPosOrderId(
        id: json["_id"]?.toString() ?? "",
        returnOrderNo: json["returnOrderNo"]?.toString() ?? "",
        posOrderId: OrderId.fromJson(json["posOrderId"] ?? {}),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
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

class Item {
  final ProductId productId;
  final String? variantId;
  final int? qty;
  final int? mrp;
  final int? discountAmount;
  final int? additionalDiscountAmount;
  final double? unitCost;
  final double? netAmount;
  final int? returnedQty;
  final int? price;
  final int? total;
  final int? quantity;

  Item({
    required this.productId,
    this.variantId,
    this.qty,
    this.mrp,
    this.discountAmount,
    this.additionalDiscountAmount,
    this.unitCost,
    this.netAmount,
    this.returnedQty,
    this.price,
    this.total,
    this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    productId: ProductId.fromJson(json["productId"] ?? {}),
    variantId: json["variantId"]?.toString(),
    qty: int.tryParse(json["qty"]?.toString() ?? "0"),
    mrp: int.tryParse(json["mrp"]?.toString() ?? "0"),
    discountAmount: int.tryParse(json["discountAmount"]?.toString() ?? "0"),
    additionalDiscountAmount: int.tryParse(
      json["additionalDiscountAmount"]?.toString() ?? "0",
    ),
    unitCost: json["unitCost"]?.toDouble(),
    netAmount: json["netAmount"]?.toDouble(),
    returnedQty: int.tryParse(json["returnedQty"]?.toString() ?? "0"),
    price: int.tryParse(json["price"]?.toString() ?? "0"),
    total: int.tryParse(json["total"]?.toString() ?? "0"),
    quantity: int.tryParse(json["quantity"]?.toString() ?? "0"),
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
    "price": price,
    "total": total,
    "quantity": quantity,
  };

  Item copyWith({
    ProductId? productId,
    String? variantId,
    int? qty,
    int? mrp,
    int? discountAmount,
    int? additionalDiscountAmount,
    double? unitCost,
    double? netAmount,
    int? returnedQty,
    int? price,
    int? total,
    int? quantity,
  }) {
    return Item(
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
      price: price ?? this.price,
      total: total ?? this.total,
      quantity: quantity ?? this.quantity,
    );
  }
}

class ProductId {
  final String id;
  final String name;
  final String? hsnCode;

  ProductId({required this.id, required this.name, this.hsnCode});

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
    id: json["_id"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "Product",
    hsnCode: json["hsnCode"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "hsnCode": hsnCode,
  };
}

class OrderId {
  final String id;
  final String orderNo;

  OrderId({required this.id, required this.orderNo});

  factory OrderId.fromJson(Map<String, dynamic> json) => OrderId(
    id: json["_id"]?.toString() ?? "",
    orderNo: json["orderNo"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {"_id": id, "orderNo": orderNo};
}
