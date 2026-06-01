import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class SalesOrderModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final SalesOrderCreatedBy? createdBy;
  final String? updatedBy;
  final IdNameModel? companyId;
  final String? salesOrderNo;
  final DateTime? date;
  final DateTime? dueDate;
  final SalesOrderCustomer? customerId;
  final String? placeOfSupply;
  final SalesOrderAddress? billingAddress;
  final SalesOrderAddress? shippingAddress;
  final String? taxType;
  final IdNameModel? selectedEstimateId;
  final List<SalesOrderItem> items;
  final SalesOrderSummary? transactionSummary;
  final List<SalesOrderAdditionalCharge> additionalCharges;
  final List<String> termsAndConditionIds;
  final String? status;
  final SalesOrderShipping? shippingDetails;
  final bool reverseCharge;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final IdNameModel? branchId;
  final String? paymentTerms;
  final String? salesManId;
  final String? notes;

  const SalesOrderModel({
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

  SalesOrderModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    SalesOrderCreatedBy? createdBy,
    String? updatedBy,
    IdNameModel? companyId,
    String? salesOrderNo,
    DateTime? date,
    DateTime? dueDate,
    SalesOrderCustomer? customerId,
    String? placeOfSupply,
    SalesOrderAddress? billingAddress,
    SalesOrderAddress? shippingAddress,
    String? taxType,
    IdNameModel? selectedEstimateId,
    List<SalesOrderItem>? items,
    SalesOrderSummary? transactionSummary,
    List<SalesOrderAdditionalCharge>? additionalCharges,
    List<String>? termsAndConditionIds,
    String? status,
    SalesOrderShipping? shippingDetails,
    bool? reverseCharge,
    DateTime? createdAt,
    DateTime? updatedAt,
    IdNameModel? branchId,
    String? paymentTerms,
    String? salesManId,
    String? notes,
  }) {
    return SalesOrderModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      salesOrderNo: salesOrderNo ?? this.salesOrderNo,
      date: date ?? this.date,
      dueDate: dueDate ?? this.dueDate,
      customerId: customerId ?? this.customerId,
      placeOfSupply: placeOfSupply ?? this.placeOfSupply,
      billingAddress: billingAddress ?? this.billingAddress,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      taxType: taxType ?? this.taxType,
      selectedEstimateId: selectedEstimateId ?? this.selectedEstimateId,
      items: items ?? this.items,
      transactionSummary: transactionSummary ?? this.transactionSummary,
      additionalCharges: additionalCharges ?? this.additionalCharges,
      termsAndConditionIds: termsAndConditionIds ?? this.termsAndConditionIds,
      status: status ?? this.status,
      shippingDetails: shippingDetails ?? this.shippingDetails,
      reverseCharge: reverseCharge ?? this.reverseCharge,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      branchId: branchId ?? this.branchId,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      salesManId: salesManId ?? this.salesManId,
      notes: notes ?? this.notes,
    );
  }

  factory SalesOrderModel.fromJson(String json) =>
      SalesOrderModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesOrderModel.fromMap(Map<String, dynamic> map) => SalesOrderModel(
    id: map["_id"]?.toString() ?? "",
    isDeleted: map["isDeleted"] as bool? ?? false,
    isActive: map["isActive"] as bool? ?? true,
    createdBy: map["createdBy"] == null
        ? null
        : SalesOrderCreatedBy.fromMap(map["createdBy"] as Map<String, dynamic>),
    updatedBy: map["updatedBy"]?.toString(),
    companyId: map["companyId"] == null
        ? null
        : IdNameModel.fromMap(map["companyId"]),
    salesOrderNo: map["salesOrderNo"]?.toString(),
    date: map["date"] != null ? DateTime.parse(map["date"].toString()) : null,
    dueDate: map["dueDate"] != null
        ? DateTime.parse(map["dueDate"].toString())
        : null,
    customerId: map["customerId"] == null
        ? null
        : SalesOrderCustomer.fromMap(map["customerId"] as Map<String, dynamic>),
    placeOfSupply: map["placeOfSupply"]?.toString(),
    billingAddress: map["billingAddress"] == null
        ? null
        : (map["billingAddress"] is String
              ? SalesOrderAddress(
                  id: map["billingAddress"].toString(),
                  addressLine1: "",
                  pinCode: 0,
                )
              : SalesOrderAddress.fromMap(
                  map["billingAddress"] as Map<String, dynamic>,
                )),
    shippingAddress: map["shippingAddress"] == null
        ? null
        : (map["shippingAddress"] is String
              ? SalesOrderAddress(
                  id: map["shippingAddress"].toString(),
                  addressLine1: "",
                  pinCode: 0,
                )
              : SalesOrderAddress.fromMap(
                  map["shippingAddress"] as Map<String, dynamic>,
                )),
    taxType: map["taxType"]?.toString(),
    selectedEstimateId: map["selectedEstimateId"] == null
        ? null
        : IdNameModel.fromMap(map["selectedEstimateId"]),
    items: List<SalesOrderItem>.from(
      (map["items"] as List<dynamic>?)?.map(
            (x) => SalesOrderItem.fromMap(x as Map<String, dynamic>),
          ) ??
          [],
    ),
    transactionSummary: map["transactionSummary"] == null
        ? null
        : SalesOrderSummary.fromMap(
            map["transactionSummary"] as Map<String, dynamic>,
          ),
    additionalCharges: List<SalesOrderAdditionalCharge>.from(
      (map["additionalCharges"] as List<dynamic>?)?.map(
            (x) =>
                SalesOrderAdditionalCharge.fromMap(x as Map<String, dynamic>),
          ) ??
          [],
    ),
    termsAndConditionIds: List<String>.from(
      (map["termsAndConditionIds"] as List<dynamic>?)?.map(
            (x) => x is Map ? (x["_id"]?.toString() ?? "") : x.toString(),
          ) ??
          [],
    ),
    status: map["status"]?.toString(),
    shippingDetails: map["shippingDetails"] == null
        ? null
        : SalesOrderShipping.fromMap(
            map["shippingDetails"] as Map<String, dynamic>,
          ),
    reverseCharge: map["reverseCharge"] as bool? ?? false,
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
    "salesOrderNo": salesOrderNo,
    "date": date?.toIso8601String(),
    "dueDate": dueDate?.toIso8601String(),
    "customerId": customerId?.toMap(),
    "placeOfSupply": placeOfSupply,
    "billingAddress": billingAddress?.toMap(),
    "shippingAddress": shippingAddress?.toMap(),
    "taxType": taxType,
    "selectedEstimateId": selectedEstimateId?.toMap(),
    "items": items.map((x) => x.toMap()).toList(),
    "transactionSummary": transactionSummary?.toMap(),
    "additionalCharges": additionalCharges.map((x) => x.toMap()).toList(),
    "termsAndConditionIds": termsAndConditionIds,
    "status": status,
    "shippingDetails": shippingDetails?.toMap(),
    "reverseCharge": reverseCharge,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "branchId": branchId?.toMap(),
    "paymentTerms": paymentTerms,
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
    salesOrderNo,
    date,
    dueDate,
    customerId,
    placeOfSupply,
    billingAddress,
    shippingAddress,
    taxType,
    selectedEstimateId,
    items,
    transactionSummary,
    additionalCharges,
    termsAndConditionIds,
    status,
    shippingDetails,
    reverseCharge,
    createdAt,
    updatedAt,
    branchId,
    paymentTerms,
    salesManId,
    notes,
  ];

  @override
  bool get stringify => true;
}

class SalesOrderAdditionalCharge extends Equatable {
  final String? chargeId;
  final String? taxId;
  final double amount;
  final double totalAmount;
  final String id;

  const SalesOrderAdditionalCharge({
    this.chargeId,
    this.taxId,
    required this.amount,
    required this.totalAmount,
    required this.id,
  });

  SalesOrderAdditionalCharge copyWith({
    String? chargeId,
    String? taxId,
    double? amount,
    double? totalAmount,
    String? id,
  }) {
    return SalesOrderAdditionalCharge(
      chargeId: chargeId ?? this.chargeId,
      taxId: taxId ?? this.taxId,
      amount: amount ?? this.amount,
      totalAmount: totalAmount ?? this.totalAmount,
      id: id ?? this.id,
    );
  }

  factory SalesOrderAdditionalCharge.fromJson(String json) =>
      SalesOrderAdditionalCharge.fromMap(
        jsonDecode(json) as Map<String, dynamic>,
      );

  String toJson() => jsonEncode(toMap());

  factory SalesOrderAdditionalCharge.fromMap(Map<String, dynamic> map) =>
      SalesOrderAdditionalCharge(
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

class SalesOrderTax extends Equatable {
  final String id;
  final String name;
  final double percentage;

  const SalesOrderTax({
    required this.id,
    required this.name,
    required this.percentage,
  });

  SalesOrderTax copyWith({String? id, String? name, double? percentage}) {
    return SalesOrderTax(
      id: id ?? this.id,
      name: name ?? this.name,
      percentage: percentage ?? this.percentage,
    );
  }

  factory SalesOrderTax.fromJson(String json) =>
      SalesOrderTax.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesOrderTax.fromMap(Map<String, dynamic> map) => SalesOrderTax(
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

class SalesOrderAddress extends Equatable {
  final String addressLine1;
  final String? addressLine2;
  final IdNameModel? country;
  final IdNameModel? state;
  final IdNameModel? city;
  final int pinCode;
  final String id;

  const SalesOrderAddress({
    required this.addressLine1,
    this.addressLine2,
    this.country,
    this.state,
    this.city,
    required this.pinCode,
    required this.id,
  });

  SalesOrderAddress copyWith({
    String? addressLine1,
    String? addressLine2,
    IdNameModel? country,
    IdNameModel? state,
    IdNameModel? city,
    int? pinCode,
    String? id,
  }) {
    return SalesOrderAddress(
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      pinCode: pinCode ?? this.pinCode,
      id: id ?? this.id,
    );
  }

  factory SalesOrderAddress.fromJson(String json) =>
      SalesOrderAddress.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesOrderAddress.fromMap(Map<String, dynamic> map) =>
      SalesOrderAddress(
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

class SalesOrderCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const SalesOrderCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  SalesOrderCreatedBy copyWith({
    String? id,
    String? fullName,
    String? userType,
  }) {
    return SalesOrderCreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory SalesOrderCreatedBy.fromJson(String json) =>
      SalesOrderCreatedBy.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesOrderCreatedBy.fromMap(Map<String, dynamic> map) =>
      SalesOrderCreatedBy(
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

class SalesOrderCustomer extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final SalesOrderPhone? phoneNo;
  final List<SalesOrderAddress> address;

  const SalesOrderCustomer({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phoneNo,
    required this.address,
  });

  SalesOrderCustomer copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    SalesOrderPhone? phoneNo,
    List<SalesOrderAddress>? address,
  }) {
    return SalesOrderCustomer(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      address: address ?? this.address,
    );
  }

  factory SalesOrderCustomer.fromJson(String json) =>
      SalesOrderCustomer.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesOrderCustomer.fromMap(Map<String, dynamic> map) =>
      SalesOrderCustomer(
        id: map["_id"]?.toString() ?? "",
        firstName: map["firstName"]?.toString() ?? "",
        lastName: map["lastName"]?.toString() ?? "",
        email: map["email"]?.toString(),
        phoneNo: map["phoneNo"] == null
            ? null
            : SalesOrderPhone.fromMap(map["phoneNo"] as Map<String, dynamic>),
        address: List<SalesOrderAddress>.from(
          (map["address"] as List<dynamic>?)?.map(
                (x) => SalesOrderAddress.fromMap(x as Map<String, dynamic>),
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

class SalesOrderPhone extends Equatable {
  final String countryCode;
  final int phoneNo;

  const SalesOrderPhone({required this.countryCode, required this.phoneNo});

  SalesOrderPhone copyWith({String? countryCode, int? phoneNo}) {
    return SalesOrderPhone(
      countryCode: countryCode ?? this.countryCode,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }

  factory SalesOrderPhone.fromJson(String json) =>
      SalesOrderPhone.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesOrderPhone.fromMap(Map<String, dynamic> map) => SalesOrderPhone(
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

class SalesOrderItem extends Equatable {
  final String? refId;
  final IdNameModel? productId;
  final double qty;
  final double freeQty;
  final IdNameModel? uomId;
  final double price;
  final double discount1;
  final double discount2;
  final SalesOrderTax? taxId;
  final double taxableAmount;
  final double totalAmount;
  final String id;

  const SalesOrderItem({
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

  SalesOrderItem copyWith({
    String? refId,
    IdNameModel? productId,
    double? qty,
    double? freeQty,
    IdNameModel? uomId,
    double? price,
    double? discount1,
    double? discount2,
    SalesOrderTax? taxId,
    double? taxableAmount,
    double? totalAmount,
    String? id,
  }) {
    return SalesOrderItem(
      refId: refId ?? this.refId,
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
    );
  }

  factory SalesOrderItem.fromJson(String json) =>
      SalesOrderItem.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesOrderItem.fromMap(Map<String, dynamic> map) => SalesOrderItem(
    refId: map["refId"]?.toString(),
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
        : SalesOrderTax.fromMap(map["taxId"] as Map<String, dynamic>),
    taxableAmount: (map["taxableAmount"] as num? ?? 0).toDouble(),
    totalAmount: (map["totalAmount"] as num? ?? 0).toDouble(),
    id: map["_id"]?.toString() ?? "",
  );

  Map<String, dynamic> toMap() => {
    "refId": refId,
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
  };

  @override
  List<Object?> get props => [
    refId,
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
  ];

  @override
  bool get stringify => true;
}

class SalesOrderShipping extends Equatable {
  final String shippingType;
  final DateTime? shippingDate;
  final String? referenceNo;
  final DateTime? transportDate;
  final String? modeOfTransport;
  final String? vehicleNo;
  final double weight;
  final String id;
  final String? transporterId;

  const SalesOrderShipping({
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

  SalesOrderShipping copyWith({
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
    return SalesOrderShipping(
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

  factory SalesOrderShipping.fromJson(String json) =>
      SalesOrderShipping.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesOrderShipping.fromMap(Map<String, dynamic> map) =>
      SalesOrderShipping(
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
        transporterId: map["transporterId"] is Map
            ? map["transporterId"]["_id"]?.toString()
            : map["transporterId"]?.toString(),
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

class SalesOrderSummary extends Equatable {
  final double flatDiscount;
  final double grossAmount;
  final double discountAmount;
  final double taxableAmount;
  final double taxAmount;
  final double roundOff;
  final double netAmount;
  final String id;

  const SalesOrderSummary({
    required this.flatDiscount,
    required this.grossAmount,
    required this.discountAmount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
    required this.id,
  });

  SalesOrderSummary copyWith({
    double? flatDiscount,
    double? grossAmount,
    double? discountAmount,
    double? taxableAmount,
    double? taxAmount,
    double? roundOff,
    double? netAmount,
    String? id,
  }) {
    return SalesOrderSummary(
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

  factory SalesOrderSummary.fromJson(String json) =>
      SalesOrderSummary.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesOrderSummary.fromMap(Map<String, dynamic> map) =>
      SalesOrderSummary(
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
