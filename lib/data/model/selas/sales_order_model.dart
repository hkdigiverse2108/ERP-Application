import 'dart:convert';

class SalesOrderModel {
  final List<SalesOrderDatum> salesOrderData;
  final int totalData;
  final Summary summary;
  final State state;

  SalesOrderModel({
    required this.salesOrderData,
    required this.totalData,
    required this.summary,
    required this.state,
  });

  factory SalesOrderModel.fromRawJson(String str) =>
      SalesOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesOrderModel.fromJson(Map<String, dynamic> json) =>
      SalesOrderModel(
        salesOrderData: json["salesOrder_data"] == null
            ? []
            : List<SalesOrderDatum>.from(
                json["salesOrder_data"].map((x) => SalesOrderDatum.fromJson(x)),
              ),
        totalData: json["totalData"] ?? 0,
        summary: json["summary"] == null
            ? Summary(
                allSalesOrders: 0,
                pending: 0,
                invoiceCreated: 0,
                deliveryChallanCreated: 0,
                cancelled: 0,
              )
            : Summary.fromJson(json["summary"]),
        state: json["state"] == null
            ? State(page: 1, limit: 10, totalPages: 1)
            : State.fromJson(json["state"]),
      );

  Map<String, dynamic> toJson() => {
    "salesOrder_data": List<dynamic>.from(
      salesOrderData.map((x) => x.toJson()),
    ),
    "totalData": totalData,
    "summary": summary.toJson(),
    "state": state.toJson(),
  };
}

class SalesOrderDatum {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final BranchId companyId;
  final String salesOrderNo;
  final DateTime date;
  final DateTime dueDate;
  final CustomerId customerId;
  final String placeOfSupply;
  final Address billingAddress;
  final Address shippingAddress;
  final String taxType;
  final SelectedEstimateId selectedEstimateId;
  final List<Item> items;
  final TransactionSummary transactionSummary;
  final List<AdditionalCharge> additionalCharges;
  final List<TermsAndConditionIdElement> termsAndConditionIds;
  final String status;
  final ShippingDetails shippingDetails;
  final bool reverseCharge;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BranchId branchId;
  final String? paymentTerms;
  final String? salesManId;
  final String? notes;

  SalesOrderDatum({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.salesOrderNo,
    required this.date,
    required this.dueDate,
    required this.customerId,
    required this.placeOfSupply,
    required this.billingAddress,
    required this.shippingAddress,
    required this.taxType,
    required this.selectedEstimateId,
    required this.items,
    required this.transactionSummary,
    required this.additionalCharges,
    required this.termsAndConditionIds,
    required this.status,
    required this.shippingDetails,
    required this.reverseCharge,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
    this.paymentTerms,
    this.salesManId,
    this.notes,
  });

  factory SalesOrderDatum.fromRawJson(String str) =>
      SalesOrderDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesOrderDatum.fromJson(
    Map<String, dynamic> json,
  ) => SalesOrderDatum(
    id: json["_id"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    createdBy: CreatedBy.fromJson(json["createdBy"]),
    updatedBy: json["updatedBy"],
    companyId: BranchId.fromJson(json["companyId"]),
    salesOrderNo: json["salesOrderNo"],
    date: DateTime.parse(json["date"]),
    dueDate: DateTime.parse(json["dueDate"]),
    customerId: CustomerId.fromJson(json["customerId"]),
    placeOfSupply: json["placeOfSupply"],
    billingAddress: Address.fromJson(json["billingAddress"]),
    shippingAddress: Address.fromJson(json["shippingAddress"]),
    taxType: json["taxType"],
    selectedEstimateId: SelectedEstimateId.fromJson(json["selectedEstimateId"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    transactionSummary: TransactionSummary.fromJson(json["transactionSummary"]),
    additionalCharges: List<AdditionalCharge>.from(
      json["additionalCharges"].map((x) => AdditionalCharge.fromJson(x)),
    ),
    termsAndConditionIds: List<TermsAndConditionIdElement>.from(
      json["termsAndConditionIds"].map(
        (x) => TermsAndConditionIdElement.fromJson(x),
      ),
    ),
    status: json["status"],
    shippingDetails: ShippingDetails.fromJson(json["shippingDetails"]),
    reverseCharge: json["reverseCharge"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    branchId: BranchId.fromJson(json["branchId"]),
    paymentTerms: json["paymentTerms"],
    salesManId: json["salesManId"],
    notes: json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "salesOrderNo": salesOrderNo,
    "date": date.toIso8601String(),
    "dueDate": dueDate.toIso8601String(),
    "customerId": customerId.toJson(),
    "placeOfSupply": placeOfSupply,
    "billingAddress": billingAddress.toJson(),
    "shippingAddress": shippingAddress.toJson(),
    "taxType": taxType,
    "selectedEstimateId": selectedEstimateId.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "transactionSummary": transactionSummary.toJson(),
    "additionalCharges": List<dynamic>.from(
      additionalCharges.map((x) => x.toJson()),
    ),
    "termsAndConditionIds": List<dynamic>.from(
      termsAndConditionIds.map((x) => x.toJson()),
    ),
    "status": status,
    "shippingDetails": shippingDetails.toJson(),
    "reverseCharge": reverseCharge,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "branchId": branchId.toJson(),
    "paymentTerms": paymentTerms,
    "salesManId": salesManId,
    "notes": notes,
  };
}

class AdditionalCharge {
  final BranchId chargeId;
  final TaxId taxId;
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
        chargeId: BranchId.fromJson(json["chargeId"]),
        taxId: TaxId.fromJson(json["taxId"]),
        amount: json["amount"],
        totalAmount: json["totalAmount"]?.toDouble(),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
    "chargeId": chargeId.toJson(),
    "taxId": taxId.toJson(),
    "amount": amount,
    "totalAmount": totalAmount,
    "_id": id,
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

class TaxId {
  final TaxIdId id;
  final Name name;
  final int percentage;

  TaxId({required this.id, required this.name, required this.percentage});

  factory TaxId.fromRawJson(String str) => TaxId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxId.fromJson(Map<String, dynamic> json) => TaxId(
    id: taxIdIdValues.map[json["_id"]] ?? TaxIdId.THE_6964_B7_F820_D84261_D82_FB8_FA,
    name: nameValues.map[json["name"]] ?? Name.GST_18,
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": taxIdIdValues.reverse[id],
    "name": nameValues.reverse[name],
    "percentage": percentage,
  };
}

enum TaxIdId {
  THE_6964_B7_F820_D84261_D82_FB8_FA,
  THE_6964_B8176_BFCE325_EDE7_F9_E3,
  THE_6981_E7_A321_D8_B862_C136_B5_F0,
}

final taxIdIdValues = EnumValues({
  "6964b7f820d84261d82fb8fa": TaxIdId.THE_6964_B7_F820_D84261_D82_FB8_FA,
  "6964b8176bfce325ede7f9e3": TaxIdId.THE_6964_B8176_BFCE325_EDE7_F9_E3,
  "6981e7a321d8b862c136b5f0": TaxIdId.THE_6981_E7_A321_D8_B862_C136_B5_F0,
});

enum Name { GST_0, GST_18, GST_28 }

final nameValues = EnumValues({
  "GST 0": Name.GST_0,
  "GST 18": Name.GST_18,
  "GST 28": Name.GST_28,
});

class Address {
  final AddressLine1 addressLine1;
  final BranchId country;
  final BranchId state;
  final BranchId city;
  final int pinCode;
  final BillingAddressId id;
  final String? addressLine2;

  Address({
    required this.addressLine1,
    required this.country,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.id,
    this.addressLine2,
  });

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    addressLine1: addressLine1Values.map[json["addressLine1"]] ?? AddressLine1.AR_MALL,
    country: BranchId.fromJson(json["country"]),
    state: BranchId.fromJson(json["state"]),
    city: BranchId.fromJson(json["city"]),
    pinCode: json["pinCode"],
    id: billingAddressIdValues.map[json["_id"]] ?? BillingAddressId.THE_699828_F0675_F1_C7_B8_DDF7212,
    addressLine2: json["addressLine2"],
  );

  Map<String, dynamic> toJson() => {
    "addressLine1": addressLine1Values.reverse[addressLine1],
    "country": country.toJson(),
    "state": state.toJson(),
    "city": city.toJson(),
    "pinCode": pinCode,
    "_id": billingAddressIdValues.reverse[id],
    "addressLine2": addressLine2,
  };
}

enum AddressLine1 { AR_MALL, SILVER_TRADE_CENTER }

final addressLine1Values = EnumValues({
  "AR Mall": AddressLine1.AR_MALL,
  "Silver Trade Center": AddressLine1.SILVER_TRADE_CENTER,
});

enum BillingAddressId {
  THE_699828_F0675_F1_C7_B8_DDF7212,
  THE_69_B24_F85918_A03_C4936_A0_DC5,
  THE_69_B24_F85918_A03_C4936_A0_DC6,
}

final billingAddressIdValues = EnumValues({
  "699828f0675f1c7b8ddf7212":
      BillingAddressId.THE_699828_F0675_F1_C7_B8_DDF7212,
  "69b24f85918a03c4936a0dc5":
      BillingAddressId.THE_69_B24_F85918_A03_C4936_A0_DC5,
  "69b24f85918a03c4936a0dc6":
      BillingAddressId.THE_69_B24_F85918_A03_C4936_A0_DC6,
});

class CreatedBy {
  final String id;
  final String fullName;
  final String userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromRawJson(String str) =>
      CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["_id"],
    fullName: json["fullName"],
    userType: json["userType"],
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
  final String email;
  final PhoneNo phoneNo;
  final List<Address> address;

  CustomerId({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.address,
  });

  factory CustomerId.fromRawJson(String str) =>
      CustomerId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phoneNo: PhoneNo.fromJson(json["phoneNo"]),
    address: List<Address>.from(
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

  factory PhoneNo.fromJson(Map<String, dynamic> json) =>
      PhoneNo(countryCode: json["countryCode"], phoneNo: json["phoneNo"]);

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "phoneNo": phoneNo,
  };
}

class Item {
  final String? refId;
  final BranchId productId;
  final int qty;
  final int freeQty;
  final BranchId uomId;
  final int price;
  final int discount1;
  final int discount2;
  final TaxId taxId;
  final int taxableAmount;
  final int totalAmount;
  final String id;

  Item({
    this.refId,
    required this.productId,
    required this.qty,
    required this.freeQty,
    required this.uomId,
    required this.price,
    required this.discount1,
    required this.discount2,
    required this.taxId,
    required this.taxableAmount,
    required this.totalAmount,
    required this.id,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    refId: json["refId"],
    productId: BranchId.fromJson(json["productId"]),
    qty: json["qty"],
    freeQty: json["freeQty"],
    uomId: BranchId.fromJson(json["uomId"]),
    price: json["price"],
    discount1: json["discount1"],
    discount2: json["discount2"],
    taxId: TaxId.fromJson(json["taxId"]),
    taxableAmount: json["taxableAmount"],
    totalAmount: json["totalAmount"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "refId": refId,
    "productId": productId.toJson(),
    "qty": qty,
    "freeQty": freeQty,
    "uomId": uomId.toJson(),
    "price": price,
    "discount1": discount1,
    "discount2": discount2,
    "taxId": taxId.toJson(),
    "taxableAmount": taxableAmount,
    "totalAmount": totalAmount,
    "_id": id,
  };
}

class SelectedEstimateId {
  final String id;
  final String estimateNo;

  SelectedEstimateId({required this.id, required this.estimateNo});

  factory SelectedEstimateId.fromRawJson(String str) =>
      SelectedEstimateId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SelectedEstimateId.fromJson(Map<String, dynamic> json) =>
      SelectedEstimateId(id: json["_id"], estimateNo: json["estimateNo"]);

  Map<String, dynamic> toJson() => {"_id": id, "estimateNo": estimateNo};
}

class ShippingDetails {
  final String shippingType;
  final DateTime? shippingDate;
  final String? referenceNo;
  final DateTime? transportDate;
  final String? modeOfTransport;
  final String? vehicleNo;
  final int weight;
  final String id;
  final TermsAndConditionIdElement? transporterId;

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

  factory ShippingDetails.fromRawJson(String str) =>
      ShippingDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingDetails.fromJson(Map<String, dynamic> json) =>
      ShippingDetails(
        shippingType: json["shippingType"],
        shippingDate: json["shippingDate"] == null
            ? null
            : DateTime.parse(json["shippingDate"]),
        referenceNo: json["referenceNo"],
        transportDate: json["transportDate"] == null
            ? null
            : DateTime.parse(json["transportDate"]),
        modeOfTransport: json["modeOfTransport"],
        vehicleNo: json["vehicleNo"],
        weight: json["weight"],
        id: json["_id"],
        transporterId: json["transporterId"] == null
            ? null
            : TermsAndConditionIdElement.fromJson(json["transporterId"]),
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
    "transporterId": transporterId?.toJson(),
  };
}

class TermsAndConditionIdElement {
  final String id;

  TermsAndConditionIdElement({required this.id});

  factory TermsAndConditionIdElement.fromRawJson(String str) =>
      TermsAndConditionIdElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsAndConditionIdElement.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionIdElement(id: json["_id"]);

  Map<String, dynamic> toJson() => {"_id": id};
}

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
  final int allSalesOrders;
  final int pending;
  final int invoiceCreated;
  final int deliveryChallanCreated;
  final int cancelled;

  Summary({
    required this.allSalesOrders,
    required this.pending,
    required this.invoiceCreated,
    required this.deliveryChallanCreated,
    required this.cancelled,
  });

  factory Summary.fromRawJson(String str) => Summary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    allSalesOrders: json["allSalesOrders"],
    pending: json["pending"],
    invoiceCreated: json["invoiceCreated"],
    deliveryChallanCreated: json["deliveryChallanCreated"],
    cancelled: json["cancelled"],
  );

  Map<String, dynamic> toJson() => {
    "allSalesOrders": allSalesOrders,
    "pending": pending,
    "invoiceCreated": invoiceCreated,
    "deliveryChallanCreated": deliveryChallanCreated,
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
