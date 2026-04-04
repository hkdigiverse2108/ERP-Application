import 'dart:convert';

class BankTransactionModel {
  final List<BankTransactionDatum> bankTransactionData;
  final int totalData;
  final State state;

  BankTransactionModel({
    required this.bankTransactionData,
    required this.totalData,
    required this.state,
  });

  factory BankTransactionModel.fromRawJson(String str) =>
      BankTransactionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankTransactionModel.fromJson(Map<String, dynamic> json) =>
      BankTransactionModel(
        bankTransactionData: List<BankTransactionDatum>.from(
          json["bankTransaction_data"].map(
            (x) => BankTransactionDatum.fromJson(x),
          ),
        ),
        totalData: json["totalData"],
        state: State.fromJson(json["state"]),
      );

  Map<String, dynamic> toJson() => {
    "bankTransaction_data": List<dynamic>.from(
      bankTransactionData.map((x) => x.toJson()),
    ),
    "totalData": totalData,
    "state": state.toJson(),
  };
}

class BankTransactionDatum {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final AtedBy createdBy;
  final AtedBy updatedBy;
  final CompanyId companyId;
  final dynamic branchId;
  final String voucherNo;
  final DateTime transactionDate;
  final String transactionType;
  final CompanyId fromAccount;
  final CompanyId? toAccount;
  final int amount;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  BankTransactionDatum({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.branchId,
    required this.voucherNo,
    required this.transactionDate,
    required this.transactionType,
    required this.fromAccount,
    this.toAccount,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BankTransactionDatum.fromRawJson(String str) =>
      BankTransactionDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankTransactionDatum.fromJson(Map<String, dynamic> json) =>
      BankTransactionDatum(
        id: json["_id"],
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
        createdBy: AtedBy.fromJson(json["createdBy"]),
        updatedBy: AtedBy.fromJson(json["updatedBy"]),
        companyId: CompanyId.fromJson(json["companyId"]),
        branchId: json["branchId"],
        voucherNo: json["voucherNo"],
        transactionDate: DateTime.parse(json["transactionDate"]),
        transactionType: json["transactionType"],
        fromAccount: CompanyId.fromJson(json["fromAccount"]),
        toAccount: json["toAccount"] == null
            ? null
            : CompanyId.fromJson(json["toAccount"]),
        amount: json["amount"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy.toJson(),
    "companyId": companyId.toJson(),
    "branchId": branchId,
    "voucherNo": voucherNo,
    "transactionDate": transactionDate.toIso8601String(),
    "transactionType": transactionType,
    "fromAccount": fromAccount.toJson(),
    "toAccount": toAccount?.toJson(),
    "amount": amount,
    "description": description,
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

  factory CompanyId.fromJson(Map<String, dynamic> json) =>
      CompanyId(id: json["_id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

class AtedBy {
  final String id;
  final String fullName;
  final String userType;

  AtedBy({required this.id, required this.fullName, required this.userType});

  factory AtedBy.fromRawJson(String str) => AtedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AtedBy.fromJson(Map<String, dynamic> json) => AtedBy(
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

class State {
  final int page;
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
