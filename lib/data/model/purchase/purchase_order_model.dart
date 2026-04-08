import 'dart:convert';

class PurchaseOrderModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String? updatedBy;
  final BranchId companyId;
  final SupplierId supplierId;
  final DateTime orderDate;
  final String orderNo;
  final String? placeOfSupply;
  final Address? billingAddress;
  final DateTime shippingDate;
  final String? shippingNote;
  final String taxType;
  final List<Item> items;
  final List<TermsAndConditionId> termsAndConditionIds;
  final String? notes;
  final String? totalQty;
  final String? totalTax;
  final String? total;
  final Summary summary;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BranchId branchId;
  final String? gstIn;

  PurchaseOrderModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    this.updatedBy,
    required this.companyId,
    required this.supplierId,
    required this.orderDate,
    required this.orderNo,
    this.placeOfSupply,
    this.billingAddress,
    required this.shippingDate,
    this.shippingNote,
    required this.taxType,
    required this.items,
    required this.termsAndConditionIds,
    this.notes,
    this.totalQty,
    this.totalTax,
    this.total,
    required this.summary,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
    this.gstIn,
  });

  factory PurchaseOrderModel.fromRawJson(String str) =>
      PurchaseOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> json) =>
      PurchaseOrderModel(
        id: json["_id"] ?? "",
        isDeleted: json["isDeleted"] ?? false,
        isActive: json["isActive"] ?? false,
        createdBy: CreatedBy.fromJson(json["createdBy"] ?? {}),
        updatedBy: json["updatedBy"]?.toString(),
        companyId: BranchId.fromJson(json["companyId"] ?? {}),
        supplierId: SupplierId.fromJson(json["supplierId"] ?? {}),
        orderDate: json["orderDate"] == null
            ? DateTime.now()
            : DateTime.parse(json["orderDate"]),
        orderNo: json["orderNo"] ?? "",
        placeOfSupply: json["placeOfSupply"]?.toString(),
        billingAddress: json["billingAddress"] == null
            ? null
            : Address.fromJson(json["billingAddress"]),
        shippingDate: json["shippingDate"] == null
            ? DateTime.now()
            : DateTime.parse(json["shippingDate"]),
        shippingNote: json["shippingNote"],
        taxType: json["taxType"]?.toString() ?? "",
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        termsAndConditionIds: json["termsAndConditionIds"] == null
            ? []
            : List<TermsAndConditionId>.from(json["termsAndConditionIds"]
                .map((x) => TermsAndConditionId.fromJson(x))),
        notes: json["notes"]?.toString(),
        totalQty: json["totalQty"]?.toString(),
        totalTax: json["totalTax"]?.toString(),
        total: json["total"]?.toString(),
        summary: Summary.fromJson(json["summary"] ?? {}),
        status: json["status"]?.toString() ?? "",
        createdAt: json["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["updatedAt"]),
        branchId: BranchId.fromJson(json["branchId"] ?? {}),
        gstIn: json["gstIn"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy.toJson(),
        "updatedBy": updatedBy,
        "companyId": companyId.toJson(),
        "supplierId": supplierId.toJson(),
        "orderDate": orderDate.toIso8601String(),
        "orderNo": orderNo,
        "placeOfSupply": placeOfSupply,
        "billingAddress": billingAddress?.toJson(),
        "shippingDate": shippingDate.toIso8601String(),
        "shippingNote": shippingNote,
        "taxType": taxType,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "termsAndConditionIds":
            List<dynamic>.from(termsAndConditionIds.map((x) => x.toJson())),
        "notes": notes,
        "totalQty": totalQty,
        "totalTax": totalTax,
        "total": total,
        "summary": summary.toJson(),
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "branchId": branchId.toJson(),
        "gstIn": gstIn,
      };
}

class Address {
  final String addressLine1;
  final String addressLine2;
  final BranchId country;
  final BranchId state;
  final BranchId city;
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
        addressLine1: json["addressLine1"] ?? "",
        addressLine2: json["addressLine2"] ?? "",
        country: BranchId.fromJson(json["country"] ?? {}),
        state: BranchId.fromJson(json["state"] ?? {}),
        city: BranchId.fromJson(json["city"] ?? {}),
        pinCode: json["pinCode"],
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "country": country.toJson(),
        "state": state.toJson(),
        "city": city.toJson(),
        "pinCode": pinCode,
        "_id": id,
      };
}

class BranchId {
  final String id;
  final String name;

  BranchId({
    required this.id,
    required this.name,
  });

  factory BranchId.fromRawJson(String str) =>
      BranchId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BranchId.fromJson(Map<String, dynamic> json) => BranchId(
        id: json["_id"]?.toString() ?? "",
        name: json["name"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class CreatedBy {
  final String id;
  final String fullName;
  final String userType;

  CreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

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

class Item {
  final BranchId productId;
  final int qty;
  final dynamic uomId;
  final String? unit;
  final double? unitCost;
  final TaxId? taxId;
  final String tax;
  final String landingCost;
  final String margin;
  final double total;

  Item({
    required this.productId,
    required this.qty,
    required this.uomId,
    this.unit,
    this.unitCost,
    this.taxId,
    required this.tax,
    required this.landingCost,
    required this.margin,
    required this.total,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: BranchId.fromJson(json["productId"] ?? {}),
        qty: json["qty"] ?? 0,
        uomId: json["uomId"],
        unit: json["unit"]?.toString(),
        unitCost: json["unitCost"]?.toDouble(),
        taxId: json["taxId"] == null ? null : TaxId.fromJson(json["taxId"]),
        tax: json["tax"]?.toString() ?? "",
        landingCost: json["landingCost"]?.toString() ?? "",
        margin: json["margin"]?.toString() ?? "",
        total: json["total"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId.toJson(),
        "qty": qty,
        "uomId": uomId,
        "unit": unit,
        "unitCost": unitCost,
        "taxId": taxId?.toJson(),
        "tax": tax,
        "landingCost": landingCost,
        "margin": margin,
        "total": total,
      };
}

class TaxId {
  final String id;
  final String name;
  final int percentage;

  TaxId({
    required this.id,
    required this.name,
    required this.percentage,
  });

  factory TaxId.fromRawJson(String str) => TaxId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxId.fromJson(Map<String, dynamic> json) => TaxId(
        id: json["_id"]?.toString() ?? "",
        name: json["name"]?.toString() ?? "",
        percentage: json["percentage"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "percentage": percentage,
      };
}

class Summary {
  final int flatDiscount;
  final double grossAmount;
  final int discountAmount;
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
        flatDiscount: json["flatDiscount"] ?? 0,
        grossAmount: json["grossAmount"]?.toDouble() ?? 0.0,
        discountAmount: json["discountAmount"] ?? 0,
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
  final PhoneNo phoneNo;
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
        phoneNo: PhoneNo.fromJson(json["phoneNo"] ?? {}),
        address: json["address"] == null
            ? []
            : List<Address>.from(
                json["address"].map((x) => Address.fromJson(x))),
        contactType: json["contactType"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "companyName": companyName,
        "email": email,
        "phoneNo": phoneNo.toJson(),
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "contactType": contactType,
      };
}

class PhoneNo {
  final String countryCode;
  final int phoneNo;

  PhoneNo({
    required this.countryCode,
    required this.phoneNo,
  });

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

class TermsAndConditionId {
  final String id;

  TermsAndConditionId({
    required this.id,
  });

  factory TermsAndConditionId.fromRawJson(String str) =>
      TermsAndConditionId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsAndConditionId.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionId(
        id: json["_id"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
      };
}
