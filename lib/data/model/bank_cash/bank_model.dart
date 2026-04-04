import 'dart:convert';

class BankModel {
  final List<BankDatum> bankData;
  final int totalData;
  final State state;

  BankModel({
    required this.bankData,
    required this.totalData,
    required this.state,
  });

  factory BankModel.fromRawJson(String str) =>
      BankModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
    bankData: List<BankDatum>.from(
      json["bank_data"].map((x) => BankDatum.fromJson(x)),
    ),
    totalData: json["totalData"],
    state: State.fromJson(json["state"]),
  );

  Map<String, dynamic> toJson() => {
    "bank_data": List<dynamic>.from(bankData.map((x) => x.toJson())),
    "totalData": totalData,
    "state": state.toJson(),
  };
}

class BankDatum {
  final String id;
  final String name;
  final String ifscCode;
  final String branchName;
  final String accountHolderName;
  final String bankAccountNumber;
  final String swiftCode;
  final OpeningBalance? openingBalance;
  final String upiId;
  final String? addressLine1;
  final String? addressLine2;
  final String? country;
  final String? state;
  final String? city;
  final String? zipCode;
  final List<Id> branchIds;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final Id companyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  BankDatum({
    required this.id,
    required this.name,
    required this.ifscCode,
    required this.branchName,
    required this.accountHolderName,
    required this.bankAccountNumber,
    required this.swiftCode,
    required this.openingBalance,
    required this.upiId,
    this.addressLine1,
    this.addressLine2,
    this.country,
    this.state,
    this.city,
    this.zipCode,
    required this.branchIds,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BankDatum.fromRawJson(String str) =>
      BankDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankDatum.fromJson(Map<String, dynamic> json) => BankDatum(
    id: json["_id"],
    name: json["name"],
    ifscCode: json["ifscCode"],
    branchName: json["branchName"],
    accountHolderName: json["accountHolderName"],
    bankAccountNumber: json["bankAccountNumber"],
    swiftCode: json["swiftCode"],
    openingBalance: OpeningBalance.fromJson(json["openingBalance"]),
    upiId: json["upiId"],
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    zipCode: json["zipCode"],
    branchIds: List<Id>.from(json["branchIds"].map((x) => Id.fromJson(x))),
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    createdBy: CreatedBy.fromJson(json["createdBy"]),
    updatedBy: json["updatedBy"],
    companyId: Id.fromJson(json["companyId"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "ifscCode": ifscCode,
    "branchName": branchName,
    "accountHolderName": accountHolderName,
    "bankAccountNumber": bankAccountNumber,
    "swiftCode": swiftCode,
    "openingBalance": openingBalance?.toJson(),
    "upiId": upiId,
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "country": country,
    "state": state,
    "city": city,
    "zipCode": zipCode,
    "branchIds": List<dynamic>.from(branchIds.map((x) => x.toJson())),
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

  factory Id.fromRawJson(String str) => Id.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Id.fromJson(Map<String, dynamic> json) =>
      Id(id: json["_id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

class CreatedBy {
  final String id;
  final String? fullName;
  final String? userType;

  CreatedBy({required this.id, this.fullName, this.userType});

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

class OpeningBalance {
  final String? creditBalance;
  final String? debitBalance;

  OpeningBalance({this.creditBalance, this.debitBalance});

  factory OpeningBalance.fromRawJson(String str) =>
      OpeningBalance.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OpeningBalance.fromJson(Map<String, dynamic> json) => OpeningBalance(
    creditBalance: json["creditBalance"],
    debitBalance: json["debitBalance"],
  );

  Map<String, dynamic> toJson() => {
    "creditBalance": creditBalance,
    "debitBalance": debitBalance,
  };
}

class State {
  final int totalPages;

  State({required this.totalPages});

  factory State.fromRawJson(String str) => State.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory State.fromJson(Map<String, dynamic> json) =>
      State(totalPages: json["totalPages"]);

  Map<String, dynamic> toJson() => {"totalPages": totalPages};
}
