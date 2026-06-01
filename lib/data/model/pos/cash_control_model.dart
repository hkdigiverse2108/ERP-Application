class CashControlModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy? createdBy;
  final String? updatedBy;
  final CompanyId? companyId;
  final RegisterId? registerId;
  final String type;
  final double amount;
  final String remark;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BranchId? branchId;

  CashControlModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    this.registerId,
    required this.type,
    required this.amount,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    this.branchId,
  });

  factory CashControlModel.fromJson(Map<String, dynamic> json) {
    return CashControlModel(
      id: json["_id"] ?? "",
      isDeleted: json["isDeleted"] ?? false,
      isActive: json["isActive"] ?? true,
      createdBy: json["createdBy"] != null ? CreatedBy.fromJson(json["createdBy"]) : null,
      updatedBy: json["updatedBy"],
      companyId: json["companyId"] != null ? CompanyId.fromJson(json["companyId"]) : null,
      registerId: json["registerId"] != null ? RegisterId.fromJson(json["registerId"]) : null,
      type: json["type"] ?? "opening",
      amount: (json["amount"] as num? ?? 0).toDouble(),
      remark: json["remark"] ?? "",
      createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
      updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
      branchId: json["branchId"] != null ? BranchId.fromJson(json["branchId"]) : null,
    );
  }
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
}

class CompanyId {
  final String id;
  final String name;

  CompanyId({required this.id, required this.name});

  factory CompanyId.fromJson(Map<String, dynamic> json) {
    return CompanyId(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
    );
  }
}

class RegisterId {
  final String id;
  final String registerNo;

  RegisterId({required this.id, required this.registerNo});

  factory RegisterId.fromJson(Map<String, dynamic> json) {
    return RegisterId(
      id: json["_id"] ?? "",
      registerNo: json["registerNo"] ?? "",
    );
  }
}

class BranchId {
  final String id;
  final String name;

  BranchId({required this.id, required this.name});

  factory BranchId.fromJson(Map<String, dynamic> json) {
    return BranchId(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
    );
  }
}
