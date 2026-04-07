import 'dart:convert';

class DeliveryChallanModel {
  final List<DeliveryChallanDatum> deliveryChallanData;
  final int totalData;
  final Summary summary;
  final State state;

  DeliveryChallanModel({
    required this.deliveryChallanData,
    required this.totalData,
    required this.summary,
    required this.state,
  });

  factory DeliveryChallanModel.fromRawJson(String str) =>
      DeliveryChallanModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveryChallanModel.fromJson(Map<String, dynamic> json) =>
      DeliveryChallanModel(
        deliveryChallanData: json["deliveryChallan_data"] == null
            ? []
            : List<DeliveryChallanDatum>.from(
                json["deliveryChallan_data"].map(
                  (x) => DeliveryChallanDatum.fromJson(x),
                ),
              ),
        totalData: json["totalData"] ?? 0,
        summary: json["summary"] == null
            ? Summary(
                allDeliveryChallans: 0,
                invoiceCreated: 0,
                delivered: 0,
                cancelled: 0,
              )
            : Summary.fromJson(json["summary"]),
        state: json["state"] == null
            ? State(page: 1, limit: 10, totalPages: 1)
            : State.fromJson(json["state"]),
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
  final String updatedBy;
  final BranchId companyId;
  final String deliveryChallanNo;
  final DateTime date;
  final CustomerId customerId;
  final String placeOfSupply;
  final Address billingAddress;
  final Address shippingAddress;
  final List<InvoiceId> invoiceIds;
  final List<SalesOrderId> salesOrderIds;
  final PaymentTermsId? paymentTermsId;
  final DateTime dueDate;
  final String taxType;
  final ShippingDetails shippingDetails;
  final List<Item> items;
  final TransactionSummary transactionSummary;
  final List<AdditionalCharge> additionalCharges;
  final bool reverseCharge;
  final String status;
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

  factory DeliveryChallanDatum.fromJson(
    Map<String, dynamic> json,
  ) => DeliveryChallanDatum(
    id: json["_id"] ?? "",
    isDeleted: json["isDeleted"] ?? false,
    isActive: json["isActive"] ?? true,
    createdBy: json["createdBy"] == null
        ? CreatedBy(id: "", fullName: "", userType: "")
        : CreatedBy.fromJson(json["createdBy"]),
    updatedBy: json["updatedBy"] ?? "",
    companyId: json["companyId"] == null
        ? BranchId(id: "", name: "")
        : BranchId.fromJson(json["companyId"]),
    deliveryChallanNo: json["deliveryChallanNo"] ?? "",
    date: json["date"] == null ? DateTime.now() : DateTime.parse(json["date"]),
    customerId: json["customerId"] == null
        ? CustomerId(
            id: "",
            firstName: "",
            lastName: "",
            email: "",
            phoneNo: PhoneNo(countryCode: "91", phoneNo: 0),
            address: [],
          )
        : CustomerId.fromJson(json["customerId"]),
    placeOfSupply: json["placeOfSupply"] ?? "",
    billingAddress: json["billingAddress"] == null
        ? Address(
            addressLine1: "",
            country: BranchId(id: "", name: ""),
            state: BranchId(id: "", name: ""),
            city: BranchId(id: "", name: ""),
            pinCode: 0,
            id: "",
          )
        : Address.fromJson(json["billingAddress"]),
    shippingAddress: json["shippingAddress"] == null
        ? Address(
            addressLine1: "",
            country: BranchId(id: "", name: ""),
            state: BranchId(id: "", name: ""),
            city: BranchId(id: "", name: ""),
            pinCode: 0,
            id: "",
          )
        : Address.fromJson(json["shippingAddress"]),
    invoiceIds: json["invoiceIds"] == null
        ? []
        : List<InvoiceId>.from(
            json["invoiceIds"].map((x) => InvoiceId.fromJson(x)),
          ),
    salesOrderIds: json["salesOrderIds"] == null
        ? []
        : List<SalesOrderId>.from(
            json["salesOrderIds"].map((x) => SalesOrderId.fromJson(x)),
          ),
    paymentTermsId: json["paymentTermsId"] == null
        ? null
        : PaymentTermsId.fromJson(json["paymentTermsId"]),
    dueDate: json["dueDate"] == null
        ? DateTime.now()
        : DateTime.parse(json["dueDate"]),
    taxType: json["taxType"] ?? "default",
    shippingDetails: json["shippingDetails"] == null
        ? ShippingDetails(shippingType: "delivery", weight: 0.0, id: "")
        : ShippingDetails.fromJson(json["shippingDetails"]),
    items: json["items"] == null
        ? []
        : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    transactionSummary: json["transactionSummary"] == null
        ? TransactionSummary(
            flatDiscount: 0.0,
            grossAmount: 0.0,
            discountAmount: 0.0,
            taxableAmount: 0.0,
            taxAmount: 0.0,
            roundOff: 0.0,
            netAmount: 0.0,
            id: "",
          )
        : TransactionSummary.fromJson(json["transactionSummary"]),
    additionalCharges: json["additionalCharges"] == null
        ? []
        : List<AdditionalCharge>.from(
            json["additionalCharges"].map((x) => AdditionalCharge.fromJson(x)),
          ),
    reverseCharge: json["reverseCharge"] ?? false,
    status: json["status"] ?? "delivered",
    termsAndConditionIds: json["termsAndConditionIds"] == null
        ? []
        : List<String>.from(
            json["termsAndConditionIds"].map((x) => x.toString()),
          ),
    createdAt: json["createdAt"] == null
        ? DateTime.now()
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? DateTime.now()
        : DateTime.parse(json["updatedAt"]),
    branchId: json["branchId"] == null
        ? BranchId(id: "", name: "")
        : BranchId.fromJson(json["branchId"]),
    createdFrom: json["createdFrom"],
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
    "deliveryChallanNo": deliveryChallanNo,
    "date": date.toIso8601String(),
    "customerId": customerId.toJson(),
    "placeOfSupply": placeOfSupply,
    "billingAddress": billingAddress.toJson(),
    "shippingAddress": shippingAddress.toJson(),
    "invoiceIds": List<dynamic>.from(invoiceIds.map((x) => x.toJson())),
    "salesOrderIds": List<dynamic>.from(salesOrderIds.map((x) => x.toJson())),
    "paymentTermsId": paymentTermsId?.toJson(),
    "dueDate": dueDate.toIso8601String(),
    "taxType": taxType,
    "shippingDetails": shippingDetails.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "transactionSummary": transactionSummary.toJson(),
    "additionalCharges": List<dynamic>.from(
      additionalCharges.map((x) => x.toJson()),
    ),
    "reverseCharge": reverseCharge,
    "status": status,
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
        chargeId: json["chargeId"] ?? "",
        taxId: json["taxId"] ?? "",
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

class BranchId {
  final String id;
  final String name;

  BranchId({required this.id, required this.name});

  factory BranchId.fromRawJson(String str) =>
      BranchId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BranchId.fromJson(Map<String, dynamic> json) =>
      BranchId(id: json["_id"] ?? "", name: json["name"] ?? "");

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
        : List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
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

class InvoiceId {
  final String id;
  final String invoiceNo;

  InvoiceId({required this.id, required this.invoiceNo});

  factory InvoiceId.fromRawJson(String str) =>
      InvoiceId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceId.fromJson(Map<String, dynamic> json) =>
      InvoiceId(id: json["_id"] ?? "", invoiceNo: json["invoiceNo"] ?? "");

  Map<String, dynamic> toJson() => {"_id": id, "invoiceNo": invoiceNo};
}

class Item {
  final BranchId productId;
  final double qty;
  final double freeQty;
  final String uomId;
  final String unit;
  final double price;
  final double discount1;
  final double discount2;
  final TaxId taxId;
  final double tax;
  final double taxableAmount;
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
    productId: json["productId"] == null
        ? BranchId(id: "", name: "")
        : BranchId.fromJson(json["productId"]),
    qty: (json["qty"] ?? 0).toDouble(),
    freeQty: (json["freeQty"] ?? 0).toDouble(),
    uomId: json["uomId"] ?? "",
    unit: json["unit"] ?? "",
    price: (json["price"] ?? 0).toDouble(),
    discount1: (json["discount1"] ?? 0).toDouble(),
    discount2: (json["discount2"] ?? 0).toDouble(),
    taxId: json["taxId"] == null
        ? TaxId(id: "", name: "", percentage: 0)
        : TaxId.fromJson(json["taxId"]),
    tax: (json["tax"] ?? 0).toDouble(),
    taxableAmount: (json["taxableAmount"] ?? 0).toDouble(),
    totalAmount: (json["totalAmount"] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId.toJson(),
    "qty": qty,
    "freeQty": freeQty,
    "uomId": uomId,
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

class SalesOrderId {
  final String id;
  final String salesOrderNo;

  SalesOrderId({required this.id, required this.salesOrderNo});

  factory SalesOrderId.fromRawJson(String str) =>
      SalesOrderId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesOrderId.fromJson(Map<String, dynamic> json) => SalesOrderId(
    id: json["_id"] ?? "",
    salesOrderNo: json["salesOrderNo"] ?? "",
  );

  Map<String, dynamic> toJson() => {"_id": id, "salesOrderNo": salesOrderNo};
}

class ShippingDetails {
  final String shippingType;
  final double weight;
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
        vehicleNo: json["vehicleNo"],
        transporterId: json["transporterId"],
      );

  Map<String, dynamic> toJson() => {
    "shippingType": shippingType,
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
    allDeliveryChallans: json["allDeliveryChallans"] ?? 0,
    invoiceCreated: json["invoiceCreated"] ?? 0,
    delivered: json["delivered"] ?? 0,
    cancelled: json["cancelled"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "allDeliveryChallans": allDeliveryChallans,
    "invoiceCreated": invoiceCreated,
    "delivered": delivered,
    "cancelled": cancelled,
  };
}
