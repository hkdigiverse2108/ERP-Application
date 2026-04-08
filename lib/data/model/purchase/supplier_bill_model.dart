import 'dart:convert';

class SupplierBillModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final UpdatedBy updatedBy;
  final CompanyId companyId;
  final SupplierId supplierId;
  final String supplierBillNo;
  final String referenceBillNo;
  final DateTime supplierBillDate;
  final String? gstIn;
  final Address? billingAddress;
  final PaymentTermsId? paymentTermsId;
  final DateTime? dueDate;
  final bool reverseCharge;
  final DateTime? shippingDate;
  final String taxType;
  final String? invoiceAmount;
  final dynamic productDetails;
  final ReturnProductDetails returnProductDetails;
  final dynamic additionalCharges;
  final List<TermsAndConditionId> termsAndConditionIds;
  final SalaryModelSummary summary;
  final int paidAmount;
  final int balanceAmount;
  final String paymentStatus;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? placeOfSupply;
  final String? branchId;
  final String? notes;
  final String? paymentTerm;

  SupplierBillModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.supplierId,
    required this.supplierBillNo,
    required this.referenceBillNo,
    required this.supplierBillDate,
    this.gstIn,
    this.billingAddress,
    this.paymentTermsId,
    this.dueDate,
    required this.reverseCharge,
    this.shippingDate,
    required this.taxType,
    this.invoiceAmount,
    required this.productDetails,
    required this.returnProductDetails,
    required this.additionalCharges,
    required this.termsAndConditionIds,
    required this.summary,
    required this.paidAmount,
    required this.balanceAmount,
    required this.paymentStatus,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.placeOfSupply,
    this.branchId,
    this.notes,
    this.paymentTerm,
  });

  factory SupplierBillModel.fromRawJson(String str) =>
      SupplierBillModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SupplierBillModel.fromJson(
    Map<String, dynamic> json,
  ) => SupplierBillModel(
    id: json["_id"]?.toString() ?? "",
    isDeleted: json["isDeleted"] ?? false,
    isActive: json["isActive"] ?? false,
    createdBy: CreatedBy.fromJson(json["createdBy"] ?? {}),
    updatedBy: UpdatedBy.fromJson(json["updatedBy"] ?? {}),
    companyId: CompanyId.fromJson(json["companyId"] ?? {}),
    supplierId: SupplierId.fromJson(json["supplierId"] ?? {}),
    supplierBillNo: json["supplierBillNo"]?.toString() ?? "",
    referenceBillNo: json["referenceBillNo"]?.toString() ?? "",
    supplierBillDate: json["supplierBillDate"] == null
        ? DateTime.now()
        : DateTime.parse(json["supplierBillDate"]),
    gstIn: json["gstIn"]?.toString(),
    billingAddress: json["billingAddress"] == null
        ? null
        : Address.fromJson(json["billingAddress"]),
    paymentTermsId: json["paymentTermsId"] == null
        ? null
        : PaymentTermsId.fromJson(json["paymentTermsId"]),
    dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
    reverseCharge: json["reverseCharge"] ?? false,
    shippingDate: json["shippingDate"] == null
        ? null
        : DateTime.parse(json["shippingDate"]),
    taxType: json["taxType"]?.toString() ?? "",
    invoiceAmount: json["invoiceAmount"]?.toString(),
    productDetails: json["productDetails"],
    returnProductDetails: ReturnProductDetails.fromJson(
      json["returnProductDetails"] ?? {},
    ),
    additionalCharges: json["additionalCharges"],
    termsAndConditionIds: json["termsAndConditionIds"] == null
        ? []
        : List<TermsAndConditionId>.from(
            json["termsAndConditionIds"].map(
              (x) => TermsAndConditionId.fromJson(x),
            ),
          ),
    summary: SalaryModelSummary.fromJson(json["summary"] ?? {}),
    paidAmount: int.tryParse(json["paidAmount"]?.toString() ?? "0") ?? 0,
    balanceAmount: int.tryParse(json["balanceAmount"]?.toString() ?? "0") ?? 0,
    paymentStatus: json["paymentStatus"]?.toString() ?? "",
    status: json["status"]?.toString() ?? "",
    createdAt: json["createdAt"] == null
        ? DateTime.now()
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? DateTime.now()
        : DateTime.parse(json["updatedAt"]),
    placeOfSupply: json["placeOfSupply"]?.toString(),
    branchId: json["branchId"]?.toString(),
    notes: json["notes"]?.toString(),
    paymentTerm: json["paymentTerm"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy.toJson(),
    "companyId": companyId.toJson(),
    "supplierId": supplierId.toJson(),
    "supplierBillNo": supplierBillNo,
    "referenceBillNo": referenceBillNo,
    "supplierBillDate": supplierBillDate.toIso8601String(),
    "gstIn": gstIn,
    "billingAddress": billingAddress?.toJson(),
    "paymentTermsId": paymentTermsId?.toJson(),
    "dueDate": dueDate?.toIso8601String(),
    "reverseCharge": reverseCharge,
    "shippingDate": shippingDate?.toIso8601String(),
    "taxType": taxType,
    "invoiceAmount": invoiceAmount,
    "productDetails": productDetails,
    "returnProductDetails": returnProductDetails.toJson(),
    "additionalCharges": additionalCharges,
    "termsAndConditionIds": List<dynamic>.from(
      termsAndConditionIds.map((x) => x.toJson()),
    ),
    "summary": summary.toJson(),
    "paidAmount": paidAmount,
    "balanceAmount": balanceAmount,
    "paymentStatus": paymentStatus,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "placeOfSupply": placeOfSupply,
    "branchId": branchId,
    "notes": notes,
    "paymentTerm": paymentTerm,
  };
}

class AdditionalCharge {
  final ChargeId chargeId;
  final TaxId? taxId;
  final int amount;
  final double totalAmount;
  final String id;

  AdditionalCharge({
    required this.chargeId,
    required this.taxId,
    required this.amount,
    required this.totalAmount,
    required this.id,
  });

  factory AdditionalCharge.fromRawJson(String str) =>
      AdditionalCharge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdditionalCharge.fromJson(Map<String, dynamic> json) =>
      AdditionalCharge(
        chargeId: ChargeId.fromJson(json["chargeId"]),
        taxId: json["taxId"] == null ? null : TaxId.fromJson(json["taxId"]),
        amount: json["amount"],
        totalAmount: json["totalAmount"]?.toDouble(),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
    "chargeId": chargeId.toJson(),
    "taxId": taxId?.toJson(),
    "amount": amount,
    "totalAmount": totalAmount,
    "_id": id,
  };
}

class ChargeId {
  final String id;
  final Type type;
  final String name;

  ChargeId({required this.id, required this.type, required this.name});

  factory ChargeId.fromRawJson(String str) =>
      ChargeId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChargeId.fromJson(Map<String, dynamic> json) =>
      ChargeId(id: json["_id"], type: json["type"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "type": type, "name": name};
}

class TaxId {
  final String id;
  final String name;
  final double percentage;

  TaxId({required this.id, required this.name, required this.percentage});

  factory TaxId.fromRawJson(String str) => TaxId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxId.fromJson(Map<String, dynamic> json) => TaxId(
    id: json["_id"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
    percentage: json["percentage"]?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "percentage": percentage,
  };
}

class AdditionalChargesClass {
  final List<AdditionalChargesItem> item;
  final double total;

  AdditionalChargesClass({required this.item, required this.total});

  factory AdditionalChargesClass.fromRawJson(String str) =>
      AdditionalChargesClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdditionalChargesClass.fromJson(Map<String, dynamic> json) =>
      AdditionalChargesClass(
        item: List<AdditionalChargesItem>.from(
          json["item"].map((x) => AdditionalChargesItem.fromJson(x)),
        ),
        total: json["total"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "item": List<dynamic>.from(item.map((x) => x.toJson())),
    "total": total,
  };
}

class AdditionalChargesItem {
  final String chargeId;
  final String taxId;
  final int amount;
  final double totalAmount;
  final String id;

  AdditionalChargesItem({
    required this.chargeId,
    required this.taxId,
    required this.amount,
    required this.totalAmount,
    required this.id,
  });

  factory AdditionalChargesItem.fromRawJson(String str) =>
      AdditionalChargesItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdditionalChargesItem.fromJson(Map<String, dynamic> json) =>
      AdditionalChargesItem(
        chargeId: json["chargeId"],
        taxId: json["taxId"],
        amount: json["amount"],
        totalAmount: json["totalAmount"]?.toDouble(),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
    "chargeId": chargeId,
    "taxId": taxId,
    "amount": amount,
    "totalAmount": totalAmount,
    "_id": id,
  };
}

class Address {
  final String addressLine1;
  final String addressLine2;
  final CompanyId country;
  final CompanyId? state;
  final CompanyId city;
  final int? pinCode;
  final String id;

  Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.country,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.id,
  });

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    addressLine1: json["addressLine1"]?.toString() ?? "",
    addressLine2: json["addressLine2"]?.toString() ?? "",
    country: CompanyId.fromJson(json["country"] ?? {}),
    state: json["state"] == null ? null : CompanyId.fromJson(json["state"]),
    city: CompanyId.fromJson(json["city"] ?? {}),
    pinCode: int.tryParse(json["pinCode"]?.toString() ?? ""),
    id: json["_id"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "country": country.toJson(),
    "state": state?.toJson(),
    "city": city.toJson(),
    "pinCode": pinCode,
    "_id": id,
  };
}

class CompanyId {
  final String id;
  final String name;

  CompanyId({required this.id, required this.name});

  factory CompanyId.fromRawJson(String str) =>
      CompanyId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyId.fromJson(Map<String, dynamic> json) => CompanyId(
    id: json["_id"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

class CreatedBy {
  final String id;
  final String fullName;
  final String userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromRawJson(String str) =>
      CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["_id"]?.toString() ?? "",
    fullName: json["fullName"]?.toString() ?? "",
    userType: json["userType"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };
}

class PaymentTermsId {
  final String id;
  final String name;
  final int day;

  PaymentTermsId({required this.id, required this.name, required this.day});

  factory PaymentTermsId.fromRawJson(String str) =>
      PaymentTermsId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentTermsId.fromJson(Map<String, dynamic> json) => PaymentTermsId(
    id: json["_id"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
    day: int.tryParse(json["day"]?.toString() ?? "0") ?? 0,
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "day": day};
}

class ProductDetail {
  final ProductId productId;
  final int qty;
  final int freeQty;
  final CompanyId? uomId;
  final String unit;
  final double unitCost;
  final int mrp;
  final int sellingPrice;
  final int discount1;
  final int discount2;
  final double taxable;
  final TaxId? taxId;
  final String tax;
  final double landingCost;
  final double margin;
  final double total;

  ProductDetail({
    required this.productId,
    required this.qty,
    required this.freeQty,
    required this.uomId,
    required this.unit,
    required this.unitCost,
    required this.mrp,
    required this.sellingPrice,
    required this.discount1,
    required this.discount2,
    required this.taxable,
    required this.taxId,
    required this.tax,
    required this.landingCost,
    required this.margin,
    required this.total,
  });

  factory ProductDetail.fromRawJson(String str) =>
      ProductDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    productId: ProductId.fromJson(json["productId"]),
    qty: json["qty"],
    freeQty: json["freeQty"],
    uomId: json["uomId"] == null ? null : CompanyId.fromJson(json["uomId"]),
    unit: json["unit"],
    unitCost: json["unitCost"]?.toDouble(),
    mrp: json["mrp"],
    sellingPrice: json["sellingPrice"],
    discount1: json["discount1"],
    discount2: json["discount2"],
    taxable: json["taxable"]?.toDouble(),
    taxId: json["taxId"] == null ? null : TaxId.fromJson(json["taxId"]),
    tax: json["tax"],
    landingCost: json["landingCost"]?.toDouble(),
    margin: json["margin"]?.toDouble(),
    total: json["total"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId.toJson(),
    "qty": qty,
    "freeQty": freeQty,
    "uomId": uomId?.toJson(),
    "unit": unit,
    "unitCost": unitCost,
    "mrp": mrp,
    "sellingPrice": sellingPrice,
    "discount1": discount1,
    "discount2": discount2,
    "taxable": taxable,
    "taxId": taxId?.toJson(),
    "tax": tax,
    "landingCost": landingCost,
    "margin": margin,
    "total": total,
  };
}

class ProductId {
  final String id;
  final String name;
  final double? purchasePrice;

  ProductId({required this.id, required this.name, this.purchasePrice});

  factory ProductId.fromRawJson(String str) =>
      ProductId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
    id: json["_id"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
    purchasePrice: json["purchasePrice"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "purchasePrice": purchasePrice,
  };
}

class ProductDetailsClass {
  final List<ProductDetailsItem> item;
  final int totalQty;
  final double totalTax;
  final double total;

  ProductDetailsClass({
    required this.item,
    required this.totalQty,
    required this.totalTax,
    required this.total,
  });

  factory ProductDetailsClass.fromRawJson(String str) =>
      ProductDetailsClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDetailsClass.fromJson(Map<String, dynamic> json) =>
      ProductDetailsClass(
        item: List<ProductDetailsItem>.from(
          json["item"].map((x) => ProductDetailsItem.fromJson(x)),
        ),
        totalQty: json["totalQty"],
        totalTax: json["totalTax"]?.toDouble(),
        total: json["total"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "item": List<dynamic>.from(item.map((x) => x.toJson())),
    "totalQty": totalQty,
    "totalTax": totalTax,
    "total": total,
  };
}

class ProductDetailsItem {
  final String productId;
  final int qty;
  final int freeQty;
  final String? uomId;
  final String? unit;
  final int? unitCost;
  final int mrp;
  final int sellingPrice;
  final int discount1;
  final int discount2;
  final dynamic taxable;
  final String? taxId;
  final String? tax;
  final double landingCost;
  final double margin;
  final double total;
  final dynamic taxAmount;

  ProductDetailsItem({
    required this.productId,
    required this.qty,
    required this.freeQty,
    this.uomId,
    this.unit,
    this.unitCost,
    required this.mrp,
    required this.sellingPrice,
    required this.discount1,
    required this.discount2,
    this.taxable,
    this.taxId,
    this.tax,
    required this.landingCost,
    required this.margin,
    required this.total,
    this.taxAmount,
  });

  factory ProductDetailsItem.fromRawJson(String str) =>
      ProductDetailsItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDetailsItem.fromJson(Map<String, dynamic> json) =>
      ProductDetailsItem(
        productId: json["productId"]?.toString() ?? "",
        qty: json["qty"] ?? 0,
        freeQty: json["freeQty"] ?? 0,
        uomId: json["uomId"]?.toString(),
        unit: json["unit"]?.toString(),
        unitCost: json["unitCost"] ?? 0,
        mrp: json["mrp"] ?? 0,
        sellingPrice: json["sellingPrice"] ?? 0,
        discount1: json["discount1"] ?? 0,
        discount2: json["discount2"] ?? 0,
        taxable: json["taxable"],
        taxId: json["taxId"]?.toString(),
        tax: json["tax"]?.toString(),
        landingCost: json["landingCost"]?.toDouble() ?? 0.0,
        margin: json["margin"]?.toDouble() ?? 0.0,
        total: json["total"]?.toDouble() ?? 0.0,
        taxAmount: json["taxAmount"],
      );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "qty": qty,
    "freeQty": freeQty,
    "uomId": uomId,
    "unit": unit,
    "unitCost": unitCost,
    "mrp": mrp,
    "sellingPrice": sellingPrice,
    "discount1": discount1,
    "discount2": discount2,
    "taxable": taxable,
    "taxId": taxId,
    "tax": tax,
    "landingCost": landingCost,
    "margin": margin,
    "total": total,
    "taxAmount": taxAmount,
  };
}

class ReturnProductDetails {
  final List<ReturnProductDetailsItem> item;
  final ReturnProductDetailsSummary? summary;
  final int? totalQty;
  final int? total;

  ReturnProductDetails({
    required this.item,
    this.summary,
    this.totalQty,
    this.total,
  });

  factory ReturnProductDetails.fromRawJson(String str) =>
      ReturnProductDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReturnProductDetails.fromJson(Map<String, dynamic> json) =>
      ReturnProductDetails(
        item: List<ReturnProductDetailsItem>.from(
          json["item"].map((x) => ReturnProductDetailsItem.fromJson(x)),
        ),
        summary: json["summary"] == null
            ? null
            : ReturnProductDetailsSummary.fromJson(json["summary"]),
        totalQty: json["totalQty"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
    "item": List<dynamic>.from(item.map((x) => x.toJson())),
    "summary": summary?.toJson(),
    "totalQty": totalQty,
    "total": total,
  };
}

class ReturnProductDetailsItem {
  final CompanyId productId;
  final int qty;
  final int discount1;
  final int discount2;
  final CompanyId? uomId;
  final String? unit;
  final double unitCost;
  final double? taxable;
  final TaxId? taxId;
  final dynamic tax;
  final int landingCost;
  final int total;

  ReturnProductDetailsItem({
    required this.productId,
    required this.qty,
    required this.discount1,
    required this.discount2,
    this.uomId,
    this.unit,
    required this.unitCost,
    this.taxable,
    this.taxId,
    required this.tax,
    required this.landingCost,
    required this.total,
  });

  factory ReturnProductDetailsItem.fromRawJson(String str) =>
      ReturnProductDetailsItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReturnProductDetailsItem.fromJson(Map<String, dynamic> json) =>
      ReturnProductDetailsItem(
        productId: CompanyId.fromJson(json["productId"]),
        qty: json["qty"],
        discount1: json["discount1"],
        discount2: json["discount2"],
        uomId: json["uomId"] == null ? null : CompanyId.fromJson(json["uomId"]),
        unit: json["unit"],
        unitCost: json["unitCost"]?.toDouble(),
        taxable: json["taxable"]?.toDouble(),
        taxId: json["taxId"] == null ? null : TaxId.fromJson(json["taxId"]),
        tax: json["tax"],
        landingCost: json["landingCost"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
    "productId": productId.toJson(),
    "qty": qty,
    "discount1": discount1,
    "discount2": discount2,
    "uomId": uomId?.toJson(),
    "unit": unit,
    "unitCost": unitCost,
    "taxable": taxable,
    "taxId": taxId?.toJson(),
    "tax": tax,
    "landingCost": landingCost,
    "total": total,
  };
}

class ReturnProductDetailsSummary {
  final double grossAmount;
  final double taxAmount;
  final int roundOff;
  final int netAmount;

  ReturnProductDetailsSummary({
    required this.grossAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
  });

  factory ReturnProductDetailsSummary.fromRawJson(String str) =>
      ReturnProductDetailsSummary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReturnProductDetailsSummary.fromJson(Map<String, dynamic> json) =>
      ReturnProductDetailsSummary(
        grossAmount: json["grossAmount"]?.toDouble(),
        taxAmount: json["taxAmount"]?.toDouble(),
        roundOff: json["roundOff"],
        netAmount: json["netAmount"],
      );

  Map<String, dynamic> toJson() => {
    "grossAmount": grossAmount,
    "taxAmount": taxAmount,
    "roundOff": roundOff,
    "netAmount": netAmount,
  };
}

class SalaryModelSummary {
  final int flatDiscount;
  final double grossAmount;
  final int discountAmount;
  final double taxableAmount;
  final double taxAmount;
  final int roundOff;
  final double netAmount;

  SalaryModelSummary({
    required this.flatDiscount,
    required this.grossAmount,
    required this.discountAmount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
  });

  factory SalaryModelSummary.fromRawJson(String str) =>
      SalaryModelSummary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalaryModelSummary.fromJson(Map<String, dynamic> json) =>
      SalaryModelSummary(
        flatDiscount:
            int.tryParse(json["flatDiscount"]?.toString() ?? "0") ?? 0,
        grossAmount: json["grossAmount"]?.toDouble() ?? 0.0,
        discountAmount:
            int.tryParse(json["discountAmount"]?.toString() ?? "0") ?? 0,
        taxableAmount: json["taxableAmount"]?.toDouble() ?? 0.0,
        taxAmount: json["taxAmount"]?.toDouble() ?? 0.0,
        roundOff: int.tryParse(json["roundOff"]?.toString() ?? "0") ?? 0,
        netAmount: json["netAmount"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
    "flatDiscount": flatDiscount,
    "grossAmount": grossAmount,
    "discountAmount": discountAmount,
    "taxableAmount": taxableAmount,
    "taxAmount": taxAmount,
    "roundOff": roundOff,
    "netAmount": netAmount,
  };
}

class SupplierId {
  final String id;
  final String firstName;
  final String lastName;
  final String companyName;
  final String email;
  final String phoneNo;
  final List<Address> address;
  final String contactType;

  SupplierId({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.companyName,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.contactType,
  });

  factory SupplierId.fromRawJson(String str) =>
      SupplierId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SupplierId.fromJson(Map<String, dynamic> json) => SupplierId(
    id: json["_id"]?.toString() ?? "",
    firstName: json["firstName"]?.toString() ?? "",
    lastName: json["lastName"]?.toString() ?? "",
    companyName: json["companyName"]?.toString() ?? "",
    email: json["email"]?.toString() ?? "",
    phoneNo: json["phoneNo"]?.toString() ?? "",
    address: json["address"] == null
        ? []
        : List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
    contactType: json["contactType"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "companyName": companyName,
    "email": email,
    "phoneNo": phoneNo,
    "address": List<dynamic>.from(address.map((x) => x.toJson())),
    "contactType": contactType,
  };
}

class PhoneNo {
  final int phoneNo;
  final String countryCode;

  PhoneNo({required this.phoneNo, required this.countryCode});

  factory PhoneNo.fromRawJson(String str) => PhoneNo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhoneNo.fromJson(Map<String, dynamic> json) =>
      PhoneNo(phoneNo: json["phoneNo"], countryCode: json["countryCode"]);

  Map<String, dynamic> toJson() => {
    "phoneNo": phoneNo,
    "countryCode": countryCode,
  };
}

class TermsAndConditionId {
  final String id;
  final String termsCondition;

  TermsAndConditionId({required this.id, required this.termsCondition});

  factory TermsAndConditionId.fromRawJson(String str) =>
      TermsAndConditionId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsAndConditionId.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionId(
        id: json["_id"],
        termsCondition: json["termsCondition"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "termsCondition": termsCondition,
  };
}

class UpdatedBy {
  final String id;
  final String userType;

  UpdatedBy({required this.id, required this.userType});

  factory UpdatedBy.fromRawJson(String str) =>
      UpdatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdatedBy.fromJson(Map<String, dynamic> json) =>
      UpdatedBy(id: json["_id"], userType: json["userType"]);

  Map<String, dynamic> toJson() => {"_id": id, "userType": userType};
}
