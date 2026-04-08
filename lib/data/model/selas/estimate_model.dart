import 'dart:convert';

class EstimateModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy? createdBy;
  final String? updatedBy;
  final CompanyId? companyId;
  final String? estimateNo;
  final DateTime? date;
  final DateTime? dueDate;
  final String? placeOfSupply;
  final Address? billingAddress;
  final Address? shippingAddress;
  final CustomerId? customerId;
  final List<Item> items;
  final List<TermsAndConditionId> termsAndConditionIds;
  final bool reverseCharge;
  final String? status;
  final TransactionSummary? transactionSummary;
  final List<AdditionalCharge> additionalCharges;
  final PaymentTermsId? paymentTermsId;
  final String? taxType;
  final ShippingDetails? shippingDetails;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? sez;
  final String? paymentTerms;
  final String? notes;

  EstimateModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    this.estimateNo,
    this.date,
    this.dueDate,
    this.placeOfSupply,
    this.billingAddress,
    this.shippingAddress,
    this.customerId,
    required this.items,
    required this.termsAndConditionIds,
    required this.reverseCharge,
    this.status,
    this.transactionSummary,
    required this.additionalCharges,
    this.paymentTermsId,
    this.taxType,
    this.shippingDetails,
    this.createdAt,
    this.updatedAt,
    this.sez,
    this.paymentTerms,
    this.notes,
  });

  factory EstimateModel.fromRawJson(String str) =>
      EstimateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EstimateModel.fromJson(Map<String, dynamic> json) => EstimateModel(
        id: json["_id"]?.toString() ?? "",
        isDeleted: json["isDeleted"] ?? false,
        isActive: json["isActive"] ?? true,
        createdBy: json["createdBy"] == null
            ? null
            : (json["createdBy"] is String ? CreatedBy(id: json["createdBy"], fullName: "", userType: "") : CreatedBy.fromJson(json["createdBy"])),
        updatedBy: json["updatedBy"] as String?,
        companyId: json["companyId"] == null
            ? null
            : (json["companyId"] is String ? CompanyId(id: json["companyId"], name: "") : CompanyId.fromJson(json["companyId"])),
        estimateNo: json["estimateNo"]?.toString(),
        date: json["date"] == null ? null : DateTime.tryParse(json["date"].toString()),
        dueDate: json["dueDate"] == null ? null : DateTime.tryParse(json["dueDate"].toString()),
        placeOfSupply: json["placeOfSupply"]?.toString(),
        billingAddress: json["billingAddress"] == null
            ? null
            : (json["billingAddress"] is String ? Address(addressLine1: "", pinCode: 0, id: json["billingAddress"]) : Address.fromJson(json["billingAddress"])),
        shippingAddress: json["shippingAddress"] == null
            ? null
            : (json["shippingAddress"] is String ? Address(addressLine1: "", pinCode: 0, id: json["shippingAddress"]) : Address.fromJson(json["shippingAddress"])),
        customerId: json["customerId"] == null
            ? null
            : (json["customerId"] is String ? CustomerId(id: json["customerId"], firstName: "", lastName: "", address: []) : CustomerId.fromJson(json["customerId"])),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        additionalCharges: json["additionalCharges"] == null
            ? []
            : List<AdditionalCharge>.from(
                json["additionalCharges"]
                    .map((x) => AdditionalCharge.fromJson(x)),
              ),
        termsAndConditionIds: json["termsAndConditionIds"] == null
            ? []
            : List<TermsAndConditionId>.from(
                json["termsAndConditionIds"].map((x) {
                  return x is String ? TermsAndConditionId(id: x, termsCondition: "") : TermsAndConditionId.fromJson(x);
                }),
              ),
        reverseCharge: json["reverseCharge"] ?? false,
        status: json["status"]?.toString(),
        transactionSummary: json["transactionSummary"] == null
            ? (json["transectionSummary"] == null
                ? null
                : TransactionSummary.fromJson(json["transectionSummary"]))
            : (json["transactionSummary"] is String ? null : TransactionSummary.fromJson(json["transactionSummary"])),
        paymentTermsId: json["paymentTermsId"] == null
            ? null
            : (json["paymentTermsId"] is String ? PaymentTermsId(id: json["paymentTermsId"], name: "", day: 0) : PaymentTermsId.fromJson(json["paymentTermsId"])),
        taxType: json["taxType"]?.toString(),
        shippingDetails: json["shippingDetails"] == null
            ? null
            : (json["shippingDetails"] is String ? null : ShippingDetails.fromJson(json["shippingDetails"])),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"].toString()),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.tryParse(json["updatedAt"].toString()),
        sez: json["sez"]?.toString(),
        paymentTerms: json["paymentTerms"]?.toString(),
        notes: json["notes"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy?.toJson(),
        "updatedBy": updatedBy,
        "companyId": companyId?.toJson(),
        "estimateNo": estimateNo,
        "date": date?.toIso8601String(),
        "dueDate": dueDate?.toIso8601String(),
        "placeOfSupply": placeOfSupply,
        "billingAddress": billingAddress?.toJson(),
        "shippingAddress": shippingAddress?.toJson(),
        "customerId": customerId?.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "termsAndConditionIds":
            List<dynamic>.from(termsAndConditionIds.map((x) => x.toJson())),
        "reverseCharge": reverseCharge,
        "status": status,
        "transactionSummary": transactionSummary?.toJson(),
        "additionalCharges":
            List<dynamic>.from(additionalCharges.map((x) => x.toJson())),
        "paymentTermsId": paymentTermsId?.toJson(),
        "taxType": taxType,
        "shippingDetails": shippingDetails?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "sez": sez,
        "paymentTerms": paymentTerms,
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
        chargeId: json["chargeId"] is Map
            ? json["chargeId"]["_id"]
            : (json["chargeId"] as String?),
        taxId: json["taxId"] is Map
            ? json["taxId"]["_id"]
            : (json["taxId"] as String?),
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

class Address {
  final String addressLine1;
  final String? addressLine2;
  final CompanyId? country;
  final CompanyId? state;
  final CompanyId? city;
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
            : CompanyId.fromJson(json["country"]),
        state: json["state"] == null
            ? null
            : CompanyId.fromJson(json["state"]),
        city: json["city"] == null
            ? null
            : (json["city"] is String ? CompanyId(id: json["city"], name: "") : CompanyId.fromJson(json["city"])),
        pinCode: int.tryParse(json["pinCode"]?.toString() ?? '0') ?? 0,
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

class CompanyId {
  final String id;
  final String name;

  CompanyId({required this.id, required this.name});

  factory CompanyId.fromJson(Map<String, dynamic> json) =>
      CompanyId(id: json["_id"] ?? "", name: json["name"] ?? "");

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
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
        countryCode: json["countryCode"]?.toString() ?? "91",
        phoneNo: int.tryParse(json["phoneNo"]?.toString() ?? '0') ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "phoneNo": phoneNo,
      };
}

class Item {
  final CompanyId? productId;
  final double qty;
  final double freeQty;
  final CompanyId? uomId;
  final String? unit;
  final double price;
  final double discount1;
  final double discount2;
  final TaxId? taxId;
  final double? tax;
  final double taxableAmount;
  final double totalAmount;

  Item({
    this.productId,
    required this.qty,
    required this.freeQty,
    this.uomId,
    this.unit,
    required this.price,
    required this.discount1,
    required this.discount2,
    this.taxId,
    this.tax,
    required this.taxableAmount,
    required this.totalAmount,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: json["productId"] == null
            ? null
            : (json["productId"] is String ? CompanyId(id: json["productId"], name: "") : CompanyId.fromJson(json["productId"])),
        qty: double.tryParse(json["qty"]?.toString() ?? '0') ?? 0.0,
        freeQty: double.tryParse(json["freeQty"]?.toString() ?? '0') ?? 0.0,
        uomId: json["uomId"] == null
            ? null
            : (json["uomId"] is String ? CompanyId(id: json["uomId"], name: "") : CompanyId.fromJson(json["uomId"])),
        unit: json["unit"] as String?,
        price: double.tryParse(json["price"]?.toString() ?? '0') ?? 0.0,
        discount1: double.tryParse(json["discount1"]?.toString() ?? '0') ?? 0.0,
        discount2: double.tryParse(json["discount2"]?.toString() ?? '0') ?? 0.0,
        taxId: json["taxId"] == null
            ? null
            : (json["taxId"] is String ? TaxId(id: json["taxId"], name: "", percentage: 0.0) : TaxId.fromJson(json["taxId"])),
        tax: double.tryParse(json["tax"]?.toString() ?? '0') ?? 0.0,
        taxableAmount: double.tryParse(json["taxableAmount"]?.toString() ?? '0') ?? 0.0,
        totalAmount: double.tryParse(json["totalAmount"]?.toString() ?? '0') ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId?.toJson(),
        "qty": qty,
        "freeQty": freeQty,
        "uomId": uomId?.toJson(),
        "unit": unit,
        "price": price,
        "discount1": discount1,
        "discount2": discount2,
        "taxId": taxId?.toJson(),
        "tax": tax,
        "taxableAmount": taxableAmount,
        "totalAmount": totalAmount,
      };
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

class PaymentTermsId {
  final String id;
  final String name;
  final int day;

  PaymentTermsId({required this.id, required this.name, required this.day});

  factory PaymentTermsId.fromJson(Map<String, dynamic> json) => PaymentTermsId(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        day: json["day"] ?? 0,
      );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "day": day};
}

class ShippingDetails {
  final String shippingType;
  final double weight;
  final String id;
  final DateTime? shippingDate;
  final String? referenceNo;
  final DateTime? transportDate;
  final String? modeOfTransport;
  final String? transporterId;
  final String? vehicleNo;

  ShippingDetails({
    required this.shippingType,
    required this.weight,
    required this.id,
    this.shippingDate,
    this.referenceNo,
    this.transportDate,
    this.modeOfTransport,
    this.transporterId,
    this.vehicleNo,
  });

  factory ShippingDetails.fromJson(Map<String, dynamic> json) =>
      ShippingDetails(
        shippingType: json["shippingType"] ?? "delivery",
        weight: (json["weight"] ?? 0).toDouble(),
        id: json["_id"] ?? "",
        shippingDate: json["shippingDate"] == null
            ? null
            : DateTime.parse(json["shippingDate"]),
        referenceNo: json["referenceNo"] as String?,
        transportDate: json["transportDate"] == null
            ? null
            : DateTime.parse(json["transportDate"]),
        modeOfTransport: json["modeOfTransport"] as String?,
        transporterId: json["transporterId"] as String?,
        vehicleNo: json["vehicleNo"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "shippingType": shippingType,
        "weight": weight,
        "_id": id,
        "shippingDate": shippingDate?.toIso8601String(),
        "referenceNo": referenceNo,
        "transportDate": transportDate?.toIso8601String(),
        "modeOfTransport": modeOfTransport,
        "transporterId": transporterId,
        "vehicleNo": vehicleNo,
      };
}

class TermsAndConditionId {
  final String id;
  final String termsCondition;

  TermsAndConditionId({required this.id, required this.termsCondition});

  factory TermsAndConditionId.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionId(
        id: json["_id"]?.toString() ?? "",
        termsCondition: json["termsCondition"]?.toString() ?? "",
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
        flatDiscount: double.tryParse(json["flatDiscount"]?.toString() ?? '0') ?? 0.0,
        grossAmount: double.tryParse(json["grossAmount"]?.toString() ?? '0') ?? 0.0,
        discountAmount: double.tryParse(json["discountAmount"]?.toString() ?? '0') ?? 0.0,
        taxableAmount: double.tryParse(json["taxableAmount"]?.toString() ?? '0') ?? 0.0,
        taxAmount: double.tryParse(json["taxAmount"]?.toString() ?? '0') ?? 0.0,
        roundOff: double.tryParse(json["roundOff"]?.toString() ?? '0') ?? 0.0,
        netAmount: double.tryParse(json["netAmount"]?.toString() ?? '0') ?? 0.0,
        id: json["_id"]?.toString() ?? "",
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
