import 'dart:convert';

class CreditNoteModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final BankAccountIdClass companyId;
  final String? personName;
  final String voucherNumber;
  final DateTime date;
  final int amount;
  final BankAccountIdClass bankAccountId;
  final String? description;
  final String type;
  final PhoneNo phoneNo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? image;

  CreditNoteModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    this.personName,
    required this.voucherNumber,
    required this.date,
    required this.amount,
    required this.bankAccountId,
    this.description,
    required this.type,
    required this.phoneNo,
    required this.createdAt,
    required this.updatedAt,
    this.image,
  });

  factory CreditNoteModel.fromRawJson(String str) =>
      CreditNoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreditNoteModel.fromJson(Map<String, dynamic> json) {
    return CreditNoteModel(
      id: json["_id"] ?? "",
      isDeleted: json["isDeleted"] ?? false,
      isActive: json["isActive"] ?? false,

      createdBy: json["createdBy"] != null
          ? CreatedBy.fromJson(json["createdBy"])
          : CreatedBy.empty(),

      updatedBy: json["updatedBy"] ?? "",

      companyId: json["companyId"] != null
          ? BankAccountIdClass.fromJson(json["companyId"])
          : BankAccountIdClass.empty(),

      personName: json["personName"],

      voucherNumber: json["voucherNumber"] ?? "",

      date: json["date"] != null
          ? DateTime.tryParse(json["date"]) ?? DateTime.now()
          : DateTime.now(),

      amount: json["amount"] ?? 0,

      bankAccountId: json["bankAccountId"] != null
          ? BankAccountIdClass.fromJson(json["bankAccountId"])
          : BankAccountIdClass.empty(),

      description: json["description"],

      type: json["type"] ?? "",

      phoneNo: json["phoneNo"] != null
          ? PhoneNo.fromJson(json["phoneNo"])
          : PhoneNo.empty(),

      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
          : DateTime.now(),

      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"]) ?? DateTime.now()
          : DateTime.now(),
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "personName": personName,
    "voucherNumber": voucherNumber,
    "date": date.toIso8601String(),
    "amount": amount,
    "bankAccountId": bankAccountId.toJson(),
    "description": description,
    "type": type,
    "phoneNo": phoneNo.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "image": image,
  };
}

class BankAccountIdClass {
  final String id;
  final String name;

  BankAccountIdClass({required this.id, required this.name});

  factory BankAccountIdClass.fromJson(Map<String, dynamic> json) {
    return BankAccountIdClass(id: json["_id"] ?? "", name: json["name"] ?? "");
  }

  factory BankAccountIdClass.empty() => BankAccountIdClass(id: "", name: "");

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

class CreatedBy {
  final String id;
  final String fullName;
  final String userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json["_id"] ?? "",
      fullName: json["fullName"] ?? "",
      userType: json["userType"] ?? "",
    );
  }

  factory CreatedBy.empty() => CreatedBy(id: "", fullName: "", userType: "");

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };
}

class PhoneNo {
  final String countryCode;
  final int phoneNo;

  PhoneNo({required this.countryCode, required this.phoneNo});

  factory PhoneNo.fromJson(Map<String, dynamic> json) {
    return PhoneNo(
      countryCode: json["countryCode"] ?? "",
      phoneNo: json["phoneNo"] ?? 0,
    );
  }

  factory PhoneNo.empty() => PhoneNo(countryCode: "", phoneNo: 0);

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "phoneNo": phoneNo,
  };
}
