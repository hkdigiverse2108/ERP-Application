import 'dart:convert';

class SalesCreditNoteModel {
  final List<SalesCreditNoteDatum> salesCreditNoteData;
  final int totalData;
  final State state;

  SalesCreditNoteModel({
    required this.salesCreditNoteData,
    required this.totalData,
    required this.state,
  });

  factory SalesCreditNoteModel.fromRawJson(String str) =>
      SalesCreditNoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesCreditNoteModel.fromJson(Map<String, dynamic> json) =>
      SalesCreditNoteModel(
        salesCreditNoteData: json["salesCreditNote_data"] == null
            ? []
            : List<SalesCreditNoteDatum>.from(
                json["salesCreditNote_data"].map(
                  (x) => SalesCreditNoteDatum.fromJson(x),
                ),
              ),
        totalData: json["totalData"] ?? 0,
        state: json["state"] == null
            ? State(page: 1, limit: 10, totalPages: 1)
            : State.fromJson(json["state"]),
      );

  Map<String, dynamic> toJson() => {
        "salesCreditNote_data":
            List<dynamic>.from(salesCreditNoteData.map((x) => x.toJson())),
        "totalData": totalData,
        "state": state.toJson(),
      };
}

class SalesCreditNoteDatum {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final BranchId companyId;
  final CustomerId customerId;
  final String placeOfSupply;
  final Address billingAddress;
  final Address shippingAddress;
  final DateTime creditNoteDate;
  final String creditNoteNo;
  final DateTime? dueDate;
  final String? reason;
  final bool reverseCharge;
  final String? sez;
  final bool paymentReminder;
  final String productType;
  final dynamic productDetails;
  final dynamic additionalCharges;
  final List<TermsAndConditionId> termsAndConditionIds;
  final String? notes;
  final ShippingDetails shippingDetails;
  final TransactionSummary summary;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? salesManId;
  final String? salesId;
  final String? accountLedgerId;

  SalesCreditNoteDatum({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.customerId,
    required this.placeOfSupply,
    required this.billingAddress,
    required this.shippingAddress,
    required this.creditNoteDate,
    required this.creditNoteNo,
    this.dueDate,
    this.reason,
    required this.reverseCharge,
    this.sez,
    required this.paymentReminder,
    required this.productType,
    required this.productDetails,
    required this.additionalCharges,
    required this.termsAndConditionIds,
    this.notes,
    required this.shippingDetails,
    required this.summary,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.salesManId,
    this.salesId,
    this.accountLedgerId,
  });

  factory SalesCreditNoteDatum.fromRawJson(String str) =>
      SalesCreditNoteDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesCreditNoteDatum.fromJson(Map<String, dynamic> json) =>
      SalesCreditNoteDatum(
        id: json["_id"] ?? "",
        isDeleted: json["isDeleted"] ?? false,
        isActive: json["isActive"] ?? true,
        createdBy: json["createdBy"] == null
            ? CreatedBy(id: "", fullName: "", userType: "")
            : CreatedBy.fromJson(json["createdBy"]),
        updatedBy: json["updatedBy"] is Map
            ? json["updatedBy"]["_id"]
            : (json["updatedBy"] ?? ""),
        companyId: json["companyId"] == null
            ? BranchId(id: "", name: "")
            : BranchId.fromJson(json["companyId"]),
        customerId: json["customerId"] == null
            ? CustomerId(
                id: "",
                firstName: "",
                lastName: "",
                email: "",
                phoneNo: PhoneNo(countryCode: "91", phoneNo: 0),
                address: [])
            : CustomerId.fromJson(json["customerId"]),
        placeOfSupply: json["placeOfSupply"] ?? "",
        billingAddress: json["billingAddress"] == null
            ? Address(
                addressLine1: "",
                country: BranchId(id: "", name: ""),
                state: BranchId(id: "", name: ""),
                city: BranchId(id: "", name: ""),
                pinCode: 0,
                id: "")
            : Address.fromJson(json["billingAddress"]),
        shippingAddress: json["shippingAddress"] == null
            ? Address(
                addressLine1: "",
                country: BranchId(id: "", name: ""),
                state: BranchId(id: "", name: ""),
                city: BranchId(id: "", name: ""),
                pinCode: 0,
                id: "")
            : Address.fromJson(json["shippingAddress"]),
        creditNoteDate: json["creditNoteDate"] == null
            ? DateTime.now()
            : DateTime.parse(json["creditNoteDate"]),
        creditNoteNo: json["creditNoteNo"] ?? "",
        dueDate:
            json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
        reason: json["reason"],
        reverseCharge: json["reverseCharge"] ?? false,
        sez: json["sez"],
        paymentReminder: json["paymentReminder"] ?? false,
        productType: json["productType"] ?? "",
        productDetails: json["productDetails"],
        additionalCharges: json["additionalCharges"],
        termsAndConditionIds: json["termsAndConditionIds"] == null
            ? []
            : List<TermsAndConditionId>.from(
                json["termsAndConditionIds"]
                    .map((x) => TermsAndConditionId.fromJson(x)),
              ),
        notes: json["notes"],
        shippingDetails: json["shippingDetails"] == null
            ? ShippingDetails(shippingType: "delivery", weight: 0.0)
            : ShippingDetails.fromJson(json["shippingDetails"]),
        summary: json["summary"] == null
            ? TransactionSummary(
                flatDiscount: 0,
                grossAmount: 0,
                discountAmount: 0,
                taxableAmount: 0,
                taxAmount: 0.0,
                roundOff: 0.0,
                netAmount: 0.0,
                id: "")
            : TransactionSummary.fromJson(json["summary"]),
        status: json["status"] ?? "pending",
        createdAt: json["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["updatedAt"]),
        salesManId: json["salesManId"] is Map
            ? json["salesManId"]["_id"]
            : json["salesManId"],
        salesId: json["salesId"] is Map ? json["salesId"]["_id"] : json["salesId"],
        accountLedgerId: json["accountLedgerId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy.toJson(),
        "updatedBy": updatedBy,
        "companyId": companyId.toJson(),
        "customerId": customerId.toJson(),
        "placeOfSupply": placeOfSupply,
        "billingAddress": billingAddress.toJson(),
        "shippingAddress": shippingAddress.toJson(),
        "creditNoteDate": creditNoteDate.toIso8601String(),
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
        "shippingDetails": shippingDetails.toJson(),
        "summary": summary.toJson(),
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "salesManId": salesManId,
        "salesId": salesId,
        "accountLedgerId": accountLedgerId,
      };
}

class BranchId {
  final String id;
  final String name;

  BranchId({required this.id, required this.name});

  factory BranchId.fromRawJson(String str) =>
      BranchId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BranchId.fromJson(Map<String, dynamic> json) => BranchId(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

class Address {
  final String addressLine1;
  final String? addressLine2;
  final BranchId country;
  final BranchId state;
  final BranchId city;
  final int pinCode;
  final String id;

  Address({
    required this.addressLine1,
    this.addressLine2,
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
        addressLine2: json["addressLine2"],
        country: json["country"] == null
            ? BranchId(id: "", name: "")
            : BranchId.fromJson(json["country"]),
        state: json["state"] == null
            ? BranchId(id: "", name: "")
            : BranchId.fromJson(json["state"]),
        city: json["city"] == null
            ? BranchId(id: "", name: "")
            : BranchId.fromJson(json["city"]),
        pinCode: json["pinCode"] ?? 0,
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

class CreatedBy {
  final String id;
  final String fullName;
  final String userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromRawJson(String str) =>
      CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
  final PhoneNo phoneNo;
  final List<Address> address;

  CustomerId({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    required this.phoneNo,
    required this.address,
  });

  factory CustomerId.fromRawJson(String str) =>
      CustomerId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
        id: json["_id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"],
        phoneNo: json["phoneNo"] == null
            ? PhoneNo(countryCode: "91", phoneNo: 0)
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
        "phoneNo": phoneNo.toJson(),
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
      };
}

class PhoneNo {
  final String countryCode;
  final int phoneNo;

  PhoneNo({required this.countryCode, required this.phoneNo});

  factory PhoneNo.fromRawJson(String str) => PhoneNo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  factory ShippingDetails.fromRawJson(String str) =>
      ShippingDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingDetails.fromJson(Map<String, dynamic> json) =>
      ShippingDetails(
        shippingType: json["shippingType"] ?? "delivery",
        weight: (json["weight"] ?? 0).toDouble(),
        id: json["_id"],
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

  factory TermsAndConditionId.fromRawJson(String str) =>
      TermsAndConditionId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsAndConditionId.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionId(
        id: json["_id"] ?? "",
        termsCondition: json["termsCondition"],
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

  factory TransactionSummary.fromRawJson(String str) =>
      TransactionSummary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

class State {
  final dynamic page;
  final dynamic limit;
  final int totalPages;

  State({required this.page, required this.limit, required this.totalPages});

  factory State.fromRawJson(String str) => State.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory State.fromJson(Map<String, dynamic> json) => State(
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
      };
}
