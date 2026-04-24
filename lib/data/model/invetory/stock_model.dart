import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class StockModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final StockCreatedBy? createdBy;
  final String updatedBy;
  final List<String> images;
  final ProductType productType;
  final String name;
  final String printName;
  final IdNameModel? categoryId;
  final IdNameModel? subCategoryId;
  final IdNameModel? brandId;
  final IdNameModel? subBrandId;
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
  final List<StockNutrition> nutrition;
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

  const StockModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
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
    this.cessPercentage,
    required this.manageMultipleBatch,
    required this.isExpiryProductSaleable,
    required this.hasExpiry,
    this.expiryReferenceDate,
    required this.ingredients,
    this.description,
    this.shortDescription,
    this.netWeight,
    required this.nutrition,
    this.masterQty,
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

  StockModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    StockCreatedBy? createdBy,
    String? updatedBy,
    List<String>? images,
    ProductType? productType,
    String? name,
    String? printName,
    IdNameModel? categoryId,
    IdNameModel? subCategoryId,
    IdNameModel? brandId,
    IdNameModel? subBrandId,
    String? hsnCode,
    int? cessPercentage,
    bool? manageMultipleBatch,
    bool? isExpiryProductSaleable,
    bool? hasExpiry,
    DateTime? expiryReferenceDate,
    List<dynamic>? ingredients,
    String? description,
    String? shortDescription,
    int? netWeight,
    List<StockNutrition>? nutrition,
    int? masterQty,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? calculateExpiryOn,
    int? expiryDays,
    List<String>? stockIds,
    String? sku,
    String? productTypeId,
    double? availableQty,
    int? purchasePrice,
    int? landingCost,
    int? mrp,
    int? sellingPrice,
    int? sellingDiscount,
    int? sellingMargin,
    int? retailerDiscount,
    int? retailerPrice,
    int? retailerMargin,
    int? wholesalerDiscount,
    int? wholesalerPrice,
    int? wholesalerMargin,
    int? minimumQty,
    int? openingQty,
    int? onlinePrice,
    String? additionalInfo,
    String? companyId,
    String? branchId,
  }) {
    return StockModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      images: images ?? this.images,
      productType: productType ?? this.productType,
      name: name ?? this.name,
      printName: printName ?? this.printName,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      brandId: brandId ?? this.brandId,
      subBrandId: subBrandId ?? this.subBrandId,
      hsnCode: hsnCode ?? this.hsnCode,
      cessPercentage: cessPercentage ?? this.cessPercentage,
      manageMultipleBatch: manageMultipleBatch ?? this.manageMultipleBatch,
      isExpiryProductSaleable:
          isExpiryProductSaleable ?? this.isExpiryProductSaleable,
      hasExpiry: hasExpiry ?? this.hasExpiry,
      expiryReferenceDate: expiryReferenceDate ?? this.expiryReferenceDate,
      ingredients: ingredients ?? this.ingredients,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      netWeight: netWeight ?? this.netWeight,
      nutrition: nutrition ?? this.nutrition,
      masterQty: masterQty ?? this.masterQty,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      calculateExpiryOn: calculateExpiryOn ?? this.calculateExpiryOn,
      expiryDays: expiryDays ?? this.expiryDays,
      stockIds: stockIds ?? this.stockIds,
      sku: sku ?? this.sku,
      productTypeId: productTypeId ?? this.productTypeId,
      availableQty: availableQty ?? this.availableQty,
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
      additionalInfo: additionalInfo ?? this.additionalInfo,
      companyId: companyId ?? this.companyId,
      branchId: branchId ?? this.branchId,
    );
  }

  factory StockModel.fromJson(String json) =>
      StockModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory StockModel.fromMap(Map<String, dynamic> map) => StockModel(
        id: map["_id"] as String? ?? '',
        isDeleted: map["isDeleted"] as bool? ?? false,
        isActive: map["isActive"] as bool? ?? true,
        createdBy: map["createdBy"] == null
            ? null
            : StockCreatedBy.fromMap(map["createdBy"] as Map<String, dynamic>),
        updatedBy: map["updatedBy"]?.toString() ?? "",
        images: List<String>.from(
            (map["images"] as List<dynamic>?)?.map((x) => x.toString()) ?? []),
        productType: _productTypeValues.map[map["productType"]] ?? ProductType.finished,
        name: map["name"]?.toString() ?? "",
        printName: map["printName"]?.toString() ?? "",
        categoryId: map["categoryId"] == null
            ? null
            : IdNameModel.fromMap(map["categoryId"]),
        subCategoryId: map["subCategoryId"] == null
            ? null
            : IdNameModel.fromMap(map["subCategoryId"]),
        brandId: map["brandId"] == null
            ? null
            : IdNameModel.fromMap(map["brandId"]),
        subBrandId: map["subBrandId"] == null
            ? null
            : IdNameModel.fromMap(map["subBrandId"]),
        hsnCode: map["hsnCode"]?.toString(),
        cessPercentage: (map["cessPercentage"] as num?)?.toInt(),
        manageMultipleBatch: map["manageMultipleBatch"] as bool? ?? false,
        isExpiryProductSaleable: map["isExpiryProductSaleable"] as bool? ?? false,
        hasExpiry: map["hasExpiry"] as bool? ?? false,
        expiryReferenceDate: map["expiryReferenceDate"] == null
            ? null
            : DateTime.tryParse(map["expiryReferenceDate"].toString()),
        ingredients: List<dynamic>.from(map["ingredients"] ?? []),
        description: map["description"]?.toString(),
        shortDescription: map["shortDescription"]?.toString(),
        netWeight: (map["netWeight"] as num?)?.toInt(),
        nutrition: List<StockNutrition>.from(
          (map["nutrition"] as List<dynamic>?)
                  ?.map((x) => StockNutrition.fromMap(x as Map<String, dynamic>)) ??
              [],
        ),
        masterQty: (map["masterQty"] as num?)?.toInt(),
        createdAt: map["createdAt"] != null
            ? DateTime.parse(map["createdAt"].toString())
            : DateTime.now(),
        updatedAt: map["updatedAt"] != null
            ? DateTime.parse(map["updatedAt"].toString())
            : DateTime.now(),
        calculateExpiryOn: map["calculateExpiryOn"]?.toString(),
        expiryDays: (map["expiryDays"] as num?)?.toInt(),
        stockIds: (map["stockIds"] as List<dynamic>?)
            ?.map((x) => x.toString())
            .toList(),
        sku: map["sku"]?.toString(),
        productTypeId: map["productTypeId"]?.toString(),
        availableQty: (map["availableQty"] as num? ?? 0).toDouble(),
        purchasePrice: (map["purchasePrice"] as num?)?.toInt(),
        landingCost: (map["landingCost"] as num?)?.toInt(),
        mrp: (map["mrp"] as num?)?.toInt(),
        sellingPrice: (map["sellingPrice"] as num?)?.toInt(),
        sellingDiscount: (map["sellingDiscount"] as num?)?.toInt(),
        sellingMargin: (map["sellingMargin"] as num?)?.toInt(),
        retailerDiscount: (map["retailerDiscount"] as num?)?.toInt(),
        retailerPrice: (map["retailerPrice"] as num?)?.toInt(),
        retailerMargin: (map["retailerMargin"] as num?)?.toInt(),
        wholesalerDiscount: (map["wholesalerDiscount"] as num?)?.toInt(),
        wholesalerPrice: (map["wholesalerPrice"] as num?)?.toInt(),
        wholesalerMargin: (map["wholesalerMargin"] as num?)?.toInt(),
        minimumQty: (map["minimumQty"] as num?)?.toInt(),
        openingQty: (map["openingQty"] as num?)?.toInt(),
        onlinePrice: (map["onlinePrice"] as num?)?.toInt(),
        additionalInfo: map["additionalInfo"]?.toString(),
        companyId: map["companyId"]?.toString(),
        branchId: map["branchId"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy?.toMap(),
        "updatedBy": updatedBy,
        "images": images,
        "productType": _productTypeValues.reverse[productType],
        "name": name,
        "printName": printName,
        "categoryId": categoryId?.toMap(),
        "subCategoryId": subCategoryId?.toMap(),
        "brandId": brandId?.toMap(),
        "subBrandId": subBrandId?.toMap(),
        "hsnCode": hsnCode,
        "cessPercentage": cessPercentage,
        "manageMultipleBatch": manageMultipleBatch,
        "isExpiryProductSaleable": isExpiryProductSaleable,
        "hasExpiry": hasExpiry,
        "expiryReferenceDate": expiryReferenceDate?.toIso8601String(),
        "ingredients": ingredients,
        "description": description,
        "shortDescription": shortDescription,
        "netWeight": netWeight,
        "nutrition": nutrition.map((x) => x.toMap()).toList(),
        "masterQty": masterQty,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "calculateExpiryOn": calculateExpiryOn,
        "expiryDays": expiryDays,
        "stockIds": stockIds,
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

  @override
  List<Object?> get props => [
        id,
        isDeleted,
        isActive,
        createdBy,
        updatedBy,
        images,
        productType,
        name,
        printName,
        categoryId,
        subCategoryId,
        brandId,
        subBrandId,
        hsnCode,
        cessPercentage,
        manageMultipleBatch,
        isExpiryProductSaleable,
        hasExpiry,
        expiryReferenceDate,
        ingredients,
        description,
        shortDescription,
        netWeight,
        nutrition,
        masterQty,
        createdAt,
        updatedAt,
        calculateExpiryOn,
        expiryDays,
        stockIds,
        sku,
        productTypeId,
        availableQty,
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
        additionalInfo,
        companyId,
        branchId,
      ];

  @override
  bool get stringify => true;
}

class StockCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final UserType userType;

  const StockCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  StockCreatedBy copyWith({
    String? id,
    String? fullName,
    UserType? userType,
  }) {
    return StockCreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory StockCreatedBy.fromJson(String json) =>
      StockCreatedBy.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory StockCreatedBy.fromMap(Map<String, dynamic> map) => StockCreatedBy(
        id: map["_id"]?.toString() ?? "",
        fullName: map["fullName"]?.toString() ?? "",
        userType: _userTypeValues.map[map["userType"]] ?? UserType.admin,
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "fullName": fullName,
        "userType": _userTypeValues.reverse[userType],
      };

  @override
  List<Object?> get props => [id, fullName, userType];

  @override
  bool get stringify => true;
}

class StockNutrition extends Equatable {
  final String name;
  final String value;
  final String id;

  const StockNutrition({
    required this.name,
    required this.value,
    required this.id,
  });

  StockNutrition copyWith({
    String? name,
    String? value,
    String? id,
  }) {
    return StockNutrition(
      name: name ?? this.name,
      value: value ?? this.value,
      id: id ?? this.id,
    );
  }

  factory StockNutrition.fromJson(String json) =>
      StockNutrition.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory StockNutrition.fromMap(Map<String, dynamic> map) => StockNutrition(
        name: map["name"]?.toString() ?? "",
        value: map["value"]?.toString() ?? "",
        id: map["_id"]?.toString() ?? "",
      );

  Map<String, dynamic> toMap() => {"name": name, "value": value, "_id": id};

  @override
  List<Object?> get props => [name, value, id];

  @override
  bool get stringify => true;
}

class StockItemModel extends Equatable {
  final String id;
  final String name;
  final IdNameModel? categoryId;
  final IdNameModel? subCategoryId;
  final IdNameModel? brandId;
  final IdNameModel? subBrandId;
  final double availableQty;
  final StockCreatedBy? createdBy;

  const StockItemModel({
    required this.id,
    required this.name,
    this.categoryId,
    this.subCategoryId,
    this.brandId,
    this.subBrandId,
    required this.availableQty,
    this.createdBy,
  });

  StockItemModel copyWith({
    String? id,
    String? name,
    IdNameModel? categoryId,
    IdNameModel? subCategoryId,
    IdNameModel? brandId,
    IdNameModel? subBrandId,
    double? availableQty,
    StockCreatedBy? createdBy,
  }) {
    return StockItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      brandId: brandId ?? this.brandId,
      subBrandId: subBrandId ?? this.subBrandId,
      availableQty: availableQty ?? this.availableQty,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  factory StockItemModel.fromJson(String json) =>
      StockItemModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory StockItemModel.fromMap(Map<String, dynamic> map) => StockItemModel(
        id: map["_id"]?.toString() ?? map["id"]?.toString() ?? '',
        name: map["name"]?.toString() ?? map["productName"]?.toString() ?? '',
        categoryId: map["categoryId"] == null
            ? null
            : IdNameModel.fromMap(map["categoryId"]),
        subCategoryId: map["subCategoryId"] == null
            ? null
            : IdNameModel.fromMap(map["subCategoryId"]),
        brandId: map["brandId"] == null
            ? null
            : IdNameModel.fromMap(map["brandId"]),
        subBrandId: map["subBrandId"] == null
            ? null
            : IdNameModel.fromMap(map["subBrandId"]),
        availableQty: (map["availableQty"] as num? ?? 0).toDouble(),
        createdBy: map["createdBy"] == null
            ? null
            : StockCreatedBy.fromMap(map["createdBy"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "categoryId": categoryId?.toMap(),
        "subCategoryId": subCategoryId?.toMap(),
        "brandId": brandId?.toMap(),
        "subBrandId": subBrandId?.toMap(),
        "availableQty": availableQty,
        "createdBy": createdBy?.toMap(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        categoryId,
        subCategoryId,
        brandId,
        subBrandId,
        availableQty,
        createdBy,
      ];

  @override
  bool get stringify => true;
}

final _userTypeValues = _EnumValues({
  "admin": UserType.admin,
  "super-admin": UserType.superAdmin,
});

final _productTypeValues = _EnumValues({
  "finished": ProductType.finished,
  "raw_material": ProductType.raw_material,
  "semi_finished": ProductType.semi_finished,
  "service": ProductType.service,
  "non_inventory": ProductType.non_inventory,
});

class _EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  _EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
