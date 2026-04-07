import 'dart:convert';

class RecipeModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final Id companyId;
  final String name;
  final DateTime date;
  final String number;
  final String type;
  final List<RawProduct> rawProducts;
  final FinalProducts finalProducts;
  final DateTime createdAt;
  final DateTime updatedAt;

  RecipeModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.name,
    required this.date,
    required this.number,
    required this.type,
    required this.rawProducts,
    required this.finalProducts,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RecipeModel.fromRawJson(String str) =>
      RecipeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
    id: json["_id"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    createdBy: CreatedBy.fromJson(json["createdBy"]),
    updatedBy: json["updatedBy"],
    companyId: Id.fromJson(json["companyId"]),
    name: json["name"],
    date: DateTime.parse(json["date"]),
    number: json["number"],
    type: json["type"],
    rawProducts: List<RawProduct>.from(
      json["rawProducts"].map((x) => RawProduct.fromJson(x)),
    ),
    finalProducts: FinalProducts.fromJson(json["finalProducts"]),
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
    "name": name,
    "date": date.toIso8601String(),
    "number": number,
    "type": type,
    "rawProducts": List<dynamic>.from(rawProducts.map((x) => x.toJson())),
    "finalProducts": finalProducts.toJson(),
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

class FinalProducts {
  final Id? productId;
  final double mrp;
  final double qtyGenerate;

  FinalProducts({
    required this.productId,
    required this.mrp,
    required this.qtyGenerate,
  });

  factory FinalProducts.fromRawJson(String str) =>
      FinalProducts.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FinalProducts.fromJson(Map<String, dynamic> json) => FinalProducts(
    productId: json["productId"] == null
        ? null
        : Id.fromJson(json["productId"]),
    mrp: json["mrp"].toDouble(),
    qtyGenerate: json["qtyGenerate"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId?.toJson(),
    "mrp": mrp,
    "qtyGenerate": qtyGenerate,
  };
}

class RawProduct {
  final Id? productId;
  final double mrp;
  final double useQty;
  final String id;

  RawProduct({
    required this.productId,
    required this.mrp,
    required this.useQty,
    required this.id,
  });

  factory RawProduct.fromRawJson(String str) =>
      RawProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RawProduct.fromJson(Map<String, dynamic> json) => RawProduct(
    productId: json["productId"] == null
        ? null
        : Id.fromJson(json["productId"]),
    mrp: json["mrp"].toDouble(),
    useQty: json["useQty"].toDouble(),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId?.toJson(),
    "mrp": mrp,
    "useQty": useQty,
    "_id": id,
  };
}
