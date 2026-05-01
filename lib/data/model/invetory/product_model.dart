import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class ProductModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy? createdBy;
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
  final IdNameModel? branchId;
  final TaxId? purchaseTaxId;
  final TaxId? salesTaxId;
  final bool isPurchaseTaxIncluding;
  final bool isSalesTaxIncluding;
  final double qty;
  final UomId? uomId;
  final IdNameModel? categoryId;
  final IdNameModel? brandId;
  final String? sku;
  final int? expiryDays;
  final String? calculateExpiryOn;
  final DateTime? expiryReferenceDate;
  final IdNameModel? productTypeId;
  final IdNameModel? subCategoryId;
  final IdNameModel? subBrandId;
  final String? hsnCode;
  final String? description;
  final String? shortDescription;
  final int? netWeight;
  final String? additionalInfo;

  const ProductModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
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

  ProductModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    CreatedBy? createdBy,
    String? updatedBy,
    String? companyId,
    List<String>? images,
    ProductType? productType,
    String? name,
    String? printName,
    int? cessPercentage,
    bool? manageMultipleBatch,
    bool? isExpiryProductSaleable,
    bool? hasExpiry,
    List<dynamic>? ingredients,
    int? masterQty,
    List<String>? stockIds,
    int? purchasePrice,
    double? landingCost,
    int? mrp,
    int? sellingPrice,
    int? sellingDiscount,
    double? sellingMargin,
    int? retailerDiscount,
    int? retailerPrice,
    int? retailerMargin,
    int? wholesalerDiscount,
    int? wholesalerPrice,
    int? wholesalerMargin,
    int? minimumQty,
    int? openingQty,
    int? onlinePrice,
    List<Nutrition>? nutrition,
    DateTime? createdAt,
    DateTime? updatedAt,
    IdNameModel? branchId,
    TaxId? purchaseTaxId,
    TaxId? salesTaxId,
    bool? isPurchaseTaxIncluding,
    bool? isSalesTaxIncluding,
    double? qty,
    UomId? uomId,
    IdNameModel? categoryId,
    IdNameModel? brandId,
    String? sku,
    int? expiryDays,
    String? calculateExpiryOn,
    DateTime? expiryReferenceDate,
    IdNameModel? productTypeId,
    IdNameModel? subCategoryId,
    IdNameModel? subBrandId,
    String? hsnCode,
    String? description,
    String? shortDescription,
    int? netWeight,
    String? additionalInfo,
  }) {
    return ProductModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      images: images ?? this.images,
      productType: productType ?? this.productType,
      name: name ?? this.name,
      printName: printName ?? this.printName,
      cessPercentage: cessPercentage ?? this.cessPercentage,
      manageMultipleBatch: manageMultipleBatch ?? this.manageMultipleBatch,
      isExpiryProductSaleable:
          isExpiryProductSaleable ?? this.isExpiryProductSaleable,
      hasExpiry: hasExpiry ?? this.hasExpiry,
      ingredients: ingredients ?? this.ingredients,
      masterQty: masterQty ?? this.masterQty,
      stockIds: stockIds ?? this.stockIds,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      landingCost: landingCost ?? this.landingCost,
      mrp: mrp ?? this.mrp,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      sellingDiscount: sellingDiscount ?? this.sellingDiscount,
      sellingMargin: sellingMargin ?? this.sellingMargin,
      retailerDiscount: retailerDiscount ?? this.retailerDiscount,
      retailerPrice: retailerPrice ?? this.retailerPrice,
      retailerMargin: retailerMargin ?? this.retailerMargin,
      wholesalerDiscount: wholesalerDiscount ?? this.wholesalerDiscount,
      wholesalerPrice: wholesalerPrice ?? this.wholesalerPrice,
      wholesalerMargin: wholesalerMargin ?? this.wholesalerMargin,
      minimumQty: minimumQty ?? this.minimumQty,
      openingQty: openingQty ?? this.openingQty,
      onlinePrice: onlinePrice ?? this.onlinePrice,
      nutrition: nutrition ?? this.nutrition,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      branchId: branchId ?? this.branchId,
      purchaseTaxId: purchaseTaxId ?? this.purchaseTaxId,
      salesTaxId: salesTaxId ?? this.salesTaxId,
      isPurchaseTaxIncluding:
          isPurchaseTaxIncluding ?? this.isPurchaseTaxIncluding,
      isSalesTaxIncluding: isSalesTaxIncluding ?? this.isSalesTaxIncluding,
      qty: qty ?? this.qty,
      uomId: uomId ?? this.uomId,
      categoryId: categoryId ?? this.categoryId,
      brandId: brandId ?? this.brandId,
      sku: sku ?? this.sku,
      expiryDays: expiryDays ?? this.expiryDays,
      calculateExpiryOn: calculateExpiryOn ?? this.calculateExpiryOn,
      expiryReferenceDate: expiryReferenceDate ?? this.expiryReferenceDate,
      productTypeId: productTypeId ?? this.productTypeId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      subBrandId: subBrandId ?? this.subBrandId,
      hsnCode: hsnCode ?? this.hsnCode,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      netWeight: netWeight ?? this.netWeight,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  factory ProductModel.fromJson(String json) =>
      ProductModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
    id: map["_id"] ?? '',
    isDeleted: map["isDeleted"] ?? false,
    isActive: map["isActive"] ?? false,
    createdBy: map["createdBy"] == null
        ? null
        : CreatedBy.fromMap(map["createdBy"]),
    updatedBy: map["updatedBy"] ?? '',
    companyId: map["companyId"],
    images: map["images"] != null
        ? List<String>.from(map["images"].map((x) => x))
        : [],
    productType:
        productTypeValues.map[map["productType"]] ?? ProductType.finished,
    name: map["name"] ?? '',
    printName: map["printName"] ?? '',
    cessPercentage: map["cessPercentage"],
    manageMultipleBatch: map["manageMultipleBatch"] ?? false,
    isExpiryProductSaleable: map["isExpiryProductSaleable"] ?? false,
    hasExpiry: map["hasExpiry"] ?? false,
    ingredients: map["ingredients"] != null
        ? (map["ingredients"] is List
            ? List<dynamic>.from(map["ingredients"].map((x) => x))
            : [map["ingredients"]])
        : [],
    masterQty: map["masterQty"],
    stockIds: map["stockIds"] == null
        ? []
        : List<String>.from(map["stockIds"]!.map((x) => x)),
    purchasePrice: map["purchasePrice"] ?? 0,
    landingCost: map["landingCost"]?.toDouble() ?? 0,
    mrp: map["mrp"] ?? 0,
    sellingPrice: map["sellingPrice"] ?? 0,
    sellingDiscount: map["sellingDiscount"] ?? 0,
    sellingMargin: map["sellingMargin"]?.toDouble() ?? 0,
    retailerDiscount: map["retailerDiscount"],
    retailerPrice: map["retailerPrice"],
    retailerMargin: map["retailerMargin"],
    wholesalerDiscount: map["wholesalerDiscount"],
    wholesalerPrice: map["wholesalerPrice"],
    wholesalerMargin: map["wholesalerMargin"],
    minimumQty: map["minimumQty"],
    openingQty: map["openingQty"],
    onlinePrice: map["onlinePrice"],
    nutrition: map["nutrition"] != null
        ? List<Nutrition>.from(
            map["nutrition"].map((x) => Nutrition.fromMap(x)),
          )
        : [],
    createdAt: map["createdAt"] != null
        ? DateTime.parse(map["createdAt"])
        : DateTime.now(),
    updatedAt: map["updatedAt"] != null
        ? DateTime.parse(map["updatedAt"])
        : DateTime.now(),
    branchId: map["branchId"] != null
        ? IdNameModel.fromMap(map["branchId"])
        : null,
    purchaseTaxId: map["purchaseTaxId"] == null
        ? null
        : TaxId.fromMap(map["purchaseTaxId"]),
    salesTaxId: map["salesTaxId"] == null
        ? null
        : TaxId.fromMap(map["salesTaxId"]),
    isPurchaseTaxIncluding: map["isPurchaseTaxIncluding"] ?? false,
    isSalesTaxIncluding: map["isSalesTaxIncluding"] ?? false,
    qty: map["qty"]?.toDouble() ?? 0,
    uomId: map["uomId"] == null ? null : UomId.fromMap(map["uomId"]),
    categoryId: map["categoryId"] == null
        ? null
        : IdNameModel.fromMap(map["categoryId"]),
    brandId: map["brandId"] == null
        ? null
        : IdNameModel.fromMap(map["brandId"]),
    sku: map["sku"],
    expiryDays: map["expiryDays"],
    calculateExpiryOn: map["calculateExpiryOn"],
    expiryReferenceDate: map["expiryReferenceDate"] == null
        ? null
        : DateTime.parse(map["expiryReferenceDate"]),
    productTypeId: map["productTypeId"] == null
        ? null
        : IdNameModel.fromMap(map["productTypeId"]),
    subCategoryId: map["subCategoryId"] == null
        ? null
        : IdNameModel.fromMap(map["subCategoryId"]),
    subBrandId: map["subBrandId"] == null
        ? null
        : IdNameModel.fromMap(map["subBrandId"]),
    hsnCode: map["hsnCode"],
    description: map["description"],
    shortDescription: map["shortDescription"],
    netWeight: map["netWeight"],
    additionalInfo: map["additionalInfo"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy?.toMap(),
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
    "nutrition": List<dynamic>.from(nutrition.map((x) => x.toMap())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "branchId": branchId?.toMap(),
    "purchaseTaxId": purchaseTaxId?.toMap(),
    "salesTaxId": salesTaxId?.toMap(),
    "isPurchaseTaxIncluding": isPurchaseTaxIncluding,
    "isSalesTaxIncluding": isSalesTaxIncluding,
    "qty": qty,
    "uomId": uomId?.toMap(),
    "categoryId": categoryId?.toMap(),
    "brandId": brandId?.toMap(),
    "sku": sku,
    "expiryDays": expiryDays,
    "calculateExpiryOn": calculateExpiryOn,
    "expiryReferenceDate": expiryReferenceDate?.toIso8601String(),
    "productTypeId": productTypeId?.toMap(),
    "subCategoryId": subCategoryId?.toMap(),
    "subBrandId": subBrandId?.toMap(),
    "hsnCode": hsnCode,
    "description": description,
    "shortDescription": shortDescription,
    "netWeight": netWeight,
    "additionalInfo": additionalInfo,
  };

  @override
  List<Object?> get props => [
    id,
    isDeleted,
    isActive,
    createdBy,
    updatedBy,
    companyId,
    images,
    productType,
    name,
    printName,
    cessPercentage,
    manageMultipleBatch,
    isExpiryProductSaleable,
    hasExpiry,
    ingredients,
    masterQty,
    stockIds,
    purchasePrice,
    landingCost,
    mrp,
    sellingPrice,
    sellingDiscount,
    sellingMargin,
    retailerDiscount,
    retailerPrice,
    retailerMargin,
    wholesalerDiscount,
    wholesalerPrice,
    wholesalerMargin,
    minimumQty,
    openingQty,
    onlinePrice,
    nutrition,
    createdAt,
    updatedAt,
    branchId,
    purchaseTaxId,
    salesTaxId,
    isPurchaseTaxIncluding,
    isSalesTaxIncluding,
    qty,
    uomId,
    categoryId,
    brandId,
    sku,
    expiryDays,
    calculateExpiryOn,
    expiryReferenceDate,
    productTypeId,
    subCategoryId,
    subBrandId,
    hsnCode,
    description,
    shortDescription,
    netWeight,
    additionalInfo,
  ];

  @override
  bool get stringify => true;
}

class CreatedBy extends Equatable {
  final String id;
  final String fullName;
  final UserType userType;

  const CreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  CreatedBy copyWith({String? id, String? fullName, UserType? userType}) {
    return CreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory CreatedBy.fromJson(String json) =>
      CreatedBy.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory CreatedBy.fromMap(Map<String, dynamic> map) => CreatedBy(
    id: map["_id"]?.toString() ?? '',
    fullName: map["fullName"]?.toString() ?? '',
    userType: userTypeValues.map[map["userType"]] ?? UserType.admin,
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "fullName": fullName,
    "userType": userTypeValues.reverse[userType],
  };

  @override
  List<Object?> get props => [id, fullName, userType];

  @override
  bool get stringify => true;
}

final userTypeValues = EnumValues({
  "admin": UserType.admin,
  "super-admin": UserType.superAdmin,
});

class Nutrition extends Equatable {
  final String name;
  final String value;
  final String? id;

  const Nutrition({required this.name, required this.value, this.id});

  Nutrition copyWith({String? name, String? value, String? id}) {
    return Nutrition(
      name: name ?? this.name,
      value: value ?? this.value,
      id: id ?? this.id,
    );
  }

  factory Nutrition.fromJson(String json) =>
      Nutrition.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory Nutrition.fromMap(Map<String, dynamic> map) => Nutrition(
    name: map["name"] ?? '',
    value: map["value"] ?? '',
    id: map["_id"] ?? '',
  );

  Map<String, dynamic> toMap() => {"name": name, "value": value, "_id": id};

  @override
  List<Object?> get props => [name, value, id];

  @override
  bool get stringify => true;
}

final productTypeValues = EnumValues({
  "finished": ProductType.finished,
  "raw_material": ProductType.raw_material,
  "semi_finished": ProductType.semi_finished,
  "non_inventory": ProductType.non_inventory,
  "service": ProductType.service,
});

class TaxId extends Equatable {
  final String id;
  final String name;
  final int percentage;

  const TaxId({required this.id, required this.name, required this.percentage});

  TaxId copyWith({String? id, String? name, int? percentage}) {
    return TaxId(
      id: id ?? this.id,
      name: name ?? this.name,
      percentage: percentage ?? this.percentage,
    );
  }

  factory TaxId.fromJson(String json) =>
      TaxId.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory TaxId.fromMap(Map<String, dynamic> map) => TaxId(
    id: map["_id"] ?? '',
    name: map["name"] ?? '',
    percentage: map["percentage"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
    "percentage": percentage,
  };

  @override
  List<Object?> get props => [id, name, percentage];

  @override
  bool get stringify => true;
}

class UomId extends Equatable {
  final String id;
  final String name;
  final String code;

  const UomId({required this.id, required this.name, required this.code});

  UomId copyWith({String? id, String? name, String? code}) {
    return UomId(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  factory UomId.fromJson(String json) =>
      UomId.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory UomId.fromMap(Map<String, dynamic> map) => UomId(
    id: map["_id"] ?? '',
    name: map["name"] ?? '',
    code: map["code"] ?? '',
  );

  Map<String, dynamic> toMap() => {"_id": id, "name": name, "code": code};

  @override
  List<Object?> get props => [id, name, code];

  @override
  bool get stringify => true;
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

class ProductItemModel extends Equatable {
  final String id;
  final String name;
  final String printName;
  final IdNameModel? categoryId;
  final IdNameModel? brandId;
  final TaxId? purchaseTaxId;
  final TaxId? salesTaxId;
  final int purchasePrice;
  final int mrp;
  final int sellingPrice;
  final double qty;
  final List<String> images;
  final CreatedBy? createdBy;

  const ProductItemModel({
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
    required this.images,
    this.createdBy,
  });

  ProductItemModel copyWith({
    String? id,
    String? name,
    String? printName,
    IdNameModel? categoryId,
    IdNameModel? brandId,
    TaxId? purchaseTaxId,
    TaxId? salesTaxId,
    int? purchasePrice,
    int? mrp,
    int? sellingPrice,
    double? qty,
    CreatedBy? createdBy,
  }) {
    return ProductItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      printName: printName ?? this.printName,
      categoryId: categoryId ?? this.categoryId,
      brandId: brandId ?? this.brandId,
      purchaseTaxId: purchaseTaxId ?? this.purchaseTaxId,
      salesTaxId: salesTaxId ?? this.salesTaxId,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      mrp: mrp ?? this.mrp,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      qty: qty ?? this.qty,
      images: images,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  factory ProductItemModel.fromJson(String json) =>
      ProductItemModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory ProductItemModel.fromMap(Map<String, dynamic> map) =>
      ProductItemModel(
        id: map["_id"] ?? '',
        name: map["name"] ?? '',
        printName: map["printName"] ?? '',
        categoryId: map["categoryId"] == null
            ? null
            : IdNameModel.fromMap(map["categoryId"]),
        brandId: map["brandId"] == null
            ? null
            : IdNameModel.fromMap(map["brandId"]),
        purchaseTaxId: map["purchaseTaxId"] == null
            ? null
            : TaxId.fromMap(map["purchaseTaxId"]),
        salesTaxId: map["salesTaxId"] == null
            ? null
            : TaxId.fromMap(map["salesTaxId"]),
        purchasePrice: map["purchasePrice"] ?? 0,
        mrp: map["mrp"] ?? 0,
        sellingPrice: map["sellingPrice"] ?? 0,
        qty: map["qty"]?.toDouble() ?? 0.0,
        images: map["images"] != null
            ? List<String>.from(map["images"].map((x) => x))
            : [],
        createdBy: map["createdBy"] == null
            ? null
            : CreatedBy.fromMap(map["createdBy"]),
      );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
    "printName": printName,
    "categoryId": categoryId?.toMap(),
    "brandId": brandId?.toMap(),
    "purchaseTaxId": purchaseTaxId?.toMap(),
    "salesTaxId": salesTaxId?.toMap(),
    "purchasePrice": purchasePrice,
    "mrp": mrp,
    "sellingPrice": sellingPrice,
    "qty": qty,
    "images": List<dynamic>.from(images.map((x) => x)),
    "createdBy": createdBy?.toMap(),
  };

  @override
  List<Object?> get props => [
    id,
    name,
    printName,
    categoryId,
    brandId,
    purchaseTaxId,
    salesTaxId,
    purchasePrice,
    mrp,
    sellingPrice,
    qty,
    images,
    createdBy,
  ];

  @override
  bool get stringify => true;
}

class ProductDropdownModel extends Equatable {
  final String id;
  final String name;
  final ProductType productType;
  final double qty;
  final double purchasePrice;
  final double landingCost;
  final double mrp;
  final double sellingPrice;
  final double sellingDiscount;
  final double sellingMargin;
  final TaxId? purchaseTaxId;
  final TaxId? salesTaxId;

  const ProductDropdownModel({
    required this.id,
    required this.name,
    required this.productType,
    required this.qty,
    required this.purchasePrice,
    required this.landingCost,
    required this.mrp,
    required this.sellingPrice,
    required this.sellingDiscount,
    required this.sellingMargin,
    this.purchaseTaxId,
    this.salesTaxId,
  });

  ProductDropdownModel copyWith({
    String? id,
    String? name,
    ProductType? productType,
    double? qty,
    double? purchasePrice,
    double? landingCost,
    double? mrp,
    double? sellingPrice,
    double? sellingDiscount,
    double? sellingMargin,
    TaxId? purchaseTaxId,
    TaxId? salesTaxId,
  }) {
    return ProductDropdownModel(
      id: id ?? this.id,
      name: name ?? this.name,
      productType: productType ?? this.productType,
      qty: qty ?? this.qty,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      landingCost: landingCost ?? this.landingCost,
      mrp: mrp ?? this.mrp,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      sellingDiscount: sellingDiscount ?? this.sellingDiscount,
      sellingMargin: sellingMargin ?? this.sellingMargin,
      purchaseTaxId: purchaseTaxId ?? this.purchaseTaxId,
      salesTaxId: salesTaxId ?? this.salesTaxId,
    );
  }

  factory ProductDropdownModel.fromJson(String json) =>
      ProductDropdownModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory ProductDropdownModel.fromMap(Map<String, dynamic> map) =>
      ProductDropdownModel(
        id: map["_id"] ?? '',
        name: map["name"] ?? '',
        productType:
            productTypeValues.map[map["productType"] ?? ''] ??
            ProductType.finished,
        qty: map["qty"]?.toDouble() ?? 0.0,
        purchasePrice: map["purchasePrice"]?.toDouble() ?? 0.0,
        landingCost: map["landingCost"]?.toDouble() ?? 0.0,
        mrp: map["mrp"]?.toDouble() ?? 0.0,
        sellingPrice: map["sellingPrice"]?.toDouble() ?? 0.0,
        sellingDiscount: map["sellingDiscount"]?.toDouble() ?? 0.0,
        sellingMargin: map["sellingMargin"]?.toDouble() ?? 0.0,
        purchaseTaxId: map["purchaseTaxId"] == null
            ? null
            : TaxId.fromMap(map["purchaseTaxId"]),
        salesTaxId: map["salesTaxId"] == null
            ? null
            : TaxId.fromMap(map["salesTaxId"]),
      );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
    "productType": productTypeValues.reverse[productType],
    "qty": qty,
    "purchasePrice": purchasePrice,
    "landingCost": landingCost,
    "mrp": mrp,
    "sellingPrice": sellingPrice,
    "sellingDiscount": sellingDiscount,
    "sellingMargin": sellingMargin,
    "purchaseTaxId": purchaseTaxId?.toMap(),
    "salesTaxId": salesTaxId?.toMap(),
  };

  @override
  List<Object?> get props => [
    id,
    name,
    productType,
    qty,
    purchasePrice,
    landingCost,
    mrp,
    sellingPrice,
    sellingDiscount,
    sellingMargin,
    purchaseTaxId,
    salesTaxId,
  ];

  @override
  bool get stringify => true;
}
