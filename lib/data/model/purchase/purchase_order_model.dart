class PurchaseOrderModel {
  final String orderNo;
  final String supplier;
  final String orderDate;
  final String amount;
  final String status;
  final String notes;
  final String action;

  PurchaseOrderModel({
    required this.orderNo,
    required this.supplier,
    required this.orderDate,
    required this.amount,
    required this.status,
    required this.notes,
    required this.action,
  });

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> json) {
    return PurchaseOrderModel(
      orderNo: json["orderNo"]?.toString() ?? json["purchaseOrderNo"]?.toString() ?? "",
      supplier: json["supplier"]?.toString() ?? (json["supplierId"] is Map ? json["supplierId"]["name"]?.toString() ?? "" : ""),
      orderDate: json["orderDate"]?.toString() ?? json["date"]?.toString() ?? "",
      amount: json["amount"]?.toString() ?? json["totalAmount"]?.toString() ?? json["grossAmount"]?.toString() ?? (json["transactionSummary"] is Map ? json["transactionSummary"]["netAmount"]?.toString() ?? "" : json["transactionSummary"]?.toString() ?? ""),
      status: json["status"]?.toString() ?? "",
      notes: json["notes"]?.toString() ?? "",
      action: json["action"]?.toString() ?? "",
    );
  }
}