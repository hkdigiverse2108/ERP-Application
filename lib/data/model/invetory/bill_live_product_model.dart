import 'dart:convert';

class BillOfLiveProductModel {
  final String id;
  final DateTime date;
  final String number;
  final List<Id> recipeId;
  final bool allowReverseCalculation;
  final List<ProductDetail> productDetails;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final Id companyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  BillOfLiveProductModel({
    required this.id,
    required this.date,
    required this.number,
    required this.recipeId,
    required this.allowReverseCalculation,
    required this.productDetails,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BillOfLiveProductModel.fromRawJson(String str) =>
      BillOfLiveProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BillOfLiveProductModel.fromJson(Map<String, dynamic> json) =>
      BillOfLiveProductModel(
        id: json["_id"],
        date: DateTime.parse(json["date"]),
        number: json["number"],
        recipeId: List<Id>.from(json["recipeId"].map((x) => Id.fromJson(x))),
        allowReverseCalculation: json["allowReverseCalculation"],
        productDetails: List<ProductDetail>.from(
          json["productDetails"].map((x) => ProductDetail.fromJson(x)),
        ),
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        updatedBy: json["updatedBy"],
        companyId: Id.fromJson(json["companyId"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "date": date.toIso8601String(),
    "number": number,
    "recipeId": List<dynamic>.from(recipeId.map((x) => x.toJson())),
    "allowReverseCalculation": allowReverseCalculation,
    "productDetails": List<dynamic>.from(productDetails.map((x) => x.toJson())),
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
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

class ProductDetail {
  final Id productId;
  final double qty;
  final double purchasePrice;
  final double landingCost;
  final double mrp;
  final double sellingPrice;
  final DateTime mfgDate;
  final int expiryDays;
  final List<Ingredient> ingredients;
  final String id;

  ProductDetail({
    required this.productId,
    required this.qty,
    required this.purchasePrice,
    required this.landingCost,
    required this.mrp,
    required this.sellingPrice,
    required this.mfgDate,
    required this.expiryDays,
    required this.ingredients,
    required this.id,
  });

  factory ProductDetail.fromRawJson(String str) =>
      ProductDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    productId: Id.fromJson(json["productId"]),
    qty: (json["qty"] ?? 0).toDouble(),
    purchasePrice: (json["purchasePrice"] ?? 0).toDouble(),
    landingCost: (json["landingCost"] ?? 0).toDouble(),
    mrp: (json["mrp"] ?? 0).toDouble(),
    sellingPrice: (json["sellingPrice"] ?? 0).toDouble(),
    mfgDate: DateTime.parse(json["mfgDate"]),
    expiryDays: json["expiryDays"],
    ingredients: List<Ingredient>.from(
      json["ingredients"].map((x) => Ingredient.fromJson(x)),
    ),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId.toJson(),
    "qty": qty,
    "purchasePrice": purchasePrice,
    "landingCost": landingCost,
    "mrp": mrp,
    "sellingPrice": sellingPrice,
    "mfgDate": mfgDate.toIso8601String(),
    "expiryDays": expiryDays,
    "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
    "_id": id,
  };
}

class Ingredient {
  final Id productId;
  final double availableQty;
  final double useQty;
  final String id;

  Ingredient({
    required this.productId,
    required this.availableQty,
    required this.useQty,
    required this.id,
  });

  factory Ingredient.fromRawJson(String str) =>
      Ingredient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    productId: Id.fromJson(json["productId"]),
    availableQty: (json["availableQty"] ?? 0).toDouble(),
    useQty: (json["useQty"] ?? 0).toDouble(),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId.toJson(),
    "availableQty": availableQty,
    "useQty": useQty,
    "_id": id,
  };
}
