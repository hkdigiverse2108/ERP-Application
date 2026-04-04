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
          json["posPayment_data"].map((x) => PosPaymentDatum.fromJson(x)),
        ),
        totalData: json["totalData"],
        state: State.fromJson(json["state"]),
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
  final VoucherType voucherType;
  final PaymentType paymentType;
  final PartyId? partyId;
  final PosOrderId? posOrderId;
  final PosCashRegisterId? posCashRegisterId;
  final PaymentMode paymentMode;
  final double totalAmount;
  final int paidAmount;
  final int pendingAmount;
  final int? kasar;
  final ExpenseType? expenseType;
  final int? discountAmount;
  final double amount;
  final bool isNonGst;
  final Status? status;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final UpdatedBy updatedBy;
  final CompanyId companyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? date;
  final String? accountId;
  final TaxId? taxId;
  final String? bankId;
  final String? remark;
  final DateTime? paymentDate;
  final int? roundOff;

  PosPaymentDatum({
    required this.id,
    required this.paymentNo,
    required this.voucherType,
    required this.paymentType,
    this.partyId,
    this.posOrderId,
    this.posCashRegisterId,
    required this.paymentMode,
    required this.totalAmount,
    required this.paidAmount,
    required this.pendingAmount,
    this.kasar,
    this.expenseType,
    this.discountAmount,
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
    this.date,
    this.accountId,
    this.taxId,
    this.bankId,
    this.remark,
    this.paymentDate,
    this.roundOff,
  });

  factory PosPaymentDatum.fromRawJson(String str) =>
      PosPaymentDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PosPaymentDatum.fromJson(
    Map<String, dynamic> json,
  ) => PosPaymentDatum(
    id: json["_id"],
    paymentNo: json["paymentNo"],
    voucherType: voucherTypeValues.map[json["voucherType"]]!,
    paymentType: paymentTypeValues.map[json["paymentType"]]!,
    partyId: json["partyId"] == null ? null : PartyId.fromJson(json["partyId"]),
    posOrderId: json["posOrderId"] == null
        ? null
        : PosOrderId.fromJson(json["posOrderId"]),
    posCashRegisterId: posCashRegisterIdValues.map[json["posCashRegisterId"]]!,
    paymentMode: paymentModeValues.map[json["paymentMode"]]!,
    totalAmount: json["totalAmount"]?.toDouble(),
    paidAmount: json["paidAmount"],
    pendingAmount: json["pendingAmount"],
    kasar: json["kasar"],
    expenseType: expenseTypeValues.map[json["expenseType"]]!,
    discountAmount: json["discountAmount"],
    amount: json["amount"]?.toDouble(),
    isNonGst: json["isNonGST"],
    status: statusValues.map[json["status"]]!,
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    createdBy: CreatedBy.fromJson(json["createdBy"]),
    updatedBy: updatedByValues.map[json["updatedBy"]]!,
    companyId: CompanyId.fromJson(json["companyId"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    accountId: json["accountId"],
    taxId: json["taxId"] == null ? null : TaxId.fromJson(json["taxId"]),
    bankId: json["bankId"],
    remark: json["remark"],
    paymentDate: json["paymentDate"] == null
        ? null
        : DateTime.parse(json["paymentDate"]),
    roundOff: json["roundOff"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "paymentNo": paymentNo,
    "voucherType": voucherTypeValues.reverse[voucherType],
    "paymentType": paymentTypeValues.reverse[paymentType],
    "partyId": partyId?.toJson(),
    "posOrderId": posOrderId?.toJson(),
    "posCashRegisterId": posCashRegisterIdValues.reverse[posCashRegisterId],
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
    "updatedBy": updatedByValues.reverse[updatedBy],
    "companyId": companyId.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "date": date?.toIso8601String(),
    "accountId": accountId,
    "taxId": taxId?.toJson(),
    "bankId": bankId,
    "remark": remark,
    "paymentDate": paymentDate?.toIso8601String(),
    "roundOff": roundOff,
  };
}

class CompanyId {
  final CompanyIdId id;
  final Name name;

  CompanyId({required this.id, required this.name});

  factory CompanyId.fromRawJson(String str) =>
      CompanyId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyId.fromJson(Map<String, dynamic> json) => CompanyId(
    id: companyIdIdValues.map[json["_id"]]!,
    name: nameValues.map[json["name"]]!,
  );

  Map<String, dynamic> toJson() => {
    "_id": companyIdIdValues.reverse[id],
    "name": nameValues.reverse[name],
  };
}

enum CompanyIdId { THE_694_A6_CCF473_CEDF2701_A6386 }

final companyIdIdValues = EnumValues({
  "694a6ccf473cedf2701a6386": CompanyIdId.THE_694_A6_CCF473_CEDF2701_A6386,
});

enum Name { DUO_FUSION1 }

final nameValues = EnumValues({"Duo Fusion1": Name.DUO_FUSION1});

class CreatedBy {
  final UpdatedBy id;
  final FullName fullName;
  final UserType userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromRawJson(String str) =>
      CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: updatedByValues.map[json["_id"]]!,
    fullName: fullNameValues.map[json["fullName"]]!,
    userType: userTypeValues.map[json["userType"]]!,
  );

  Map<String, dynamic> toJson() => {
    "_id": updatedByValues.reverse[id],
    "fullName": fullNameValues.reverse[fullName],
    "userType": userTypeValues.reverse[userType],
  };
}

enum FullName { HARSHITHKDIGIVERSE, KRISH_GEDIYA }

final fullNameValues = EnumValues({
  "harshithkdigiverse": FullName.HARSHITHKDIGIVERSE,
  "Krish Gediya": FullName.KRISH_GEDIYA,
});

enum UpdatedBy {
  THE_694_D017_B7_CB4009_F97_A30854,
  THE_699_C40239_F9_E8_A56822_E8929,
}

final updatedByValues = EnumValues({
  "694d017b7cb4009f97a30854": UpdatedBy.THE_694_D017_B7_CB4009_F97_A30854,
  "699c40239f9e8a56822e8929": UpdatedBy.THE_699_C40239_F9_E8_A56822_E8929,
});

enum UserType { ADMIN, SUPER_ADMIN }

final userTypeValues = EnumValues({
  "admin": UserType.ADMIN,
  "super-admin": UserType.SUPER_ADMIN,
});

enum ExpenseType { PRODUCT, SERVICE }

final expenseTypeValues = EnumValues({
  "product": ExpenseType.PRODUCT,
  "service": ExpenseType.SERVICE,
});

class PartyId {
  final PartyIdId id;
  final FirstName firstName;
  final LastName lastName;
  final CompanyName? companyName;

  PartyId({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.companyName,
  });

  factory PartyId.fromRawJson(String str) => PartyId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PartyId.fromJson(Map<String, dynamic> json) => PartyId(
    id: partyIdIdValues.map[json["_id"]]!,
    firstName: firstNameValues.map[json["firstName"]]!,
    lastName: lastNameValues.map[json["lastName"]]!,
    companyName: companyNameValues.map[json["companyName"]]!,
  );

  Map<String, dynamic> toJson() => {
    "_id": partyIdIdValues.reverse[id],
    "firstName": firstNameValues.reverse[firstName],
    "lastName": lastNameValues.reverse[lastName],
    "companyName": companyNameValues.reverse[companyName],
  };
}

enum CompanyName { ABCD, NEW_RETAILERS, TOO_SMART_RETAILZZZ }

final companyNameValues = EnumValues({
  "abcd": CompanyName.ABCD,
  "New Retailers": CompanyName.NEW_RETAILERS,
  "TooSmart Retailzzz": CompanyName.TOO_SMART_RETAILZZZ,
});

enum FirstName { A, B, BU, BUNTYLAL, JEEL, KRISH, PRAMIT_MANGUKIYA }

final firstNameValues = EnumValues({
  "A": FirstName.A,
  "B": FirstName.B,
  "Bu": FirstName.BU,
  "Buntylal": FirstName.BUNTYLAL,
  "Jeel ": FirstName.JEEL,
  "Krish ": FirstName.KRISH,
  "Pramit Mangukiya": FirstName.PRAMIT_MANGUKIYA,
});

enum PartyIdId {
  THE_6987152828_A1_FB305_FB90214,
  THE_69895_B8_A1_BA2_B4871_EC34_D08,
  THE_69897_CE48_FC4_AAE4_B354_E5_E5,
  THE_69897_F9_BFE8744_EC9_BB7_AC93,
  THE_699805_D2675_F1_C7_B8_DDF6_FC4,
  THE_699806_A0675_F1_C7_B8_DDF709_E,
  THE_699828_F0675_F1_C7_B8_DDF7211,
}

final partyIdIdValues = EnumValues({
  "6987152828a1fb305fb90214": PartyIdId.THE_6987152828_A1_FB305_FB90214,
  "69895b8a1ba2b4871ec34d08": PartyIdId.THE_69895_B8_A1_BA2_B4871_EC34_D08,
  "69897ce48fc4aae4b354e5e5": PartyIdId.THE_69897_CE48_FC4_AAE4_B354_E5_E5,
  "69897f9bfe8744ec9bb7ac93": PartyIdId.THE_69897_F9_BFE8744_EC9_BB7_AC93,
  "699805d2675f1c7b8ddf6fc4": PartyIdId.THE_699805_D2675_F1_C7_B8_DDF6_FC4,
  "699806a0675f1c7b8ddf709e": PartyIdId.THE_699806_A0675_F1_C7_B8_DDF709_E,
  "699828f0675f1c7b8ddf7211": PartyIdId.THE_699828_F0675_F1_C7_B8_DDF7211,
});

enum LastName { BORAD, MANGUKIYA, O, ONE, OV, OVER_SMART, RADADIYA }

final lastNameValues = EnumValues({
  "Borad": LastName.BORAD,
  "Mangukiya": LastName.MANGUKIYA,
  "O": LastName.O,
  "One": LastName.ONE,
  "Ov": LastName.OV,
  "OverSmart": LastName.OVER_SMART,
  "Radadiya": LastName.RADADIYA,
});

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

enum PosCashRegisterId {
  THE_69_AF96_BD5210_CD62_DC1_A9928,
  THE_69_AFD8882_C30_E20727_DAF2_E6,
  THE_69_B2_ACFD0625979952_A89_BC1,
  THE_69_B3_DD7923_EBCC976_A205_A92,
  THE_69_B77_D2_E237_DE7_C97_DFAD6_B9,
}

final posCashRegisterIdValues = EnumValues({
  "69af96bd5210cd62dc1a9928":
      PosCashRegisterId.THE_69_AF96_BD5210_CD62_DC1_A9928,
  "69afd8882c30e20727daf2e6":
      PosCashRegisterId.THE_69_AFD8882_C30_E20727_DAF2_E6,
  "69b2acfd0625979952a89bc1":
      PosCashRegisterId.THE_69_B2_ACFD0625979952_A89_BC1,
  "69b3dd7923ebcc976a205a92":
      PosCashRegisterId.THE_69_B3_DD7923_EBCC976_A205_A92,
  "69b77d2e237de7c97dfad6b9":
      PosCashRegisterId.THE_69_B77_D2_E237_DE7_C97_DFAD6_B9,
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
    id: json["_id"],
    orderNo: json["orderNo"],
    totalAmount: json["totalAmount"]?.toDouble(),
    paidAmount: json["paidAmount"]?.toDouble(),
    createdAt: DateTime.parse(json["createdAt"]),
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

class TaxId {
  final String id;
  final String name;
  final int percentage;

  TaxId({required this.id, required this.name, required this.percentage});

  factory TaxId.fromRawJson(String str) => TaxId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxId.fromJson(Map<String, dynamic> json) => TaxId(
    id: json["_id"],
    name: json["name"],
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "percentage": percentage,
  };
}

enum VoucherType { EXPENSE, PURCHASE, SALES }

final voucherTypeValues = EnumValues({
  "expense": VoucherType.EXPENSE,
  "purchase": VoucherType.PURCHASE,
  "sales": VoucherType.SALES,
});

class State {
  final dynamic page;
  final dynamic limit;
  final int totalPages;

  State({required this.page, required this.limit, required this.totalPages});

  factory State.fromRawJson(String str) => State.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory State.fromJson(Map<String, dynamic> json) => State(
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
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
