import 'dart:convert';

class MaterialConsumptionModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final Id companyId;
  final Id branchId;
  final String number;
  final DateTime date;
  final Id consumptionTypeId;
  final List<Item> items;
  final double totalQty;
  final double totalAmount;
  final String? remark;
  final DateTime createdAt;
  final DateTime updatedAt;

  MaterialConsumptionModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.branchId,
    required this.number,
    required this.date,
    required this.consumptionTypeId,
    required this.items,
    required this.totalQty,
    required this.totalAmount,
    this.remark,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MaterialConsumptionModel.fromRawJson(String str) =>
      MaterialConsumptionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MaterialConsumptionModel.fromJson(Map<String, dynamic> json) =>
      MaterialConsumptionModel(
        id: json["_id"],
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        updatedBy: json["updatedBy"],
        companyId: Id.fromJson(json["companyId"]),
        branchId: Id.fromJson(json["branchId"]),
        number: json["number"],
        date: DateTime.parse(json["date"]),
        consumptionTypeId: Id.fromJson(json["consumptionTypeId"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        totalQty: (json["totalQty"] ?? 0).toDouble(),
        totalAmount: (json["totalAmount"] ?? 0).toDouble(),
        remark: json["remark"] ?? json["notes"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "branchId": branchId.toJson(),
    "number": number,
    "date": date.toIso8601String(),
    "consumptionTypeId": consumptionTypeId.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "totalQty": totalQty,
    "totalAmount": totalAmount,
    "remark": remark,
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
  final double qty;
  final double price;
  final double totalPrice;

  Item({
    required this.productId,
    required this.qty,
    required this.price,
    required this.totalPrice,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    productId: Id.fromJson(json["productId"]),
    qty: (json["qty"] ?? 0).toDouble(),
    price: (json["price"] ?? 0).toDouble(),
    totalPrice: (json["totalPrice"] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId.toJson(),
    "qty": qty,
    "price": price,
    "totalPrice": totalPrice,
  };
}
