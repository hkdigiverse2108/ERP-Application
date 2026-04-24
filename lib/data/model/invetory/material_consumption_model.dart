import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class MaterialConsumptionModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final MaterialConsumptionCreatedBy? createdBy;
  final String updatedBy;
  final IdNameModel? companyId;
  final IdNameModel? branchId;
  final String number;
  final DateTime date;
  final IdNameModel? consumptionTypeId;
  final String? type;
  final List<MaterialConsumptionItem> items;
  final double totalQty;
  final double totalAmount;
  final String? remark;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MaterialConsumptionModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    required this.updatedBy,
    this.companyId,
    this.branchId,
    required this.number,
    required this.date,
    this.consumptionTypeId,
    this.type,
    required this.items,
    required this.totalQty,
    required this.totalAmount,
    this.remark,
    required this.createdAt,
    required this.updatedAt,
  });

  String get displayType => consumptionTypeId?.name ?? type ?? '-';

  MaterialConsumptionModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    MaterialConsumptionCreatedBy? createdBy,
    String? updatedBy,
    IdNameModel? companyId,
    IdNameModel? branchId,
    String? number,
    DateTime? date,
    IdNameModel? consumptionTypeId,
    String? type,
    List<MaterialConsumptionItem>? items,
    double? totalQty,
    double? totalAmount,
    String? remark,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MaterialConsumptionModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      branchId: branchId ?? this.branchId,
      number: number ?? this.number,
      date: date ?? this.date,
      consumptionTypeId: consumptionTypeId ?? this.consumptionTypeId,
      type: type ?? this.type,
      items: items ?? this.items,
      totalQty: totalQty ?? this.totalQty,
      totalAmount: totalAmount ?? this.totalAmount,
      remark: remark ?? this.remark,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory MaterialConsumptionModel.fromJson(String json) =>
      MaterialConsumptionModel.fromMap(
          jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory MaterialConsumptionModel.fromMap(Map<String, dynamic> map) =>
      MaterialConsumptionModel(
        id: map["_id"]?.toString() ?? '',
        isDeleted: map["isDeleted"] as bool? ?? false,
        isActive: map["isActive"] as bool? ?? true,
        createdBy: map["createdBy"] == null
            ? null
            : MaterialConsumptionCreatedBy.fromMap(
                map["createdBy"] as Map<String, dynamic>),
        updatedBy: map["updatedBy"]?.toString() ?? "",
        companyId: map["companyId"] == null
            ? null
            : IdNameModel.fromMap(map["companyId"]),
        branchId: map["branchId"] == null
            ? null
            : IdNameModel.fromMap(map["branchId"]),
        number: map["number"]?.toString() ?? "",
        date: map["date"] != null
            ? DateTime.parse(map["date"].toString())
            : DateTime.now(),
        consumptionTypeId: map["consumptionTypeId"] == null
            ? null
            : IdNameModel.fromMap(map["consumptionTypeId"]),
        type: map["type"]?.toString(),
        items: List<MaterialConsumptionItem>.from(
          (map["items"] as List<dynamic>?)?.map(
                (x) => MaterialConsumptionItem.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        totalQty: (map["totalQty"] as num? ?? 0).toDouble(),
        totalAmount: (map["totalAmount"] as num? ?? 0).toDouble(),
        remark: (map["remark"] ?? map["notes"])?.toString(),
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
        "updatedBy": updatedBy,
        "companyId": companyId?.toMap(),
        "branchId": branchId?.toMap(),
        "number": number,
        "date": date.toIso8601String(),
        "consumptionTypeId": consumptionTypeId?.toMap(),
        "type": type,
        "items": items.map((x) => x.toMap()).toList(),
        "totalQty": totalQty,
        "totalAmount": totalAmount,
        "remark": remark,
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
        branchId,
        number,
        date,
        consumptionTypeId,
        type,
        items,
        totalQty,
        totalAmount,
        remark,
        createdAt,
        updatedAt,
      ];

  @override
  bool get stringify => true;
}

class MaterialConsumptionCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const MaterialConsumptionCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  MaterialConsumptionCreatedBy copyWith({
    String? id,
    String? fullName,
    String? userType,
  }) {
    return MaterialConsumptionCreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory MaterialConsumptionCreatedBy.fromJson(String json) =>
      MaterialConsumptionCreatedBy.fromMap(
          jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory MaterialConsumptionCreatedBy.fromMap(Map<String, dynamic> map) =>
      MaterialConsumptionCreatedBy(
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

class MaterialConsumptionItem extends Equatable {
  final IdNameModel productId;
  final double qty;
  final double price;
  final double totalPrice;

  const MaterialConsumptionItem({
    required this.productId,
    required this.qty,
    required this.price,
    required this.totalPrice,
  });

  MaterialConsumptionItem copyWith({
    IdNameModel? productId,
    double? qty,
    double? price,
    double? totalPrice,
  }) {
    return MaterialConsumptionItem(
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  factory MaterialConsumptionItem.fromJson(String json) =>
      MaterialConsumptionItem.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory MaterialConsumptionItem.fromMap(Map<String, dynamic> map) =>
      MaterialConsumptionItem(
        productId: IdNameModel.fromMap(map["productId"]),
        qty: (map["qty"] as num? ?? 0).toDouble(),
        price: (map["price"] as num? ?? 0).toDouble(),
        totalPrice: (map["totalPrice"] as num? ?? 0).toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "productId": productId.toMap(),
        "qty": qty,
        "price": price,
        "totalPrice": totalPrice,
      };

  @override
  List<Object?> get props => [productId, qty, price, totalPrice];

  @override
  bool get stringify => true;
}
