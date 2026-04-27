import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class PosPaymentModel extends Equatable {
  final String id;
  final String paymentNo;
  final String voucherType;
  final String paymentType;
  final PosPaymentParty? partyId;
  final PosPaymentOrder? posOrderId;
  final String posCashRegisterId;
  final String paymentMode;
  final double totalAmount;
  final double paidAmount;
  final double pendingAmount;
  final double kasar;
  final String expenseType;
  final double discountAmount;
  final double amount;
  final bool isNonGst;
  final String status;
  final bool isDeleted;
  final bool isActive;
  final PosPaymentCreatedBy? createdBy;
  final String updatedBy;
  final IdNameModel? companyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PosPaymentModel({
    required this.id,
    required this.paymentNo,
    required this.voucherType,
    required this.paymentType,
    this.partyId,
    this.posOrderId,
    required this.posCashRegisterId,
    required this.paymentMode,
    required this.totalAmount,
    required this.paidAmount,
    required this.pendingAmount,
    required this.kasar,
    required this.expenseType,
    required this.discountAmount,
    required this.amount,
    required this.isNonGst,
    required this.status,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    required this.updatedBy,
    this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  PosPaymentModel copyWith({
    String? id,
    String? paymentNo,
    String? voucherType,
    String? paymentType,
    PosPaymentParty? partyId,
    PosPaymentOrder? posOrderId,
    String? posCashRegisterId,
    String? paymentMode,
    double? totalAmount,
    double? paidAmount,
    double? pendingAmount,
    double? kasar,
    String? expenseType,
    double? discountAmount,
    double? amount,
    bool? isNonGst,
    String? status,
    bool? isDeleted,
    bool? isActive,
    PosPaymentCreatedBy? createdBy,
    String? updatedBy,
    IdNameModel? companyId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PosPaymentModel(
      id: id ?? this.id,
      paymentNo: paymentNo ?? this.paymentNo,
      voucherType: voucherType ?? this.voucherType,
      paymentType: paymentType ?? this.paymentType,
      partyId: partyId ?? this.partyId,
      posOrderId: posOrderId ?? this.posOrderId,
      posCashRegisterId: posCashRegisterId ?? this.posCashRegisterId,
      paymentMode: paymentMode ?? this.paymentMode,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      pendingAmount: pendingAmount ?? this.pendingAmount,
      kasar: kasar ?? this.kasar,
      expenseType: expenseType ?? this.expenseType,
      discountAmount: discountAmount ?? this.discountAmount,
      amount: amount ?? this.amount,
      isNonGst: isNonGst ?? this.isNonGst,
      status: status ?? this.status,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory PosPaymentModel.fromJson(String json) =>
      PosPaymentModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory PosPaymentModel.fromMap(Map<String, dynamic> map) => PosPaymentModel(
    id: map["_id"]?.toString() ?? "",
    paymentNo: map["paymentNo"]?.toString() ?? "",
    voucherType: map["voucherType"]?.toString() ?? "",
    paymentType: map["paymentType"]?.toString() ?? "",
    partyId: map["partyId"] == null
        ? null
        : PosPaymentParty.fromMap(map["partyId"] as Map<String, dynamic>),
    posOrderId: map["posOrderId"] == null
        ? null
        : PosPaymentOrder.fromMap(map["posOrderId"] as Map<String, dynamic>),
    posCashRegisterId: map["posCashRegisterId"]?.toString() ?? "",
    paymentMode: map["paymentMode"]?.toString() ?? "",
    totalAmount: (map["totalAmount"] as num? ?? 0).toDouble(),
    paidAmount: (map["paidAmount"] as num? ?? 0).toDouble(),
    pendingAmount: (map["pendingAmount"] as num? ?? 0).toDouble(),
    kasar: (map["kasar"] as num? ?? 0).toDouble(),
    expenseType: map["expenseType"]?.toString() ?? "",
    discountAmount: (map["discountAmount"] as num? ?? 0).toDouble(),
    amount: (map["amount"] as num? ?? 0).toDouble(),
    isNonGst: map["isNonGST"] as bool? ?? map["isNonGst"] as bool? ?? false,
    status: map["status"]?.toString() ?? "",
    isDeleted: map["isDeleted"] as bool? ?? false,
    isActive: map["isActive"] as bool? ?? true,
    createdBy: map["createdBy"] == null
        ? null
        : PosPaymentCreatedBy.fromMap(map["createdBy"] as Map<String, dynamic>),
    updatedBy: map["updatedBy"]?.toString() ?? "",
    companyId: map["companyId"] == null
        ? null
        : IdNameModel.fromMap(map["companyId"]),
    createdAt: map["createdAt"] != null
        ? DateTime.parse(map["createdAt"].toString())
        : DateTime.now(),
    updatedAt: map["updatedAt"] != null
        ? DateTime.parse(map["updatedAt"].toString())
        : DateTime.now(),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "paymentNo": paymentNo,
    "voucherType": voucherType,
    "paymentType": paymentType,
    "partyId": partyId?.toMap(),
    "posOrderId": posOrderId?.toMap(),
    "posCashRegisterId": posCashRegisterId,
    "paymentMode": paymentMode,
    "totalAmount": totalAmount,
    "paidAmount": paidAmount,
    "pendingAmount": pendingAmount,
    "kasar": kasar,
    "expenseType": expenseType,
    "discountAmount": discountAmount,
    "amount": amount,
    "isNonGST": isNonGst,
    "status": status,
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
    paymentNo,
    voucherType,
    paymentType,
    partyId,
    posOrderId,
    posCashRegisterId,
    paymentMode,
    totalAmount,
    paidAmount,
    pendingAmount,
    kasar,
    expenseType,
    discountAmount,
    amount,
    isNonGst,
    status,
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

class PosPaymentCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const PosPaymentCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  PosPaymentCreatedBy copyWith({
    String? id,
    String? fullName,
    String? userType,
  }) {
    return PosPaymentCreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory PosPaymentCreatedBy.fromJson(String json) =>
      PosPaymentCreatedBy.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory PosPaymentCreatedBy.fromMap(Map<String, dynamic> map) =>
      PosPaymentCreatedBy(
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

class PosPaymentParty extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String? companyName;

  const PosPaymentParty({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.companyName,
  });

  PosPaymentParty copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? companyName,
  }) {
    return PosPaymentParty(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      companyName: companyName ?? this.companyName,
    );
  }

  factory PosPaymentParty.fromJson(String json) =>
      PosPaymentParty.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory PosPaymentParty.fromMap(Map<String, dynamic> map) => PosPaymentParty(
    id: map["_id"]?.toString() ?? "",
    firstName: map["firstName"]?.toString() ?? "",
    lastName: map["lastName"]?.toString() ?? "",
    companyName: map["companyName"]?.toString(),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "companyName": companyName,
  };

  @override
  List<Object?> get props => [id, firstName, lastName, companyName];

  @override
  bool get stringify => true;
}

class PosPaymentOrder extends Equatable {
  final String id;
  final String orderNo;
  final double totalAmount;
  final double paidAmount;
  final DateTime createdAt;

  const PosPaymentOrder({
    required this.id,
    required this.orderNo,
    required this.totalAmount,
    required this.paidAmount,
    required this.createdAt,
  });

  PosPaymentOrder copyWith({
    String? id,
    String? orderNo,
    double? totalAmount,
    double? paidAmount,
    DateTime? createdAt,
  }) {
    return PosPaymentOrder(
      id: id ?? this.id,
      orderNo: orderNo ?? this.orderNo,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory PosPaymentOrder.fromJson(String json) =>
      PosPaymentOrder.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory PosPaymentOrder.fromMap(Map<String, dynamic> map) => PosPaymentOrder(
    id: map["_id"]?.toString() ?? "",
    orderNo: map["orderNo"]?.toString() ?? "",
    totalAmount: (map["totalAmount"] as num? ?? 0).toDouble(),
    paidAmount: (map["paidAmount"] as num? ?? 0).toDouble(),
    createdAt: map["createdAt"] != null
        ? DateTime.parse(map["createdAt"].toString())
        : DateTime.now(),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "orderNo": orderNo,
    "totalAmount": totalAmount,
    "paidAmount": paidAmount,
    "createdAt": createdAt.toIso8601String(),
  };

  @override
  List<Object?> get props => [id, orderNo, totalAmount, paidAmount, createdAt];

  @override
  bool get stringify => true;
}
