import 'dart:convert';

class SalesCreditNoteModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy? createdBy;
  final String? updatedBy;
  final BranchId? companyId;
  final CustomerId? customerId;
  final String? placeOfSupply;
  final Address? billingAddress;
  final Address? shippingAddress;
  final DateTime? creditNoteDate;
  final String? creditNoteNo;
  final DateTime? dueDate;
  final String? reason;
  final bool reverseCharge;
  final String? sez;
  final bool paymentReminder;
  final String? productType;
  final dynamic productDetails;
  final dynamic additionalCharges;
  final List<TermsAndConditionId> termsAndConditionIds;
  final String? notes;
  final ShippingDetails? shippingDetails;
  final TransactionSummary? summary;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? salesManId;
  final String? salesId;
  final String? accountLedgerId;

  SalesCreditNoteModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    this.customerId,
    this.placeOfSupply,
    this.billingAddress,
    this.shippingAddress,
    this.creditNoteDate,
    this.creditNoteNo,
    this.dueDate,
    this.reason,
    required this.reverseCharge,
    this.sez,
    required this.paymentReminder,
    this.productType,
    this.productDetails,
    this.additionalCharges,
    required this.termsAndConditionIds,
    this.notes,
    this.shippingDetails,
    this.summary,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.salesManId,
    this.salesId,
    this.accountLedgerId,
  });

  factory SalesCreditNoteModel.fromRawJson(String str) =>
      SalesCreditNoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesCreditNoteModel.fromJson(Map<String, dynamic> json) =>
      SalesCreditNoteModel(
        id: json["_id"] ?? "",
        isDeleted: json["isDeleted"] ?? false,
        isActive: json["isActive"] ?? true,
        createdBy: json["createdBy"] == null
            ? null
            : CreatedBy.fromJson(json["createdBy"]),
        updatedBy: json["updatedBy"] is Map
            ? json["updatedBy"]["_id"]
            : (json["updatedBy"] as String?),
        companyId: json["companyId"] == null
            ? null
            : BranchId.fromJson(json["companyId"]),
        customerId: json["customerId"] == null
            ? null
            : CustomerId.fromJson(json["customerId"]),
        placeOfSupply: json["placeOfSupply"] as String?,
        billingAddress: json["billingAddress"] == null
            ? null
            : Address.fromJson(json["billingAddress"]),
        shippingAddress: json["shippingAddress"] == null
            ? null
            : Address.fromJson(json["shippingAddress"]),
        creditNoteDate: json["creditNoteDate"] == null
            ? null
            : DateTime.parse(json["creditNoteDate"]),
        creditNoteNo: json["creditNoteNo"] as String?,
        dueDate:
            json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
        reason: json["reason"] as String?,
        reverseCharge: json["reverseCharge"] ?? false,
        sez: json["sez"] as String?,
        paymentReminder: json["paymentReminder"] ?? false,
        productType: json["productType"] as String?,
        productDetails: json["productDetails"],
        additionalCharges: json["additionalCharges"],
        termsAndConditionIds: json["termsAndConditionIds"] == null
            ? []
            : List<TermsAndConditionId>.from(
                json["termsAndConditionIds"]
                    .map((x) => TermsAndConditionId.fromJson(x)),
              ),
        notes: json["notes"] as String?,
        shippingDetails: json["shippingDetails"] == null
            ? null
            : ShippingDetails.fromJson(json["shippingDetails"]),
        summary: json["summary"] == null
            ? null
            : TransactionSummary.fromJson(json["summary"]),
        status: json["status"] as String?,
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        salesManId: json["salesManId"] is Map
            ? json["salesManId"]["_id"]
            : json["salesManId"] as String?,
        salesId: json["salesId"] is Map 
            ? json["salesId"]["_id"] 
            : json["salesId"] as String?,
        accountLedgerId: json["accountLedgerId"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy?.toJson(),
        "updatedBy": updatedBy,
        "companyId": companyId?.toJson(),
        "customerId": customerId?.toJson(),
        "placeOfSupply": placeOfSupply,
        "billingAddress": billingAddress?.toJson(),
        "shippingAddress": shippingAddress?.toJson(),
        "creditNoteDate": creditNoteDate?.toIso8601String(),
        "creditNoteNo": creditNoteNo,
        "dueDate": dueDate?.toIso8601String(),
        "reason": reason,
        "reverseCharge": reverseCharge,
        "sez": sez,
        "paymentReminder": paymentReminder,
        "productType": productType,
        "productDetails": productDetails,
        "additionalCharges": additionalCharges,
        "termsAndConditionIds": List<dynamic>.from(
          termsAndConditionIds.map((x) => x.toJson()),
        ),
        "notes": notes,
        "shippingDetails": shippingDetails?.toJson(),
        "summary": summary?.toJson(),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "salesManId": salesManId,
        "salesId": salesId,
        "accountLedgerId": accountLedgerId,
      };
}

class BranchId {
  final String id;
  final String name;

  BranchId({required this.id, required this.name});

  factory BranchId.fromJson(Map<String, dynamic> json) => BranchId(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

class Address {
  final String addressLine1;
  final String? addressLine2;
  final BranchId? country;
  final BranchId? state;
  final BranchId? city;
  final int pinCode;
  final String id;

  Address({
    required this.addressLine1,
    this.addressLine2,
    this.country,
    this.state,
    this.city,
    required this.pinCode,
    required this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine1: json["addressLine1"] ?? "",
        addressLine2: json["addressLine2"] as String?,
        country: json["country"] == null
            ? null
            : BranchId.fromJson(json["country"]),
        state: json["state"] == null
            ? null
            : BranchId.fromJson(json["state"]),
        city: json["city"] == null
            ? null
            : BranchId.fromJson(json["city"]),
        pinCode: json["pinCode"] ?? 0,
        id: json["_id"] ?? "",
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

class CreatedBy {
  final String id;
  final String fullName;
  final String userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"] ?? "",
        fullName: json["fullName"] ?? "",
        userType: json["userType"] ?? "",
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
  final PhoneNo? phoneNo;
  final List<Address> address;

  CustomerId({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phoneNo,
    required this.address,
  });

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
        id: json["_id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] as String?,
        phoneNo: json["phoneNo"] == null
            ? null
            : PhoneNo.fromJson(json["phoneNo"]),
        address: json["address"] == null
            ? []
            : List<Address>.from(
                json["address"].map((x) => Address.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNo": phoneNo?.toJson(),
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
      };
}

class PhoneNo {
  final String countryCode;
  final int phoneNo;

  PhoneNo({required this.countryCode, required this.phoneNo});

  factory PhoneNo.fromJson(Map<String, dynamic> json) => PhoneNo(
        countryCode: json["countryCode"] ?? "91",
        phoneNo: json["phoneNo"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "phoneNo": phoneNo,
      };
}

class ShippingDetails {
  final String shippingType;
  final double weight;
  final String? id;

  ShippingDetails({
    required this.shippingType,
    required this.weight,
    this.id,
  });

  factory ShippingDetails.fromJson(Map<String, dynamic> json) =>
      ShippingDetails(
        shippingType: json["shippingType"] ?? "delivery",
        weight: (json["weight"] ?? 0).toDouble(),
        id: json["_id"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "shippingType": shippingType,
        "weight": weight,
        "_id": id,
      };
}

class TermsAndConditionId {
  final String id;
  final String? termsCondition;

  TermsAndConditionId({required this.id, this.termsCondition});

  factory TermsAndConditionId.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionId(
        id: json["_id"] ?? "",
        termsCondition: json["termsCondition"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "termsCondition": termsCondition,
      };
}

class TransactionSummary {
  final double flatDiscount;
  final double grossAmount;
  final double discountAmount;
  final double taxableAmount;
  final double taxAmount;
  final double roundOff;
  final double netAmount;
  final String id;

  TransactionSummary({
    required this.flatDiscount,
    required this.grossAmount,
    required this.discountAmount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
    required this.id,
  });

  factory TransactionSummary.fromJson(Map<String, dynamic> json) =>
      TransactionSummary(
        flatDiscount: (json["flatDiscount"] ?? 0).toDouble(),
        grossAmount: (json["grossAmount"] ?? 0).toDouble(),
        discountAmount: (json["discountAmount"] ?? 0).toDouble(),
        taxableAmount: (json["taxableAmount"] ?? 0).toDouble(),
        taxAmount: (json["taxAmount"] ?? 0).toDouble(),
        roundOff: (json["roundOff"] ?? 0).toDouble(),
        netAmount: (json["netAmount"] ?? 0).toDouble(),
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "flatDiscount": flatDiscount,
        "grossAmount": grossAmount,
        "discountAmount": discountAmount,
        "taxableAmount": taxableAmount,
        "taxAmount": taxAmount,
        "roundOff": roundOff,
        "netAmount": netAmount,
        "_id": id,
      };
}
