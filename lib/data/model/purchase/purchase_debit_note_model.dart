import 'dart:convert';

class PurchaseDebitNoteModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final CompanyId companyId;
  final SupplierId? supplierId;
  final dynamic billingAddress;
  final dynamic shippingAddress;
  final String debitNoteNo;
  final DateTime debitNoteDate;
  final DateTime? dueDate;
  final PaymentTermsId? paymentTermsId;
  final PurchaseId? purchaseId;
  final bool reverseCharge;
  final dynamic productDetails;
  final dynamic additionalCharges;
  final List<String> termsAndConditionIds;
  final ShippingDetails? shippingDetails;
  final Summary summary;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String branchId;
  final String? placeOfSupply;
  final String? referenceBillNo;
  final DateTime? shippingDate;
  final String? reason;
  final String? paymentTerm;
  final String? exportSez;
  final String? notes;
  final String? accountLedgerId;

  PurchaseDebitNoteModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.supplierId,
    required this.billingAddress,
    required this.shippingAddress,
    required this.debitNoteNo,
    required this.debitNoteDate,
    this.dueDate,
    this.paymentTermsId,
    this.purchaseId,
    required this.reverseCharge,
    required this.productDetails,
    required this.additionalCharges,
    required this.termsAndConditionIds,
    this.shippingDetails,
    required this.summary,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
    this.placeOfSupply,
    this.referenceBillNo,
    this.shippingDate,
    this.reason,
    this.paymentTerm,
    this.exportSez,
    this.notes,
    this.accountLedgerId,
  });

  factory PurchaseDebitNoteModel.fromRawJson(String str) =>
      PurchaseDebitNoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurchaseDebitNoteModel.fromJson(Map<String, dynamic> json) =>
      PurchaseDebitNoteModel(
        id: json["_id"]?.toString() ?? "",
        isDeleted: json["isDeleted"] ?? false,
        isActive: json["isActive"] ?? false,
        createdBy: CreatedBy.fromJson(json["createdBy"] ?? {}),
        updatedBy: json["updatedBy"]?.toString() ?? "",
        companyId: CompanyId.fromJson(json["companyId"] ?? {}),
        supplierId: json["supplierId"] == null
            ? null
            : SupplierId.fromJson(json["supplierId"]),
        billingAddress: json["billingAddress"],
        shippingAddress: json["shippingAddress"],
        debitNoteNo: json["debitNoteNo"]?.toString() ?? "",
        debitNoteDate: json["debitNoteDate"] == null
            ? DateTime.now()
            : DateTime.parse(json["debitNoteDate"]),
        dueDate: json["dueDate"] == null
            ? null
            : DateTime.parse(json["dueDate"]),
        paymentTermsId: json["paymentTermsId"] == null
            ? null
            : PaymentTermsId.fromJson(json["paymentTermsId"]),
        purchaseId: json["purchaseId"] == null
            ? null
            : PurchaseId.fromJson(json["purchaseId"]),
        reverseCharge: json["reverseCharge"] ?? false,
        productDetails: json["productDetails"],
        additionalCharges: json["additionalCharges"],
        termsAndConditionIds: json["termsAndConditionIds"] == null
            ? []
            : List<String>.from(json["termsAndConditionIds"].map((x) => x)),
        shippingDetails: json["shippingDetails"] == null
            ? null
            : ShippingDetails.fromJson(json["shippingDetails"]),
        summary: Summary.fromJson(json["summary"] ?? {}),
        status: json["status"]?.toString() ?? "Pending",
        createdAt: json["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["updatedAt"]),
        branchId: json["branchId"]?.toString() ?? "",
        placeOfSupply: json["placeOfSupply"]?.toString(),
        referenceBillNo: json["referenceBillNo"]?.toString(),
        shippingDate: json["shippingDate"] == null
            ? null
            : DateTime.parse(json["shippingDate"]),
        reason: json["reason"]?.toString(),
        paymentTerm: json["paymentTerm"]?.toString(),
        exportSez: json["exportSez"]?.toString(),
        notes: json["notes"]?.toString(),
        accountLedgerId: json["accountLedgerId"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "supplierId": supplierId?.toJson(),
    "billingAddress": billingAddress,
    "shippingAddress": shippingAddress,
    "debitNoteNo": debitNoteNo,
    "debitNoteDate": debitNoteDate.toIso8601String(),
    "dueDate": dueDate?.toIso8601String(),
    "paymentTermsId": paymentTermsId?.toJson(),
    "purchaseId": purchaseId?.toJson(),
    "reverseCharge": reverseCharge,
    "productDetails": productDetails,
    "additionalCharges": additionalCharges,
    "termsAndConditionIds": List<dynamic>.from(
      termsAndConditionIds.map((x) => x),
    ),
    "shippingDetails": shippingDetails?.toJson(),
    "summary": summary.toJson(),
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "branchId": branchId,
    "placeOfSupply": placeOfSupply,
    "referenceBillNo": referenceBillNo,
    "shippingDate": shippingDate?.toIso8601String(),
    "reason": reason,
    "paymentTerm": paymentTerm,
    "exportSez": exportSez,
    "notes": notes,
    "accountLedgerId": accountLedgerId,
  };
}

class AdditionalCharge {
  final ChargeId? chargeId;
  final TaxId? taxId;
  final int amount;
  final int totalAmount;
  final String id;

  AdditionalCharge({
    this.chargeId,
    this.taxId,
    required this.amount,
    required this.totalAmount,
    required this.id,
  });

  factory AdditionalCharge.fromRawJson(String str) =>
      AdditionalCharge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdditionalCharge.fromJson(Map<String, dynamic> json) =>
      AdditionalCharge(
        chargeId: json["chargeId"] == null
            ? null
            : ChargeId.fromJson(json["chargeId"]),
        taxId: json["taxId"] == null ? null : TaxId.fromJson(json["taxId"]),
        amount: json["amount"] ?? 0,
        totalAmount: json["totalAmount"] ?? 0,
        id: json["_id"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
    "chargeId": chargeId?.toJson(),
    "taxId": taxId?.toJson(),
    "amount": amount,
    "totalAmount": totalAmount,
    "_id": id,
  };
}

class ChargeId {
  final String id;
  final String type;
  final String name;

  ChargeId({required this.id, required this.type, required this.name});

  factory ChargeId.fromRawJson(String str) =>
      ChargeId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChargeId.fromJson(Map<String, dynamic> json) => ChargeId(
    id: json["_id"]?.toString() ?? "",
    type: json["type"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
  );

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
  final List<AdditionalChargesItem> items;
  final double total;

  AdditionalChargesClass({required this.items, required this.total});

  factory AdditionalChargesClass.fromRawJson(String str) =>
      AdditionalChargesClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdditionalChargesClass.fromJson(Map<String, dynamic> json) =>
      AdditionalChargesClass(
        items: json["items"] == null
            ? []
            : List<AdditionalChargesItem>.from(
                json["items"].map((x) => AdditionalChargesItem.fromJson(x)),
              ),
        total: json["total"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "total": total,
  };
}

class AdditionalChargesItem {
  final String chargeId;
  final String taxId;
  final double amount;
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
        chargeId: json["chargeId"]?.toString() ?? "",
        taxId: json["taxId"]?.toString() ?? "",
        amount: json["amount"]?.toDouble() ?? 0.0,
        totalAmount: json["totalAmount"]?.toDouble() ?? 0.0,
        id: json["_id"]?.toString() ?? "",
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
  final CompanyId? country;
  final CompanyId? state;
  final CompanyId? city;
  final String pinCode;
  final String id;

  Address({
    required this.addressLine1,
    required this.addressLine2,
    this.country,
    this.state,
    this.city,
    required this.pinCode,
    required this.id,
  });

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    addressLine1: json["addressLine1"]?.toString() ?? "",
    addressLine2: json["addressLine2"]?.toString() ?? "",
    country: json["country"] == null
        ? null
        : CompanyId.fromJson(json["country"]),
    state: json["state"] == null ? null : CompanyId.fromJson(json["state"]),
    city: json["city"] == null ? null : CompanyId.fromJson(json["city"]),
    pinCode: json["pinCode"]?.toString() ?? "",
    id: json["_id"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "country": country?.toJson(),
    "state": state?.toJson(),
    "city": city?.toJson(),
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
    day: json["day"] ?? 0,
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "day": day};
}

class ProductDetail {
  final ProductId? productId;
  final String? unit;
  final CompanyId? uomId;
  final double unitCost;
  final double mrp;
  final double sellingPrice;
  final double discount1;
  final double discount2;
  final double tax;
  final TaxId? taxId;
  final double qty;
  final double landingCost;
  final double margin;
  final double total;

  ProductDetail({
    this.productId,
    this.unit,
    this.uomId,
    required this.unitCost,
    required this.mrp,
    required this.sellingPrice,
    required this.discount1,
    required this.discount2,
    required this.tax,
    this.taxId,
    required this.qty,
    required this.landingCost,
    required this.margin,
    required this.total,
  });

  factory ProductDetail.fromRawJson(String str) =>
      ProductDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    productId: json["productId"] == null
        ? null
        : ProductId.fromJson(json["productId"]),
    unit: json["unit"]?.toString(),
    uomId: json["uomId"] == null ? null : CompanyId.fromJson(json["uomId"]),
    unitCost: json["unitCost"]?.toDouble() ?? 0.0,
    mrp: json["mrp"]?.toDouble() ?? 0.0,
    sellingPrice: json["sellingPrice"]?.toDouble() ?? 0.0,
    discount1: json["discount1"]?.toDouble() ?? 0.0,
    discount2: json["discount2"]?.toDouble() ?? 0.0,
    tax: json["tax"]?.toDouble() ?? 0.0,
    taxId: json["taxId"] == null ? null : TaxId.fromJson(json["taxId"]),
    qty: json["qty"]?.toDouble() ?? 0.0,
    landingCost: json["landingCost"]?.toDouble() ?? 0.0,
    margin: json["margin"]?.toDouble() ?? 0.0,
    total: json["total"]?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    "productId": productId?.toJson(),
    "unit": unit,
    "uomId": uomId?.toJson(),
    "unitCost": unitCost,
    "mrp": mrp,
    "sellingPrice": sellingPrice,
    "discount1": discount1,
    "discount2": discount2,
    "tax": tax,
    "taxId": taxId?.toJson(),
    "qty": qty,
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
  final List<ProductDetailsItem> items;
  final double totalQty;
  final double totalTax;
  final double totalAmount;

  ProductDetailsClass({
    required this.items,
    required this.totalQty,
    required this.totalTax,
    required this.totalAmount,
  });

  factory ProductDetailsClass.fromRawJson(String str) =>
      ProductDetailsClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDetailsClass.fromJson(Map<String, dynamic> json) =>
      ProductDetailsClass(
        items: json["items"] == null
            ? []
            : List<ProductDetailsItem>.from(
                json["items"].map((x) => ProductDetailsItem.fromJson(x)),
              ),
        totalQty: json["totalQty"]?.toDouble() ?? 0.0,
        totalTax: json["totalTax"]?.toDouble() ?? 0.0,
        totalAmount: json["totalAmount"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "totalQty": totalQty,
    "totalTax": totalTax,
    "totalAmount": totalAmount,
  };
}

class ProductDetailsItem {
  final String productId;
  final String uomId;
  final double unitCost;
  final double mrp;
  final double sellingPrice;
  final double discount1;
  final double discount2;
  final String taxId;
  final double landingCost;
  final double margin;
  final double total;

  ProductDetailsItem({
    required this.productId,
    required this.uomId,
    required this.unitCost,
    required this.mrp,
    required this.sellingPrice,
    required this.discount1,
    required this.discount2,
    required this.taxId,
    required this.landingCost,
    required this.margin,
    required this.total,
  });

  factory ProductDetailsItem.fromRawJson(String str) =>
      ProductDetailsItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDetailsItem.fromJson(Map<String, dynamic> json) =>
      ProductDetailsItem(
        productId: json["productId"]?.toString() ?? "",
        uomId: json["uomId"]?.toString() ?? "",
        unitCost: json["unitCost"]?.toDouble() ?? 0.0,
        mrp: json["mrp"]?.toDouble() ?? 0.0,
        sellingPrice: json["sellingPrice"]?.toDouble() ?? 0.0,
        discount1: json["discount1"]?.toDouble() ?? 0.0,
        discount2: json["discount2"]?.toDouble() ?? 0.0,
        taxId: json["taxId"]?.toString() ?? "",
        landingCost: json["landingCost"]?.toDouble() ?? 0.0,
        margin: json["margin"]?.toDouble() ?? 0.0,
        total: json["total"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "uomId": uomId,
    "unitCost": unitCost,
    "mrp": mrp,
    "sellingPrice": sellingPrice,
    "discount1": discount1,
    "discount2": discount2,
    "taxId": taxId,
    "landingCost": landingCost,
    "margin": margin,
    "total": total,
  };
}

class PurchaseId {
  final String id;

  PurchaseId({required this.id});

  factory PurchaseId.fromRawJson(String str) =>
      PurchaseId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurchaseId.fromJson(Map<String, dynamic> json) =>
      PurchaseId(id: json["_id"]?.toString() ?? "");

  Map<String, dynamic> toJson() => {"_id": id};
}

class ShippingDetails {
  final String shippingType;
  final double weight;
  final DateTime? shippingDate;
  final String? referenceNo;
  final DateTime? transportDate;
  final String? modeOfTransport;
  final String? transporterId;
  final String? vehicleNo;

  ShippingDetails({
    required this.shippingType,
    required this.weight,
    this.shippingDate,
    this.referenceNo,
    this.transportDate,
    this.modeOfTransport,
    this.transporterId,
    this.vehicleNo,
  });

  factory ShippingDetails.fromRawJson(String str) =>
      ShippingDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingDetails.fromJson(Map<String, dynamic> json) =>
      ShippingDetails(
        shippingType: json["shippingType"]?.toString() ?? "",
        weight: json["weight"]?.toDouble() ?? 0.0,
        shippingDate: json["shippingDate"] == null
            ? null
            : DateTime.parse(json["shippingDate"]),
        referenceNo: json["referenceNo"]?.toString(),
        transportDate: json["transportDate"] == null
            ? null
            : DateTime.parse(json["transportDate"]),
        modeOfTransport: json["modeOfTransport"]?.toString(),
        transporterId: json["transporterId"]?.toString(),
        vehicleNo: json["vehicleNo"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "shippingType": shippingType,
    "weight": weight,
    "shippingDate": shippingDate?.toIso8601String(),
    "referenceNo": referenceNo,
    "transportDate": transportDate?.toIso8601String(),
    "modeOfTransport": modeOfTransport,
    "transporterId": transporterId,
    "vehicleNo": vehicleNo,
  };
}

class Summary {
  final double flatDiscount;
  final double grossAmount;
  final double discountAmount;
  final double taxableAmount;
  final double taxAmount;
  final double roundOff;
  final double netAmount;

  Summary({
    required this.flatDiscount,
    required this.grossAmount,
    required this.discountAmount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
  });

  factory Summary.fromRawJson(String str) => Summary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    flatDiscount: json["flatDiscount"]?.toDouble() ?? 0.0,
    grossAmount: json["grossAmount"]?.toDouble() ?? 0.0,
    discountAmount: json["discountAmount"]?.toDouble() ?? 0.0,
    taxableAmount: json["taxableAmount"]?.toDouble() ?? 0.0,
    taxAmount: json["taxAmount"]?.toDouble() ?? 0.0,
    roundOff: json["roundOff"]?.toDouble() ?? 0.0,
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
  final String countryCode;
  final int phoneNo;

  PhoneNo({required this.countryCode, required this.phoneNo});

  factory PhoneNo.fromRawJson(String str) => PhoneNo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhoneNo.fromJson(Map<String, dynamic> json) => PhoneNo(
    countryCode: json["countryCode"]?.toString() ?? "",
    phoneNo: json["phoneNo"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "phoneNo": phoneNo,
  };
}
