import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class InvoiceModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final InvoiceCreatedBy? createdBy;
  final String? updatedBy;
  final IdNameModel? companyId;
  final String? invoiceNo;
  final DateTime? date;
  final DateTime? dueDate;
  final InvoiceCustomer? customerId;
  final String? placeOfSupply;
  final InvoiceAddress? billingAddress;
  final InvoiceAddress? shippingAddress;
  final bool reverseCharge;
  final List<IdNameModel> salesOrderIds;
  final List<IdNameModel> deliveryChallanIds;
  final String? taxType;
  final InvoiceShipping? shippingDetails;
  final List<InvoiceItem> items;
  final InvoiceSummary? transactionSummary;
  final List<InvoiceAdditionalCharge> additionalCharges;
  final double paidAmount;
  final double balanceAmount;
  final String? paymentStatus;
  final List<dynamic> termsAndConditionIds;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final IdNameModel? branchId;
  final String? paymentTerms;
  final String? createdFrom;
  final String? salesManId;
  final String? notes;

  const InvoiceModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    this.invoiceNo,
    this.date,
    this.dueDate,
    this.customerId,
    this.placeOfSupply,
    this.billingAddress,
    this.shippingAddress,
    required this.reverseCharge,
    required this.salesOrderIds,
    required this.deliveryChallanIds,
    this.taxType,
    this.shippingDetails,
    required this.items,
    this.transactionSummary,
    required this.additionalCharges,
    required this.paidAmount,
    required this.balanceAmount,
    this.paymentStatus,
    required this.termsAndConditionIds,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.branchId,
    this.paymentTerms,
    this.createdFrom,
    this.salesManId,
    this.notes,
  });

  InvoiceModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    InvoiceCreatedBy? createdBy,
    String? updatedBy,
    IdNameModel? companyId,
    String? invoiceNo,
    DateTime? date,
    DateTime? dueDate,
    InvoiceCustomer? customerId,
    String? placeOfSupply,
    InvoiceAddress? billingAddress,
    InvoiceAddress? shippingAddress,
    bool? reverseCharge,
    List<IdNameModel>? salesOrderIds,
    List<IdNameModel>? deliveryChallanIds,
    String? taxType,
    InvoiceShipping? shippingDetails,
    List<InvoiceItem>? items,
    InvoiceSummary? transactionSummary,
    List<InvoiceAdditionalCharge>? additionalCharges,
    double? paidAmount,
    double? balanceAmount,
    String? paymentStatus,
    List<dynamic>? termsAndConditionIds,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    IdNameModel? branchId,
    String? paymentTerms,
    String? createdFrom,
    String? salesManId,
    String? notes,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      date: date ?? this.date,
      dueDate: dueDate ?? this.dueDate,
      customerId: customerId ?? this.customerId,
      placeOfSupply: placeOfSupply ?? this.placeOfSupply,
      billingAddress: billingAddress ?? this.billingAddress,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      reverseCharge: reverseCharge ?? this.reverseCharge,
      salesOrderIds: salesOrderIds ?? this.salesOrderIds,
      deliveryChallanIds: deliveryChallanIds ?? this.deliveryChallanIds,
      taxType: taxType ?? this.taxType,
      shippingDetails: shippingDetails ?? this.shippingDetails,
      items: items ?? this.items,
      transactionSummary: transactionSummary ?? this.transactionSummary,
      additionalCharges: additionalCharges ?? this.additionalCharges,
      paidAmount: paidAmount ?? this.paidAmount,
      balanceAmount: balanceAmount ?? this.balanceAmount,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      termsAndConditionIds: termsAndConditionIds ?? this.termsAndConditionIds,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      branchId: branchId ?? this.branchId,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      createdFrom: createdFrom ?? this.createdFrom,
      salesManId: salesManId ?? this.salesManId,
      notes: notes ?? this.notes,
    );
  }

  factory InvoiceModel.fromJson(String json) =>
      InvoiceModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory InvoiceModel.fromMap(Map<String, dynamic> map) => InvoiceModel(
    id: map["_id"]?.toString() ?? "",
    isDeleted: map["isDeleted"] as bool? ?? false,
    isActive: map["isActive"] as bool? ?? true,
    createdBy: map["createdBy"] == null
        ? null
        : InvoiceCreatedBy.fromMap(map["createdBy"] as Map<String, dynamic>),
    updatedBy: map["updatedBy"]?.toString(),
    companyId: map["companyId"] == null
        ? null
        : IdNameModel.fromMap(map["companyId"]),
    invoiceNo: map["invoiceNo"]?.toString(),
    date: map["date"] != null ? DateTime.parse(map["date"].toString()) : null,
    dueDate: map["dueDate"] != null
        ? DateTime.parse(map["dueDate"].toString())
        : null,
    customerId: map["customerId"] == null
        ? null
        : InvoiceCustomer.fromMap(map["customerId"] as Map<String, dynamic>),
    placeOfSupply: map["placeOfSupply"]?.toString(),
    billingAddress: map["billingAddress"] == null
        ? null
        : InvoiceAddress.fromMap(map["billingAddress"] as Map<String, dynamic>),
    shippingAddress: map["shippingAddress"] == null
        ? null
        : InvoiceAddress.fromMap(
            map["shippingAddress"] as Map<String, dynamic>,
          ),
    reverseCharge: map["reverseCharge"] as bool? ?? false,
    salesOrderIds: List<IdNameModel>.from(
      (map["salesOrderIds"] as List<dynamic>?)?.map(
            (x) => IdNameModel.fromMap(x),
          ) ??
          [],
    ),
    deliveryChallanIds: List<IdNameModel>.from(
      (map["deliveryChallanIds"] as List<dynamic>?)?.map(
            (x) => IdNameModel.fromMap(x),
          ) ??
          [],
    ),
    taxType: map["taxType"]?.toString(),
    shippingDetails: map["shippingDetails"] == null
        ? null
        : InvoiceShipping.fromMap(
            map["shippingDetails"] as Map<String, dynamic>,
          ),
    items: List<InvoiceItem>.from(
      (map["items"] as List<dynamic>?)?.map(
            (x) => InvoiceItem.fromMap(x as Map<String, dynamic>),
          ) ??
          [],
    ),
    transactionSummary: map["transactionSummary"] == null
        ? null
        : InvoiceSummary.fromMap(
            map["transactionSummary"] as Map<String, dynamic>,
          ),
    additionalCharges: List<InvoiceAdditionalCharge>.from(
      (map["additionalCharges"] as List<dynamic>?)?.map(
            (x) => InvoiceAdditionalCharge.fromMap(x as Map<String, dynamic>),
          ) ??
          [],
    ),
    paidAmount: (map["paidAmount"] as num? ?? 0).toDouble(),
    balanceAmount: (map["balanceAmount"] as num? ?? 0).toDouble(),
    paymentStatus: map["paymentStatus"]?.toString(),
    termsAndConditionIds: List<dynamic>.from(
      (map["termsAndConditionIds"] as List<dynamic>?)?.map((x) => x) ?? [],
    ),
    status: map["status"]?.toString(),
    createdAt: map["createdAt"] != null
        ? DateTime.parse(map["createdAt"].toString())
        : null,
    updatedAt: map["updatedAt"] != null
        ? DateTime.parse(map["updatedAt"].toString())
        : null,
    branchId: map["branchId"] == null
        ? null
        : IdNameModel.fromMap(map["branchId"]),
    paymentTerms: map["paymentTerms"]?.toString(),
    createdFrom: map["createdFrom"]?.toString(),
    salesManId: map["salesManId"] is Map
        ? map["salesManId"]["_id"]?.toString()
        : map["salesManId"]?.toString(),
    notes: map["notes"]?.toString(),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy?.toMap(),
    "updatedBy": updatedBy,
    "companyId": companyId?.toMap(),
    "invoiceNo": invoiceNo,
    "date": date?.toIso8601String(),
    "dueDate": dueDate?.toIso8601String(),
    "customerId": customerId?.toMap(),
    "placeOfSupply": placeOfSupply,
    "billingAddress": billingAddress?.toMap(),
    "shippingAddress": shippingAddress?.toMap(),
    "reverseCharge": reverseCharge,
    "salesOrderIds": salesOrderIds.map((x) => x.toMap()).toList(),
    "deliveryChallanIds": deliveryChallanIds.map((x) => x.toMap()).toList(),
    "taxType": taxType,
    "shippingDetails": shippingDetails?.toMap(),
    "items": items.map((x) => x.toMap()).toList(),
    "transactionSummary": transactionSummary?.toMap(),
    "additionalCharges": additionalCharges.map((x) => x.toMap()).toList(),
    "paidAmount": paidAmount,
    "balanceAmount": balanceAmount,
    "paymentStatus": paymentStatus,
    "termsAndConditionIds": termsAndConditionIds,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "branchId": branchId?.toMap(),
    "paymentTerms": paymentTerms,
    "createdFrom": createdFrom,
    "salesManId": salesManId,
    "notes": notes,
  };

  @override
  List<Object?> get props => [
    id,
    isDeleted,
    isActive,
    createdBy,
    updatedBy,
    companyId,
    invoiceNo,
    date,
    dueDate,
    customerId,
    placeOfSupply,
    billingAddress,
    shippingAddress,
    reverseCharge,
    salesOrderIds,
    deliveryChallanIds,
    taxType,
    shippingDetails,
    items,
    transactionSummary,
    additionalCharges,
    paidAmount,
    balanceAmount,
    paymentStatus,
    termsAndConditionIds,
    status,
    createdAt,
    updatedAt,
    branchId,
    paymentTerms,
    createdFrom,
    salesManId,
    notes,
  ];

  @override
  bool get stringify => true;
}

class InvoiceAdditionalCharge extends Equatable {
  final String? chargeId;
  final String? taxId;
  final double amount;
  final double totalAmount;
  final String id;

  const InvoiceAdditionalCharge({
    this.chargeId,
    this.taxId,
    required this.amount,
    required this.totalAmount,
    required this.id,
  });

  InvoiceAdditionalCharge copyWith({
    String? chargeId,
    String? taxId,
    double? amount,
    double? totalAmount,
    String? id,
  }) {
    return InvoiceAdditionalCharge(
      chargeId: chargeId ?? this.chargeId,
      taxId: taxId ?? this.taxId,
      amount: amount ?? this.amount,
      totalAmount: totalAmount ?? this.totalAmount,
      id: id ?? this.id,
    );
  }

  factory InvoiceAdditionalCharge.fromJson(String json) =>
      InvoiceAdditionalCharge.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory InvoiceAdditionalCharge.fromMap(Map<String, dynamic> map) =>
      InvoiceAdditionalCharge(
        chargeId: map["chargeId"] is Map
            ? map["chargeId"]["_id"]?.toString()
            : map["chargeId"]?.toString(),
        taxId: map["taxId"] is Map
            ? map["taxId"]["_id"]?.toString()
            : map["taxId"]?.toString(),
        amount: (map["amount"] as num? ?? 0).toDouble(),
        totalAmount: (map["totalAmount"] as num? ?? 0).toDouble(),
        id: map["_id"]?.toString() ?? "",
      );

  Map<String, dynamic> toMap() => {
    "chargeId": chargeId,
    "taxId": taxId,
    "amount": amount,
    "totalAmount": totalAmount,
    "_id": id,
  };

  @override
  List<Object?> get props => [chargeId, taxId, amount, totalAmount, id];

  @override
  bool get stringify => true;
}

class InvoiceTax extends Equatable {
  final String id;
  final String name;
  final double percentage;

  const InvoiceTax({
    required this.id,
    required this.name,
    required this.percentage,
  });

  InvoiceTax copyWith({String? id, String? name, double? percentage}) {
    return InvoiceTax(
      id: id ?? this.id,
      name: name ?? this.name,
      percentage: percentage ?? this.percentage,
    );
  }

  factory InvoiceTax.fromJson(String json) =>
      InvoiceTax.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory InvoiceTax.fromMap(Map<String, dynamic> map) => InvoiceTax(
    id: map["_id"]?.toString() ?? "",
    name: map["name"]?.toString() ?? "",
    percentage: (map["percentage"] as num? ?? 0).toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
    "percentage": percentage,
  };

  @override
  List<Object?> get props => [id, name, percentage];

  @override
  bool get stringify => true;
}

class InvoiceAddress extends Equatable {
  final String addressLine1;
  final String? addressLine2;
  final IdNameModel? country;
  final IdNameModel? state;
  final IdNameModel? city;
  final int pinCode;
  final String id;

  const InvoiceAddress({
    required this.addressLine1,
    this.addressLine2,
    this.country,
    this.state,
    this.city,
    required this.pinCode,
    required this.id,
  });

  InvoiceAddress copyWith({
    String? addressLine1,
    String? addressLine2,
    IdNameModel? country,
    IdNameModel? state,
    IdNameModel? city,
    int? pinCode,
    String? id,
  }) {
    return InvoiceAddress(
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      pinCode: pinCode ?? this.pinCode,
      id: id ?? this.id,
    );
  }

  factory InvoiceAddress.fromJson(String json) =>
      InvoiceAddress.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory InvoiceAddress.fromMap(Map<String, dynamic> map) => InvoiceAddress(
    addressLine1: map["addressLine1"]?.toString() ?? "",
    addressLine2: map["addressLine2"]?.toString(),
    country: map["country"] == null
        ? null
        : IdNameModel.fromMap(map["country"]),
    state: map["state"] == null ? null : IdNameModel.fromMap(map["state"]),
    city: map["city"] == null ? null : IdNameModel.fromMap(map["city"]),
    pinCode: (map["pinCode"] as num? ?? 0).toInt(),
    id: map["_id"]?.toString() ?? "",
  );

  Map<String, dynamic> toMap() => {
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "country": country?.toMap(),
    "state": state?.toMap(),
    "city": city?.toMap(),
    "pinCode": pinCode,
    "_id": id,
  };

  @override
  List<Object?> get props => [
    addressLine1,
    addressLine2,
    country,
    state,
    city,
    pinCode,
    id,
  ];

  @override
  bool get stringify => true;
}

class InvoiceCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const InvoiceCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  InvoiceCreatedBy copyWith({String? id, String? fullName, String? userType}) {
    return InvoiceCreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory InvoiceCreatedBy.fromJson(String json) =>
      InvoiceCreatedBy.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory InvoiceCreatedBy.fromMap(Map<String, dynamic> map) =>
      InvoiceCreatedBy(
        id: map["_id"]?.toString() ?? "",
        fullName: map["fullName"]?.toString() ?? "",
        userType: map["userType"]?.toString() ?? "",
      );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };

  @override
  List<Object?> get props => [id, fullName, userType];

  @override
  bool get stringify => true;
}

class InvoiceCustomer extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final InvoicePhone? phoneNo;
  final List<InvoiceAddress> address;

  const InvoiceCustomer({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phoneNo,
    required this.address,
  });

  InvoiceCustomer copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    InvoicePhone? phoneNo,
    List<InvoiceAddress>? address,
  }) {
    return InvoiceCustomer(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      address: address ?? this.address,
    );
  }

  factory InvoiceCustomer.fromJson(String json) =>
      InvoiceCustomer.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory InvoiceCustomer.fromMap(Map<String, dynamic> map) => InvoiceCustomer(
    id: map["_id"]?.toString() ?? "",
    firstName: map["firstName"]?.toString() ?? "",
    lastName: map["lastName"]?.toString() ?? "",
    email: map["email"]?.toString(),
    phoneNo: map["phoneNo"] == null
        ? null
        : InvoicePhone.fromMap(map["phoneNo"] as Map<String, dynamic>),
    address: List<InvoiceAddress>.from(
      (map["address"] as List<dynamic>?)?.map(
            (x) => InvoiceAddress.fromMap(x as Map<String, dynamic>),
          ) ??
          [],
    ),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phoneNo": phoneNo?.toMap(),
    "address": address.map((x) => x.toMap()).toList(),
  };

  @override
  List<Object?> get props => [id, firstName, lastName, email, phoneNo, address];

  @override
  bool get stringify => true;
}

class InvoicePhone extends Equatable {
  final String countryCode;
  final int phoneNo;

  const InvoicePhone({required this.countryCode, required this.phoneNo});

  InvoicePhone copyWith({String? countryCode, int? phoneNo}) {
    return InvoicePhone(
      countryCode: countryCode ?? this.countryCode,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }

  factory InvoicePhone.fromJson(String json) =>
      InvoicePhone.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory InvoicePhone.fromMap(Map<String, dynamic> map) => InvoicePhone(
    countryCode: map["countryCode"]?.toString() ?? "91",
    phoneNo: (map["phoneNo"] as num? ?? 0).toInt(),
  );

  Map<String, dynamic> toMap() => {
    "countryCode": countryCode,
    "phoneNo": phoneNo,
  };

  @override
  List<Object?> get props => [countryCode, phoneNo];

  @override
  bool get stringify => true;
}

class InvoiceItem extends Equatable {
  final IdNameModel? productId;
  final double qty;
  final double freeQty;
  final IdNameModel? uomId;
  final double price;
  final double discount1;
  final double discount2;
  final InvoiceTax? taxId;
  final double taxableAmount;
  final double totalAmount;
  final String id;
  final String? unit;
  final double? tax;

  const InvoiceItem({
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
    this.unit,
    this.tax,
  });

  InvoiceItem copyWith({
    IdNameModel? productId,
    double? qty,
    double? freeQty,
    IdNameModel? uomId,
    double? price,
    double? discount1,
    double? discount2,
    InvoiceTax? taxId,
    double? taxableAmount,
    double? totalAmount,
    String? id,
    String? unit,
    double? tax,
  }) {
    return InvoiceItem(
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      freeQty: freeQty ?? this.freeQty,
      uomId: uomId ?? this.uomId,
      price: price ?? this.price,
      discount1: discount1 ?? this.discount1,
      discount2: discount2 ?? this.discount2,
      taxId: taxId ?? this.taxId,
      taxableAmount: taxableAmount ?? this.taxableAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      id: id ?? this.id,
      unit: unit ?? this.unit,
      tax: tax ?? this.tax,
    );
  }

  factory InvoiceItem.fromJson(String json) =>
      InvoiceItem.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory InvoiceItem.fromMap(Map<String, dynamic> map) => InvoiceItem(
    productId: map["productId"] == null
        ? null
        : IdNameModel.fromMap(map["productId"]),
    qty: (map["qty"] as num? ?? 0).toDouble(),
    freeQty: (map["freeQty"] as num? ?? 0).toDouble(),
    uomId: map["uomId"] == null ? null : IdNameModel.fromMap(map["uomId"]),
    price: (map["price"] as num? ?? 0).toDouble(),
    discount1: (map["discount1"] as num? ?? 0).toDouble(),
    discount2: (map["discount2"] as num? ?? 0).toDouble(),
    taxId: map["taxId"] == null
        ? null
        : InvoiceTax.fromMap(map["taxId"] as Map<String, dynamic>),
    taxableAmount: (map["taxableAmount"] as num? ?? 0).toDouble(),
    totalAmount: (map["totalAmount"] as num? ?? 0).toDouble(),
    id: map["_id"]?.toString() ?? "",
    unit: map["unit"]?.toString(),
    tax: (map["tax"] as num? ?? 0).toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "productId": productId?.toMap(),
    "qty": qty,
    "freeQty": freeQty,
    "uomId": uomId?.toMap(),
    "price": price,
    "discount1": discount1,
    "discount2": discount2,
    "taxId": taxId?.toMap(),
    "taxableAmount": taxableAmount,
    "totalAmount": totalAmount,
    "_id": id,
    "unit": unit,
    "tax": tax,
  };

  @override
  List<Object?> get props => [
    productId,
    qty,
    freeQty,
    uomId,
    price,
    discount1,
    discount2,
    taxId,
    taxableAmount,
    totalAmount,
    id,
    unit,
    tax,
  ];

  @override
  bool get stringify => true;
}

class InvoiceShipping extends Equatable {
  final String shippingType;
  final DateTime? shippingDate;
  final String? referenceNo;
  final DateTime? transportDate;
  final String? modeOfTransport;
  final String? vehicleNo;
  final double weight;
  final String id;
  final String? transporterId;

  const InvoiceShipping({
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

  InvoiceShipping copyWith({
    String? shippingType,
    DateTime? shippingDate,
    String? referenceNo,
    DateTime? transportDate,
    String? modeOfTransport,
    String? vehicleNo,
    double? weight,
    String? id,
    String? transporterId,
  }) {
    return InvoiceShipping(
      shippingType: shippingType ?? this.shippingType,
      shippingDate: shippingDate ?? this.shippingDate,
      referenceNo: referenceNo ?? this.referenceNo,
      transportDate: transportDate ?? this.transportDate,
      modeOfTransport: modeOfTransport ?? this.modeOfTransport,
      vehicleNo: vehicleNo ?? this.vehicleNo,
      weight: weight ?? this.weight,
      id: id ?? this.id,
      transporterId: transporterId ?? this.transporterId,
    );
  }

  factory InvoiceShipping.fromJson(String json) =>
      InvoiceShipping.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory InvoiceShipping.fromMap(Map<String, dynamic> map) => InvoiceShipping(
    shippingType: map["shippingType"]?.toString() ?? "delivery",
    shippingDate: map["shippingDate"] != null
        ? DateTime.parse(map["shippingDate"].toString())
        : null,
    referenceNo: map["referenceNo"]?.toString(),
    transportDate: map["transportDate"] != null
        ? DateTime.parse(map["transportDate"].toString())
        : null,
    modeOfTransport: map["modeOfTransport"]?.toString(),
    vehicleNo: map["vehicleNo"]?.toString(),
    weight: (map["weight"] as num? ?? 0).toDouble(),
    id: map["_id"]?.toString() ?? "",
    transporterId: map["transporterId"]?.toString(),
  );

  Map<String, dynamic> toMap() => {
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

  @override
  List<Object?> get props => [
    shippingType,
    shippingDate,
    referenceNo,
    transportDate,
    modeOfTransport,
    vehicleNo,
    weight,
    id,
    transporterId,
  ];

  @override
  bool get stringify => true;
}

class InvoiceSummary extends Equatable {
  final double flatDiscount;
  final double grossAmount;
  final double discountAmount;
  final double taxableAmount;
  final double taxAmount;
  final double roundOff;
  final double netAmount;
  final String id;

  const InvoiceSummary({
    required this.flatDiscount,
    required this.grossAmount,
    required this.discountAmount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
    required this.id,
  });

  InvoiceSummary copyWith({
    double? flatDiscount,
    double? grossAmount,
    double? discountAmount,
    double? taxableAmount,
    double? taxAmount,
    double? roundOff,
    double? netAmount,
    String? id,
  }) {
    return InvoiceSummary(
      flatDiscount: flatDiscount ?? this.flatDiscount,
      grossAmount: grossAmount ?? this.grossAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      taxableAmount: taxableAmount ?? this.taxableAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      roundOff: roundOff ?? this.roundOff,
      netAmount: netAmount ?? this.netAmount,
      id: id ?? this.id,
    );
  }

  factory InvoiceSummary.fromJson(String json) =>
      InvoiceSummary.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory InvoiceSummary.fromMap(Map<String, dynamic> map) => InvoiceSummary(
    flatDiscount: (map["flatDiscount"] as num? ?? 0).toDouble(),
    grossAmount: (map["grossAmount"] as num? ?? 0).toDouble(),
    discountAmount: (map["discountAmount"] as num? ?? 0).toDouble(),
    taxableAmount: (map["taxableAmount"] as num? ?? 0).toDouble(),
    taxAmount: (map["taxAmount"] as num? ?? 0).toDouble(),
    roundOff: (map["roundOff"] as num? ?? 0).toDouble(),
    netAmount: (map["netAmount"] as num? ?? 0).toDouble(),
    id: map["_id"]?.toString() ?? "",
  );

  Map<String, dynamic> toMap() => {
    "flatDiscount": flatDiscount,
    "grossAmount": grossAmount,
    "discountAmount": discountAmount,
    "taxableAmount": taxableAmount,
    "taxAmount": taxAmount,
    "roundOff": roundOff,
    "netAmount": netAmount,
    "_id": id,
  };

  @override
  List<Object?> get props => [
    flatDiscount,
    grossAmount,
    discountAmount,
    taxableAmount,
    taxAmount,
    roundOff,
    netAmount,
    id,
  ];

  @override
  bool get stringify => true;
}
