import 'dart:convert';

class StockVerificationModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final UpdatedBy updatedBy;
  final Id companyId;
  final String stockVerificationNo;
  final List<Item> items;
  final double totalProducts;
  final double totalPhysicalQty;
  final double totalDifferenceAmount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  StockVerificationModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.stockVerificationNo,
    required this.items,
    required this.totalProducts,
    required this.totalPhysicalQty,
    required this.totalDifferenceAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StockVerificationModel.fromRawJson(String str) =>
      StockVerificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockVerificationModel.fromJson(Map<String, dynamic> json) =>
      StockVerificationModel(
        id: json["_id"],
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        updatedBy: UpdatedBy.fromJson(json["updatedBy"]),
        companyId: Id.fromJson(json["companyId"]),
        stockVerificationNo: json["stockVerificationNo"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        totalProducts: json["totalProducts"].toDouble(),
        totalPhysicalQty: json["totalPhysicalQty"].toDouble(),
        totalDifferenceAmount: json["totalDifferenceAmount"].toDouble(),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy.toJson(),
    "companyId": companyId.toJson(),
    "stockVerificationNo": stockVerificationNo,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "totalProducts": totalProducts,
    "totalPhysicalQty": totalPhysicalQty,
    "totalDifferenceAmount": totalDifferenceAmount,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Id {
  final String id;
  final String name;

  Id({required this.id, required this.name});

  factory Id.fromRawJson(String str) => Id.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Id.fromJson(Map<String, dynamic> json) =>
      Id(id: json["_id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
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

class Item {
  final Id productId;
  final double landingCost;
  final double price;
  final double mrp;
  final double sellingPrice;
  final double systemQty;
  final double physicalQty;
  final double differenceQty;
  final double differenceAmount;

  Item({
    required this.productId,
    required this.landingCost,
    required this.price,
    required this.mrp,
    required this.sellingPrice,
    required this.systemQty,
    required this.physicalQty,
    required this.differenceQty,
    required this.differenceAmount,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    productId: Id.fromJson(json["productId"]),
    landingCost: json["landingCost"].toDouble(),
    price: json["price"].toDouble(),
    mrp: json["mrp"].toDouble(),
    sellingPrice: json["sellingPrice"].toDouble(),
    systemQty: json["systemQty"].toDouble(),
    physicalQty: json["physicalQty"].toDouble(),
    differenceQty: json["differenceQty"].toDouble(),
    differenceAmount: json["differenceAmount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId.toJson(),
    "landingCost": landingCost,
    "price": price,
    "mrp": mrp,
    "sellingPrice": sellingPrice,
    "systemQty": systemQty,
    "physicalQty": physicalQty,
    "differenceQty": differenceQty,
    "differenceAmount": differenceAmount,
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
