import 'dart:convert';

class EstimateModel {
  final List<EstimateDatum> estimateData;
  final int totalData;
  final Summary summary;
  final State state;

  EstimateModel({
    required this.estimateData,
    required this.totalData,
    required this.summary,
    required this.state,
  });

  factory EstimateModel.fromRawJson(String str) =>
      EstimateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EstimateModel.fromJson(Map<String, dynamic> json) => EstimateModel(
        estimateData: json["estimate_data"] == null
            ? []
            : List<EstimateDatum>.from(
                json["estimate_data"].map((x) => EstimateDatum.fromJson(x)),
              ),
        totalData: json["totalData"] ?? 0,
        summary: json["summary"] == null
            ? Summary(
                allEstimates: 0,
                pending: 0,
                orderCreated: 0,
                invoiceCreated: 0,
              )
            : Summary.fromJson(json["summary"]),
        state: json["state"] == null
            ? State(page: 1, limit: 10, totalPages: 1)
            : State.fromJson(json["state"]),
      );

  Map<String, dynamic> toJson() => {
        "estimate_data": List<dynamic>.from(estimateData.map((x) => x.toJson())),
        "totalData": totalData,
        "summary": summary.toJson(),
        "state": state.toJson(),
      };
}

class EstimateDatum {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final CompanyId companyId;
  final String estimateNo;
  final DateTime date;
  final DateTime dueDate;
  final String? placeOfSupply;
  final Address? billingAddress;
  final Address? shippingAddress;
  final CustomerId customerId;
  final List<Item> items;
  final List<TermsAndConditionId> termsAndConditionIds;
  final bool reverseCharge;
  final String status;
  final TransactionSummary? transactionSummary;
  final List<AdditionalCharge> additionalCharges;
  final PaymentTermsId? paymentTermsId;
  final String taxType;
  final ShippingDetails? shippingDetails;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? sez;
  final String? paymentTerms;
  final String? notes;

  EstimateDatum({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.estimateNo,
    required this.date,
    required this.dueDate,
    this.placeOfSupply,
    this.billingAddress,
    this.shippingAddress,
    required this.customerId,
    required this.items,
    required this.termsAndConditionIds,
    required this.reverseCharge,
    required this.status,
    this.transactionSummary,
    required this.additionalCharges,
    this.paymentTermsId,
    required this.taxType,
    this.shippingDetails,
    required this.createdAt,
    required this.updatedAt,
    this.sez,
    this.paymentTerms,
    this.notes,
  });

  factory EstimateDatum.fromRawJson(String str) =>
      EstimateDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EstimateDatum.fromJson(Map<String, dynamic> json) => EstimateDatum(
        id: json["_id"] ?? "",
        isDeleted: json["isDeleted"] ?? false,
        isActive: json["isActive"] ?? true,
        createdBy: json["createdBy"] == null
            ? CreatedBy(id: "", fullName: "", userType: "admin")
            : CreatedBy.fromJson(json["createdBy"]),
        updatedBy: json["updatedBy"] ?? "",
        companyId: json["companyId"] == null
            ? CompanyId(id: "", name: "")
            : CompanyId.fromJson(json["companyId"]),
        estimateNo: json["estimateNo"] ?? "",
        date:
            json["date"] == null ? DateTime.now() : DateTime.parse(json["date"]),
        dueDate: json["dueDate"] == null
            ? DateTime.now()
            : DateTime.parse(json["dueDate"]),
        placeOfSupply: json["placeOfSupply"],
        billingAddress: json["billingAddress"] == null
            ? null
            : Address.fromJson(json["billingAddress"]),
        shippingAddress: json["shippingAddress"] == null
            ? null
            : Address.fromJson(json["shippingAddress"]),
        customerId: json["customerId"] == null
            ? CustomerId(
                id: "",
                firstName: "",
                lastName: "",
                email: "",
                phoneNo: PhoneNo(countryCode: "91", phoneNo: 0),
                address: [])
            : CustomerId.fromJson(json["customerId"]),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        termsAndConditionIds: json["termsAndConditionIds"] == null
            ? []
            : List<TermsAndConditionId>.from(
                json["termsAndConditionIds"]
                    .map((x) => TermsAndConditionId.fromJson(x)),
              ),
        reverseCharge: json["reverseCharge"] ?? false,
        status: json["status"] ?? "pending",
        transactionSummary: json["transactionSummary"] == null
            ? (json["transectionSummary"] == null
                ? null
                : TransactionSummary.fromJson(json["transectionSummary"]))
            : TransactionSummary.fromJson(json["transactionSummary"]),
        additionalCharges: json["additionalCharges"] == null
            ? []
            : List<AdditionalCharge>.from(
                json["additionalCharges"]
                    .map((x) => AdditionalCharge.fromJson(x)),
              ),
        paymentTermsId: json["paymentTermsId"] == null
            ? null
            : PaymentTermsId.fromJson(json["paymentTermsId"]),
        taxType: json["taxType"] ?? "default",
        shippingDetails: json["shippingDetails"] == null
            ? null
            : ShippingDetails.fromJson(json["shippingDetails"]),
        createdAt: json["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["updatedAt"]),
        sez: json["sez"],
        paymentTerms: json["paymentTerms"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy.toJson(),
        "updatedBy": updatedBy,
        "companyId": companyId.toJson(),
        "estimateNo": estimateNo,
        "date": date.toIso8601String(),
        "dueDate": dueDate.toIso8601String(),
        "placeOfSupply": placeOfSupply,
        "billingAddress": billingAddress?.toJson(),
        "shippingAddress": shippingAddress?.toJson(),
        "customerId": customerId.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "termsAndConditionIds": List<dynamic>.from(
          termsAndConditionIds.map((x) => x.toJson()),
        ),
        "reverseCharge": reverseCharge,
        "status": status,
        "transactionSummary": transactionSummary?.toJson(),
        "additionalCharges":
            List<dynamic>.from(additionalCharges.map((x) => x.toJson())),
        "paymentTermsId": paymentTermsId?.toJson(),
        "taxType": taxType,
        "shippingDetails": shippingDetails?.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "sez": sez,
        "paymentTerms": paymentTerms,
        "notes": notes,
      };
}

class AdditionalCharge {
  final String chargeId;
  final String taxId;
  final double amount;
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
        chargeId: json["chargeId"] is Map ? json["chargeId"]["_id"] : (json["chargeId"] ?? ""),
        taxId: json["taxId"] is Map ? json["taxId"]["_id"] : (json["taxId"] ?? ""),
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
  final CompanyId country;
  final CompanyId state;
  final CompanyId city;
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
            ? CompanyId(id: "", name: "")
            : CompanyId.fromJson(json["country"]),
        state: json["state"] == null
            ? CompanyId(id: "", name: "")
            : CompanyId.fromJson(json["state"]),
        city: json["city"] == null
            ? CompanyId(id: "", name: "")
            : CompanyId.fromJson(json["city"]),
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

class CompanyId {
  final String id;
  final String name;

  CompanyId({required this.id, required this.name});

  factory CompanyId.fromRawJson(String str) =>
      CompanyId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyId.fromJson(Map<String, dynamic> json) => CompanyId(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
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

class Item {
  final CompanyId productId;
  final double qty;
  final double freeQty;
  final CompanyId uomId;
  final String? unit;
  final double price;
  final double discount1;
  final double discount2;
  final TaxId taxId;
  final double? tax;
  final double taxableAmount;
  final double totalAmount;

  Item({
    required this.productId,
    required this.qty,
    required this.freeQty,
    required this.uomId,
    this.unit,
    required this.price,
    required this.discount1,
    required this.discount2,
    required this.taxId,
    this.tax,
    required this.taxableAmount,
    required this.totalAmount,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: json["productId"] == null
            ? CompanyId(id: "", name: "")
            : CompanyId.fromJson(json["productId"]),
        qty: (json["qty"] ?? 0).toDouble(),
        freeQty: (json["freeQty"] ?? 0).toDouble(),
        uomId: json["uomId"] == null
            ? CompanyId(id: "", name: "")
            : CompanyId.fromJson(json["uomId"]),
        unit: json["unit"],
        price: (json["price"] ?? 0).toDouble(),
        discount1: (json["discount1"] ?? 0).toDouble(),
        discount2: (json["discount2"] ?? 0).toDouble(),
        taxId: json["taxId"] == null
            ? TaxId(id: "", name: "", percentage: 0)
            : TaxId.fromJson(json["taxId"]),
        tax: json["tax"]?.toDouble(),
        taxableAmount: (json["taxableAmount"] ?? 0).toDouble(),
        totalAmount: (json["totalAmount"] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId.toJson(),
        "qty": qty,
        "freeQty": freeQty,
        "uomId": uomId.toJson(),
        "unit": unit,
        "price": price,
        "discount1": discount1,
        "discount2": discount2,
        "taxId": taxId.toJson(),
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

  factory TaxId.fromRawJson(String str) => TaxId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  factory PaymentTermsId.fromRawJson(String str) =>
      PaymentTermsId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  factory ShippingDetails.fromRawJson(String str) =>
      ShippingDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingDetails.fromJson(Map<String, dynamic> json) =>
      ShippingDetails(
        shippingType: json["shippingType"] ?? "delivery",
        weight: (json["weight"] ?? 0).toDouble(),
        id: json["_id"] ?? "",
        shippingDate: json["shippingDate"] == null
            ? null
            : DateTime.parse(json["shippingDate"]),
        referenceNo: json["referenceNo"],
        transportDate: json["transportDate"] == null
            ? null
            : DateTime.parse(json["transportDate"]),
        modeOfTransport: json["modeOfTransport"],
        transporterId: json["transporterId"],
        vehicleNo: json["vehicleNo"],
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

  factory TermsAndConditionId.fromRawJson(String str) =>
      TermsAndConditionId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsAndConditionId.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionId(
        id: json["_id"] ?? "",
        termsCondition: json["termsCondition"] ?? "",
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

class Summary {
  final int allEstimates;
  final int pending;
  final int orderCreated;
  final int invoiceCreated;

  Summary({
    required this.allEstimates,
    required this.pending,
    required this.orderCreated,
    required this.invoiceCreated,
  });

  factory Summary.fromRawJson(String str) => Summary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        allEstimates: json["allEstimates"] ?? 0,
        pending: json["pending"] ?? 0,
        orderCreated: json["orderCreated"] ?? 0,
        invoiceCreated: json["invoiceCreated"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "allEstimates": allEstimates,
        "pending": pending,
        "orderCreated": orderCreated,
        "invoiceCreated": invoiceCreated,
      };
}
