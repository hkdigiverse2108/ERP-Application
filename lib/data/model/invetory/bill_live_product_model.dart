import 'dart:convert';
import 'package:equatable/equatable.dart';

class BillOfLiveProductModel extends Equatable {
  final String id;
  final DateTime date;
  final String number;
  final List<BillIdName> recipeId;
  final bool allowReverseCalculation;
  final List<ProductDetail> productDetails;
  final bool isDeleted;
  final bool isActive;
  final BillCreatedBy? createdBy;
  final String updatedBy;
  final BillIdName? companyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BillOfLiveProductModel({
    required this.id,
    required this.date,
    required this.number,
    required this.recipeId,
    required this.allowReverseCalculation,
    required this.productDetails,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    required this.updatedBy,
    this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  BillOfLiveProductModel copyWith({
    String? id,
    DateTime? date,
    String? number,
    List<BillIdName>? recipeId,
    bool? allowReverseCalculation,
    List<ProductDetail>? productDetails,
    bool? isDeleted,
    bool? isActive,
    BillCreatedBy? createdBy,
    String? updatedBy,
    BillIdName? companyId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BillOfLiveProductModel(
      id: id ?? this.id,
      date: date ?? this.date,
      number: number ?? this.number,
      recipeId: recipeId ?? this.recipeId,
      allowReverseCalculation: allowReverseCalculation ?? this.allowReverseCalculation,
      productDetails: productDetails ?? this.productDetails,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory BillOfLiveProductModel.fromJson(String json) =>
      BillOfLiveProductModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory BillOfLiveProductModel.fromMap(Map<String, dynamic> map) =>
      BillOfLiveProductModel(
        id: map["_id"] as String? ?? '',
        date: map["date"] == null
            ? DateTime.now()
            : DateTime.parse(map["date"] as String),
        number: map["number"] as String? ?? '',
        recipeId: map["recipeId"] == null
            ? []
            : List<BillIdName>.from(
                (map["recipeId"] as List).map((x) => BillIdName.fromMap(x))),
        allowReverseCalculation: map["allowReverseCalculation"] as bool? ?? false,
        productDetails: map["productDetails"] == null
            ? []
            : List<ProductDetail>.from(
                (map["productDetails"] as List).map((x) => ProductDetail.fromMap(x)),
              ),
        isDeleted: map["isDeleted"] as bool? ?? false,
        isActive: map["isActive"] as bool? ?? true,
        createdBy: map["createdBy"] == null
            ? null
            : BillCreatedBy.fromMap(map["createdBy"] as Map<String, dynamic>),
        updatedBy: map["updatedBy"] as String? ?? '',
        companyId: map["companyId"] == null
            ? null
            : BillIdName.fromMap(map["companyId"] as Map<String, dynamic>),
        createdAt: map["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(map["createdAt"] as String),
        updatedAt: map["updatedAt"] == null
            ? DateTime.now()
            : DateTime.parse(map["updatedAt"] as String),
      );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        "_id": id,
        "date": date.toIso8601String(),
        "number": number,
        "recipeId": List<dynamic>.from(recipeId.map((x) => x.toMap())),
        "allowReverseCalculation": allowReverseCalculation,
        "productDetails": List<dynamic>.from(productDetails.map((x) => x.toMap())),
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy?.toMap(),
        "updatedBy": updatedBy,
        "companyId": companyId?.toMap(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        date,
        number,
        recipeId,
        allowReverseCalculation,
        productDetails,
        isDeleted,
        isActive,
        createdBy,
        updatedBy,
        companyId,
        createdAt,
        updatedAt,
      ];

  @override
  bool get stringify => true;
}

class BillIdName extends Equatable {
  final String id;
  final String name;

  const BillIdName({required this.id, required this.name});

  factory BillIdName.fromMap(dynamic json) {
    if (json is String) return BillIdName(id: json, name: '');
    return BillIdName(
      id: json["_id"] as String? ?? '',
      name: json["name"] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() => {"_id": id, "name": name};

  @override
  List<Object?> get props => [id, name];
}

class BillCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const BillCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  factory BillCreatedBy.fromMap(Map<String, dynamic> map) => BillCreatedBy(
        id: map["_id"] as String? ?? '',
        fullName: map["fullName"] as String? ?? '',
        userType: map["userType"] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "fullName": fullName,
        "userType": userType,
      };

  @override
  List<Object?> get props => [id, fullName, userType];
}

class ProductDetail extends Equatable {
  final BillIdName productId;
  final double qty;
  final double purchasePrice;
  final double landingCost;
  final double mrp;
  final double sellingPrice;
  final DateTime mfgDate;
  final int expiryDays;
  final List<Ingredient> ingredients;
  final String id;

  const ProductDetail({
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

  factory ProductDetail.fromMap(Map<String, dynamic> map) => ProductDetail(
        productId: BillIdName.fromMap(map["productId"]),
        qty: (map["qty"] as num? ?? 0).toDouble(),
        purchasePrice: (map["purchasePrice"] as num? ?? 0).toDouble(),
        landingCost: (map["landingCost"] as num? ?? 0).toDouble(),
        mrp: (map["mrp"] as num? ?? 0).toDouble(),
        sellingPrice: (map["sellingPrice"] as num? ?? 0).toDouble(),
        mfgDate: map["mfgDate"] == null
            ? DateTime.now()
            : DateTime.parse(map["mfgDate"] as String),
        expiryDays: (map["expiryDays"] as num? ?? 0).toInt(),
        ingredients: map["ingredients"] == null
            ? []
            : List<Ingredient>.from(
                (map["ingredients"] as List).map((x) => Ingredient.fromMap(x))),
        id: map["_id"] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "productId": productId.toMap(),
        "qty": qty,
        "purchasePrice": purchasePrice,
        "landingCost": landingCost,
        "mrp": mrp,
        "sellingPrice": sellingPrice,
        "mfgDate": mfgDate.toIso8601String(),
        "expiryDays": expiryDays,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toMap())),
        "_id": id,
      };

  @override
  List<Object?> get props => [
        productId,
        qty,
        purchasePrice,
        landingCost,
        mrp,
        sellingPrice,
        mfgDate,
        expiryDays,
        ingredients,
        id,
      ];
}

class Ingredient extends Equatable {
  final BillIdName productId;
  final double availableQty;
  final double useQty;
  final String id;

  const Ingredient({
    required this.productId,
    required this.availableQty,
    required this.useQty,
    required this.id,
  });

  factory Ingredient.fromMap(Map<String, dynamic> map) => Ingredient(
        productId: BillIdName.fromMap(map["productId"]),
        availableQty: (map["availableQty"] as num? ?? 0).toDouble(),
        useQty: (map["useQty"] as num? ?? 0).toDouble(),
        id: map["_id"] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        "productId": productId.toMap(),
        "availableQty": availableQty,
        "useQty": useQty,
        "_id": id,
      };

  @override
  List<Object?> get props => [productId, availableQty, useQty, id];
}
