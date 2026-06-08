import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class StockVerificationModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final StockVerificationCreatedBy? createdBy;
  final StockVerificationUpdatedBy? updatedBy;
  final IdNameModel? companyId;
  final String stockVerificationNo;
  final List<StockVerificationItem> items;
  final double totalProducts;
  final double totalPhysicalQty;
  final double totalDifferenceAmount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StockVerificationModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    required this.stockVerificationNo,
    required this.items,
    required this.totalProducts,
    required this.totalPhysicalQty,
    required this.totalDifferenceAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  StockVerificationModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    StockVerificationCreatedBy? createdBy,
    StockVerificationUpdatedBy? updatedBy,
    IdNameModel? companyId,
    String? stockVerificationNo,
    List<StockVerificationItem>? items,
    double? totalProducts,
    double? totalPhysicalQty,
    double? totalDifferenceAmount,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StockVerificationModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      stockVerificationNo: stockVerificationNo ?? this.stockVerificationNo,
      items: items ?? this.items,
      totalProducts: totalProducts ?? this.totalProducts,
      totalPhysicalQty: totalPhysicalQty ?? this.totalPhysicalQty,
      totalDifferenceAmount:
          totalDifferenceAmount ?? this.totalDifferenceAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory StockVerificationModel.fromJson(String json) =>
      StockVerificationModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory StockVerificationModel.fromMap(Map<String, dynamic> map) =>
      StockVerificationModel(
        id: map["_id"]?.toString() ?? '',
        isDeleted: map["isDeleted"] as bool? ?? false,
        isActive: map["isActive"] as bool? ?? true,
        createdBy: map["createdBy"] == null
            ? null
            : StockVerificationCreatedBy.fromMap(
                map["createdBy"] as Map<String, dynamic>,
              ),
        updatedBy: map["updatedBy"] == null
            ? null
            : StockVerificationUpdatedBy.fromMap(
                map["updatedBy"] as Map<String, dynamic>,
              ),
        companyId: map["companyId"] == null
            ? null
            : IdNameModel.fromMap(map["companyId"]),
        stockVerificationNo: map["stockVerificationNo"]?.toString() ?? "",
        items: List<StockVerificationItem>.from(
          (map["items"] as List<dynamic>?)?.map(
                (x) => StockVerificationItem.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        totalProducts: (map["totalProducts"] as num? ?? 0).toDouble(),
        totalPhysicalQty: (map["totalPhysicalQty"] as num? ?? 0).toDouble(),
        totalDifferenceAmount: (map["totalDifferenceAmount"] as num? ?? 0)
            .toDouble(),
        status: map["status"]?.toString() ?? 'pending',
        createdAt: map["createdAt"] != null
            ? DateTime.parse(map["createdAt"].toString())
            : DateTime.now(),
        updatedAt: map["updatedAt"] != null
            ? DateTime.parse(map["updatedAt"].toString())
            : DateTime.now(),
      );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy?.toMap(),
    "updatedBy": updatedBy?.toMap(),
    "companyId": companyId?.toMap(),
    "stockVerificationNo": stockVerificationNo,
    "items": items.map((x) => x.toMap()).toList(),
    "totalProducts": totalProducts,
    "totalPhysicalQty": totalPhysicalQty,
    "totalDifferenceAmount": totalDifferenceAmount,
    "status": status,
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
    stockVerificationNo,
    items,
    totalProducts,
    totalPhysicalQty,
    totalDifferenceAmount,
    status,
    createdAt,
    updatedAt,
  ];

  @override
  bool get stringify => true;
}

class StockVerificationCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const StockVerificationCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  StockVerificationCreatedBy copyWith({
    String? id,
    String? fullName,
    String? userType,
  }) {
    return StockVerificationCreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory StockVerificationCreatedBy.fromJson(String json) =>
      StockVerificationCreatedBy.fromMap(
        jsonDecode(json) as Map<String, dynamic>,
      );

  String toJson() => jsonEncode(toMap());

  factory StockVerificationCreatedBy.fromMap(Map<String, dynamic> map) =>
      StockVerificationCreatedBy(
        id: map["_id"]?.toString() ?? "",
        fullName: map["fullName"]?.toString() ?? "",
        userType: map["userType"]?.toString() ?? "",
      );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };

  @override
  List<Object?> get props => [id, fullName, userType];

  @override
  bool get stringify => true;
}

class StockVerificationItem extends Equatable {
  final IdNameModel productId;
  final double landingCost;
  final double price;
  final double mrp;
  final double sellingPrice;
  final double systemQty;
  final double physicalQty;
  final double differenceQty;
  final double differenceAmount;
  final String? variantId;

  const StockVerificationItem({
    required this.productId,
    required this.landingCost,
    required this.price,
    required this.mrp,
    required this.sellingPrice,
    required this.systemQty,
    required this.physicalQty,
    required this.differenceQty,
    required this.differenceAmount,
    this.variantId,
  });

  StockVerificationItem copyWith({
    IdNameModel? productId,
    double? landingCost,
    double? price,
    double? mrp,
    double? sellingPrice,
    double? systemQty,
    double? physicalQty,
    double? differenceQty,
    double? differenceAmount,
    String? variantId,
  }) {
    return StockVerificationItem(
      productId: productId ?? this.productId,
      landingCost: landingCost ?? this.landingCost,
      price: price ?? this.price,
      mrp: mrp ?? this.mrp,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      systemQty: systemQty ?? this.systemQty,
      physicalQty: physicalQty ?? this.physicalQty,
      differenceQty: differenceQty ?? this.differenceQty,
      differenceAmount: differenceAmount ?? this.differenceAmount,
      variantId: variantId ?? this.variantId,
    );
  }

  factory StockVerificationItem.fromJson(String json) =>
      StockVerificationItem.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory StockVerificationItem.fromMap(Map<String, dynamic> map) =>
      StockVerificationItem(
        productId: IdNameModel.fromMap(map["productId"]),
        landingCost: (map["landingCost"] as num? ?? 0).toDouble(),
        price: (map["price"] as num? ?? 0).toDouble(),
        mrp: (map["mrp"] as num? ?? 0).toDouble(),
        sellingPrice: (map["sellingPrice"] as num? ?? 0).toDouble(),
        systemQty: (map["systemQty"] as num? ?? 0).toDouble(),
        physicalQty: (map["physicalQty"] as num? ?? 0).toDouble(),
        differenceQty: (map["differenceQty"] as num? ?? 0).toDouble(),
        differenceAmount: (map["differenceAmount"] as num? ?? 0).toDouble(),
        variantId: map["variantId"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
    "productId": productId.toMap(),
    "landingCost": landingCost,
    "price": price,
    "mrp": mrp,
    "sellingPrice": sellingPrice,
    "systemQty": systemQty,
    "physicalQty": physicalQty,
    "differenceQty": differenceQty,
    "differenceAmount": differenceAmount,
    "variantId": variantId,
  };

  @override
  List<Object?> get props => [
    productId,
    landingCost,
    price,
    mrp,
    sellingPrice,
    systemQty,
    physicalQty,
    differenceQty,
    differenceAmount,
    variantId,
  ];

  @override
  bool get stringify => true;
}

class StockVerificationUpdatedBy extends Equatable {
  final String id;
  final String userType;

  const StockVerificationUpdatedBy({required this.id, required this.userType});

  StockVerificationUpdatedBy copyWith({String? id, String? userType}) {
    return StockVerificationUpdatedBy(
      id: id ?? this.id,
      userType: userType ?? this.userType,
    );
  }

  factory StockVerificationUpdatedBy.fromJson(String json) =>
      StockVerificationUpdatedBy.fromMap(
        jsonDecode(json) as Map<String, dynamic>,
      );

  String toJson() => jsonEncode(toMap());

  factory StockVerificationUpdatedBy.fromMap(Map<String, dynamic> map) =>
      StockVerificationUpdatedBy(
        id: map["_id"]?.toString() ?? "",
        userType: map["userType"]?.toString() ?? "",
      );

  Map<String, dynamic> toMap() => {"_id": id, "userType": userType};

  @override
  List<Object?> get props => [id, userType];

  @override
  bool get stringify => true;
}
