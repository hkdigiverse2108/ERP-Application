
class PosPaymentModel {
  final String id;
  final String paymentNo;
  final String voucherType;
  final String paymentType;
  final PartyId partyId;
  final PosOrderId posOrderId;
  final String posCashRegisterId;
  final String paymentMode;
  final int totalAmount;
  final int paidAmount;
  final int pendingAmount;
  final int kasar;
  final String expenseType;
  final int discountAmount;
  final double amount;
  final bool isNonGst;
  final String status;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final CompanyId companyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  PosPaymentModel({
    required this.id,
    required this.paymentNo,
    required this.voucherType,
    required this.paymentType,
    required this.partyId,
    required this.posOrderId,
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
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PosPaymentModel.fromJson(Map<String, dynamic> json) {
    return PosPaymentModel(
      id: json["_id"] ?? "",
      paymentNo: json["paymentNo"] ?? "",
      voucherType: json["voucherType"] ?? "",
      paymentType: json["paymentType"] ?? "",

      partyId: json["partyId"] != null
          ? PartyId.fromJson(json["partyId"])
          : PartyId.empty(),

      posOrderId: json["posOrderId"] != null
          ? PosOrderId.fromJson(json["posOrderId"])
          : PosOrderId.empty(),

      posCashRegisterId: json["posCashRegisterId"] ?? "",
      paymentMode: json["paymentMode"] ?? "",

      totalAmount: (json["totalAmount"] ?? 0).toInt(),
      paidAmount: (json["paidAmount"] ?? 0).toInt(),
      pendingAmount: (json["pendingAmount"] ?? 0).toInt(),
      kasar: (json["kasar"] ?? 0).toInt(),

      expenseType: json["expenseType"] ?? "",
      discountAmount: (json["discountAmount"] ?? 0).toInt(),

      amount: (json["amount"] ?? 0).toDouble(),

      isNonGst: json["isNonGST"] ?? json["isNonGst"] ?? false,

      status: json["status"] ?? "",
      isDeleted: json["isDeleted"] ?? false,
      isActive: json["isActive"] ?? false,

      createdBy: json["createdBy"] != null
          ? CreatedBy.fromJson(json["createdBy"])
          : CreatedBy.empty(),

      updatedBy: json["updatedBy"] ?? "",

      companyId: json["companyId"] != null
          ? CompanyId.fromJson(json["companyId"])
          : CompanyId.empty(),

      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
          : DateTime.now(),

      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"]) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "paymentNo": paymentNo,
    "voucherType": voucherType,
    "paymentType": paymentType,
    "partyId": partyId.toJson(),
    "posOrderId": posOrderId.toJson(),
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

  factory CompanyId.fromJson(Map<String, dynamic> json) =>
      CompanyId(id: json["_id"] ?? "", name: json["name"] ?? "");

  factory CompanyId.empty() => CompanyId(id: "", name: "");

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

class CreatedBy {
  final String id;
  final String fullName;
  final String userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["_id"] ?? "",
    fullName: json["fullName"] ?? "",
    userType: json["userType"] ?? "",
  );

  factory CreatedBy.empty() => CreatedBy(id: "", fullName: "", userType: "");

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };
}

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

  factory PartyId.fromJson(Map<String, dynamic> json) => PartyId(
    id: json["_id"] ?? "",
    firstName: json["firstName"] ?? "",
    lastName: json["lastName"] ?? "",
    companyName: json["companyName"],
  );

  factory PartyId.empty() => PartyId(id: "", firstName: "", lastName: "");

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "companyName": companyName,
  };
}

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

  factory PosOrderId.fromJson(Map<String, dynamic> json) => PosOrderId(
    id: json["_id"] ?? "",
    orderNo: json["orderNo"] ?? "",
    totalAmount: (json["totalAmount"] ?? 0).toDouble(),
    paidAmount: (json["paidAmount"] ?? 0).toDouble(),
    createdAt: json["createdAt"] != null
        ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
        : DateTime.now(),
  );

  factory PosOrderId.empty() => PosOrderId(
    id: "",
    orderNo: "",
    totalAmount: 0,
    paidAmount: 0,
    createdAt: DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "orderNo": orderNo,
    "totalAmount": totalAmount,
    "paidAmount": paidAmount,
    "createdAt": createdAt.toIso8601String(),
  };
}
