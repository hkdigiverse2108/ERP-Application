
class BankTransactionModel {
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

  BankTransactionModel({
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

  factory BankTransactionModel.fromJson(Map<String, dynamic> json) {
    return BankTransactionModel(
      id: json["_id"] ?? "",
      isDeleted: json["isDeleted"] ?? false,
      isActive: json["isActive"] ?? false,

      createdBy: json["createdBy"] != null
          ? AtedBy.fromJson(json["createdBy"])
          : AtedBy.empty(),

      updatedBy: json["updatedBy"] != null
          ? AtedBy.fromJson(json["updatedBy"])
          : AtedBy.empty(),

      companyId: json["companyId"] != null
          ? CompanyId.fromJson(json["companyId"])
          : CompanyId.empty(),

      branchId: json["branchId"],

      voucherNo: json["voucherNo"] ?? "",

      transactionDate: json["transactionDate"] != null
          ? DateTime.tryParse(json["transactionDate"]) ?? DateTime.now()
          : DateTime.now(),

      transactionType: json["transactionType"] ?? "",

      fromAccount: json["fromAccount"] != null
          ? CompanyId.fromJson(json["fromAccount"])
          : CompanyId.empty(),

      toAccount: json["toAccount"] != null
          ? CompanyId.fromJson(json["toAccount"])
          : null,

      amount: (json["amount"] ?? 0).toInt(),

      description: json["description"] ?? "",

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

  factory CompanyId.fromJson(Map<String, dynamic> json) =>
      CompanyId(id: json["_id"] ?? "", name: json["name"] ?? "");

  factory CompanyId.empty() => CompanyId(id: "", name: "");

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

class AtedBy {
  final String id;
  final String fullName;
  final String userType;

  AtedBy({required this.id, required this.fullName, required this.userType});

  factory AtedBy.fromJson(Map<String, dynamic> json) => AtedBy(
    id: json["_id"] ?? "",
    fullName: json["fullName"] ?? "",
    userType: json["userType"] ?? "",
  );

  factory AtedBy.empty() => AtedBy(id: "", fullName: "", userType: "");

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };
}
