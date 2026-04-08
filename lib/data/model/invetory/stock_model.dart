import 'dart:convert';

import 'package:ai_setu/core/constants/enums.dart';

class StockModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final List<String> images;
  final ProductType productType;
  final String name;
  final String printName;
  final Id? categoryId;
  final Id? subCategoryId;
  final Id? brandId;
  final Id? subBrandId;
  final String? hsnCode;
  final int? cessPercentage;
  final bool manageMultipleBatch;
  final bool isExpiryProductSaleable;
  final bool hasExpiry;
  final DateTime? expiryReferenceDate;
  final List<dynamic> ingredients;
  final String? description;
  final String? shortDescription;
  final int? netWeight;
  final List<Nutrition> nutrition;
  final int? masterQty;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? calculateExpiryOn;
  final int? expiryDays;
  final List<String>? stockIds;
  final String? sku;
  final String? productTypeId;
  final double availableQty;
  final int? purchasePrice;
  final int? landingCost;
  final int? mrp;
  final int? sellingPrice;
  final int? sellingDiscount;
  final int? sellingMargin;
  final int? retailerDiscount;
  final int? retailerPrice;
  final int? retailerMargin;
  final int? wholesalerDiscount;
  final int? wholesalerPrice;
  final int? wholesalerMargin;
  final int? minimumQty;
  final int? openingQty;
  final int? onlinePrice;
  final String? additionalInfo;
  final String? companyId;
  final String? branchId;

  StockModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.images,
    required this.productType,
    required this.name,
    required this.printName,
    this.categoryId,
    this.subCategoryId,
    this.brandId,
    this.subBrandId,
    this.hsnCode,
    required this.cessPercentage,
    required this.manageMultipleBatch,
    required this.isExpiryProductSaleable,
    required this.hasExpiry,
    this.expiryReferenceDate,
    required this.ingredients,
    this.description,
    this.shortDescription,
    this.netWeight,
    required this.nutrition,
    required this.masterQty,
    required this.createdAt,
    required this.updatedAt,
    this.calculateExpiryOn,
    this.expiryDays,
    this.stockIds,
    this.sku,
    this.productTypeId,
    required this.availableQty,
    this.purchasePrice,
    this.landingCost,
    this.mrp,
    this.sellingPrice,
    this.sellingDiscount,
    this.sellingMargin,
    this.retailerDiscount,
    this.retailerPrice,
    this.retailerMargin,
    this.wholesalerDiscount,
    this.wholesalerPrice,
    this.wholesalerMargin,
    this.minimumQty,
    this.openingQty,
    this.onlinePrice,
    this.additionalInfo,
    this.companyId,
    this.branchId,
  });

  factory StockModel.fromRawJson(String str) =>
      StockModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
    id: json["_id"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    createdBy: CreatedBy.fromJson(json["createdBy"]),
    updatedBy: json["updatedBy"],
    images: List<String>.from(json["images"].map((x) => x)),
    productType: productTypeValues.map[json["productType"]]!,
    name: json["name"],
    printName: json["printName"],
    categoryId: json["categoryId"] == null
        ? null
        : Id.fromJson(json["categoryId"]),
    subCategoryId: json["subCategoryId"] == null
        ? null
        : Id.fromJson(json["subCategoryId"]),
    brandId: json["brandId"] == null ? null : Id.fromJson(json["brandId"]),
    subBrandId: json["subBrandId"] == null
        ? null
        : Id.fromJson(json["subBrandId"]),
    hsnCode: json["hsnCode"],
    cessPercentage: json["cessPercentage"],
    manageMultipleBatch: json["manageMultipleBatch"],
    isExpiryProductSaleable: json["isExpiryProductSaleable"],
    hasExpiry: json["hasExpiry"],
    expiryReferenceDate: json["expiryReferenceDate"] == null
        ? null
        : DateTime.parse(json["expiryReferenceDate"]),
    ingredients: List<dynamic>.from(json["ingredients"].map((x) => x)),
    description: json["description"],
    shortDescription: json["shortDescription"],
    netWeight: json["netWeight"],
    nutrition: List<Nutrition>.from(
      json["nutrition"].map((x) => Nutrition.fromJson(x)),
    ),
    masterQty: json["masterQty"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    calculateExpiryOn: json["calculateExpiryOn"],
    expiryDays: json["expiryDays"],
    stockIds: json["stockIds"] == null
        ? []
        : List<String>.from(json["stockIds"]!.map((x) => x)),
    sku: json["sku"],
    productTypeId: json["productTypeId"],
    availableQty: json["availableQty"]?.toDouble(),
    purchasePrice: json["purchasePrice"],
    landingCost: json["landingCost"],
    mrp: json["mrp"],
    sellingPrice: json["sellingPrice"],
    sellingDiscount: json["sellingDiscount"],
    sellingMargin: json["sellingMargin"],
    retailerDiscount: json["retailerDiscount"],
    retailerPrice: json["retailerPrice"],
    retailerMargin: json["retailerMargin"],
    wholesalerDiscount: json["wholesalerDiscount"],
    wholesalerPrice: json["wholesalerPrice"],
    wholesalerMargin: json["wholesalerMargin"],
    minimumQty: json["minimumQty"],
    openingQty: json["openingQty"],
    onlinePrice: json["onlinePrice"],
    additionalInfo: json["additionalInfo"],
    companyId: json["companyId"],
    branchId: json["branchId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "images": List<dynamic>.from(images.map((x) => x)),
    "productType": productTypeValues.reverse[productType],
    "name": name,
    "printName": printName,
    "categoryId": categoryId?.toJson(),
    "subCategoryId": subCategoryId?.toJson(),
    "brandId": brandId?.toJson(),
    "subBrandId": subBrandId?.toJson(),
    "hsnCode": hsnCode,
    "cessPercentage": cessPercentage,
    "manageMultipleBatch": manageMultipleBatch,
    "isExpiryProductSaleable": isExpiryProductSaleable,
    "hasExpiry": hasExpiry,
    "expiryReferenceDate": expiryReferenceDate?.toIso8601String(),
    "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
    "description": description,
    "shortDescription": shortDescription,
    "netWeight": netWeight,
    "nutrition": List<dynamic>.from(nutrition.map((x) => x.toJson())),
    "masterQty": masterQty,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "calculateExpiryOn": calculateExpiryOn,
    "expiryDays": expiryDays,
    "stockIds": stockIds == null
        ? []
        : List<dynamic>.from(stockIds!.map((x) => x)),
    "sku": sku,
    "productTypeId": productTypeId,
    "availableQty": availableQty,
    "purchasePrice": purchasePrice,
    "landingCost": landingCost,
    "mrp": mrp,
    "sellingPrice": sellingPrice,
    "sellingDiscount": sellingDiscount,
    "sellingMargin": sellingMargin,
    "retailerDiscount": retailerDiscount,
    "retailerPrice": retailerPrice,
    "retailerMargin": retailerMargin,
    "wholesalerDiscount": wholesalerDiscount,
    "wholesalerPrice": wholesalerPrice,
    "wholesalerMargin": wholesalerMargin,
    "minimumQty": minimumQty,
    "openingQty": openingQty,
    "onlinePrice": onlinePrice,
    "additionalInfo": additionalInfo,
    "companyId": companyId,
    "branchId": branchId,
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
  final UserType userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromRawJson(String str) =>
      CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["_id"],
    fullName: json["fullName"],
    userType: userTypeValues.map[json["userType"]]!,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userTypeValues.reverse[userType],
  };
}

final userTypeValues = EnumValues({
  "admin": UserType.admin,
  "super-admin": UserType.superAdmin,
});

class Nutrition {
  final String name;
  final String value;
  final String id;

  Nutrition({required this.name, required this.value, required this.id});

  factory Nutrition.fromRawJson(String str) =>
      Nutrition.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Nutrition.fromJson(Map<String, dynamic> json) =>
      Nutrition(name: json["name"], value: json["value"], id: json["_id"]);

  Map<String, dynamic> toJson() => {"name": name, "value": value, "_id": id};
}

final productTypeValues = EnumValues({
  "finished": ProductType.finished,
  "raw_material": ProductType.raw_material,
  "semi_finished": ProductType.semi_finished,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class StockItemModel {
  final String id;
  final String name;
  final Id? categoryId;
  final Id? subCategoryId;
  final Id? brandId;
  final Id? subBrandId;
  final double availableQty;
  final CreatedBy createdBy;

  StockItemModel({
    required this.id,
    required this.name,
    this.categoryId,
    this.subCategoryId,
    this.brandId,
    this.subBrandId,
    required this.availableQty,
    required this.createdBy,
  });

  factory StockItemModel.fromRawJson(String str) =>
      StockItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockItemModel.fromJson(Map<String, dynamic> json) => StockItemModel(
    id: json["_id"] ?? '',
    name: json["name"] ?? json["productName"] ?? '',
    categoryId: json["categoryId"] == null
        ? null
        : Id.fromJson(json["categoryId"]),
    subCategoryId: json["subCategoryId"] == null
        ? null
        : Id.fromJson(json["subCategoryId"]),
    brandId: json["brandId"] == null ? null : Id.fromJson(json["brandId"]),
    subBrandId: json["subBrandId"] == null
        ? null
        : Id.fromJson(json["subBrandId"]),
    availableQty: (json["availableQty"] ?? 0).toDouble(),
    createdBy: CreatedBy.fromJson(json["createdBy"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "categoryId": categoryId?.toJson(),
    "subCategoryId": subCategoryId?.toJson(),
    "brandId": brandId?.toJson(),
    "subBrandId": subBrandId?.toJson(),
    "availableQty": availableQty,
    "createdBy": createdBy.toJson(),
  };
}
