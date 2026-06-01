import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class DeliveryChallanModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final DeliveryChallanCreatedBy? createdBy;
  final String? updatedBy;
  final IdNameModel? companyId;
  final String? deliveryChallanNo;
  final DateTime? date;
  final DeliveryChallanCustomer? customerId;
  final String? placeOfSupply;
  final DeliveryChallanAddress? billingAddress;
  final DeliveryChallanAddress? shippingAddress;
  final List<IdNameModel> invoiceIds;
  final List<IdNameModel> salesOrderIds;
  final IdNameModel? paymentTermsId;
  final DateTime? dueDate;
  final String? taxType;
  final DeliveryChallanShipping? shippingDetails;
  final List<DeliveryChallanItem> items;
  final DeliveryChallanSummary? transactionSummary;
  final List<DeliveryChallanAdditionalCharge> additionalCharges;
  final bool reverseCharge;
  final String? status;
  final List<String> termsAndConditionIds;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final IdNameModel? branchId;
  final String? createdFrom;
  final String? paymentTerms;
  final String? notes;

  const DeliveryChallanModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    this.deliveryChallanNo,
    this.date,
    this.customerId,
    this.placeOfSupply,
    this.billingAddress,
    this.shippingAddress,
    required this.invoiceIds,
    required this.salesOrderIds,
    this.paymentTermsId,
    this.dueDate,
    this.taxType,
    this.shippingDetails,
    required this.items,
    this.transactionSummary,
    required this.additionalCharges,
    required this.reverseCharge,
    this.status,
    required this.termsAndConditionIds,
    this.createdAt,
    this.updatedAt,
    this.branchId,
    this.createdFrom,
    this.paymentTerms,
    this.notes,
  });

  DeliveryChallanModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    DeliveryChallanCreatedBy? createdBy,
    String? updatedBy,
    IdNameModel? companyId,
    String? deliveryChallanNo,
    DateTime? date,
    DeliveryChallanCustomer? customerId,
    String? placeOfSupply,
    DeliveryChallanAddress? billingAddress,
    DeliveryChallanAddress? shippingAddress,
    List<IdNameModel>? invoiceIds,
    List<IdNameModel>? salesOrderIds,
    IdNameModel? paymentTermsId,
    DateTime? dueDate,
    String? taxType,
    DeliveryChallanShipping? shippingDetails,
    List<DeliveryChallanItem>? items,
    DeliveryChallanSummary? transactionSummary,
    List<DeliveryChallanAdditionalCharge>? additionalCharges,
    bool? reverseCharge,
    String? status,
    List<String>? termsAndConditionIds,
    DateTime? createdAt,
    DateTime? updatedAt,
    IdNameModel? branchId,
    String? createdFrom,
    String? paymentTerms,
    String? notes,
  }) {
    return DeliveryChallanModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      deliveryChallanNo: deliveryChallanNo ?? this.deliveryChallanNo,
      date: date ?? this.date,
      customerId: customerId ?? this.customerId,
      placeOfSupply: placeOfSupply ?? this.placeOfSupply,
      billingAddress: billingAddress ?? this.billingAddress,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      invoiceIds: invoiceIds ?? this.invoiceIds,
      salesOrderIds: salesOrderIds ?? this.salesOrderIds,
      paymentTermsId: paymentTermsId ?? this.paymentTermsId,
      dueDate: dueDate ?? this.dueDate,
      taxType: taxType ?? this.taxType,
      shippingDetails: shippingDetails ?? this.shippingDetails,
      items: items ?? this.items,
      transactionSummary: transactionSummary ?? this.transactionSummary,
      additionalCharges: additionalCharges ?? this.additionalCharges,
      reverseCharge: reverseCharge ?? this.reverseCharge,
      status: status ?? this.status,
      termsAndConditionIds: termsAndConditionIds ?? this.termsAndConditionIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      branchId: branchId ?? this.branchId,
      createdFrom: createdFrom ?? this.createdFrom,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      notes: notes ?? this.notes,
    );
  }

  factory DeliveryChallanModel.fromJson(String json) =>
      DeliveryChallanModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory DeliveryChallanModel.fromMap(Map<String, dynamic> map) =>
      DeliveryChallanModel(
        id: map["_id"]?.toString() ?? "",
        isDeleted: map["isDeleted"] as bool? ?? false,
        isActive: map["isActive"] as bool? ?? true,
        createdBy: map["createdBy"] == null
            ? null
            : DeliveryChallanCreatedBy.fromMap(
                map["createdBy"] as Map<String, dynamic>),
        updatedBy: map["updatedBy"]?.toString(),
        companyId:
            map["companyId"] == null ? null : IdNameModel.fromMap(map["companyId"]),
        deliveryChallanNo: map["deliveryChallanNo"]?.toString(),
        date: map["date"] != null ? DateTime.parse(map["date"].toString()) : null,
        customerId: map["customerId"] == null
            ? null
            : DeliveryChallanCustomer.fromMap(
                map["customerId"] as Map<String, dynamic>),
        placeOfSupply: map["placeOfSupply"]?.toString(),
        billingAddress: map["billingAddress"] == null
            ? null
            : (map["billingAddress"] is String
                ? DeliveryChallanAddress(
                    id: map["billingAddress"].toString(),
                    addressLine1: "",
                    pinCode: 0,
                  )
                : DeliveryChallanAddress.fromMap(
                    map["billingAddress"] as Map<String, dynamic>)),
        shippingAddress: map["shippingAddress"] == null
            ? null
            : (map["shippingAddress"] is String
                ? DeliveryChallanAddress(
                    id: map["shippingAddress"].toString(),
                    addressLine1: "",
                    pinCode: 0,
                  )
                : DeliveryChallanAddress.fromMap(
                    map["shippingAddress"] as Map<String, dynamic>)),
        invoiceIds: List<IdNameModel>.from(
          (map["invoiceIds"] as List<dynamic>?)?.map(
                (x) => IdNameModel.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        salesOrderIds: List<IdNameModel>.from(
          (map["salesOrderIds"] as List<dynamic>?)?.map(
                (x) => IdNameModel.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        paymentTermsId: map["paymentTermsId"] == null
            ? null
            : IdNameModel.fromMap(map["paymentTermsId"]),
        dueDate:
            map["dueDate"] != null ? DateTime.parse(map["dueDate"].toString()) : null,
        taxType: map["taxType"]?.toString(),
        shippingDetails: map["shippingDetails"] == null
            ? null
            : DeliveryChallanShipping.fromMap(
                map["shippingDetails"] as Map<String, dynamic>),
        items: List<DeliveryChallanItem>.from(
          (map["items"] as List<dynamic>?)?.map(
                (x) => DeliveryChallanItem.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        transactionSummary: map["transactionSummary"] == null
            ? null
            : DeliveryChallanSummary.fromMap(
                map["transactionSummary"] as Map<String, dynamic>),
        additionalCharges: List<DeliveryChallanAdditionalCharge>.from(
          (map["additionalCharges"] as List<dynamic>?)?.map(
                (x) => DeliveryChallanAdditionalCharge.fromMap(
                    x as Map<String, dynamic>),
              ) ??
              [],
        ),
        reverseCharge: map["reverseCharge"] as bool? ?? false,
        status: map["status"]?.toString(),
        termsAndConditionIds: List<String>.from(
          (map["termsAndConditionIds"] as List<dynamic>?)?.map(
                (x) => x.toString(),
              ) ??
              [],
        ),
        createdAt: map["createdAt"] != null
            ? DateTime.parse(map["createdAt"].toString())
            : null,
        updatedAt: map["updatedAt"] != null
            ? DateTime.parse(map["updatedAt"].toString())
            : null,
        branchId:
            map["branchId"] == null ? null : IdNameModel.fromMap(map["branchId"]),
        createdFrom: map["createdFrom"]?.toString(),
        paymentTerms: map["paymentTerms"]?.toString(),
        notes: map["notes"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy?.toMap(),
        "updatedBy": updatedBy,
        "companyId": companyId?.toMap(),
        "deliveryChallanNo": deliveryChallanNo,
        "date": date?.toIso8601String(),
        "customerId": customerId?.toMap(),
        "placeOfSupply": placeOfSupply,
        "billingAddress": billingAddress?.toMap(),
        "shippingAddress": shippingAddress?.toMap(),
        "invoiceIds": invoiceIds.map((x) => x.toMap()).toList(),
        "salesOrderIds": salesOrderIds.map((x) => x.toMap()).toList(),
        "paymentTermsId": paymentTermsId?.toMap(),
        "dueDate": dueDate?.toIso8601String(),
        "taxType": taxType,
        "shippingDetails": shippingDetails?.toMap(),
        "items": items.map((x) => x.toMap()).toList(),
        "transactionSummary": transactionSummary?.toMap(),
        "additionalCharges": additionalCharges.map((x) => x.toMap()).toList(),
        "reverseCharge": reverseCharge,
        "status": status,
        "termsAndConditionIds": termsAndConditionIds,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "branchId": branchId?.toMap(),
        "createdFrom": createdFrom,
        "paymentTerms": paymentTerms,
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
        deliveryChallanNo,
        date,
        customerId,
        placeOfSupply,
        billingAddress,
        shippingAddress,
        invoiceIds,
        salesOrderIds,
        paymentTermsId,
        dueDate,
        taxType,
        shippingDetails,
        items,
        transactionSummary,
        additionalCharges,
        reverseCharge,
        status,
        termsAndConditionIds,
        createdAt,
        updatedAt,
        branchId,
        createdFrom,
        paymentTerms,
        notes,
      ];

  @override
  bool get stringify => true;
}

class DeliveryChallanAdditionalCharge extends Equatable {
  final String? chargeId;
  final String? taxId;
  final double amount;
  final double totalAmount;
  final String id;

  const DeliveryChallanAdditionalCharge({
    this.chargeId,
    this.taxId,
    required this.amount,
    required this.totalAmount,
    required this.id,
  });

  DeliveryChallanAdditionalCharge copyWith({
    String? chargeId,
    String? taxId,
    double? amount,
    double? totalAmount,
    String? id,
  }) {
    return DeliveryChallanAdditionalCharge(
      chargeId: chargeId ?? this.chargeId,
      taxId: taxId ?? this.taxId,
      amount: amount ?? this.amount,
      totalAmount: totalAmount ?? this.totalAmount,
      id: id ?? this.id,
    );
  }

  factory DeliveryChallanAdditionalCharge.fromJson(String json) =>
      DeliveryChallanAdditionalCharge.fromMap(
          jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory DeliveryChallanAdditionalCharge.fromMap(Map<String, dynamic> map) =>
      DeliveryChallanAdditionalCharge(
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

class DeliveryChallanAddress extends Equatable {
  final String addressLine1;
  final String? addressLine2;
  final IdNameModel? country;
  final IdNameModel? state;
  final IdNameModel? city;
  final int pinCode;
  final String id;

  const DeliveryChallanAddress({
    required this.addressLine1,
    this.addressLine2,
    this.country,
    this.state,
    this.city,
    required this.pinCode,
    required this.id,
  });

  DeliveryChallanAddress copyWith({
    String? addressLine1,
    String? addressLine2,
    IdNameModel? country,
    IdNameModel? state,
    IdNameModel? city,
    int? pinCode,
    String? id,
  }) {
    return DeliveryChallanAddress(
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      pinCode: pinCode ?? this.pinCode,
      id: id ?? this.id,
    );
  }

  factory DeliveryChallanAddress.fromJson(String json) =>
      DeliveryChallanAddress.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory DeliveryChallanAddress.fromMap(Map<String, dynamic> map) =>
      DeliveryChallanAddress(
        addressLine1: map["addressLine1"]?.toString() ?? "",
        addressLine2: map["addressLine2"]?.toString(),
        country: map["country"] == null ? null : IdNameModel.fromMap(map["country"]),
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

class DeliveryChallanCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const DeliveryChallanCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  DeliveryChallanCreatedBy copyWith({
    String? id,
    String? fullName,
    String? userType,
  }) {
    return DeliveryChallanCreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory DeliveryChallanCreatedBy.fromJson(String json) =>
      DeliveryChallanCreatedBy.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory DeliveryChallanCreatedBy.fromMap(Map<String, dynamic> map) =>
      DeliveryChallanCreatedBy(
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

class DeliveryChallanCustomer extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final DeliveryChallanPhone? phoneNo;
  final List<DeliveryChallanAddress> address;

  const DeliveryChallanCustomer({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phoneNo,
    required this.address,
  });

  DeliveryChallanCustomer copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    DeliveryChallanPhone? phoneNo,
    List<DeliveryChallanAddress>? address,
  }) {
    return DeliveryChallanCustomer(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      address: address ?? this.address,
    );
  }

  factory DeliveryChallanCustomer.fromJson(String json) =>
      DeliveryChallanCustomer.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory DeliveryChallanCustomer.fromMap(Map<String, dynamic> map) =>
      DeliveryChallanCustomer(
        id: map["_id"]?.toString() ?? "",
        firstName: map["firstName"]?.toString() ?? "",
        lastName: map["lastName"]?.toString() ?? "",
        email: map["email"]?.toString(),
        phoneNo: map["phoneNo"] == null
            ? null
            : DeliveryChallanPhone.fromMap(map["phoneNo"] as Map<String, dynamic>),
        address: List<DeliveryChallanAddress>.from(
          (map["address"] as List<dynamic>?)?.map(
                (x) => DeliveryChallanAddress.fromMap(x as Map<String, dynamic>),
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

class DeliveryChallanPhone extends Equatable {
  final String countryCode;
  final int phoneNo;

  const DeliveryChallanPhone({required this.countryCode, required this.phoneNo});

  DeliveryChallanPhone copyWith({String? countryCode, int? phoneNo}) {
    return DeliveryChallanPhone(
      countryCode: countryCode ?? this.countryCode,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }

  factory DeliveryChallanPhone.fromJson(String json) =>
      DeliveryChallanPhone.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory DeliveryChallanPhone.fromMap(Map<String, dynamic> map) =>
      DeliveryChallanPhone(
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

class DeliveryChallanItem extends Equatable {
  final IdNameModel? productId;
  final double qty;
  final double freeQty;
  final String? uomId;
  final String? unit;
  final double price;
  final double discount1;
  final double discount2;
  final DeliveryChallanTax? taxId;
  final double tax;
  final double taxableAmount;
  final double totalAmount;

  const DeliveryChallanItem({
    this.productId,
    required this.qty,
    required this.freeQty,
    this.uomId,
    this.unit,
    required this.price,
    required this.discount1,
    required this.discount2,
    this.taxId,
    required this.tax,
    required this.taxableAmount,
    required this.totalAmount,
  });

  DeliveryChallanItem copyWith({
    IdNameModel? productId,
    double? qty,
    double? freeQty,
    String? uomId,
    String? unit,
    double? price,
    double? discount1,
    double? discount2,
    DeliveryChallanTax? taxId,
    double? tax,
    double? taxableAmount,
    double? totalAmount,
  }) {
    return DeliveryChallanItem(
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      freeQty: freeQty ?? this.freeQty,
      uomId: uomId ?? this.uomId,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      discount1: discount1 ?? this.discount1,
      discount2: discount2 ?? this.discount2,
      taxId: taxId ?? this.taxId,
      tax: tax ?? this.tax,
      taxableAmount: taxableAmount ?? this.taxableAmount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  factory DeliveryChallanItem.fromJson(String json) =>
      DeliveryChallanItem.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory DeliveryChallanItem.fromMap(Map<String, dynamic> map) =>
      DeliveryChallanItem(
        productId:
            map["productId"] == null ? null : IdNameModel.fromMap(map["productId"]),
        qty: (map["qty"] as num? ?? 0).toDouble(),
        freeQty: (map["freeQty"] as num? ?? 0).toDouble(),
        uomId: map["uomId"]?.toString(),
        unit: map["unit"]?.toString(),
        price: (map["price"] as num? ?? 0).toDouble(),
        discount1: (map["discount1"] as num? ?? 0).toDouble(),
        discount2: (map["discount2"] as num? ?? 0).toDouble(),
        taxId: map["taxId"] == null
            ? null
            : DeliveryChallanTax.fromMap(map["taxId"] as Map<String, dynamic>),
        tax: (map["tax"] as num? ?? 0).toDouble(),
        taxableAmount: (map["taxableAmount"] as num? ?? 0).toDouble(),
        totalAmount: (map["totalAmount"] as num? ?? 0).toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "productId": productId?.toMap(),
        "qty": qty,
        "freeQty": freeQty,
        "uomId": uomId,
        "unit": unit,
        "price": price,
        "discount1": discount1,
        "discount2": discount2,
        "taxId": taxId?.toMap(),
        "tax": tax,
        "taxableAmount": taxableAmount,
        "totalAmount": totalAmount,
      };

  @override
  List<Object?> get props => [
        productId,
        qty,
        freeQty,
        uomId,
        unit,
        price,
        discount1,
        discount2,
        taxId,
        tax,
        taxableAmount,
        totalAmount,
      ];

  @override
  bool get stringify => true;
}

class DeliveryChallanTax extends Equatable {
  final String id;
  final String name;
  final double percentage;

  const DeliveryChallanTax({
    required this.id,
    required this.name,
    required this.percentage,
  });

  DeliveryChallanTax copyWith({String? id, String? name, double? percentage}) {
    return DeliveryChallanTax(
      id: id ?? this.id,
      name: name ?? this.name,
      percentage: percentage ?? this.percentage,
    );
  }

  factory DeliveryChallanTax.fromJson(String json) =>
      DeliveryChallanTax.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory DeliveryChallanTax.fromMap(Map<String, dynamic> map) => DeliveryChallanTax(
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

class DeliveryChallanShipping extends Equatable {
  final String shippingType;
  final double weight;
  final String id;
  final DateTime? shippingDate;
  final String? referenceNo;
  final DateTime? transportDate;
  final String? modeOfTransport;
  final String? vehicleNo;
  final String? transporterId;

  const DeliveryChallanShipping({
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

  DeliveryChallanShipping copyWith({
    String? shippingType,
    double? weight,
    String? id,
    DateTime? shippingDate,
    String? referenceNo,
    DateTime? transportDate,
    String? modeOfTransport,
    String? vehicleNo,
    String? transporterId,
  }) {
    return DeliveryChallanShipping(
      shippingType: shippingType ?? this.shippingType,
      weight: weight ?? this.weight,
      id: id ?? this.id,
      shippingDate: shippingDate ?? this.shippingDate,
      referenceNo: referenceNo ?? this.referenceNo,
      transportDate: transportDate ?? this.transportDate,
      modeOfTransport: modeOfTransport ?? this.modeOfTransport,
      vehicleNo: vehicleNo ?? this.vehicleNo,
      transporterId: transporterId ?? this.transporterId,
    );
  }

  factory DeliveryChallanShipping.fromJson(String json) =>
      DeliveryChallanShipping.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory DeliveryChallanShipping.fromMap(Map<String, dynamic> map) =>
      DeliveryChallanShipping(
        shippingType: map["shippingType"]?.toString() ?? "delivery",
        weight: (map["weight"] as num? ?? 0).toDouble(),
        id: map["_id"]?.toString() ?? "",
        shippingDate: map["shippingDate"] != null
            ? DateTime.parse(map["shippingDate"].toString())
            : null,
        referenceNo: map["referenceNo"]?.toString(),
        transportDate: map["transportDate"] != null
            ? DateTime.parse(map["transportDate"].toString())
            : null,
        modeOfTransport: map["modeOfTransport"]?.toString(),
        vehicleNo: map["vehicleNo"]?.toString(),
        transporterId: map["transporterId"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
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

  @override
  List<Object?> get props => [
        shippingType,
        weight,
        id,
        shippingDate,
        referenceNo,
        transportDate,
        modeOfTransport,
        vehicleNo,
        transporterId,
      ];

  @override
  bool get stringify => true;
}

class DeliveryChallanSummary extends Equatable {
  final double flatDiscount;
  final double grossAmount;
  final double discountAmount;
  final double taxableAmount;
  final double taxAmount;
  final double roundOff;
  final double netAmount;
  final String id;

  const DeliveryChallanSummary({
    required this.flatDiscount,
    required this.grossAmount,
    required this.discountAmount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
    required this.id,
  });

  DeliveryChallanSummary copyWith({
    double? flatDiscount,
    double? grossAmount,
    double? discountAmount,
    double? taxableAmount,
    double? taxAmount,
    double? roundOff,
    double? netAmount,
    String? id,
  }) {
    return DeliveryChallanSummary(
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

  factory DeliveryChallanSummary.fromJson(String json) =>
      DeliveryChallanSummary.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory DeliveryChallanSummary.fromMap(Map<String, dynamic> map) =>
      DeliveryChallanSummary(
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
