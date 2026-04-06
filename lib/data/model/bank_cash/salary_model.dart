import 'dart:convert';

class SalaryModel {
  final List<SalaryDatum> salaryData;
  final int totalData;
  final State state;

  SalaryModel({
    required this.salaryData,
    required this.totalData,
    required this.state,
  });

  factory SalaryModel.fromRawJson(String str) =>
      SalaryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalaryModel.fromJson(Map<String, dynamic> json) => SalaryModel(
    salaryData: List<SalaryDatum>.from(
      json["salary_data"].map((x) => SalaryDatum.fromJson(x)),
    ),
    totalData: json["totalData"],
    state: State.fromJson(json["state"]),
  );

  Map<String, dynamic> toJson() => {
    "salary_data": List<dynamic>.from(salaryData.map((x) => x.toJson())),
    "totalData": totalData,
    "state": state.toJson(),
  };
}

class SalaryDatum {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final AtedBy createdBy;
  final AtedBy updatedBy;
  final CompanyId companyId;
  final int amount;
  final String? image;
  final String? description;
  final bool isSalary;
  final PartyId partyId;
  final String type;
  final int incentive;
  final DateTime fromDate;
  final DateTime toDate;
  final int total;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String branchId;

  SalaryDatum({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.amount,
    this.image,
    this.description,
    required this.isSalary,
    required this.partyId,
    required this.type,
    required this.incentive,
    required this.fromDate,
    required this.toDate,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
  });

  factory SalaryDatum.fromRawJson(String str) =>
      SalaryDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalaryDatum.fromJson(Map<String, dynamic> json) => SalaryDatum(
    id: json["_id"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    createdBy: AtedBy.fromJson(json["createdBy"]),
    updatedBy: AtedBy.fromJson(json["updatedBy"]),
    companyId: CompanyId.fromJson(json["companyId"]),
    amount: json["amount"],
    image: json["image"],
    description: json["description"],
    isSalary: json["isSalary"],
    partyId: PartyId.fromJson(json["partyId"]),
    type: json["type"],
    incentive: json["incentive"],
    fromDate: DateTime.parse(json["fromDate"]),
    toDate: DateTime.parse(json["toDate"]),
    total: json["total"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    branchId: json["branchId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy.toJson(),
    "companyId": companyId.toJson(),
    "amount": amount,
    "image": image,
    "description": description,
    "isSalary": isSalary,
    "partyId": partyId.toJson(),
    "type": type,
    "incentive": incentive,
    "fromDate": fromDate.toIso8601String(),
    "toDate": toDate.toIso8601String(),
    "total": total,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "branchId": branchId,
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

class PartyId {
  final String id;
  final String fullName;

  PartyId({required this.id, required this.fullName});

  factory PartyId.fromRawJson(String str) => PartyId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PartyId.fromJson(Map<String, dynamic> json) =>
      PartyId(id: json["_id"], fullName: json["fullName"]);

  Map<String, dynamic> toJson() => {"_id": id, "fullName": fullName};
}

class State {
  final String page;
  final String limit;
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
