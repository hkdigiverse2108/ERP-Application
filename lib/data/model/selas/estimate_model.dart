import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class EstimateModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final EstimateCreatedBy? createdBy;
  final String? updatedBy;
  final IdNameModel? companyId;
  final String? estimateNo;
  final DateTime? date;
  final DateTime? dueDate;
  final String? placeOfSupply;
  final EstimateAddress? billingAddress;
  final EstimateAddress? shippingAddress;
  final EstimateCustomer? customerId;
  final List<EstimateItem> items;
  final List<EstimateTerms> termsAndConditionIds;
  final bool reverseCharge;
  final String? status;
  final EstimateSummary? transactionSummary;
  final List<EstimateAdditionalCharge> additionalCharges;
  final IdNameModel? paymentTermsId;
  final String? taxType;
  final EstimateShipping? shippingDetails;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? sez;
  final String? paymentTerms;
  final String? notes;

  const EstimateModel({
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

  EstimateModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    EstimateCreatedBy? createdBy,
    String? updatedBy,
    IdNameModel? companyId,
    String? estimateNo,
    DateTime? date,
    DateTime? dueDate,
    String? placeOfSupply,
    EstimateAddress? billingAddress,
    EstimateAddress? shippingAddress,
    EstimateCustomer? customerId,
    List<EstimateItem>? items,
    List<EstimateTerms>? termsAndConditionIds,
    bool? reverseCharge,
    String? status,
    EstimateSummary? transactionSummary,
    List<EstimateAdditionalCharge>? additionalCharges,
    IdNameModel? paymentTermsId,
    String? taxType,
    EstimateShipping? shippingDetails,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? sez,
    String? paymentTerms,
    String? notes,
  }) {
    return EstimateModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      estimateNo: estimateNo ?? this.estimateNo,
      date: date ?? this.date,
      dueDate: dueDate ?? this.dueDate,
      placeOfSupply: placeOfSupply ?? this.placeOfSupply,
      billingAddress: billingAddress ?? this.billingAddress,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      customerId: customerId ?? this.customerId,
      items: items ?? this.items,
      termsAndConditionIds: termsAndConditionIds ?? this.termsAndConditionIds,
      reverseCharge: reverseCharge ?? this.reverseCharge,
      status: status ?? this.status,
      transactionSummary: transactionSummary ?? this.transactionSummary,
      additionalCharges: additionalCharges ?? this.additionalCharges,
      paymentTermsId: paymentTermsId ?? this.paymentTermsId,
      taxType: taxType ?? this.taxType,
      shippingDetails: shippingDetails ?? this.shippingDetails,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sez: sez ?? this.sez,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      notes: notes ?? this.notes,
    );
  }

  factory EstimateModel.fromJson(String json) =>
      EstimateModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory EstimateModel.fromMap(Map<String, dynamic> map) => EstimateModel(
        id: map["_id"]?.toString() ?? "",
        isDeleted: map["isDeleted"] as bool? ?? false,
        isActive: map["isActive"] as bool? ?? true,
        createdBy: map["createdBy"] == null
            ? null
            : (map["createdBy"] is String
                ? EstimateCreatedBy(id: map["createdBy"], fullName: "", userType: "")
                : EstimateCreatedBy.fromMap(
                    map["createdBy"] as Map<String, dynamic>)),
        updatedBy: map["updatedBy"]?.toString(),
        companyId:
            map["companyId"] == null ? null : IdNameModel.fromMap(map["companyId"]),
        estimateNo: map["estimateNo"]?.toString(),
        date: map["date"] != null ? DateTime.parse(map["date"].toString()) : null,
        dueDate:
            map["dueDate"] != null ? DateTime.parse(map["dueDate"].toString()) : null,
        placeOfSupply: map["placeOfSupply"]?.toString(),
        billingAddress: map["billingAddress"] == null
            ? null
            : EstimateAddress.fromMap(map["billingAddress"] as Map<String, dynamic>),
        shippingAddress: map["shippingAddress"] == null
            ? null
            : EstimateAddress.fromMap(
                map["shippingAddress"] as Map<String, dynamic>),
        customerId: map["customerId"] == null
            ? null
            : EstimateCustomer.fromMap(map["customerId"] as Map<String, dynamic>),
        items: List<EstimateItem>.from(
          (map["items"] as List<dynamic>?)?.map(
                (x) => EstimateItem.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        termsAndConditionIds: List<EstimateTerms>.from(
          (map["termsAndConditionIds"] as List<dynamic>?)?.map(
                (x) => x is String
                    ? EstimateTerms(id: x, termsCondition: "")
                    : EstimateTerms.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        reverseCharge: map["reverseCharge"] as bool? ?? false,
        status: map["status"]?.toString(),
        transactionSummary: map["transactionSummary"] == null
            ? (map["transectionSummary"] == null
                ? null
                : EstimateSummary.fromMap(
                    map["transectionSummary"] as Map<String, dynamic>))
            : EstimateSummary.fromMap(
                map["transactionSummary"] as Map<String, dynamic>),
        paymentTermsId: map["paymentTermsId"] == null
            ? null
            : IdNameModel.fromMap(map["paymentTermsId"]),
        taxType: map["taxType"]?.toString(),
        additionalCharges: List<EstimateAdditionalCharge>.from(
          (map["additionalCharges"] as List<dynamic>?)?.map(
                (x) => EstimateAdditionalCharge.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        shippingDetails: map["shippingDetails"] == null
            ? null
            : EstimateShipping.fromMap(
                map["shippingDetails"] as Map<String, dynamic>),
        createdAt: map["createdAt"] != null
            ? DateTime.parse(map["createdAt"].toString())
            : null,
        updatedAt: map["updatedAt"] != null
            ? DateTime.parse(map["updatedAt"].toString())
            : null,
        sez: map["sez"]?.toString(),
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
        "estimateNo": estimateNo,
        "date": date?.toIso8601String(),
        "dueDate": dueDate?.toIso8601String(),
        "placeOfSupply": placeOfSupply,
        "billingAddress": billingAddress?.toMap(),
        "shippingAddress": shippingAddress?.toMap(),
        "customerId": customerId?.toMap(),
        "items": items.map((x) => x.toMap()).toList(),
        "termsAndConditionIds":
            termsAndConditionIds.map((x) => x.toMap()).toList(),
        "reverseCharge": reverseCharge,
        "status": status,
        "transactionSummary": transactionSummary?.toMap(),
        "additionalCharges": additionalCharges.map((x) => x.toMap()).toList(),
        "paymentTermsId": paymentTermsId?.toMap(),
        "taxType": taxType,
        "shippingDetails": shippingDetails?.toMap(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "sez": sez,
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
        estimateNo,
        date,
        dueDate,
        placeOfSupply,
        billingAddress,
        shippingAddress,
        customerId,
        items,
        termsAndConditionIds,
        reverseCharge,
        status,
        transactionSummary,
        additionalCharges,
        paymentTermsId,
        taxType,
        shippingDetails,
        createdAt,
        updatedAt,
        sez,
        paymentTerms,
        notes,
      ];

  @override
  bool get stringify => true;
}

class EstimateAdditionalCharge extends Equatable {
  final String? chargeId;
  final String? taxId;
  final double amount;
  final double totalAmount;
  final String id;

  const EstimateAdditionalCharge({
    this.chargeId,
    this.taxId,
    required this.amount,
    required this.totalAmount,
    required this.id,
  });

  EstimateAdditionalCharge copyWith({
    String? chargeId,
    String? taxId,
    double? amount,
    double? totalAmount,
    String? id,
  }) {
    return EstimateAdditionalCharge(
      chargeId: chargeId ?? this.chargeId,
      taxId: taxId ?? this.taxId,
      amount: amount ?? this.amount,
      totalAmount: totalAmount ?? this.totalAmount,
      id: id ?? this.id,
    );
  }

  factory EstimateAdditionalCharge.fromJson(String json) =>
      EstimateAdditionalCharge.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory EstimateAdditionalCharge.fromMap(Map<String, dynamic> map) =>
      EstimateAdditionalCharge(
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

class EstimateTax extends Equatable {
  final String id;
  final String name;
  final double percentage;

  const EstimateTax({
    required this.id,
    required this.name,
    required this.percentage,
  });

  EstimateTax copyWith({String? id, String? name, double? percentage}) {
    return EstimateTax(
      id: id ?? this.id,
      name: name ?? this.name,
      percentage: percentage ?? this.percentage,
    );
  }

  factory EstimateTax.fromJson(String json) =>
      EstimateTax.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory EstimateTax.fromMap(Map<String, dynamic> map) => EstimateTax(
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

class EstimateAddress extends Equatable {
  final String addressLine1;
  final String? addressLine2;
  final IdNameModel? country;
  final IdNameModel? state;
  final IdNameModel? city;
  final int pinCode;
  final String id;

  const EstimateAddress({
    required this.addressLine1,
    this.addressLine2,
    this.country,
    this.state,
    this.city,
    required this.pinCode,
    required this.id,
  });

  EstimateAddress copyWith({
    String? addressLine1,
    String? addressLine2,
    IdNameModel? country,
    IdNameModel? state,
    IdNameModel? city,
    int? pinCode,
    String? id,
  }) {
    return EstimateAddress(
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      pinCode: pinCode ?? this.pinCode,
      id: id ?? this.id,
    );
  }

  factory EstimateAddress.fromJson(String json) =>
      EstimateAddress.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory EstimateAddress.fromMap(Map<String, dynamic> map) => EstimateAddress(
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

class EstimateCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const EstimateCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  EstimateCreatedBy copyWith({
    String? id,
    String? fullName,
    String? userType,
  }) {
    return EstimateCreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory EstimateCreatedBy.fromJson(String json) =>
      EstimateCreatedBy.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory EstimateCreatedBy.fromMap(Map<String, dynamic> map) => EstimateCreatedBy(
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

class EstimateCustomer extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final EstimatePhone? phoneNo;
  final List<EstimateAddress> address;

  const EstimateCustomer({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phoneNo,
    required this.address,
  });

  EstimateCustomer copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    EstimatePhone? phoneNo,
    List<EstimateAddress>? address,
  }) {
    return EstimateCustomer(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      address: address ?? this.address,
    );
  }

  factory EstimateCustomer.fromJson(String json) =>
      EstimateCustomer.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory EstimateCustomer.fromMap(Map<String, dynamic> map) => EstimateCustomer(
        id: map["_id"]?.toString() ?? "",
        firstName: map["firstName"]?.toString() ?? "",
        lastName: map["lastName"]?.toString() ?? "",
        email: map["email"]?.toString(),
        phoneNo: map["phoneNo"] == null
            ? null
            : EstimatePhone.fromMap(map["phoneNo"] as Map<String, dynamic>),
        address: List<EstimateAddress>.from(
          (map["address"] as List<dynamic>?)?.map(
                (x) => EstimateAddress.fromMap(x as Map<String, dynamic>),
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

class EstimatePhone extends Equatable {
  final String countryCode;
  final int phoneNo;

  const EstimatePhone({required this.countryCode, required this.phoneNo});

  EstimatePhone copyWith({String? countryCode, int? phoneNo}) {
    return EstimatePhone(
      countryCode: countryCode ?? this.countryCode,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }

  factory EstimatePhone.fromJson(String json) =>
      EstimatePhone.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory EstimatePhone.fromMap(Map<String, dynamic> map) => EstimatePhone(
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

class EstimateItem extends Equatable {
  final IdNameModel? productId;
  final double qty;
  final double freeQty;
  final IdNameModel? uomId;
  final String? unit;
  final double price;
  final double discount1;
  final double discount2;
  final EstimateTax? taxId;
  final double? tax;
  final double taxableAmount;
  final double totalAmount;

  const EstimateItem({
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

  EstimateItem copyWith({
    IdNameModel? productId,
    double? qty,
    double? freeQty,
    IdNameModel? uomId,
    String? unit,
    double? price,
    double? discount1,
    double? discount2,
    EstimateTax? taxId,
    double? tax,
    double? taxableAmount,
    double? totalAmount,
  }) {
    return EstimateItem(
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

  factory EstimateItem.fromJson(String json) =>
      EstimateItem.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory EstimateItem.fromMap(Map<String, dynamic> map) => EstimateItem(
        productId:
            map["productId"] == null ? null : IdNameModel.fromMap(map["productId"]),
        qty: (map["qty"] as num? ?? 0).toDouble(),
        freeQty: (map["freeQty"] as num? ?? 0).toDouble(),
        uomId: map["uomId"] == null ? null : IdNameModel.fromMap(map["uomId"]),
        unit: map["unit"]?.toString(),
        price: (map["price"] as num? ?? 0).toDouble(),
        discount1: (map["discount1"] as num? ?? 0).toDouble(),
        discount2: (map["discount2"] as num? ?? 0).toDouble(),
        taxId: map["taxId"] == null
            ? null
            : EstimateTax.fromMap(map["taxId"] as Map<String, dynamic>),
        tax: (map["tax"] as num? ?? 0).toDouble(),
        taxableAmount: (map["taxableAmount"] as num? ?? 0).toDouble(),
        totalAmount: (map["totalAmount"] as num? ?? 0).toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "productId": productId?.toMap(),
        "qty": qty,
        "freeQty": freeQty,
        "uomId": uomId?.toMap(),
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

class EstimateShipping extends Equatable {
  final String shippingType;
  final double weight;
  final String id;
  final DateTime? shippingDate;
  final String? referenceNo;
  final DateTime? transportDate;
  final String? modeOfTransport;
  final String? transporterId;
  final String? vehicleNo;

  const EstimateShipping({
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

  EstimateShipping copyWith({
    String? shippingType,
    double? weight,
    String? id,
    DateTime? shippingDate,
    String? referenceNo,
    DateTime? transportDate,
    String? modeOfTransport,
    String? transporterId,
    String? vehicleNo,
  }) {
    return EstimateShipping(
      shippingType: shippingType ?? this.shippingType,
      weight: weight ?? this.weight,
      id: id ?? this.id,
      shippingDate: shippingDate ?? this.shippingDate,
      referenceNo: referenceNo ?? this.referenceNo,
      transportDate: transportDate ?? this.transportDate,
      modeOfTransport: modeOfTransport ?? this.modeOfTransport,
      transporterId: transporterId ?? this.transporterId,
      vehicleNo: vehicleNo ?? this.vehicleNo,
    );
  }

  factory EstimateShipping.fromJson(String json) =>
      EstimateShipping.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory EstimateShipping.fromMap(Map<String, dynamic> map) => EstimateShipping(
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
        transporterId: map["transporterId"]?.toString(),
        vehicleNo: map["vehicleNo"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
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

  @override
  List<Object?> get props => [
        shippingType,
        weight,
        id,
        shippingDate,
        referenceNo,
        transportDate,
        modeOfTransport,
        transporterId,
        vehicleNo,
      ];

  @override
  bool get stringify => true;
}

class EstimateTerms extends Equatable {
  final String id;
  final String termsCondition;

  const EstimateTerms({required this.id, required this.termsCondition});

  EstimateTerms copyWith({String? id, String? termsCondition}) {
    return EstimateTerms(
      id: id ?? this.id,
      termsCondition: termsCondition ?? this.termsCondition,
    );
  }

  factory EstimateTerms.fromJson(String json) =>
      EstimateTerms.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory EstimateTerms.fromMap(Map<String, dynamic> map) => EstimateTerms(
        id: map["_id"]?.toString() ?? "",
        termsCondition: map["termsCondition"]?.toString() ?? "",
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "termsCondition": termsCondition,
      };

  @override
  List<Object?> get props => [id, termsCondition];

  @override
  bool get stringify => true;
}

class EstimateSummary extends Equatable {
  final double flatDiscount;
  final double grossAmount;
  final double discountAmount;
  final double taxableAmount;
  final double taxAmount;
  final double roundOff;
  final double netAmount;
  final String id;

  const EstimateSummary({
    required this.flatDiscount,
    required this.grossAmount,
    required this.discountAmount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
    required this.id,
  });

  EstimateSummary copyWith({
    double? flatDiscount,
    double? grossAmount,
    double? discountAmount,
    double? taxableAmount,
    double? taxAmount,
    double? roundOff,
    double? netAmount,
    String? id,
  }) {
    return EstimateSummary(
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

  factory EstimateSummary.fromJson(String json) =>
      EstimateSummary.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory EstimateSummary.fromMap(Map<String, dynamic> map) => EstimateSummary(
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
