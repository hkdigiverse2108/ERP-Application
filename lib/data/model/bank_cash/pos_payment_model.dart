import 'dart:convert';

class PosPaymentModel {
  final List<PosPaymentDatum> posPaymentData;
  final int totalData;
  final State state;

  PosPaymentModel({
    required this.posPaymentData,
    required this.totalData,
    required this.state,
  });

  factory PosPaymentModel.fromRawJson(String str) =>
      PosPaymentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PosPaymentModel.fromJson(Map<String, dynamic> json) =>
      PosPaymentModel(
        posPaymentData: List<PosPaymentDatum>.from(
          (json["posPayment_data"] ?? []).map((x) => PosPaymentDatum.fromJson(x)),
        ),
        totalData: json["totalData"] ?? 0,
        state: State.fromJson(json["state"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
    "posPayment_data": List<dynamic>.from(
      posPaymentData.map((x) => x.toJson()),
    ),
    "totalData": totalData,
    "state": state.toJson(),
  };
}

class PosPaymentDatum {
  final String id;
  final String paymentNo;
  final VoucherType? voucherType;
  final PaymentType? paymentType;
  final PartyId? partyId;
  final PosOrderId? posOrderId;
  final String? posCashRegisterId;
  final PaymentMode? paymentMode;
  final double totalAmount;
  final int paidAmount;
  final int pendingAmount;
  final int kasar;
  final ExpenseType? expenseType;
  final int discountAmount;
  final double amount;
  final bool isNonGst;
  final Status? status;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final CompanyId companyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  PosPaymentDatum({
    required this.id,
    required this.paymentNo,
    this.voucherType,
    this.paymentType,
    this.partyId,
    this.posOrderId,
    this.posCashRegisterId,
    this.paymentMode,
    required this.totalAmount,
    required this.paidAmount,
    required this.pendingAmount,
    required this.kasar,
    this.expenseType,
    required this.discountAmount,
    required this.amount,
    required this.isNonGst,
    this.status,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PosPaymentDatum.fromRawJson(String str) =>
      PosPaymentDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PosPaymentDatum.fromJson(Map<String, dynamic> json) =>
      PosPaymentDatum(
        id: json["_id"] ?? "",
        paymentNo: json["paymentNo"] ?? "",
        voucherType: voucherTypeValues.map[json["voucherType"]],
        paymentType: paymentTypeValues.map[json["paymentType"]],
        partyId: json["partyId"] == null ? null : PartyId.fromJson(json["partyId"]),
        posOrderId: json["posOrderId"] == null
            ? null
            : PosOrderId.fromJson(json["posOrderId"]),
        posCashRegisterId: json["posCashRegisterId"]?.toString(),
        paymentMode: paymentModeValues.map[json["paymentMode"]],
        totalAmount: (json["totalAmount"] ?? 0).toDouble(),
        paidAmount: json["paidAmount"] ?? 0,
        pendingAmount: json["pendingAmount"] ?? 0,
        kasar: json["kasar"] ?? 0,
        expenseType: expenseTypeValues.map[json["expenseType"]],
        discountAmount: json["discountAmount"] ?? 0,
        amount: (json["amount"] ?? 0).toDouble(),
        isNonGst: json["isNonGST"] ?? false,
        status: statusValues.map[json["status"]],
        isDeleted: json["isDeleted"] ?? false,
        isActive: json["isActive"] ?? false,
        createdBy: CreatedBy.fromJson(json["createdBy"] ?? {}),
        updatedBy: (json["updatedBy"] ?? "").toString(),
        companyId: CompanyId.fromJson(json["companyId"] ?? {}),
        createdAt: json["createdAt"] == null ? DateTime.now() : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? DateTime.now() : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "paymentNo": paymentNo,
    "voucherType": voucherTypeValues.reverse[voucherType],
    "paymentType": paymentTypeValues.reverse[paymentType],
    "partyId": partyId?.toJson(),
    "posOrderId": posOrderId?.toJson(),
    "posCashRegisterId": posCashRegisterId,
    "paymentMode": paymentModeValues.reverse[paymentMode],
    "totalAmount": totalAmount,
    "paidAmount": paidAmount,
    "pendingAmount": pendingAmount,
    "kasar": kasar,
    "expenseType": expenseTypeValues.reverse[expenseType],
    "discountAmount": discountAmount,
    "amount": amount,
    "isNonGST": isNonGst,
    "status": statusValues.reverse[status],
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class CompanyId {
  final String id;
  final String name;

  CompanyId({required this.id, required this.name});

  factory CompanyId.fromRawJson(String str) =>
      CompanyId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyId.fromJson(Map<String, dynamic> json) => CompanyId(
    id: (json["_id"] ?? "").toString(),
    name: (json["name"] ?? "").toString(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

class CreatedBy {
  final String id;
  final String fullName;
  final UserType? userType;

  CreatedBy({required this.id, required this.fullName, this.userType});

  factory CreatedBy.fromRawJson(String str) =>
      CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: (json["_id"] ?? "").toString(),
    fullName: (json["fullName"] ?? "").toString(),
    userType: userTypeValues.map[json["userType"]],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userTypeValues.reverse[userType],
  };
}

enum UserType { ADMIN }

final userTypeValues = EnumValues({"admin": UserType.ADMIN});

enum ExpenseType { PRODUCT }

final expenseTypeValues = EnumValues({"product": ExpenseType.PRODUCT});

class PartyId {
  final String id;
  final String firstName;
  final String lastName;
  final String? companyName;

  PartyId({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.companyName,
  });

  factory PartyId.fromRawJson(String str) => PartyId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PartyId.fromJson(Map<String, dynamic> json) => PartyId(
    id: (json["_id"] ?? "").toString(),
    firstName: (json["firstName"] ?? "").toString(),
    lastName: (json["lastName"] ?? "").toString(),
    companyName: json["companyName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "companyName": companyName,
  };
}

enum PaymentMode { BANK, CARD, CASH, CHEQUE, UPI, WALLET }

final paymentModeValues = EnumValues({
  "bank": PaymentMode.BANK,
  "card": PaymentMode.CARD,
  "cash": PaymentMode.CASH,
  "cheque": PaymentMode.CHEQUE,
  "upi": PaymentMode.UPI,
  "wallet": PaymentMode.WALLET,
});

enum PaymentType { ADVANCE, AGAINST_BILL }

final paymentTypeValues = EnumValues({
  "advance": PaymentType.ADVANCE,
  "against_bill": PaymentType.AGAINST_BILL,
});

class PosOrderId {
  final String id;
  final String orderNo;
  final double totalAmount;
  final double paidAmount;
  final DateTime createdAt;

  PosOrderId({
    required this.id,
    required this.orderNo,
    required this.totalAmount,
    required this.paidAmount,
    required this.createdAt,
  });

  factory PosOrderId.fromRawJson(String str) =>
      PosOrderId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PosOrderId.fromJson(Map<String, dynamic> json) => PosOrderId(
    id: json["_id"] ?? "",
    orderNo: json["orderNo"] ?? "",
    totalAmount: (json["totalAmount"] ?? 0).toDouble(),
    paidAmount: (json["paidAmount"] ?? 0).toDouble(),
    createdAt: json["createdAt"] == null ? DateTime.now() : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "orderNo": orderNo,
    "totalAmount": totalAmount,
    "paidAmount": paidAmount,
    "createdAt": createdAt.toIso8601String(),
  };
}

enum Status { CLEARED }

final statusValues = EnumValues({"cleared": Status.CLEARED});

enum VoucherType { EXPENSE, PURCHASE, SALES }

final voucherTypeValues = EnumValues({
  "expense": VoucherType.EXPENSE,
  "purchase": VoucherType.PURCHASE,
  "sales": VoucherType.SALES,
});

class State {
  final int page;
  final int limit;
  final int totalPages;

  State({required this.page, required this.limit, required this.totalPages});

  factory State.fromRawJson(String str) => State.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory State.fromJson(Map<String, dynamic> json) => State(
    page: json["page"] ?? 0,
    limit: json["limit"] ?? 0,
    totalPages: json["totalPages"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
  };
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
