import 'dart:convert';

class ExpenseModel {
  final List<ExpenseDatum> expenseData;
  final int totalData;
  final State state;

  ExpenseModel({
    required this.expenseData,
    required this.totalData,
    required this.state,
  });

  factory ExpenseModel.fromRawJson(String str) =>
      ExpenseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
    expenseData: List<ExpenseDatum>.from(
      json["expense_data"].map((x) => ExpenseDatum.fromJson(x)),
    ),
    totalData: json["totalData"],
    state: State.fromJson(json["state"]),
  );

  Map<String, dynamic> toJson() => {
    "expense_data": List<dynamic>.from(expenseData.map((x) => x.toJson())),
    "totalData": totalData,
    "state": state.toJson(),
  };
}

class ExpenseDatum {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final CompanyId companyId;
  final int amount;
  final String? image;
  final String? description;
  final bool isSalary;
  final PartyId partyId;
  final String type;
  final DateTime fromDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String branchId;
  final int? total;

  ExpenseDatum({
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
    required this.fromDate,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
    this.total,
  });

  factory ExpenseDatum.fromRawJson(String str) =>
      ExpenseDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExpenseDatum.fromJson(Map<String, dynamic> json) => ExpenseDatum(
    id: json["_id"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    createdBy: CreatedBy.fromJson(json["createdBy"]),
    updatedBy: json["updatedBy"],
    companyId: CompanyId.fromJson(json["companyId"]),
    amount: json["amount"],
    image: json["image"],
    description: json["description"],
    isSalary: json["isSalary"],
    partyId: PartyId.fromJson(json["partyId"]),
    type: json["type"],
    fromDate: DateTime.parse(json["fromDate"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    branchId: json["branchId"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "amount": amount,
    "image": image,
    "description": description,
    "isSalary": isSalary,
    "partyId": partyId.toJson(),
    "type": type,
    "fromDate": fromDate.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "branchId": branchId,
    "total": total,
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
  final int page;
  final int limit;
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
