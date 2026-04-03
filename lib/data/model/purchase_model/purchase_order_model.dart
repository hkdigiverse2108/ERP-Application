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
}