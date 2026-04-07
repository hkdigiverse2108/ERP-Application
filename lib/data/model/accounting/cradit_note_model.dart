import 'dart:convert';

class CreditNoteModel {
  final List<CreditNoteDatum> creditNoteData;
  final int totalData;
  final State state;

  CreditNoteModel({
    required this.creditNoteData,
    required this.totalData,
    required this.state,
  });

  factory CreditNoteModel.fromRawJson(String str) =>
      CreditNoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreditNoteModel.fromJson(Map<String, dynamic> json) =>
      CreditNoteModel(
        creditNoteData: json["creditNote_data"] == null
            ? []
            : List<CreditNoteDatum>.from(
                json["creditNote_data"].map((x) => CreditNoteDatum.fromJson(x)),
              ),
        totalData: json["totalData"] ?? 0,
        state: json["state"] == null
            ? State(page: 1, limit: 10, totalPages: 1)
            : State.fromJson(json["state"]),
      );

  Map<String, dynamic> toJson() => {
    "creditNote_data": List<dynamic>.from(
      creditNoteData.map((x) => x.toJson()),
    ),
    "totalData": totalData,
    "state": state.toJson(),
  };
}

class CreditNoteDatum {
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

  CreditNoteDatum({
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
  });

  factory CreditNoteDatum.fromRawJson(String str) =>
      CreditNoteDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreditNoteDatum.fromJson(Map<String, dynamic> json) =>
      CreditNoteDatum(
        id: json["_id"] ?? "",
        isDeleted: json["isDeleted"] ?? false,
        isActive: json["isActive"] ?? true,
        createdBy: json["createdBy"] == null
            ? CreatedBy(id: "", fullName: "", userType: "")
            : CreatedBy.fromJson(json["createdBy"]),
        updatedBy: json["updatedBy"] ?? "",
        companyId: json["companyId"] == null
            ? BankAccountIdClass(id: "", name: "")
            : BankAccountIdClass.fromJson(json["companyId"]),
        personName: json["personName"] ?? "",
        voucherNumber: json["voucherNumber"] ?? "",
        date: json["date"] == null
            ? DateTime.now()
            : DateTime.parse(json["date"]),
        amount: json["amount"] ?? 0,
        bankAccountId: json["bankAccountId"] == null
            ? BankAccountIdClass(id: "", name: "")
            : BankAccountIdClass.fromJson(json["bankAccountId"]),
        description: json["description"] ?? "",
        type: json["type"] ?? "",
        phoneNo: json["phoneNo"] == null
            ? PhoneNo(countryCode: "", phoneNo: 0)
            : PhoneNo.fromJson(json["phoneNo"]),
        createdAt: json["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["updatedAt"]),
      );

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
  };
}

class BankAccountIdClass {
  final String id;
  final String name;

  BankAccountIdClass({required this.id, required this.name});

  factory BankAccountIdClass.fromRawJson(String str) =>
      BankAccountIdClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankAccountIdClass.fromJson(Map<String, dynamic> json) =>
      BankAccountIdClass(id: json["_id"] ?? "", name: json["name"] ?? "");

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

class PhoneNo {
  final String countryCode;
  final int phoneNo;

  PhoneNo({required this.countryCode, required this.phoneNo});

  factory PhoneNo.fromRawJson(String str) => PhoneNo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhoneNo.fromJson(Map<String, dynamic> json) =>
      PhoneNo(countryCode: json["countryCode"], phoneNo: json["phoneNo"]);

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "phoneNo": phoneNo,
  };
}

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
