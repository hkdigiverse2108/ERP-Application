import 'dart:convert';

class OredrListModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final BranchId companyId;
  final String orderNo;
  final PosCashRegisterId? posCashRegisterId;
  final CustomerId? customerId;
  final String orderType;
  final SalesManId salesManId;
  final List<Item> items;
  final int totalQty;
  final int totalMrp;
  final double totalTaxAmount;
  final double totalAdditionalCharge;
  final double totalDiscount;
  final int flatDiscountAmount;
  final double roundOff;
  final double totalAmount;
  final int? totalReturnedQty;
  final int? returnedAmount;
  final List<AdditionalCharge> additionalCharges;
  final List<MultiplePayment> multiplePayments;
  final String? paymentMethod;
  final String paymentStatus;
  final String status;
  final double paidAmount;
  final double dueAmount;
  final PayLater payLater;
  final String? couponId;
  final double couponDiscount;
  final String? discountId;
  final int? discountAmount;
  final String? discountMode;
  final List<dynamic>? freeProducts;
  final String? loyaltyId;
  final int loyaltyDiscount;
  final String? redeemCreditId;
  final double redeemCreditAmount;
  final String? redeemCreditType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BranchId branchId;
  final DateTime? holdDate;
  final String? remark;

  OredrListModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.orderNo,
    this.posCashRegisterId,
    this.customerId,
    required this.orderType,
    required this.salesManId,
    required this.items,
    required this.totalQty,
    required this.totalMrp,
    required this.totalTaxAmount,
    required this.totalAdditionalCharge,
    required this.totalDiscount,
    required this.flatDiscountAmount,
    required this.roundOff,
    required this.totalAmount,
    this.totalReturnedQty,
    this.returnedAmount,
    required this.additionalCharges,
    required this.multiplePayments,
    this.paymentMethod,
    required this.paymentStatus,
    required this.status,
    required this.paidAmount,
    required this.dueAmount,
    required this.payLater,
    required this.couponId,
    required this.couponDiscount,
    this.discountId,
    this.discountAmount,
    this.discountMode,
    this.freeProducts,
    required this.loyaltyId,
    required this.loyaltyDiscount,
    required this.redeemCreditId,
    required this.redeemCreditAmount,
    required this.redeemCreditType,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
    this.holdDate,
    this.remark,
  });

  factory OredrListModel.fromRawJson(String str) =>
      OredrListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OredrListModel.fromJson(Map<String, dynamic> json) => OredrListModel(
    id: json["_id"]?.toString() ?? "",
    isDeleted: json["isDeleted"] ?? false,
    isActive: json["isActive"] ?? true,
    createdBy: CreatedBy.fromJson(json["createdBy"] ?? {}),
    updatedBy: json["updatedBy"]?.toString() ?? "",
    companyId: BranchId.fromJson(json["companyId"] ?? {}),
    orderNo: json["orderNo"]?.toString() ?? "",
    posCashRegisterId: json["posCashRegisterId"] == null
        ? null
        : PosCashRegisterId.fromJson(json["posCashRegisterId"]),
    customerId: json["customerId"] == null
        ? null
        : CustomerId.fromJson(json["customerId"]),
    orderType: json["orderType"]?.toString() ?? "",
    salesManId: SalesManId.fromJson(json["salesManId"] ?? {}),
    items: json["items"] == null
        ? []
        : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    totalQty: int.tryParse(json["totalQty"]?.toString() ?? "0") ?? 0,
    totalMrp: int.tryParse(json["totalMrp"]?.toString() ?? "0") ?? 0,
    totalTaxAmount: json["totalTaxAmount"]?.toDouble() ?? 0.0,
    totalAdditionalCharge: json["totalAdditionalCharge"]?.toDouble() ?? 0.0,
    totalDiscount: json["totalDiscount"]?.toDouble() ?? 0.0,
    flatDiscountAmount: int.tryParse(json["flatDiscountAmount"]?.toString() ?? "0") ?? 0,
    roundOff: json["roundOff"]?.toDouble() ?? 0.0,
    totalAmount: json["totalAmount"]?.toDouble() ?? 0.0,
    totalReturnedQty: int.tryParse(json["totalReturnedQty"]?.toString() ?? "0"),
    returnedAmount: int.tryParse(json["returnedAmount"]?.toString() ?? "0"),
    additionalCharges: json["additionalCharges"] == null
        ? []
        : List<AdditionalCharge>.from(
      json["additionalCharges"].map((x) => AdditionalCharge.fromJson(x)),
    ),
    multiplePayments: json["multiplePayments"] == null
        ? []
        : List<MultiplePayment>.from(
      json["multiplePayments"].map((x) => MultiplePayment.fromJson(x)),
    ),
    paymentMethod: json["paymentMethod"]?.toString(),
    paymentStatus: json["paymentStatus"]?.toString() ?? "Unpaid",
    status: json["status"]?.toString() ?? "Unknown",
    paidAmount: json["paidAmount"]?.toDouble() ?? 0.0,
    dueAmount: json["dueAmount"]?.toDouble() ?? 0.0,
    payLater: PayLater.fromJson(json["payLater"] ?? {}),
    couponId: json["couponId"]?.toString(),
    couponDiscount: json["couponDiscount"]?.toDouble() ?? 0.0,
    discountId: json["discountId"]?.toString(),
    discountAmount: int.tryParse(json["discountAmount"]?.toString() ?? "0"),
    discountMode: json["discountMode"]?.toString(),
    freeProducts: json["freeProducts"] == null
        ? []
        : List<dynamic>.from(json["freeProducts"]!.map((x) => x)),
    loyaltyId: json["loyaltyId"]?.toString(),
    loyaltyDiscount: int.tryParse(json["loyaltyDiscount"]?.toString() ?? "0") ?? 0,
    redeemCreditId: json["redeemCreditId"]?.toString(),
    redeemCreditAmount: json["redeemCreditAmount"]?.toDouble() ?? 0.0,
    redeemCreditType: json["redeemCreditType"]?.toString(),
    createdAt: DateTime.tryParse(json["createdAt"]?.toString() ?? "") ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json["updatedAt"]?.toString() ?? "") ?? DateTime.now(),
    branchId: BranchId.fromJson(json["branchId"] ?? {}),
    holdDate: json["holdDate"] == null
        ? null
        : DateTime.tryParse(json["holdDate"].toString()),
    remark: json["remark"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "orderNo": orderNo,
    "posCashRegisterId": posCashRegisterId?.toJson(),
    "customerId": customerId?.toJson(),
    "orderType": orderType,
    "salesManId": salesManId.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "totalQty": totalQty,
    "totalMrp": totalMrp,
    "totalTaxAmount": totalTaxAmount,
    "totalAdditionalCharge": totalAdditionalCharge,
    "totalDiscount": totalDiscount,
    "flatDiscountAmount": flatDiscountAmount,
    "roundOff": roundOff,
    "totalAmount": totalAmount,
    "totalReturnedQty": totalReturnedQty,
    "returnedAmount": returnedAmount,
    "additionalCharges": List<dynamic>.from(
      additionalCharges.map((x) => x.toJson()),
    ),
    "multiplePayments": List<dynamic>.from(
      multiplePayments.map((x) => x.toJson()),
    ),
    "paymentMethod": paymentMethod,
    "paymentStatus": paymentStatus,
    "status": status,
    "paidAmount": paidAmount,
    "dueAmount": dueAmount,
    "payLater": payLater.toJson(),
    "couponId": couponId,
    "couponDiscount": couponDiscount,
    "discountId": discountId,
    "discountAmount": discountAmount,
    "discountMode": discountMode,
    "freeProducts": freeProducts == null
        ? []
        : List<dynamic>.from(freeProducts!.map((x) => x)),
    "loyaltyId": loyaltyId,
    "loyaltyDiscount": loyaltyDiscount,
    "redeemCreditId": redeemCreditId,
    "redeemCreditAmount": redeemCreditAmount,
    "redeemCreditType": redeemCreditType,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "branchId": branchId.toJson(),
    "holdDate": holdDate?.toIso8601String(),
    "remark": remark,
  };
}

class AdditionalCharge {
  final BranchId chargeId;
  final int value;
  final TaxId taxId;
  final double totalAmount;
  final String? accountGroupId;

  AdditionalCharge({
    required this.chargeId,
    required this.value,
    required this.taxId,
    required this.totalAmount,
    this.accountGroupId,
  });

  factory AdditionalCharge.fromJson(Map<String, dynamic> json) =>
      AdditionalCharge(
        chargeId: BranchId.fromJson(json["chargeId"] ?? {}),
        value: int.tryParse(json["value"]?.toString() ?? "0") ?? 0,
        taxId: TaxId.fromJson(json["taxId"] ?? {}),
        totalAmount: json["totalAmount"]?.toDouble() ?? 0.0,
        accountGroupId: json["accountGroupId"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "chargeId": chargeId.toJson(),
    "value": value,
    "taxId": taxId.toJson(),
    "totalAmount": totalAmount,
    "accountGroupId": accountGroupId,
  };
}

class BranchId {
  final String id;
  final String name;

  BranchId({required this.id, required this.name});

  factory BranchId.fromJson(Map<String, dynamic> json) =>
      BranchId(
        id: json["_id"]?.toString() ?? "", 
        name: json["name"]?.toString() ?? ""
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

class TaxId {
  final String id;
  final String name;
  final int percentage;

  TaxId({required this.id, required this.name, required this.percentage});

  factory TaxId.fromJson(Map<String, dynamic> json) => TaxId(
    id: json["_id"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "0%",
    percentage: int.tryParse(json["percentage"]?.toString() ?? "0") ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "percentage": percentage,
  };
}

class CreatedBy {
  final String id;
  final String fullName;
  final String userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["_id"]?.toString() ?? "",
    fullName: json["fullName"]?.toString() ?? "Unknown",
    userType: json["userType"]?.toString() ?? "user",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };
}

class CustomerId {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final PhoneNo phoneNo;
  final List<Address> address;
  final String? companyName;

  CustomerId({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    required this.phoneNo,
    required this.address,
    this.companyName,
  });

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
    id: json["_id"]?.toString() ?? "",
    firstName: json["firstName"]?.toString() ?? "",
    lastName: json["lastName"]?.toString() ?? "",
    email: json["email"]?.toString(),
    phoneNo: PhoneNo.fromJson(json["phoneNo"] ?? {}),
    address: json["address"] == null
        ? []
        : List<Address>.from(
      json["address"].map((x) => Address.fromJson(x)),
    ),
    companyName: json["companyName"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phoneNo": phoneNo.toJson(),
    "address": List<dynamic>.from(address.map((x) => x.toJson())),
    "companyName": companyName,
  };
}

class Address {
  final BranchId state;

  Address({required this.state});

  factory Address.fromJson(Map<String, dynamic> json) =>
      Address(state: BranchId.fromJson(json["state"] ?? {}));

  Map<String, dynamic> toJson() => {"state": state.toJson()};
}

class PhoneNo {
  final String countryCode;
  final int phoneNo;

  PhoneNo({required this.countryCode, required this.phoneNo});

  factory PhoneNo.fromJson(Map<String, dynamic> json) =>
      PhoneNo(
        countryCode: json["countryCode"]?.toString() ?? "+91", 
        phoneNo: int.tryParse(json["phoneNo"]?.toString() ?? "0") ?? 0
      );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "phoneNo": phoneNo,
  };
}

class Item {
  final ProductId productId;
  final int qty;
  final int mrp;
  final int discountAmount;
  final int additionalDiscountAmount;
  final double unitCost;
  final double netAmount;
  final int? returnedQty;

  Item({
    required this.productId,
    required this.qty,
    required this.mrp,
    required this.discountAmount,
    required this.additionalDiscountAmount,
    required this.unitCost,
    required this.netAmount,
    this.returnedQty,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    productId: ProductId.fromJson(json["productId"] ?? {}),
    qty: int.tryParse(json["qty"]?.toString() ?? "0") ?? 0,
    mrp: int.tryParse(json["mrp"]?.toString() ?? "0") ?? 0,
    discountAmount: int.tryParse(json["discountAmount"]?.toString() ?? "0") ?? 0,
    additionalDiscountAmount: int.tryParse(json["additionalDiscountAmount"]?.toString() ?? "0") ?? 0,
    unitCost: json["unitCost"]?.toDouble() ?? 0.0,
    netAmount: json["netAmount"]?.toDouble() ?? 0.0,
    returnedQty: int.tryParse(json["returnedQty"]?.toString() ?? "0"),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId.toJson(),
    "qty": qty,
    "mrp": mrp,
    "discountAmount": discountAmount,
    "additionalDiscountAmount": additionalDiscountAmount,
    "unitCost": unitCost,
    "netAmount": netAmount,
    "returnedQty": returnedQty,
  };
}

class ProductId {
  final String id;
  final String name;
  final TaxId salesTaxId;
  final TaxId purchaseTaxId;
  final bool isSalesTaxIncluding;
  final bool isPurchaseTaxIncluding;

  ProductId({
    required this.id,
    required this.name,
    required this.salesTaxId,
    required this.purchaseTaxId,
    required this.isSalesTaxIncluding,
    required this.isPurchaseTaxIncluding,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
    id: json["_id"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "Product",
    salesTaxId: TaxId.fromJson(json["salesTaxId"] ?? {}),
    purchaseTaxId: TaxId.fromJson(json["purchaseTaxId"] ?? {}),
    isSalesTaxIncluding: json["isSalesTaxIncluding"] ?? true,
    isPurchaseTaxIncluding: json["isPurchaseTaxIncluding"] ?? true,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "salesTaxId": salesTaxId.toJson(),
    "purchaseTaxId": purchaseTaxId.toJson(),
    "isSalesTaxIncluding": isSalesTaxIncluding,
    "isPurchaseTaxIncluding": isPurchaseTaxIncluding,
  };
}

class MultiplePayment {
  final double amount;
  final String method;
  final String? paymentAccountId;
  final String? upiId;
  final String? bankAccountNo;

  MultiplePayment({
    required this.amount,
    required this.method,
    required this.paymentAccountId,
    this.upiId,
    this.bankAccountNo,
  });

  factory MultiplePayment.fromJson(Map<String, dynamic> json) =>
      MultiplePayment(
        amount: json["amount"]?.toDouble() ?? 0.0,
        method: json["method"]?.toString() ?? "cash",
        paymentAccountId: json["paymentAccountId"]?.toString(),
        upiId: json["upiId"]?.toString(),
        bankAccountNo: json["bankAccountNo"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "method": method,
    "paymentAccountId": paymentAccountId,
    "upiId": upiId,
    "bankAccountNo": bankAccountNo,
  };
}

class PayLater {
  final bool sendReminder;
  final String? status;
  final DateTime? dueDate;
  final PaymentTermsId? paymentTermsId;
  final DateTime? settledDate;
  final String? paymentTerm;

  PayLater({
    required this.sendReminder,
    this.status,
    this.dueDate,
    this.paymentTermsId,
    this.settledDate,
    this.paymentTerm,
  });

  factory PayLater.fromJson(Map<String, dynamic> json) => PayLater(
    sendReminder: json["sendReminder"] ?? false,
    status: json["status"]?.toString(),
    dueDate: json["dueDate"] == null ? null : DateTime.tryParse(json["dueDate"].toString()),
    paymentTermsId: json["paymentTermsId"] == null
        ? null
        : PaymentTermsId.fromJson(json["paymentTermsId"]),
    settledDate: json["settledDate"] == null
        ? null
        : DateTime.tryParse(json["settledDate"].toString()),
    paymentTerm: json["paymentTerm"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "sendReminder": sendReminder,
    "status": status,
    "dueDate": dueDate?.toIso8601String(),
    "paymentTermsId": paymentTermsId?.toJson(),
    "settledDate": settledDate?.toIso8601String(),
    "paymentTerm": paymentTerm,
  };
}

class PaymentTermsId {
  final String id;
  final String name;
  final int day;

  PaymentTermsId({required this.id, required this.name, required this.day});

  factory PaymentTermsId.fromJson(Map<String, dynamic> json) =>
      PaymentTermsId(
        id: json["_id"]?.toString() ?? "", 
        name: json["name"]?.toString() ?? "0 Days", 
        day: int.tryParse(json["day"]?.toString() ?? "0") ?? 0
      );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "day": day};
}

class PosCashRegisterId {
  final String id;
  final String registerNo;
  final String status;

  PosCashRegisterId({
    required this.id,
    required this.registerNo,
    required this.status,
  });

  factory PosCashRegisterId.fromJson(Map<String, dynamic> json) =>
      PosCashRegisterId(
        id: json["_id"]?.toString() ?? "",
        registerNo: json["registerNo"]?.toString() ?? "",
        status: json["status"]?.toString() ?? "Open",
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "registerNo": registerNo,
    "status": status,
  };
}

class SalesManId {
  final String id;
  final String fullName;

  SalesManId({required this.id, required this.fullName});

  factory SalesManId.fromJson(Map<String, dynamic> json) => SalesManId(
    id: json["_id"]?.toString() ?? "",
    fullName: json["fullName"]?.toString() ?? "Salesman",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
  };
}
