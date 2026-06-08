import 'dart:convert';
import 'package:equatable/equatable.dart';

class RecipeModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final RecipeCreatedBy? createdBy;
  final String updatedBy;
  final RecipeIdName? companyId;
  final String name;
  final DateTime date;
  final String number;
  final String type;
  final List<RawProduct> rawProducts;
  final FinalProducts finalProducts;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RecipeModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    required this.updatedBy,
    this.companyId,
    required this.name,
    required this.date,
    required this.number,
    required this.type,
    required this.rawProducts,
    required this.finalProducts,
    required this.createdAt,
    required this.updatedAt,
  });

  RecipeModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    RecipeCreatedBy? createdBy,
    String? updatedBy,
    RecipeIdName? companyId,
    String? name,
    DateTime? date,
    String? number,
    String? type,
    List<RawProduct>? rawProducts,
    FinalProducts? finalProducts,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      date: date ?? this.date,
      number: number ?? this.number,
      type: type ?? this.type,
      rawProducts: rawProducts ?? this.rawProducts,
      finalProducts: finalProducts ?? this.finalProducts,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory RecipeModel.fromJson(String json) =>
      RecipeModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory RecipeModel.fromMap(Map<String, dynamic> map) => RecipeModel(
    id: map["_id"] as String? ?? '',
    isDeleted: map["isDeleted"] as bool? ?? false,
    isActive: map["isActive"] as bool? ?? true,
    createdBy: map["createdBy"] == null
        ? null
        : RecipeCreatedBy.fromMap(map["createdBy"] as Map<String, dynamic>),
    updatedBy: map["updatedBy"] as String? ?? '',
    companyId: map["companyId"] == null
        ? null
        : RecipeIdName.fromMap(map["companyId"] as Map<String, dynamic>),
    name: map["name"] as String? ?? '',
    date: map["date"] == null
        ? DateTime.now()
        : DateTime.parse(map["date"] as String),
    number: map["number"] as String? ?? '',
    type: map["type"] as String? ?? '',
    rawProducts: map["rawProducts"] == null
        ? []
        : List<RawProduct>.from(
            (map["rawProducts"] as List).map((x) => RawProduct.fromMap(x)),
          ),
    finalProducts: map["finalProducts"] == null
        ? const FinalProducts(productId: null, mrp: 0, qtyGenerate: 0)
        : FinalProducts.fromMap(map["finalProducts"] as Map<String, dynamic>),
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
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy?.toMap(),
    "updatedBy": updatedBy,
    "companyId": companyId?.toMap(),
    "name": name,
    "date": date.toIso8601String(),
    "number": number,
    "type": type,
    "rawProducts": List<dynamic>.from(rawProducts.map((x) => x.toMap())),
    "finalProducts": finalProducts.toMap(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };

  @override
  List<Object?> get props => [
    id,
    isDeleted,
    isActive,
    createdBy,
    updatedBy,
    companyId,
    name,
    date,
    number,
    type,
    rawProducts,
    finalProducts,
    createdAt,
    updatedAt,
  ];

  @override
  bool get stringify => true;
}

class RecipeIdName extends Equatable {
  final String id;
  final String name;

  const RecipeIdName({required this.id, required this.name});

  factory RecipeIdName.fromMap(Map<String, dynamic> map) => RecipeIdName(
    id: map["_id"] as String? ?? '',
    name: map["name"] as String? ?? '',
  );

  Map<String, dynamic> toMap() => {"_id": id, "name": name};

  @override
  List<Object?> get props => [id, name];
}

class RecipeCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const RecipeCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  factory RecipeCreatedBy.fromMap(Map<String, dynamic> map) => RecipeCreatedBy(
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

class FinalProducts extends Equatable {
  final RecipeIdName? productId;
  final double mrp;
  final double qtyGenerate;

  const FinalProducts({
    required this.productId,
    required this.mrp,
    required this.qtyGenerate,
  });

  factory FinalProducts.fromMap(Map<String, dynamic> map) => FinalProducts(
    productId: map["productId"] == null
        ? null
        : RecipeIdName.fromMap(map["productId"] as Map<String, dynamic>),
    mrp: (map["mrp"] as num? ?? 0).toDouble(),
    qtyGenerate: (map["qtyGenerate"] as num? ?? 0).toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "productId": productId?.toMap(),
    "mrp": mrp,
    "qtyGenerate": qtyGenerate,
  };

  @override
  List<Object?> get props => [productId, mrp, qtyGenerate];
}

class RawProduct extends Equatable {
  final RecipeIdName? productId;
  final double mrp;
  final double useQty;
  final String id;
  final String? variantId;

  const RawProduct({
    required this.productId,
    required this.mrp,
    required this.useQty,
    required this.id,
    this.variantId,
  });

  factory RawProduct.fromMap(Map<String, dynamic> map) => RawProduct(
    productId: map["productId"] == null
        ? null
        : RecipeIdName.fromMap(map["productId"] as Map<String, dynamic>),
    mrp: (map["mrp"] as num? ?? 0).toDouble(),
    useQty: (map["useQty"] as num? ?? 0).toDouble(),
    id: map["_id"] as String? ?? '',
    variantId: map["variantId"],
  );

  Map<String, dynamic> toMap() => {
    "productId": productId?.toMap(),
    "mrp": mrp,
    "useQty": useQty,
    "_id": id,
    "variantId": variantId,
  };

  @override
  List<Object?> get props => [productId, mrp, useQty, id, variantId];
}
