
class BankModel {
  final String id;
  final String name;
  final String ifscCode;
  final String branchName;
  final String accountHolderName;
  final String bankAccountNumber;
  final String swiftCode;
  final OpeningBalance openingBalance;
  final String upiId;
  final String addressLine1;
  final String addressLine2;
  final String country;
  final String state;
  final String city;
  final String zipCode;
  final List<Id> branchIds;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final Id companyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  BankModel({
    required this.id,
    required this.name,
    required this.ifscCode,
    required this.branchName,
    required this.accountHolderName,
    required this.bankAccountNumber,
    required this.swiftCode,
    required this.openingBalance,
    required this.upiId,
    required this.addressLine1,
    required this.addressLine2,
    required this.country,
    required this.state,
    required this.city,
    required this.zipCode,
    required this.branchIds,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      ifscCode: json["ifscCode"] ?? "",
      branchName: json["branchName"] ?? "",
      accountHolderName: json["accountHolderName"] ?? "",
      bankAccountNumber: json["bankAccountNumber"] ?? "",
      swiftCode: json["swiftCode"] ?? "",

      openingBalance: json["openingBalance"] != null
          ? OpeningBalance.fromJson(json["openingBalance"])
          : OpeningBalance.empty(),

      upiId: json["upiId"] ?? "",
      addressLine1: json["addressLine1"] ?? "",
      addressLine2: json["addressLine2"] ?? "",
      country: json["country"] ?? "",
      state: json["state"] ?? "",
      city: json["city"] ?? "",
      zipCode: json["zipCode"] ?? "",

      branchIds: json["branchIds"] != null
          ? List<Id>.from(json["branchIds"].map((x) => Id.fromJson(x)))
          : [],

      isDeleted: json["isDeleted"] ?? false,
      isActive: json["isActive"] ?? false,

      createdBy: json["createdBy"] != null
          ? CreatedBy.fromJson(json["createdBy"])
          : CreatedBy.empty(),

      updatedBy: json["updatedBy"] ?? "",

      companyId: json["companyId"] != null
          ? Id.fromJson(json["companyId"])
          : Id.empty(),

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
    "name": name,
    "ifscCode": ifscCode,
    "branchName": branchName,
    "accountHolderName": accountHolderName,
    "bankAccountNumber": bankAccountNumber,
    "swiftCode": swiftCode,
    "openingBalance": openingBalance.toJson(),
    "upiId": upiId,
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "country": country,
    "state": state,
    "city": city,
    "zipCode": zipCode,
    "branchIds": branchIds.map((e) => e.toJson()).toList(),
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Id {
  final String id;
  final String name;

  Id({required this.id, required this.name});

  factory Id.fromJson(Map<String, dynamic> json) =>
      Id(id: json["_id"] ?? "", name: json["name"] ?? "");

  factory Id.empty() => Id(id: "", name: "");

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

class OpeningBalance {
  final String creditBalance;
  final String debitBalance;

  OpeningBalance({required this.creditBalance, required this.debitBalance});

  factory OpeningBalance.fromJson(Map<String, dynamic> json) => OpeningBalance(
    creditBalance: json["creditBalance"] ?? "0",
    debitBalance: json["debitBalance"] ?? "0",
  );

  factory OpeningBalance.empty() =>
      OpeningBalance(creditBalance: "0", debitBalance: "0");

  Map<String, dynamic> toJson() => {
    "creditBalance": creditBalance,
    "debitBalance": debitBalance,
  };
}
