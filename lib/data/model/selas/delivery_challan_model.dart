import 'dart:convert';

class DeliveryChallanMode {
  final List<DeliveryChallanDatum> deliveryChallanData;
  final int totalData;
  final Summary summary;
  final State state;

  DeliveryChallanMode({
    required this.deliveryChallanData,
    required this.totalData,
    required this.summary,
    required this.state,
  });

  factory DeliveryChallanMode.fromRawJson(String str) =>
      DeliveryChallanMode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveryChallanMode.fromJson(Map<String, dynamic> json) =>
      DeliveryChallanMode(
        deliveryChallanData: List<DeliveryChallanDatum>.from(
          json["deliveryChallan_data"].map(
            (x) => DeliveryChallanDatum.fromJson(x),
          ),
        ),
        totalData: json["totalData"],
        summary: Summary.fromJson(json["summary"]),
        state: State.fromJson(json["state"]),
      );

  Map<String, dynamic> toJson() => {
    "deliveryChallan_data": List<dynamic>.from(
      deliveryChallanData.map((x) => x.toJson()),
    ),
    "totalData": totalData,
    "summary": summary.toJson(),
    "state": state.toJson(),
  };
}

class DeliveryChallanDatum {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final UpdatedBy updatedBy;
  final BranchId companyId;
  final String deliveryChallanNo;
  final DateTime date;
  final CustomerId customerId;
  final PlaceOfSupply placeOfSupply;
  final Address billingAddress;
  final Address shippingAddress;
  final List<InvoiceId> invoiceIds;
  final List<SalesOrderId> salesOrderIds;
  final PaymentTermsId? paymentTermsId;
  final DateTime dueDate;
  final TaxType taxType;
  final ShippingDetails shippingDetails;
  final List<Item> items;
  final TransactionSummary transactionSummary;
  final List<AdditionalCharge> additionalCharges;
  final bool reverseCharge;
  final Status status;
  final List<String> termsAndConditionIds;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BranchId branchId;
  final String? createdFrom;
  final String? paymentTerms;
  final String? notes;

  DeliveryChallanDatum({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.deliveryChallanNo,
    required this.date,
    required this.customerId,
    required this.placeOfSupply,
    required this.billingAddress,
    required this.shippingAddress,
    required this.invoiceIds,
    required this.salesOrderIds,
    this.paymentTermsId,
    required this.dueDate,
    required this.taxType,
    required this.shippingDetails,
    required this.items,
    required this.transactionSummary,
    required this.additionalCharges,
    required this.reverseCharge,
    required this.status,
    required this.termsAndConditionIds,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
    this.createdFrom,
    this.paymentTerms,
    this.notes,
  });

  factory DeliveryChallanDatum.fromRawJson(String str) =>
      DeliveryChallanDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveryChallanDatum.fromJson(Map<String, dynamic> json) =>
      DeliveryChallanDatum(
        id: json["_id"],
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        updatedBy: updatedByValues.map[json["updatedBy"]] ?? UpdatedBy.THE_694_D017_B7_CB4009_F97_A30854,
        companyId: BranchId.fromJson(json["companyId"]),
        deliveryChallanNo: json["deliveryChallanNo"],
        date: DateTime.parse(json["date"]),
        customerId: CustomerId.fromJson(json["customerId"]),
        placeOfSupply: placeOfSupplyValues.map[json["placeOfSupply"]] ?? PlaceOfSupply.GUJARAT,
        billingAddress: Address.fromJson(json["billingAddress"]),
        shippingAddress: Address.fromJson(json["shippingAddress"]),
        invoiceIds: List<InvoiceId>.from(
          json["invoiceIds"].map((x) => InvoiceId.fromJson(x)),
        ),
        salesOrderIds: List<SalesOrderId>.from(
          json["salesOrderIds"].map((x) => SalesOrderId.fromJson(x)),
        ),
        paymentTermsId: json["paymentTermsId"] == null
            ? null
            : PaymentTermsId.fromJson(json["paymentTermsId"]),
        dueDate: DateTime.parse(json["dueDate"]),
        taxType: taxTypeValues.map[json["taxType"]] ?? TaxType.DEFAULT,
        shippingDetails: ShippingDetails.fromJson(json["shippingDetails"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        transactionSummary: TransactionSummary.fromJson(
          json["transactionSummary"],
        ),
        additionalCharges: List<AdditionalCharge>.from(
          json["additionalCharges"].map((x) => AdditionalCharge.fromJson(x)),
        ),
        reverseCharge: json["reverseCharge"],
        status: statusValues.map[json["status"]] ?? Status.DELIVERED,
        termsAndConditionIds: List<String>.from(
          json["termsAndConditionIds"].map((x) => x),
        ),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        branchId: BranchId.fromJson(json["branchId"]),
        createdFrom: json["createdFrom"],
        paymentTerms: json["paymentTerms"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedByValues.reverse[updatedBy],
    "companyId": companyId.toJson(),
    "deliveryChallanNo": deliveryChallanNo,
    "date": date.toIso8601String(),
    "customerId": customerId.toJson(),
    "placeOfSupply": placeOfSupplyValues.reverse[placeOfSupply],
    "billingAddress": billingAddress.toJson(),
    "shippingAddress": shippingAddress.toJson(),
    "invoiceIds": List<dynamic>.from(invoiceIds.map((x) => x.toJson())),
    "salesOrderIds": List<dynamic>.from(salesOrderIds.map((x) => x.toJson())),
    "paymentTermsId": paymentTermsId?.toJson(),
    "dueDate": dueDate.toIso8601String(),
    "taxType": taxTypeValues.reverse[taxType],
    "shippingDetails": shippingDetails.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "transactionSummary": transactionSummary.toJson(),
    "additionalCharges": List<dynamic>.from(
      additionalCharges.map((x) => x.toJson()),
    ),
    "reverseCharge": reverseCharge,
    "status": statusValues.reverse[status],
    "termsAndConditionIds": List<dynamic>.from(
      termsAndConditionIds.map((x) => x),
    ),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "branchId": branchId.toJson(),
    "createdFrom": createdFrom,
    "paymentTerms": paymentTerms,
    "notes": notes,
  };
}

class AdditionalCharge {
  final String chargeId;
  final String taxId;
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
  final String? addressLine2;
  final BranchId country;
  final BranchId state;
  final BranchId city;
  final int pinCode;
  final BillingAddressId id;

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
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    country: BranchId.fromJson(json["country"]),
    state: BranchId.fromJson(json["state"]),
    city: BranchId.fromJson(json["city"]),
    pinCode: json["pinCode"],
    id: billingAddressIdValues.map[json["_id"]] ?? BillingAddressId.THE_699828_F0675_F1_C7_B8_DDF7212,
  );

  Map<String, dynamic> toJson() => {
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "country": country.toJson(),
    "state": state.toJson(),
    "city": city.toJson(),
    "pinCode": pinCode,
    "_id": billingAddressIdValues.reverse[id],
  };
}

class BranchId {
  final String id;
  final String name;

  BranchId({required this.id, required this.name});

  factory BranchId.fromRawJson(String str) =>
      BranchId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BranchId.fromJson(Map<String, dynamic> json) =>
      BranchId(id: json["_id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

enum BillingAddressId {
  THE_698980209_B8_C1_E41_C7226_EFF,
  THE_699828_F0675_F1_C7_B8_DDF7212,
  THE_69_B24_F85918_A03_C4936_A0_DC5,
  THE_69_B24_F85918_A03_C4936_A0_DC6,
}

final billingAddressIdValues = EnumValues({
  "698980209b8c1e41c7226eff":
      BillingAddressId.THE_698980209_B8_C1_E41_C7226_EFF,
  "699828f0675f1c7b8ddf7212":
      BillingAddressId.THE_699828_F0675_F1_C7_B8_DDF7212,
  "69b24f85918a03c4936a0dc5":
      BillingAddressId.THE_69_B24_F85918_A03_C4936_A0_DC5,
  "69b24f85918a03c4936a0dc6":
      BillingAddressId.THE_69_B24_F85918_A03_C4936_A0_DC6,
});

class CreatedBy {
  final UpdatedBy id;
  final FullName fullName;
  final UserType userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromRawJson(String str) =>
      CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: updatedByValues.map[json["_id"]] ?? UpdatedBy.THE_694_D017_B7_CB4009_F97_A30854,
    fullName: fullNameValues.map[json["fullName"]] ?? FullName.HARSHITHKDIGIVERSE,
    userType: userTypeValues.map[json["userType"]] ?? UserType.ADMIN,
  );

  Map<String, dynamic> toJson() => {
    "_id": updatedByValues.reverse[id],
    "fullName": fullNameValues.reverse[fullName],
    "userType": userTypeValues.reverse[userType],
  };
}

enum FullName { HARSHITHKDIGIVERSE, KRISH_GEDIYA, SHAKIL_GAHA }

final fullNameValues = EnumValues({
  "harshithkdigiverse": FullName.HARSHITHKDIGIVERSE,
  "Krish Gediya": FullName.KRISH_GEDIYA,
  "Shakil Gaha": FullName.SHAKIL_GAHA,
});

enum UpdatedBy {
  THE_694_D017_B7_CB4009_F97_A30854,
  THE_699_BECB3_E36_A172238520458,
  THE_699_C40239_F9_E8_A56822_E8929,
}

final updatedByValues = EnumValues({
  "694d017b7cb4009f97a30854": UpdatedBy.THE_694_D017_B7_CB4009_F97_A30854,
  "699becb3e36a172238520458": UpdatedBy.THE_699_BECB3_E36_A172238520458,
  "699c40239f9e8a56822e8929": UpdatedBy.THE_699_C40239_F9_E8_A56822_E8929,
});

enum UserType { ADMIN, SUPER_ADMIN }

final userTypeValues = EnumValues({
  "admin": UserType.ADMIN,
  "super-admin": UserType.SUPER_ADMIN,
});

class CustomerId {
  final CustomerIdId id;
  final FirstName firstName;
  final LastName lastName;
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
    id: customerIdIdValues.map[json["_id"]] ?? CustomerIdId.THE_699828_F0675_F1_C7_B8_DDF7211,
    firstName: firstNameValues.map[json["firstName"]] ?? FirstName.KRISH,
    lastName: lastNameValues.map[json["lastName"]] ?? LastName.RADADIYA,
    email: json["email"],
    phoneNo: PhoneNo.fromJson(json["phoneNo"]),
    address: List<Address>.from(
      json["address"].map((x) => Address.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "_id": customerIdIdValues.reverse[id],
    "firstName": firstNameValues.reverse[firstName],
    "lastName": lastNameValues.reverse[lastName],
    "email": email,
    "phoneNo": phoneNo.toJson(),
    "address": List<dynamic>.from(address.map((x) => x.toJson())),
  };
}

enum FirstName { BUNTYLAL, JEEL, KRISH }

final firstNameValues = EnumValues({
  "Buntylal": FirstName.BUNTYLAL,
  "Jeel ": FirstName.JEEL,
  "Krish ": FirstName.KRISH,
});

enum CustomerIdId {
  THE_69897_CE48_FC4_AAE4_B354_E5_E5,
  THE_699806_A0675_F1_C7_B8_DDF709_E,
  THE_699828_F0675_F1_C7_B8_DDF7211,
}

final customerIdIdValues = EnumValues({
  "69897ce48fc4aae4b354e5e5": CustomerIdId.THE_69897_CE48_FC4_AAE4_B354_E5_E5,
  "699806a0675f1c7b8ddf709e": CustomerIdId.THE_699806_A0675_F1_C7_B8_DDF709_E,
  "699828f0675f1c7b8ddf7211": CustomerIdId.THE_699828_F0675_F1_C7_B8_DDF7211,
});

enum LastName { BORAD, OVER_SMART, RADADIYA }

final lastNameValues = EnumValues({
  "Borad": LastName.BORAD,
  "OverSmart": LastName.OVER_SMART,
  "Radadiya": LastName.RADADIYA,
});

class PhoneNo {
  final String countryCode;
  final int phoneNo;

  PhoneNo({required this.countryCode, required this.phoneNo});

  factory PhoneNo.fromRawJson(String str) => PhoneNo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhoneNo.fromJson(Map<String, dynamic> json) =>
      PhoneNo(countryCode: json["countryCode"], phoneNo: json["phoneNo"]);

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "phoneNo": phoneNo,
  };
}

class InvoiceId {
  final String id;
  final String invoiceNo;

  InvoiceId({required this.id, required this.invoiceNo});

  factory InvoiceId.fromRawJson(String str) =>
      InvoiceId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceId.fromJson(Map<String, dynamic> json) =>
      InvoiceId(id: json["_id"], invoiceNo: json["invoiceNo"]);

  Map<String, dynamic> toJson() => {"_id": id, "invoiceNo": invoiceNo};
}

class Item {
  final BranchId productId;
  final int qty;
  final int freeQty;
  final UomId uomId;
  final Unit unit;
  final int price;
  final int discount1;
  final int discount2;
  final TaxId taxId;
  final double tax;
  final int taxableAmount;
  final double totalAmount;

  Item({
    required this.productId,
    required this.qty,
    required this.freeQty,
    required this.uomId,
    required this.unit,
    required this.price,
    required this.discount1,
    required this.discount2,
    required this.taxId,
    required this.tax,
    required this.taxableAmount,
    required this.totalAmount,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    productId: BranchId.fromJson(json["productId"]),
    qty: json["qty"],
    freeQty: json["freeQty"],
    uomId: uomIdValues.map[json["uomId"]] ?? UomId.THE_69982_A4_D9_F5643_C708711_E61,
    unit: unitValues.map[json["unit"]] ?? Unit.PIECES,
    price: json["price"],
    discount1: json["discount1"],
    discount2: json["discount2"],
    taxId: TaxId.fromJson(json["taxId"]),
    tax: json["tax"]?.toDouble(),
    taxableAmount: json["taxableAmount"],
    totalAmount: json["totalAmount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId.toJson(),
    "qty": qty,
    "freeQty": freeQty,
    "uomId": uomIdValues.reverse[uomId],
    "unit": unitValues.reverse[unit],
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
  final int percentage;

  TaxId({required this.id, required this.name, required this.percentage});

  factory TaxId.fromRawJson(String str) => TaxId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxId.fromJson(Map<String, dynamic> json) => TaxId(
    id: json["_id"],
    name: json["name"],
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "percentage": percentage,
  };
}

enum Unit { KG, PIECES, UNIT_KG }

final unitValues = EnumValues({
  "kg": Unit.KG,
  "PIECES": Unit.PIECES,
  "KG": Unit.UNIT_KG,
});

enum UomId {
  THE_697_C761_BBCA4_EB2_E71_D246_F6,
  THE_69982_A4_D9_F5643_C708711_E61,
}

final uomIdValues = EnumValues({
  "697c761bbca4eb2e71d246f6": UomId.THE_697_C761_BBCA4_EB2_E71_D246_F6,
  "69982a4d9f5643c708711e61": UomId.THE_69982_A4_D9_F5643_C708711_E61,
});

class PaymentTermsId {
  final String id;
  final String name;
  final int day;

  PaymentTermsId({required this.id, required this.name, required this.day});

  factory PaymentTermsId.fromRawJson(String str) =>
      PaymentTermsId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentTermsId.fromJson(Map<String, dynamic> json) =>
      PaymentTermsId(id: json["_id"], name: json["name"], day: json["day"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "day": day};
}

enum PlaceOfSupply { GOA, GUJARAT }

final placeOfSupplyValues = EnumValues({
  "Goa": PlaceOfSupply.GOA,
  "Gujarat": PlaceOfSupply.GUJARAT,
});

class SalesOrderId {
  final String id;
  final String salesOrderNo;

  SalesOrderId({required this.id, required this.salesOrderNo});

  factory SalesOrderId.fromRawJson(String str) =>
      SalesOrderId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesOrderId.fromJson(Map<String, dynamic> json) =>
      SalesOrderId(id: json["_id"], salesOrderNo: json["salesOrderNo"]);

  Map<String, dynamic> toJson() => {"_id": id, "salesOrderNo": salesOrderNo};
}

class ShippingDetails {
  final ShippingType shippingType;
  final int weight;
  final String id;
  final DateTime? shippingDate;
  final String? referenceNo;
  final DateTime? transportDate;
  final String? modeOfTransport;
  final String? vehicleNo;
  final String? transporterId;

  ShippingDetails({
    required this.shippingType,
    required this.weight,
    required this.id,
    this.shippingDate,
    this.referenceNo,
    this.transportDate,
    this.modeOfTransport,
    this.vehicleNo,
    this.transporterId,
  });

  factory ShippingDetails.fromRawJson(String str) =>
      ShippingDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingDetails.fromJson(Map<String, dynamic> json) =>
      ShippingDetails(
        shippingType: shippingTypeValues.map[json["shippingType"]] ?? ShippingType.DELIVERY,
        weight: json["weight"],
        id: json["_id"],
        shippingDate: json["shippingDate"] == null
            ? null
            : DateTime.parse(json["shippingDate"]),
        referenceNo: json["referenceNo"],
        transportDate: json["transportDate"] == null
            ? null
            : DateTime.parse(json["transportDate"]),
        modeOfTransport: json["modeOfTransport"],
        vehicleNo: json["vehicleNo"],
        transporterId: json["transporterId"],
      );

  Map<String, dynamic> toJson() => {
    "shippingType": shippingTypeValues.reverse[shippingType],
    "weight": weight,
    "_id": id,
    "shippingDate": shippingDate?.toIso8601String(),
    "referenceNo": referenceNo,
    "transportDate": transportDate?.toIso8601String(),
    "modeOfTransport": modeOfTransport,
    "vehicleNo": vehicleNo,
    "transporterId": transporterId,
  };
}

enum ShippingType { DELIVERY }

final shippingTypeValues = EnumValues({"delivery": ShippingType.DELIVERY});

enum Status { DELIVERED }

final statusValues = EnumValues({"delivered": Status.DELIVERED});

enum TaxType { DEFAULT, TAX_EXCLUSIVE, TAX_INCLUSIVE }

final taxTypeValues = EnumValues({
  "default": TaxType.DEFAULT,
  "tax_exclusive": TaxType.TAX_EXCLUSIVE,
  "tax_inclusive": TaxType.TAX_INCLUSIVE,
});

class TransactionSummary {
  final int flatDiscount;
  final int grossAmount;
  final int discountAmount;
  final int taxableAmount;
  final double taxAmount;
  final int roundOff;
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
        flatDiscount: json["flatDiscount"],
        grossAmount: json["grossAmount"],
        discountAmount: json["discountAmount"],
        taxableAmount: json["taxableAmount"],
        taxAmount: json["taxAmount"]?.toDouble(),
        roundOff: json["roundOff"],
        netAmount: json["netAmount"]?.toDouble(),
        id: json["_id"],
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
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
  };
}

class Summary {
  final int allDeliveryChallans;
  final int invoiceCreated;
  final int delivered;
  final int cancelled;

  Summary({
    required this.allDeliveryChallans,
    required this.invoiceCreated,
    required this.delivered,
    required this.cancelled,
  });

  factory Summary.fromRawJson(String str) => Summary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    allDeliveryChallans: json["allDeliveryChallans"],
    invoiceCreated: json["invoiceCreated"],
    delivered: json["delivered"],
    cancelled: json["cancelled"],
  );

  Map<String, dynamic> toJson() => {
    "allDeliveryChallans": allDeliveryChallans,
    "invoiceCreated": invoiceCreated,
    "delivered": delivered,
    "cancelled": cancelled,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
