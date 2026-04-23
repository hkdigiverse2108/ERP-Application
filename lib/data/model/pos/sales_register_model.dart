import 'dart:convert';

class SalesRegisterModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final BranchIdClass companyId;
  final String? registerNo;
  final int openingCash;
  final SalesManId? salesManId;
  final int cashPayment;
  final int chequePayment;
  final int cardPayment;
  final int bankPayment;
  final int upiPayment;
  final int salesReturn;
  final int cashRefund;
  final int bankRefund;
  final int? numberOfBills;
  final int? numberOfItems;
  final int? totalDiscount;
  final double? taxAmount;
  final int creditAdvanceRedeemed;
  final int payLater;
  final int expense;
  final int purchasePayment;
  final int totalSales;
  final int bankTransferAmount;
  final int cashFlow;
  final String status;
  final List<Denomination> denominations;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BranchIdClass branchId;
  final int? physicalDrawerCash;
  final int? totalCashInDrawer;
  final int? totalCashLeftInDrawer;
  final String? closingNote;
  final int? totalDenominationAmount;
  final int? walletPayment;
  final dynamic bankAccountId;

  SalesRegisterModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    this.registerNo,
    required this.openingCash,
    this.salesManId,
    required this.cashPayment,
    required this.chequePayment,
    required this.cardPayment,
    required this.bankPayment,
    required this.upiPayment,
    required this.salesReturn,
    required this.cashRefund,
    required this.bankRefund,
    this.numberOfBills,
    this.numberOfItems,
    this.totalDiscount,
    this.taxAmount,
    required this.creditAdvanceRedeemed,
    required this.payLater,
    required this.expense,
    required this.purchasePayment,
    required this.totalSales,
    required this.bankTransferAmount,
    required this.cashFlow,
    required this.status,
    required this.denominations,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
    this.physicalDrawerCash,
    this.totalCashInDrawer,
    this.totalCashLeftInDrawer,
    this.closingNote,
    this.totalDenominationAmount,
    this.walletPayment,
    this.bankAccountId,
  });

  factory SalesRegisterModel.fromRawJson(String str) =>
      SalesRegisterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesRegisterModel.fromJson(Map<String, dynamic> json) =>
      SalesRegisterModel(
        id: json["_id"]?.toString() ?? "",
        isDeleted: json["isDeleted"] ?? false,
        isActive: json["isActive"] ?? true,
        createdBy: CreatedBy.fromJson(json["createdBy"] ?? {}),
        updatedBy: json["updatedBy"]?.toString() ?? "",
        companyId: BranchIdClass.fromJson(json["companyId"] ?? {}),
        registerNo: json["registerNo"]?.toString(),
        openingCash: int.tryParse(json["openingCash"]?.toString() ?? "0") ?? 0,
        salesManId: json["salesManId"] == null
            ? null
            : SalesManId.fromJson(json["salesManId"]),
        cashPayment: int.tryParse(json["cashPayment"]?.toString() ?? "0") ?? 0,
        chequePayment:
            int.tryParse(json["chequePayment"]?.toString() ?? "0") ?? 0,
        cardPayment: int.tryParse(json["cardPayment"]?.toString() ?? "0") ?? 0,
        bankPayment: int.tryParse(json["bankPayment"]?.toString() ?? "0") ?? 0,
        upiPayment: int.tryParse(json["upiPayment"]?.toString() ?? "0") ?? 0,
        salesReturn: int.tryParse(json["salesReturn"]?.toString() ?? "0") ?? 0,
        cashRefund: int.tryParse(json["cashRefund"]?.toString() ?? "0") ?? 0,
        bankRefund: int.tryParse(json["bankRefund"]?.toString() ?? "0") ?? 0,
        numberOfBills: int.tryParse(json["numberOfBills"]?.toString() ?? "0"),
        numberOfItems: int.tryParse(json["numberOfItems"]?.toString() ?? "0"),
        totalDiscount: int.tryParse(json["totalDiscount"]?.toString() ?? "0"),
        taxAmount: json["taxAmount"]?.toDouble() ?? 0.0,
        creditAdvanceRedeemed:
            int.tryParse(json["creditAdvanceRedeemed"]?.toString() ?? "0") ?? 0,
        payLater: int.tryParse(json["payLater"]?.toString() ?? "0") ?? 0,
        expense: int.tryParse(json["expense"]?.toString() ?? "0") ?? 0,
        purchasePayment:
            int.tryParse(json["purchasePayment"]?.toString() ?? "0") ?? 0,
        totalSales: int.tryParse(json["totalSales"]?.toString() ?? "0") ?? 0,
        bankTransferAmount:
            int.tryParse(json["bankTransferAmount"]?.toString() ?? "0") ?? 0,
        cashFlow: int.tryParse(json["cashFlow"]?.toString() ?? "0") ?? 0,
        status: json["status"]?.toString() ?? "Open",
        denominations: json["denominations"] == null
            ? []
            : List<Denomination>.from(
                json["denominations"].map((x) => Denomination.fromJson(x)),
              ),
        createdAt:
            DateTime.tryParse(json["createdAt"]?.toString() ?? "") ??
            DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updatedAt"]?.toString() ?? "") ??
            DateTime.now(),
        branchId: BranchIdClass.fromJson(json["branchId"] ?? {}),
        physicalDrawerCash: int.tryParse(
          json["physicalDrawerCash"]?.toString() ?? "0",
        ),
        totalCashInDrawer: int.tryParse(
          json["totalCashInDrawer"]?.toString() ?? "0",
        ),
        totalCashLeftInDrawer: int.tryParse(
          json["totalCashLeftInDrawer"]?.toString() ?? "0",
        ),
        closingNote: json["closingNote"]?.toString(),
        totalDenominationAmount: int.tryParse(
          json["totalDenominationAmount"]?.toString() ?? "0",
        ),
        walletPayment: int.tryParse(json["walletPayment"]?.toString() ?? "0"),
        bankAccountId: json["bankAccountId"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "registerNo": registerNo,
    "openingCash": openingCash,
    "salesManId": salesManId?.toJson(),
    "cashPayment": cashPayment,
    "chequePayment": chequePayment,
    "cardPayment": cardPayment,
    "bankPayment": bankPayment,
    "upiPayment": upiPayment,
    "salesReturn": salesReturn,
    "cashRefund": cashRefund,
    "bankRefund": bankRefund,
    "numberOfBills": numberOfBills,
    "numberOfItems": numberOfItems,
    "totalDiscount": totalDiscount,
    "taxAmount": taxAmount,
    "creditAdvanceRedeemed": creditAdvanceRedeemed,
    "payLater": payLater,
    "expense": expense,
    "purchasePayment": purchasePayment,
    "totalSales": totalSales,
    "bankTransferAmount": bankTransferAmount,
    "cashFlow": cashFlow,
    "status": status,
    "denominations": List<dynamic>.from(denominations.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "branchId": branchId.toJson(),
    "physicalDrawerCash": physicalDrawerCash,
    "totalCashInDrawer": totalCashInDrawer,
    "totalCashLeftInDrawer": totalCashLeftInDrawer,
    "closingNote": closingNote,
    "totalDenominationAmount": totalDenominationAmount,
    "walletPayment": walletPayment,
    "bankAccountId": bankAccountId,
  };
}

class BranchIdClass {
  final String id;
  final String name;

  BranchIdClass({required this.id, required this.name});

  factory BranchIdClass.fromRawJson(String str) =>
      BranchIdClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BranchIdClass.fromJson(Map<String, dynamic> json) => BranchIdClass(
    id: json["_id"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
  );

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
    id: json["_id"]?.toString() ?? "",
    fullName: json["fullName"]?.toString() ?? "",
    userType: json["userType"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };
}

class Denomination {
  final int currency;
  final int count;
  final int amount;

  Denomination({
    required this.currency,
    required this.count,
    required this.amount,
  });

  factory Denomination.fromRawJson(String str) =>
      Denomination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Denomination.fromJson(Map<String, dynamic> json) => Denomination(
    currency: int.tryParse(json["currency"]?.toString() ?? "0") ?? 0,
    count: int.tryParse(json["count"]?.toString() ?? "0") ?? 0,
    amount: int.tryParse(json["amount"]?.toString() ?? "0") ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "count": count,
    "amount": amount,
  };
}

class SalesManId {
  final String id;
  final String fullName;

  SalesManId({required this.id, required this.fullName});

  factory SalesManId.fromRawJson(String str) =>
      SalesManId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesManId.fromJson(Map<String, dynamic> json) => SalesManId(
    id: json["_id"]?.toString() ?? "",
    fullName: json["fullName"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {"_id": id, "fullName": fullName};
}
