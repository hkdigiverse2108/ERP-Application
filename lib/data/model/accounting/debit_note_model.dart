import 'dart:convert';

class DebitNoteModel {
  final List<DebitNoteDatum> debitNoteData;
  final int totalData;
  final State state;

  DebitNoteModel({
    required this.debitNoteData,
    required this.totalData,
    required this.state,
  });

  factory DebitNoteModel.fromRawJson(String str) =>
      DebitNoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DebitNoteModel.fromJson(Map<String, dynamic> json) => DebitNoteModel(
    debitNoteData: json["debitNote_data"] == null
        ? []
        : List<DebitNoteDatum>.from(
            json["debitNote_data"].map((x) => DebitNoteDatum.fromJson(x)),
          ),
    totalData: json["totalData"] ?? 0,
    state: json["state"] == null
        ? State(page: 1, limit: 10, totalPages: 1)
        : State.fromJson(json["state"]),
  );

  Map<String, dynamic> toJson() => {
    "debitNote_data": List<dynamic>.from(debitNoteData.map((x) => x.toJson())),
    "totalData": totalData,
    "state": state.toJson(),
  };
}

class DebitNoteDatum {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final Id companyId;
  final String personName;
  final String voucherNumber;
  final DateTime date;
  final int amount;
  final Id bankAccountId;
  final String description;
  final String type;
  final PhoneNo phoneNo;
  final DateTime createdAt;
  final DateTime updatedAt;

  DebitNoteDatum({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.personName,
    required this.voucherNumber,
    required this.date,
    required this.amount,
    required this.bankAccountId,
    required this.description,
    required this.type,
    required this.phoneNo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DebitNoteDatum.fromRawJson(String str) =>
      DebitNoteDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DebitNoteDatum.fromJson(Map<String, dynamic> json) => DebitNoteDatum(
    id: json["_id"] ?? "",
    isDeleted: json["isDeleted"] ?? false,
    isActive: json["isActive"] ?? true,
    createdBy: json["createdBy"] == null
        ? CreatedBy(id: "", fullName: "", userType: "")
        : CreatedBy.fromJson(json["createdBy"]),
    updatedBy: json["updatedBy"] ?? "",
    companyId: json["companyId"] == null
        ? Id(id: "", name: "")
        : Id.fromJson(json["companyId"]),
    personName: json["personName"] ?? "",
    voucherNumber: json["voucherNumber"] ?? "",
    date: json["date"] == null ? DateTime.now() : DateTime.parse(json["date"]),
    amount: json["amount"] ?? 0,
    bankAccountId: json["bankAccountId"] == null
        ? Id(id: "", name: "")
        : Id.fromJson(json["bankAccountId"]),
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
