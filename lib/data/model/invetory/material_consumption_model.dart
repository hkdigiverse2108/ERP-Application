class MaterialConsumptionModel {
  final String? branch;
  final String? mcNo;
  final String? type;
  final String? totalqty;
  final String? totalAmount;
  final String? date;
  final String? remark;
  final String? action;

  MaterialConsumptionModel({
    this.branch,
    this.mcNo,
    this.type,
    this.totalqty,
    this.totalAmount,
    this.date,
    this.remark,
    this.action,
  });

  factory MaterialConsumptionModel.fromJson(Map<String, dynamic> json) {
    return MaterialConsumptionModel(
      branch: json["branch"]?.toString() ?? (json["branchId"] is Map ? json["branchId"]["name"]?.toString() : null),
      mcNo: json["mcNo"]?.toString(),
      type: json["type"]?.toString(),
      totalqty: json["totalQty"]?.toString() ?? json["totalqty"]?.toString(),
      totalAmount: json["totalAmount"]?.toString(),
      date: json["date"]?.toString(),
      remark: json["remark"]?.toString() ?? json["remarks"]?.toString(),
      action: json["action"]?.toString(),
    );
  }
}
