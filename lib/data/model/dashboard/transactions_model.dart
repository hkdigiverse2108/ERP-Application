class TransactionsModel {
  final double totalSales;
  final int totalInvoice;
  final int soldQty;
  final int totalCustomers;
  final int toReceive;
  final double totalSalesReturn;
  final double totalPurchase;
  final int totalBills;
  final int purchaseQty;
  final int totalSuppliers;
  final int toPay;
  final double totalPurchaseReturn;
  final double totalPaid;
  final double totalExpense;
  final double cashInHand;
  final double bankAccountsBalance;
  final int totalProducts;
  final int stockQty;
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
        totalSales: json["totalSales"]?.toDouble() ?? 0,
        totalInvoice: json["totalInvoice"] ?? 0,
        soldQty: json["soldQty"] ?? 0,
        totalCustomers: json["totalCustomers"] ?? 0,
        toReceive: json["toReceive"] ?? 0,
        totalSalesReturn: json["totalSalesReturn"]?.toDouble() ?? 0,
        totalPurchase: json["totalPurchase"]?.toDouble() ?? 0,
        totalBills: json["totalBills"] ?? 0,
        purchaseQty: json["purchaseQty"] ?? 0,
        totalSuppliers: json["totalSuppliers"] ?? 0,
        toPay: json["toPay"] ?? 0,
        totalPurchaseReturn: json["totalPurchaseReturn"]?.toDouble() ?? 0,
        totalPaid: json["totalPaid"]?.toDouble() ?? 0,
        totalExpense: json["totalExpense"]?.toDouble() ?? 0,
        cashInHand: json["cashInHand"]?.toDouble() ?? 0,
        bankAccountsBalance: json["bankAccountsBalance"]?.toDouble() ?? 0,
        totalProducts: json["totalProducts"] ?? 0,
        stockQty: json["stockQty"] ?? 0,
        stockValue: json["stockValue"]?.toDouble() ?? 0,
        grossProfit: json["grossProfit"]?.toDouble() ?? 0,
        avgProfitMarginAmount: json["avgProfitMarginAmount"]?.toDouble() ?? 0,
        avgProfitMarginPercent: json["avgProfitMarginPercent"]?.toDouble() ?? 0,
        avgCartValue: json["avgCartValue"]?.toDouble() ?? 0,
        avgBillsCount: json["avgBillsCount"]?.toDouble() ?? 0,
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
