class CustomersModel {
  final String? customerName;
  final String? noofBill;
  final String? totalAmount;
  final String? invoiceNo;
  final String? pendingAmount;
  final String? date;

  CustomersModel({
    this.customerName,
    this.noofBill,
    this.totalAmount,
    this.invoiceNo,
    this.pendingAmount,
    this.date,
  });
  double get totalAmountAsDouble => double.parse(totalAmount ?? '0');
  int get noofBillAsInt => int.parse(noofBill ?? '0');
}
