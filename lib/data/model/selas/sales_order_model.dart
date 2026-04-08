import 'dart:convert';

class SalesOrderModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy? createdBy;
  final String? updatedBy;
  final BranchId? companyId;
  final String? salesOrderNo;
  final DateTime? date;
  final DateTime? dueDate;
  final CustomerId? customerId;
  final String? placeOfSupply;
  final Address? billingAddress;
  final Address? shippingAddress;
  final String? taxType;
  final SelectedEstimateId? selectedEstimateId;
  final List<Item> items;
  final TransactionSummary? transactionSummary;
  final List<AdditionalCharge> additionalCharges;
  final List<TermsAndConditionIdElement> termsAndConditionIds;
  final String? status;
  final ShippingDetails? shippingDetails;
  final bool reverseCharge;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final BranchId? branchId;
  final String? paymentTerms;
  final String? salesManId;
  final String? notes;

  SalesOrderModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    this.salesOrderNo,
    this.date,
    this.dueDate,
    this.customerId,
    this.placeOfSupply,
    this.billingAddress,
    this.shippingAddress,
    this.taxType,
    this.selectedEstimateId,
    required this.items,
    this.transactionSummary,
    required this.additionalCharges,
    required this.termsAndConditionIds,
    this.status,
    this.shippingDetails,
    required this.reverseCharge,
    this.createdAt,
    this.updatedAt,
    this.branchId,
    this.paymentTerms,
    this.salesManId,
    this.notes,
  });

  factory SalesOrderModel.fromRawJson(String str) =>
      SalesOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesOrderModel.fromJson(Map<String, dynamic> json) => SalesOrderModel(
        id: json["_id"] ?? "",
        isDeleted: json["isDeleted"] ?? false,
        isActive: json["isActive"] ?? true,
        createdBy: json["createdBy"] == null
            ? null
            : CreatedBy.fromJson(json["createdBy"]),
        updatedBy: json["updatedBy"] as String?,
        companyId: json["companyId"] == null
            ? null
            : BranchId.fromJson(json["companyId"]),
        salesOrderNo: json["salesOrderNo"] as String?,
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
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
        taxType: json["taxType"] as String?,
        selectedEstimateId: json["selectedEstimateId"] == null
            ? null
            : SelectedEstimateId.fromJson(json["selectedEstimateId"]),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        transactionSummary: json["transactionSummary"] == null
            ? null
            : TransactionSummary.fromJson(json["transactionSummary"]),
        additionalCharges: json["additionalCharges"] == null
            ? []
            : List<AdditionalCharge>.from(
                json["additionalCharges"]
                    .map((x) => AdditionalCharge.fromJson(x)),
              ),
        termsAndConditionIds: json["termsAndConditionIds"] == null
            ? []
            : List<TermsAndConditionIdElement>.from(
                json["termsAndConditionIds"]
                    .map((x) => TermsAndConditionIdElement.fromJson(x)),
              ),
        status: json["status"] as String?,
        shippingDetails: json["shippingDetails"] == null
            ? null
            : ShippingDetails.fromJson(json["shippingDetails"]),
        reverseCharge: json["reverseCharge"] ?? false,
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        branchId: json["branchId"] == null
            ? null
            : BranchId.fromJson(json["branchId"]),
        paymentTerms: json["paymentTerms"] as String?,
        salesManId: json["salesManId"] is Map 
            ? json["salesManId"]["_id"] 
            : json["salesManId"] as String?,
        notes: json["notes"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy?.toJson(),
        "updatedBy": updatedBy,
        "companyId": companyId?.toJson(),
        "salesOrderNo": salesOrderNo,
        "date": date?.toIso8601String(),
        "dueDate": dueDate?.toIso8601String(),
        "customerId": customerId?.toJson(),
        "placeOfSupply": placeOfSupply,
        "billingAddress": billingAddress?.toJson(),
        "shippingAddress": shippingAddress?.toJson(),
        "taxType": taxType,
        "selectedEstimateId": selectedEstimateId?.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "transactionSummary": transactionSummary?.toJson(),
        "additionalCharges":
            List<dynamic>.from(additionalCharges.map((x) => x.toJson())),
        "termsAndConditionIds":
            List<dynamic>.from(termsAndConditionIds.map((x) => x.toJson())),
        "status": status,
        "shippingDetails": shippingDetails?.toJson(),
        "reverseCharge": reverseCharge,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "branchId": branchId?.toJson(),
        "paymentTerms": paymentTerms,
        "salesManId": salesManId,
        "notes": notes,
      };
}

class AdditionalCharge {
  final String? chargeId;
  final String? taxId;
  final double amount;
  final double totalAmount;
  final String id;

  AdditionalCharge({
    this.chargeId,
    this.taxId,
    required this.amount,
    required this.totalAmount,
    required this.id,
  });

  factory AdditionalCharge.fromJson(Map<String, dynamic> json) =>
      AdditionalCharge(
        chargeId: json["chargeId"] is Map ? json["chargeId"]["_id"] : (json["chargeId"] as String?),
        taxId: json["taxId"] is Map ? json["taxId"]["_id"] : (json["taxId"] as String?),
        amount: (json["amount"] ?? 0).toDouble(),
        totalAmount: (json["totalAmount"] ?? 0).toDouble(),
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "chargeId": chargeId,
        "taxId": taxId,
        "amount": amount,
        "totalAmount": totalAmount,
        "_id": id,
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

class TaxId {
  final String id;
  final String name;
  final double percentage;

  TaxId({required this.id, required this.name, required this.percentage});

  factory TaxId.fromJson(Map<String, dynamic> json) => TaxId(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        percentage: (json["percentage"] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "percentage": percentage,
      };
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

class Item {
  final String? refId;
  final BranchId? productId;
  final double qty;
  final double freeQty;
  final BranchId? uomId;
  final double price;
  final double discount1;
  final double discount2;
  final TaxId? taxId;
  final double taxableAmount;
  final double totalAmount;
  final String id;

  Item({
    this.refId,
    this.productId,
    required this.qty,
    required this.freeQty,
    this.uomId,
    required this.price,
    required this.discount1,
    required this.discount2,
    this.taxId,
    required this.taxableAmount,
    required this.totalAmount,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        refId: json["refId"] as String?,
        productId: json["productId"] == null
            ? null
            : BranchId.fromJson(json["productId"]),
        qty: (json["qty"] ?? 0).toDouble(),
        freeQty: (json["freeQty"] ?? 0).toDouble(),
        uomId: json["uomId"] == null
            ? null
            : BranchId.fromJson(json["uomId"]),
        price: (json["price"] ?? 0).toDouble(),
        discount1: (json["discount1"] ?? 0).toDouble(),
        discount2: (json["discount2"] ?? 0).toDouble(),
        taxId: json["taxId"] == null
            ? null
            : TaxId.fromJson(json["taxId"]),
        taxableAmount: (json["taxableAmount"] ?? 0).toDouble(),
        totalAmount: (json["totalAmount"] ?? 0).toDouble(),
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "refId": refId,
        "productId": productId?.toJson(),
        "qty": qty,
        "freeQty": freeQty,
        "uomId": uomId?.toJson(),
        "price": price,
        "discount1": discount1,
        "discount2": discount2,
        "taxId": taxId?.toJson(),
        "taxableAmount": taxableAmount,
        "totalAmount": totalAmount,
        "_id": id,
      };
}

class SelectedEstimateId {
  final String id;
  final String estimateNo;

  SelectedEstimateId({required this.id, required this.estimateNo});

  factory SelectedEstimateId.fromJson(Map<String, dynamic> json) =>
      SelectedEstimateId(
        id: json["_id"] ?? "",
        estimateNo: json["estimateNo"] ?? "",
      );

  Map<String, dynamic> toJson() => {"_id": id, "estimateNo": estimateNo};
}

class ShippingDetails {
  final String shippingType;
  final DateTime? shippingDate;
  final String? referenceNo;
  final DateTime? transportDate;
  final String? modeOfTransport;
  final String? vehicleNo;
  final double weight;
  final String id;
  final String? transporterId;

  ShippingDetails({
    required this.shippingType,
    this.shippingDate,
    this.referenceNo,
    this.transportDate,
    this.modeOfTransport,
    this.vehicleNo,
    required this.weight,
    required this.id,
    this.transporterId,
  });

  factory ShippingDetails.fromJson(Map<String, dynamic> json) =>
      ShippingDetails(
        shippingType: json["shippingType"] ?? "delivery",
        shippingDate: json["shippingDate"] == null
            ? null
            : DateTime.parse(json["shippingDate"]),
        referenceNo: json["referenceNo"] as String?,
        transportDate: json["transportDate"] == null
            ? null
            : DateTime.parse(json["transportDate"]),
        modeOfTransport: json["modeOfTransport"] as String?,
        vehicleNo: json["vehicleNo"] as String?,
        weight: (json["weight"] ?? 0).toDouble(),
        id: json["_id"] ?? "",
        transporterId: json["transporterId"] is Map
            ? json["transporterId"]["_id"]
            : json["transporterId"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "shippingType": shippingType,
        "shippingDate": shippingDate?.toIso8601String(),
        "referenceNo": referenceNo,
        "transportDate": transportDate?.toIso8601String(),
        "modeOfTransport": modeOfTransport,
        "vehicleNo": vehicleNo,
        "weight": weight,
        "_id": id,
        "transporterId": transporterId,
      };
}

class TermsAndConditionIdElement {
  final String id;

  TermsAndConditionIdElement({required this.id});

  factory TermsAndConditionIdElement.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionIdElement(id: json["_id"] ?? "");

  Map<String, dynamic> toJson() => {"_id": id};
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
