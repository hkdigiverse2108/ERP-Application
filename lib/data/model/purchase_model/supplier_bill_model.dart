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
}