class SupplierBillModel {
  final String status;
  final String company;
  final String billNo;
  final String supplier;
  final String billDate;
  final String billAmount;
  final String paidAmount;
  final String dueAmount;
  final String taxAmount;
  final String dueDate;
  final String notes;
  final String action;

  SupplierBillModel({
    required this.status,
    required this.company,
    required this.billNo,
    required this.supplier,
    required this.billDate,
    required this.billAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.taxAmount,
    required this.dueDate,
    required this.notes,
    required this.action,
  });

  factory SupplierBillModel.fromJson(Map<String, dynamic> json) {
    return SupplierBillModel(
      status: json["status"]?.toString() ?? "",
      company: json["company"]?.toString() ?? (json["companyId"] is Map ? json["companyId"]["name"]?.toString() ?? "" : ""),
      billNo: json["billNo"]?.toString() ?? json["supplierBillNo"]?.toString() ?? "",
      supplier: json["supplier"]?.toString() ?? (json["supplierId"] is Map ? json["supplierId"]["name"]?.toString() ?? "" : ""),
      billDate: json["billDate"]?.toString() ?? json["date"]?.toString() ?? "",
      billAmount: json["billAmount"]?.toString() ?? json["totalAmount"]?.toString() ?? json["grossAmount"]?.toString() ?? (json["transactionSummary"] is Map ? json["transactionSummary"]["netAmount"]?.toString() ?? "" : json["transactionSummary"]?.toString() ?? ""),
      paidAmount: json["paidAmount"]?.toString() ?? "0",
      dueAmount: json["dueAmount"]?.toString() ?? "0",
      taxAmount: json["taxAmount"]?.toString() ?? (json["transactionSummary"] is Map ? json["transactionSummary"]["taxAmount"]?.toString() ?? "0" : "0"),
      dueDate: json["dueDate"]?.toString() ?? "",
      notes: json["notes"]?.toString() ?? "",
      action: json["action"]?.toString() ?? "",
    );
  }
}