import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class StockTransferModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final StockTransferUser? createdBy;
  final String updatedBy;
  final IdNameModel? companyId;
  final IdNameModel? branchId;
  final String transferNo;
  final IdNameModel? requestedByBranchId;
  final IdNameModel? requestedToBranchId;
  final String status;
  final List<StockTransferItem> items;
  final String requestNote;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String approvalNote;
  final DateTime? approvedAt;
  final StockTransferUser? approvedBy;
  final String type;

  const StockTransferModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    required this.updatedBy,
    this.companyId,
    this.branchId,
    required this.transferNo,
    this.requestedByBranchId,
    this.requestedToBranchId,
    required this.status,
    required this.items,
    required this.requestNote,
    required this.createdAt,
    required this.updatedAt,
    required this.approvalNote,
    this.approvedAt,
    this.approvedBy,
    required this.type,
  });

  factory StockTransferModel.fromMap(Map<String, dynamic> map) =>
      StockTransferModel(
        id: map["_id"]?.toString() ?? "",
        isDeleted: map["isDeleted"] as bool? ?? false,
        isActive: map["isActive"] as bool? ?? true,
        createdBy: map["createdBy"] == null
            ? null
            : StockTransferUser.fromMap(map["createdBy"]),
        updatedBy: map["updatedBy"]?.toString() ?? "",
        companyId: map["companyId"] == null
            ? null
            : IdNameModel.fromMap(map["companyId"]),
        branchId: map["branchId"] == null
            ? null
            : IdNameModel.fromMap(map["branchId"]),
        transferNo: map["transferNo"]?.toString() ?? "",
        requestedByBranchId: map["requestedByBranchId"] == null
            ? null
            : IdNameModel.fromMap(map["requestedByBranchId"]),
        requestedToBranchId: map["requestedToBranchId"] == null
            ? null
            : IdNameModel.fromMap(map["requestedToBranchId"]),
        status: map["status"]?.toString() ?? "",
        items: List<StockTransferItem>.from(
          (map["items"] as List<dynamic>?)?.map(
                (x) => StockTransferItem.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        requestNote: map["requestNote"]?.toString() ?? "",
        createdAt: map["createdAt"] != null
            ? DateTime.parse(map["createdAt"].toString())
            : DateTime.now(),
        updatedAt: map["updatedAt"] != null
            ? DateTime.parse(map["updatedAt"].toString())
            : DateTime.now(),
        approvalNote: map["approvalNote"]?.toString() ?? "",
        approvedAt: map["approvedAt"] != null
            ? DateTime.parse(map["approvedAt"].toString())
            : null,
        approvedBy: map["approvedBy"] == null
            ? null
            : StockTransferUser.fromMap(map["approvedBy"]),
        type: map["type"]?.toString() ?? "",
      );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy?.toMap(),
    "updatedBy": updatedBy,
    "companyId": companyId?.toMap(),
    "branchId": branchId?.toMap(),
    "transferNo": transferNo,
    "requestedByBranchId": requestedByBranchId?.toMap(),
    "requestedToBranchId": requestedToBranchId?.toMap(),
    "status": status,
    "items": items.map((x) => x.toMap()).toList(),
    "requestNote": requestNote,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "approvalNote": approvalNote,
    "approvedAt": approvedAt?.toIso8601String(),
    "approvedBy": approvedBy?.toMap(),
    "type": type,
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
    transferNo,
    requestedByBranchId,
    requestedToBranchId,
    status,
    items,
    requestNote,
    createdAt,
    updatedAt,
    approvalNote,
    approvedAt,
    approvedBy,
    type,
  ];
}

class StockTransferUser extends Equatable {
  final String id;
  final String fullName;

  const StockTransferUser({required this.id, required this.fullName});

  factory StockTransferUser.fromMap(dynamic json) {
    if (json is Map) {
      return StockTransferUser(
        id: json["_id"]?.toString() ?? "",
        fullName: json["fullName"]?.toString() ?? "",
      );
    }
    if (json is String) {
      return StockTransferUser(id: json, fullName: "");
    }
    return const StockTransferUser(id: "", fullName: "");
  }

  Map<String, dynamic> toMap() => {"_id": id, "fullName": fullName};

  @override
  List<Object?> get props => [id, fullName];
}

class StockTransferItem extends Equatable {
  final IdNameModel? productId;
  final double price;
  final double requestedQty;
  final double approvedQty;
  final double receivedQty;

  const StockTransferItem({
    this.productId,
    required this.price,
    required this.requestedQty,
    required this.approvedQty,
    required this.receivedQty,
  });

  factory StockTransferItem.fromMap(Map<String, dynamic> map) =>
      StockTransferItem(
        productId: map["productId"] == null
            ? null
            : IdNameModel.fromMap(map["productId"]),
        price: (map["price"] as num? ?? 0).toDouble(),
        requestedQty: (map["requestedQty"] as num? ?? 0).toDouble(),
        approvedQty: (map["approvedQty"] as num? ?? 0).toDouble(),
        receivedQty: (map["receivedQty"] as num? ?? 0).toDouble(),
      );

  Map<String, dynamic> toMap() => {
    "productId": productId?.toMap(),
    "price": price,
    "requestedQty": requestedQty,
    "approvedQty": approvedQty,
    "receivedQty": receivedQty,
  };

  @override
  List<Object?> get props => [
    productId,
    price,
    requestedQty,
    approvedQty,
    receivedQty,
  ];
}
