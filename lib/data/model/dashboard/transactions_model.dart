class TransactionsModel {
  final double totalSales;
  final double totalInvoice;
  final double soldQty;
  final double totalCustomers;
  final double toReceive;
  final double totalSalesReturn;
  final double totalPurchase;
  final double totalBills;
  final double purchaseQty;
  final double totalSuppliers;
  final double toPay;
  final double totalPurchaseReturn;
  final double totalPaid;
  final double totalExpense;
  final double cashInHand;
  final double bankAccountsBalance;
  final double totalProducts;
  final double stockQty;
  final double stockValue;
  final double grossProfit;
  final double avgProfitMarginAmount;
  final double avgProfitMarginPercent;
  final double avgCartValue;
  final double avgBillsCount;

  TransactionsModel({
    required this.totalSales,
    required this.totalInvoice,
    required this.soldQty,
    required this.totalCustomers,
    required this.toReceive,
    required this.totalSalesReturn,
    required this.totalPurchase,
    required this.totalBills,
    required this.purchaseQty,
    required this.totalSuppliers,
    required this.toPay,
    required this.totalPurchaseReturn,
    required this.totalPaid,
    required this.totalExpense,
    required this.cashInHand,
    required this.bankAccountsBalance,
    required this.totalProducts,
    required this.stockQty,
    required this.stockValue,
    required this.grossProfit,
    required this.avgProfitMarginAmount,
    required this.avgProfitMarginPercent,
    required this.avgCartValue,
    required this.avgBillsCount,
  });

  factory TransactionsModel.empty() => TransactionsModel(
    totalSales: 0,
    totalInvoice: 0,
    soldQty: 0,
    totalCustomers: 0,
    toReceive: 0,
    totalSalesReturn: 0,
    totalPurchase: 0,
    totalBills: 0,
    purchaseQty: 0,
    totalSuppliers: 0,
    toPay: 0,
    totalPurchaseReturn: 0,
    totalPaid: 0,
    totalExpense: 0,
    cashInHand: 0,
    bankAccountsBalance: 0,
    totalProducts: 0,
    stockQty: 0,
    stockValue: 0,
    grossProfit: 0,
    avgProfitMarginAmount: 0,
    avgProfitMarginPercent: 0,
    avgCartValue: 0,
    avgBillsCount: 0,
  );

  factory TransactionsModel.fromJson(Map<String, dynamic> json) =>
      TransactionsModel(
        totalSales: (json["totalSales"] ?? 0).toDouble(),
        totalInvoice: (json["totalInvoice"] ?? 0).toDouble(),
        soldQty: (json["soldQty"] ?? 0).toDouble(),
        totalCustomers: (json["totalCustomers"] ?? 0).toDouble(),
        toReceive: (json["toReceive"] ?? 0).toDouble(),
        totalSalesReturn: (json["totalSalesReturn"] ?? 0).toDouble(),
        totalPurchase: (json["totalPurchase"] ?? 0).toDouble(),
        totalBills: (json["totalBills"] ?? 0).toDouble(),
        purchaseQty: (json["purchaseQty"] ?? 0).toDouble(),
        totalSuppliers: (json["totalSuppliers"] ?? 0).toDouble(),
        toPay: (json["toPay"] ?? 0).toDouble(),
        totalPurchaseReturn: (json["totalPurchaseReturn"] ?? 0).toDouble(),
        totalPaid: (json["totalPaid"] ?? 0).toDouble(),
        totalExpense: (json["totalExpense"] ?? 0).toDouble(),
        cashInHand: (json["cashInHand"] ?? 0).toDouble(),
        bankAccountsBalance: (json["bankAccountsBalance"] ?? 0).toDouble(),
        totalProducts: (json["totalProducts"] ?? 0).toDouble(),
        stockQty: (json["stockQty"] ?? 0).toDouble(),
        stockValue: (json["stockValue"] ?? 0).toDouble(),
        grossProfit: (json["grossProfit"] ?? 0).toDouble(),
        avgProfitMarginAmount: (json["avgProfitMarginAmount"] ?? 0).toDouble(),
        avgProfitMarginPercent: (json["avgProfitMarginPercent"] ?? 0).toDouble(),
        avgCartValue: (json["avgCartValue"] ?? 0).toDouble(),
        avgBillsCount: (json["avgBillsCount"] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "totalSales": totalSales,
    "totalInvoice": totalInvoice,
    "soldQty": soldQty,
    "totalCustomers": totalCustomers,
    "toReceive": toReceive,
    "totalSalesReturn": totalSalesReturn,
    "totalPurchase": totalPurchase,
    "totalBills": totalBills,
    "purchaseQty": purchaseQty,
    "totalSuppliers": totalSuppliers,
    "toPay": toPay,
    "totalPurchaseReturn": totalPurchaseReturn,
    "totalPaid": totalPaid,
    "totalExpense": totalExpense,
    "cashInHand": cashInHand,
    "bankAccountsBalance": bankAccountsBalance,
    "totalProducts": totalProducts,
    "stockQty": stockQty,
    "stockValue": stockValue,
    "grossProfit": grossProfit,
    "avgProfitMarginAmount": avgProfitMarginAmount,
    "avgProfitMarginPercent": avgProfitMarginPercent,
    "avgCartValue": avgCartValue,
    "avgBillsCount": avgBillsCount,
  };
}
