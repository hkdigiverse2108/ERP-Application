import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class SalesCreditNoteModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final SalesCreditNoteCreatedBy? createdBy;
  final String? updatedBy;
  final IdNameModel? companyId;
  final SalesCreditNoteCustomer? customerId;
  final String? placeOfSupply;
  final SalesCreditNoteAddress? billingAddress;
  final SalesCreditNoteAddress? shippingAddress;
  final DateTime? creditNoteDate;
  final String? creditNoteNo;
  final DateTime? dueDate;
  final String? reason;
  final bool reverseCharge;
  final String? sez;
  final bool paymentReminder;
  final String? productType;
  final dynamic productDetails;
  final dynamic additionalCharges;
  final List<SalesCreditNoteTerms> termsAndConditionIds;
  final String? notes;
  final SalesCreditNoteShipping? shippingDetails;
  final SalesCreditNoteSummary? summary;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? salesManId;
  final String? salesId;
  final String? accountLedgerId;

  const SalesCreditNoteModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    this.customerId,
    this.placeOfSupply,
    this.billingAddress,
    this.shippingAddress,
    this.creditNoteDate,
    this.creditNoteNo,
    this.dueDate,
    this.reason,
    required this.reverseCharge,
    this.sez,
    required this.paymentReminder,
    this.productType,
    this.productDetails,
    this.additionalCharges,
    required this.termsAndConditionIds,
    this.notes,
    this.shippingDetails,
    this.summary,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.salesManId,
    this.salesId,
    this.accountLedgerId,
  });

  SalesCreditNoteModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    SalesCreditNoteCreatedBy? createdBy,
    String? updatedBy,
    IdNameModel? companyId,
    SalesCreditNoteCustomer? customerId,
    String? placeOfSupply,
    SalesCreditNoteAddress? billingAddress,
    SalesCreditNoteAddress? shippingAddress,
    DateTime? creditNoteDate,
    String? creditNoteNo,
    DateTime? dueDate,
    String? reason,
    bool? reverseCharge,
    String? sez,
    bool? paymentReminder,
    String? productType,
    dynamic productDetails,
    dynamic additionalCharges,
    List<SalesCreditNoteTerms>? termsAndConditionIds,
    String? notes,
    SalesCreditNoteShipping? shippingDetails,
    SalesCreditNoteSummary? summary,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? salesManId,
    String? salesId,
    String? accountLedgerId,
  }) {
    return SalesCreditNoteModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      customerId: customerId ?? this.customerId,
      placeOfSupply: placeOfSupply ?? this.placeOfSupply,
      billingAddress: billingAddress ?? this.billingAddress,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      creditNoteDate: creditNoteDate ?? this.creditNoteDate,
      creditNoteNo: creditNoteNo ?? this.creditNoteNo,
      dueDate: dueDate ?? this.dueDate,
      reason: reason ?? this.reason,
      reverseCharge: reverseCharge ?? this.reverseCharge,
      sez: sez ?? this.sez,
      paymentReminder: paymentReminder ?? this.paymentReminder,
      productType: productType ?? this.productType,
      productDetails: productDetails ?? this.productDetails,
      additionalCharges: additionalCharges ?? this.additionalCharges,
      termsAndConditionIds: termsAndConditionIds ?? this.termsAndConditionIds,
      notes: notes ?? this.notes,
      shippingDetails: shippingDetails ?? this.shippingDetails,
      summary: summary ?? this.summary,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      salesManId: salesManId ?? this.salesManId,
      salesId: salesId ?? this.salesId,
      accountLedgerId: accountLedgerId ?? this.accountLedgerId,
    );
  }

  factory SalesCreditNoteModel.fromJson(String json) =>
      SalesCreditNoteModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesCreditNoteModel.fromMap(Map<String, dynamic> map) =>
      SalesCreditNoteModel(
        id: map["_id"]?.toString() ?? "",
        isDeleted: map["isDeleted"] as bool? ?? false,
        isActive: map["isActive"] as bool? ?? true,
        createdBy: map["createdBy"] == null
            ? null
            : SalesCreditNoteCreatedBy.fromMap(
                map["createdBy"] as Map<String, dynamic>),
        updatedBy: map["updatedBy"] is Map
            ? map["updatedBy"]["_id"]?.toString()
            : map["updatedBy"]?.toString(),
        companyId:
            map["companyId"] == null ? null : IdNameModel.fromMap(map["companyId"]),
        customerId: map["customerId"] == null
            ? null
            : SalesCreditNoteCustomer.fromMap(
                map["customerId"] as Map<String, dynamic>),
        placeOfSupply: map["placeOfSupply"]?.toString(),
        billingAddress: map["billingAddress"] == null
            ? null
            : SalesCreditNoteAddress.fromMap(
                map["billingAddress"] as Map<String, dynamic>),
        shippingAddress: map["shippingAddress"] == null
            ? null
            : SalesCreditNoteAddress.fromMap(
                map["shippingAddress"] as Map<String, dynamic>),
        creditNoteDate: map["creditNoteDate"] != null
            ? DateTime.parse(map["creditNoteDate"].toString())
            : null,
        creditNoteNo: map["creditNoteNo"]?.toString(),
        dueDate:
            map["dueDate"] != null ? DateTime.parse(map["dueDate"].toString()) : null,
        reason: map["reason"]?.toString(),
        reverseCharge: map["reverseCharge"] as bool? ?? false,
        sez: map["sez"]?.toString(),
        paymentReminder: map["paymentReminder"] as bool? ?? false,
        productType: map["productType"]?.toString(),
        productDetails: map["productDetails"],
        additionalCharges: map["additionalCharges"],
        termsAndConditionIds: List<SalesCreditNoteTerms>.from(
          (map["termsAndConditionIds"] as List<dynamic>?)?.map(
                (x) => SalesCreditNoteTerms.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        notes: map["notes"]?.toString(),
        shippingDetails: map["shippingDetails"] == null
            ? null
            : SalesCreditNoteShipping.fromMap(
                map["shippingDetails"] as Map<String, dynamic>),
        summary: map["summary"] == null
            ? null
            : SalesCreditNoteSummary.fromMap(map["summary"] as Map<String, dynamic>),
        status: map["status"]?.toString(),
        createdAt: map["createdAt"] != null
            ? DateTime.parse(map["createdAt"].toString())
            : null,
        updatedAt: map["updatedAt"] != null
            ? DateTime.parse(map["updatedAt"].toString())
            : null,
        salesManId: map["salesManId"] is Map
            ? map["salesManId"]["_id"]?.toString()
            : map["salesManId"]?.toString(),
        salesId: map["salesId"] is Map
            ? map["salesId"]["_id"]?.toString()
            : map["salesId"]?.toString(),
        accountLedgerId: map["accountLedgerId"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy?.toMap(),
        "updatedBy": updatedBy,
        "companyId": companyId?.toMap(),
        "customerId": customerId?.toMap(),
        "placeOfSupply": placeOfSupply,
        "billingAddress": billingAddress?.toMap(),
        "shippingAddress": shippingAddress?.toMap(),
        "creditNoteDate": creditNoteDate?.toIso8601String(),
        "creditNoteNo": creditNoteNo,
        "dueDate": dueDate?.toIso8601String(),
        "reason": reason,
        "reverseCharge": reverseCharge,
        "sez": sez,
        "paymentReminder": paymentReminder,
        "productType": productType,
        "productDetails": productDetails,
        "additionalCharges": additionalCharges,
        "termsAndConditionIds": termsAndConditionIds.map((x) => x.toMap()).toList(),
        "notes": notes,
        "shippingDetails": shippingDetails?.toMap(),
        "summary": summary?.toMap(),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "salesManId": salesManId,
        "salesId": salesId,
        "accountLedgerId": accountLedgerId,
      };

  @override
  List<Object?> get props => [
        id,
        isDeleted,
        isActive,
        createdBy,
        updatedBy,
        companyId,
        customerId,
        placeOfSupply,
        billingAddress,
        shippingAddress,
        creditNoteDate,
        creditNoteNo,
        dueDate,
        reason,
        reverseCharge,
        sez,
        paymentReminder,
        productType,
        productDetails,
        additionalCharges,
        termsAndConditionIds,
        notes,
        shippingDetails,
        summary,
        status,
        createdAt,
        updatedAt,
        salesManId,
        salesId,
        accountLedgerId,
      ];

  @override
  bool get stringify => true;
}

class SalesCreditNoteAddress extends Equatable {
  final String addressLine1;
  final String? addressLine2;
  final IdNameModel? country;
  final IdNameModel? state;
  final IdNameModel? city;
  final int pinCode;
  final String id;

  const SalesCreditNoteAddress({
    required this.addressLine1,
    this.addressLine2,
    this.country,
    this.state,
    this.city,
    required this.pinCode,
    required this.id,
  });

  SalesCreditNoteAddress copyWith({
    String? addressLine1,
    String? addressLine2,
    IdNameModel? country,
    IdNameModel? state,
    IdNameModel? city,
    int? pinCode,
    String? id,
  }) {
    return SalesCreditNoteAddress(
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      pinCode: pinCode ?? this.pinCode,
      id: id ?? this.id,
    );
  }

  factory SalesCreditNoteAddress.fromJson(String json) =>
      SalesCreditNoteAddress.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesCreditNoteAddress.fromMap(Map<String, dynamic> map) => SalesCreditNoteAddress(
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

class SalesCreditNoteCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const SalesCreditNoteCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  SalesCreditNoteCreatedBy copyWith({
    String? id,
    String? fullName,
    String? userType,
  }) {
    return SalesCreditNoteCreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory SalesCreditNoteCreatedBy.fromJson(String json) =>
      SalesCreditNoteCreatedBy.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesCreditNoteCreatedBy.fromMap(Map<String, dynamic> map) =>
      SalesCreditNoteCreatedBy(
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

class SalesCreditNoteCustomer extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final SalesCreditNotePhone? phoneNo;
  final List<SalesCreditNoteAddress> address;

  const SalesCreditNoteCustomer({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phoneNo,
    required this.address,
  });

  SalesCreditNoteCustomer copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    SalesCreditNotePhone? phoneNo,
    List<SalesCreditNoteAddress>? address,
  }) {
    return SalesCreditNoteCustomer(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      address: address ?? this.address,
    );
  }

  factory SalesCreditNoteCustomer.fromJson(String json) =>
      SalesCreditNoteCustomer.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesCreditNoteCustomer.fromMap(Map<String, dynamic> map) => SalesCreditNoteCustomer(
        id: map["_id"]?.toString() ?? "",
        firstName: map["firstName"]?.toString() ?? "",
        lastName: map["lastName"]?.toString() ?? "",
        email: map["email"]?.toString(),
        phoneNo: map["phoneNo"] == null
            ? null
            : SalesCreditNotePhone.fromMap(map["phoneNo"] as Map<String, dynamic>),
        address: List<SalesCreditNoteAddress>.from(
          (map["address"] as List<dynamic>?)?.map(
                (x) => SalesCreditNoteAddress.fromMap(x as Map<String, dynamic>),
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

class SalesCreditNotePhone extends Equatable {
  final String countryCode;
  final int phoneNo;

  const SalesCreditNotePhone({required this.countryCode, required this.phoneNo});

  SalesCreditNotePhone copyWith({String? countryCode, int? phoneNo}) {
    return SalesCreditNotePhone(
      countryCode: countryCode ?? this.countryCode,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }

  factory SalesCreditNotePhone.fromJson(String json) =>
      SalesCreditNotePhone.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesCreditNotePhone.fromMap(Map<String, dynamic> map) => SalesCreditNotePhone(
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

class SalesCreditNoteShipping extends Equatable {
  final String shippingType;
  final double weight;
  final String? id;

  const SalesCreditNoteShipping({
    required this.shippingType,
    required this.weight,
    this.id,
  });

  SalesCreditNoteShipping copyWith({
    String? shippingType,
    double? weight,
    String? id,
  }) {
    return SalesCreditNoteShipping(
      shippingType: shippingType ?? this.shippingType,
      weight: weight ?? this.weight,
      id: id ?? this.id,
    );
  }

  factory SalesCreditNoteShipping.fromJson(String json) =>
      SalesCreditNoteShipping.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesCreditNoteShipping.fromMap(Map<String, dynamic> map) =>
      SalesCreditNoteShipping(
        shippingType: map["shippingType"]?.toString() ?? "delivery",
        weight: (map["weight"] as num? ?? 0).toDouble(),
        id: map["_id"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
        "shippingType": shippingType,
        "weight": weight,
        "_id": id,
      };

  @override
  List<Object?> get props => [shippingType, weight, id];

  @override
  bool get stringify => true;
}

class SalesCreditNoteTerms extends Equatable {
  final String id;
  final String? termsCondition;

  const SalesCreditNoteTerms({required this.id, this.termsCondition});

  SalesCreditNoteTerms copyWith({String? id, String? termsCondition}) {
    return SalesCreditNoteTerms(
      id: id ?? this.id,
      termsCondition: termsCondition ?? this.termsCondition,
    );
  }

  factory SalesCreditNoteTerms.fromJson(String json) =>
      SalesCreditNoteTerms.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesCreditNoteTerms.fromMap(Map<String, dynamic> map) => SalesCreditNoteTerms(
        id: map["_id"]?.toString() ?? "",
        termsCondition: map["termsCondition"]?.toString(),
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

class SalesCreditNoteSummary extends Equatable {
  final double flatDiscount;
  final double grossAmount;
  final double discountAmount;
  final double taxableAmount;
  final double taxAmount;
  final double roundOff;
  final double netAmount;
  final String id;

  const SalesCreditNoteSummary({
    required this.flatDiscount,
    required this.grossAmount,
    required this.discountAmount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
    required this.id,
  });

  SalesCreditNoteSummary copyWith({
    double? flatDiscount,
    double? grossAmount,
    double? discountAmount,
    double? taxableAmount,
    double? taxAmount,
    double? roundOff,
    double? netAmount,
    String? id,
  }) {
    return SalesCreditNoteSummary(
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

  factory SalesCreditNoteSummary.fromJson(String json) =>
      SalesCreditNoteSummary.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SalesCreditNoteSummary.fromMap(Map<String, dynamic> map) => SalesCreditNoteSummary(
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
