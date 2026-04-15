import 'dart:convert';

import 'package:ai_setu/core/constants/enums.dart';

class ProductModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final String? companyId;
  final List<String> images;
  final ProductType productType;
  final String name;
  final String printName;
  final int? cessPercentage;
  final bool manageMultipleBatch;
  final bool isExpiryProductSaleable;
  final bool hasExpiry;
  final List<dynamic> ingredients;
  final int? masterQty;
  final List<String>? stockIds;
  final int purchasePrice;
  final double landingCost;
  final int mrp;
  final int sellingPrice;
  final int sellingDiscount;
  final double sellingMargin;
  final int? retailerDiscount;
  final int? retailerPrice;
  final int? retailerMargin;
  final int? wholesalerDiscount;
  final int? wholesalerPrice;
  final int? wholesalerMargin;
  final int? minimumQty;
  final int? openingQty;
  final int? onlinePrice;
  final List<Nutrition> nutrition;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? branchId;
  final TaxId? purchaseTaxId;
  final TaxId? salesTaxId;
  final bool isPurchaseTaxIncluding;
  final bool isSalesTaxIncluding;
  final double qty;
  final UomId? uomId;
  final Id? categoryId;
  final Id? brandId;
  final String? sku;
  final int? expiryDays;
  final String? calculateExpiryOn;
  final DateTime? expiryReferenceDate;
  final Id? productTypeId;
  final Id? subCategoryId;
  final Id? subBrandId;
  final String? hsnCode;
  final String? description;
  final String? shortDescription;
  final int? netWeight;
  final String? additionalInfo;

  ProductModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    this.companyId,
    required this.images,
    required this.productType,
    required this.name,
    required this.printName,
    required this.cessPercentage,
    required this.manageMultipleBatch,
    required this.isExpiryProductSaleable,
    required this.hasExpiry,
    required this.ingredients,
    required this.masterQty,
    this.stockIds,
    required this.purchasePrice,
    required this.landingCost,
    required this.mrp,
    required this.sellingPrice,
    required this.sellingDiscount,
    required this.sellingMargin,
    this.retailerDiscount,
    this.retailerPrice,
    this.retailerMargin,
    this.wholesalerDiscount,
    this.wholesalerPrice,
    this.wholesalerMargin,
    this.minimumQty,
    this.openingQty,
    this.onlinePrice,
    required this.nutrition,
    required this.createdAt,
    required this.updatedAt,
    this.branchId,
    required this.purchaseTaxId,
    required this.salesTaxId,
    required this.isPurchaseTaxIncluding,
    required this.isSalesTaxIncluding,
    required this.qty,
    required this.uomId,
    this.categoryId,
    this.brandId,
    this.sku,
    this.expiryDays,
    this.calculateExpiryOn,
    this.expiryReferenceDate,
    this.productTypeId,
    this.subCategoryId,
    this.subBrandId,
    this.hsnCode,
    this.description,
    this.shortDescription,
    this.netWeight,
    this.additionalInfo,
  });

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["_id"] ?? '',
    isDeleted: json["isDeleted"] ?? false,
    isActive: json["isActive"] ?? false,
    createdBy: CreatedBy.fromJson(json["createdBy"] ?? {}),
    updatedBy: json["updatedBy"] ?? '',
    companyId: json["companyId"],
    images: json["images"] != null
        ? List<String>.from(json["images"].map((x) => x))
        : [],
    productType:
        productTypeValues.map[json["productType"]] ?? ProductType.finished,
    name: json["name"] ?? '',
    printName: json["printName"] ?? '',
    cessPercentage: json["cessPercentage"],
    manageMultipleBatch: json["manageMultipleBatch"] ?? false,
    isExpiryProductSaleable: json["isExpiryProductSaleable"] ?? false,
    hasExpiry: json["hasExpiry"] ?? false,
    ingredients: json["ingredients"] != null
        ? List<dynamic>.from(json["ingredients"].map((x) => x))
        : [],
    masterQty: json["masterQty"],
    stockIds: json["stockIds"] == null
        ? []
        : List<String>.from(json["stockIds"]!.map((x) => x)),
    purchasePrice: json["purchasePrice"] ?? 0,
    landingCost: json["landingCost"]?.toDouble() ?? 0,
    mrp: json["mrp"] ?? 0,
    sellingPrice: json["sellingPrice"] ?? 0,
    sellingDiscount: json["sellingDiscount"] ?? 0,
    sellingMargin: json["sellingMargin"]?.toDouble() ?? 0,
    retailerDiscount: json["retailerDiscount"],
    retailerPrice: json["retailerPrice"],
    retailerMargin: json["retailerMargin"],
    wholesalerDiscount: json["wholesalerDiscount"],
    wholesalerPrice: json["wholesalerPrice"],
    wholesalerMargin: json["wholesalerMargin"],
    minimumQty: json["minimumQty"],
    openingQty: json["openingQty"],
    onlinePrice: json["onlinePrice"],
    nutrition: json["nutrition"] != null
        ? List<Nutrition>.from(
            json["nutrition"].map((x) => Nutrition.fromJson(x)),
          )
        : [],
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : DateTime.now(),
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : DateTime.now(),
    branchId: json["branchId"],
    purchaseTaxId: json["purchaseTaxId"] == null
        ? null
        : TaxId.fromJson(json["purchaseTaxId"]),
    salesTaxId: json["salesTaxId"] == null
        ? null
        : TaxId.fromJson(json["salesTaxId"]),
    isPurchaseTaxIncluding: json["isPurchaseTaxIncluding"] ?? false,
    isSalesTaxIncluding: json["isSalesTaxIncluding"] ?? false,
    qty: json["qty"]?.toDouble() ?? 0,
    uomId: json["uomId"] == null ? null : UomId.fromJson(json["uomId"]),
    categoryId: json["categoryId"] == null
        ? null
        : Id.fromJson(json["categoryId"]),
    brandId: json["brandId"] == null ? null : Id.fromJson(json["brandId"]),
    sku: json["sku"],
    expiryDays: json["expiryDays"],
    calculateExpiryOn: json["calculateExpiryOn"],
    expiryReferenceDate: json["expiryReferenceDate"] == null
        ? null
        : DateTime.parse(json["expiryReferenceDate"]),
    productTypeId: json["productTypeId"] == null
        ? null
        : Id.fromJson(json["productTypeId"]),
    subCategoryId: json["subCategoryId"] == null
        ? null
        : Id.fromJson(json["subCategoryId"]),
    subBrandId: json["subBrandId"] == null
        ? null
        : Id.fromJson(json["subBrandId"]),
    hsnCode: json["hsnCode"],
    description: json["description"],
    shortDescription: json["shortDescription"],
    netWeight: json["netWeight"],
    additionalInfo: json["additionalInfo"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId,
    "images": List<dynamic>.from(images.map((x) => x)),
    "productType": productTypeValues.reverse[productType],
    "name": name,
    "printName": printName,
    "cessPercentage": cessPercentage,
    "manageMultipleBatch": manageMultipleBatch,
    "isExpiryProductSaleable": isExpiryProductSaleable,
    "hasExpiry": hasExpiry,
    "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
    "masterQty": masterQty,
    "stockIds": stockIds == null
        ? []
        : List<dynamic>.from(stockIds!.map((x) => x)),
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
    "nutrition": List<dynamic>.from(nutrition.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "branchId": branchId,
    "purchaseTaxId": purchaseTaxId?.toJson(),
    "salesTaxId": salesTaxId?.toJson(),
    "isPurchaseTaxIncluding": isPurchaseTaxIncluding,
    "isSalesTaxIncluding": isSalesTaxIncluding,
    "qty": qty,
    "uomId": uomId?.toJson(),
    "categoryId": categoryId?.toJson(),
    "brandId": brandId?.toJson(),
    "sku": sku,
    "expiryDays": expiryDays,
    "calculateExpiryOn": calculateExpiryOn,
    "expiryReferenceDate": expiryReferenceDate?.toIso8601String(),
    "productTypeId": productTypeId?.toJson(),
    "subCategoryId": subCategoryId?.toJson(),
    "subBrandId": subBrandId?.toJson(),
    "hsnCode": hsnCode,
    "description": description,
    "shortDescription": shortDescription,
    "netWeight": netWeight,
    "additionalInfo": additionalInfo,
  };
}

class Id {
  final String id;
  final String name;

  Id({required this.id, required this.name});

  factory Id.fromRawJson(String str) => Id.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Id.fromJson(Map<String, dynamic> json) =>
      Id(id: json["_id"] ?? '', name: json["name"] ?? '');

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
    id: json["_id"] ?? '',
    fullName: json["fullName"] ?? '',
    userType: userTypeValues.map[json["userType"]] ?? UserType.admin,
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
  final String? id;

  Nutrition({required this.name, required this.value, this.id});

  factory Nutrition.fromRawJson(String str) =>
      Nutrition.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Nutrition.fromJson(Map<String, dynamic> json) => Nutrition(
    name: json["name"] ?? '',
    value: json["value"] ?? '',
    id: json["_id"] ?? '',
  );

  Map<String, dynamic> toJson() => {"name": name, "value": value, "_id": id};
}

final productTypeValues = EnumValues({
  "finished": ProductType.finished,
  "raw_material": ProductType.raw_material,
  "semi_finished": ProductType.semi_finished,
});

class TaxId {
  final String id;
  final String name;
  final int percentage;

  TaxId({required this.id, required this.name, required this.percentage});

  factory TaxId.fromRawJson(String str) => TaxId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxId.fromJson(Map<String, dynamic> json) => TaxId(
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    percentage: json["percentage"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "percentage": percentage,
  };
}

class UomId {
  final String id;
  final String name;
  final String code;

  UomId({required this.id, required this.name, required this.code});

  factory UomId.fromRawJson(String str) => UomId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UomId.fromJson(Map<String, dynamic> json) => UomId(
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    code: json["code"] ?? '',
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "code": code};
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class ProductItemModel {
  final String id;
  final String name;
  final String printName;
  final Id? categoryId;
  final Id? brandId;
  final TaxId? purchaseTaxId;
  final TaxId? salesTaxId;
  final int purchasePrice;
  final int mrp;
  final int sellingPrice;
  final double qty;
  final CreatedBy createdBy;

  ProductItemModel({
    required this.id,
    required this.name,
    required this.printName,
    this.categoryId,
    this.brandId,
    this.purchaseTaxId,
    this.salesTaxId,
    required this.purchasePrice,
    required this.mrp,
    required this.sellingPrice,
    required this.qty,
    required this.createdBy,
  });

  factory ProductItemModel.fromRawJson(String str) =>
      ProductItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductItemModel.fromJson(Map<String, dynamic> json) =>
      ProductItemModel(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        printName: json["printName"] ?? '',
        categoryId: json["categoryId"] == null
            ? null
            : Id.fromJson(json["categoryId"]),
        brandId: json["brandId"] == null ? null : Id.fromJson(json["brandId"]),
        purchaseTaxId: json["purchaseTaxId"] == null
            ? null
            : TaxId.fromJson(json["purchaseTaxId"]),
        salesTaxId: json["salesTaxId"] == null
            ? null
            : TaxId.fromJson(json["salesTaxId"]),
        purchasePrice: json["purchasePrice"] ?? 0,
        mrp: json["mrp"] ?? 0,
        sellingPrice: json["sellingPrice"] ?? 0,
        qty: json["qty"]?.toDouble() ?? 0.0,
        createdBy: CreatedBy.fromJson(json["createdBy"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "printName": printName,
    "categoryId": categoryId?.toJson(),
    "brandId": brandId?.toJson(),
    "purchaseTaxId": purchaseTaxId?.toJson(),
    "salesTaxId": salesTaxId?.toJson(),
    "purchasePrice": purchasePrice,
    "mrp": mrp,
    "sellingPrice": sellingPrice,
    "qty": qty,
    "createdBy": createdBy.toJson(),
  };
}
