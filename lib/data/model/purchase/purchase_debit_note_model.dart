import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class PurchaseDebitNoteModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final PurchaseDebitNoteCreatedBy? createdBy;
  final String? updatedBy;
  final IdNameModel? companyId;
  final PurchaseDebitNoteSupplier? supplierId;
  final PurchaseDebitNoteAddress? billingAddress;
  final PurchaseDebitNoteAddress? shippingAddress;
  final String? debitNoteNo;
  final DateTime? debitNoteDate;
  final DateTime? dueDate;
  final PurchaseDebitNotePaymentTerms? paymentTermsId;
  final String? purchaseId;
  final bool reverseCharge;
  final dynamic productDetails;
  final dynamic additionalCharges;
  final List<String> termsAndConditionIds;
  final PurchaseDebitNoteShipping? shippingDetails;
  final PurchaseDebitNoteSummary? summary;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? branchId;
  final String? placeOfSupply;
  final String? referenceBillNo;
  final DateTime? shippingDate;
  final String? reason;
  final String? paymentTerm;
  final String? exportSez;
  final String? notes;
  final String? accountLedgerId;

  const PurchaseDebitNoteModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    this.supplierId,
    this.billingAddress,
    this.shippingAddress,
    this.debitNoteNo,
    this.debitNoteDate,
    this.dueDate,
    this.paymentTermsId,
    this.purchaseId,
    required this.reverseCharge,
    this.productDetails,
    this.additionalCharges,
    required this.termsAndConditionIds,
    this.shippingDetails,
    this.summary,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.branchId,
    this.placeOfSupply,
    this.referenceBillNo,
    this.shippingDate,
    this.reason,
    this.paymentTerm,
    this.exportSez,
    this.notes,
    this.accountLedgerId,
  });

  PurchaseDebitNoteModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    PurchaseDebitNoteCreatedBy? createdBy,
    String? updatedBy,
    IdNameModel? companyId,
    PurchaseDebitNoteSupplier? supplierId,
    PurchaseDebitNoteAddress? billingAddress,
    PurchaseDebitNoteAddress? shippingAddress,
    String? debitNoteNo,
    DateTime? debitNoteDate,
    DateTime? dueDate,
    PurchaseDebitNotePaymentTerms? paymentTermsId,
    String? purchaseId,
    bool? reverseCharge,
    dynamic productDetails,
    dynamic additionalCharges,
    List<String>? termsAndConditionIds,
    PurchaseDebitNoteShipping? shippingDetails,
    PurchaseDebitNoteSummary? summary,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? branchId,
    String? placeOfSupply,
    String? referenceBillNo,
    DateTime? shippingDate,
    String? reason,
    String? paymentTerm,
    String? exportSez,
    String? notes,
    String? accountLedgerId,
  }) {
    return PurchaseDebitNoteModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      supplierId: supplierId ?? this.supplierId,
      billingAddress: billingAddress ?? this.billingAddress,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      debitNoteNo: debitNoteNo ?? this.debitNoteNo,
      debitNoteDate: debitNoteDate ?? this.debitNoteDate,
      dueDate: dueDate ?? this.dueDate,
      paymentTermsId: paymentTermsId ?? this.paymentTermsId,
      purchaseId: purchaseId ?? this.purchaseId,
      reverseCharge: reverseCharge ?? this.reverseCharge,
      productDetails: productDetails ?? this.productDetails,
      additionalCharges: additionalCharges ?? this.additionalCharges,
      termsAndConditionIds: termsAndConditionIds ?? this.termsAndConditionIds,
      shippingDetails: shippingDetails ?? this.shippingDetails,
      summary: summary ?? this.summary,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      branchId: branchId ?? this.branchId,
      placeOfSupply: placeOfSupply ?? this.placeOfSupply,
      referenceBillNo: referenceBillNo ?? this.referenceBillNo,
      shippingDate: shippingDate ?? this.shippingDate,
      reason: reason ?? this.reason,
      paymentTerm: paymentTerm ?? this.paymentTerm,
      exportSez: exportSez ?? this.exportSez,
      notes: notes ?? this.notes,
      accountLedgerId: accountLedgerId ?? this.accountLedgerId,
    );
  }

  factory PurchaseDebitNoteModel.fromJson(String json) =>
      PurchaseDebitNoteModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory PurchaseDebitNoteModel.fromMap(Map<String, dynamic> map) =>
      PurchaseDebitNoteModel(
        id: map["_id"]?.toString() ?? "",
        isDeleted: map["isDeleted"] as bool? ?? false,
        isActive: map["isActive"] as bool? ?? true,
        createdBy: map["createdBy"] == null
            ? null
            : PurchaseDebitNoteCreatedBy.fromMap(
                map["createdBy"] as Map<String, dynamic>),
        updatedBy: map["updatedBy"]?.toString(),
        companyId:
            map["companyId"] == null ? null : IdNameModel.fromMap(map["companyId"]),
        supplierId: map["supplierId"] == null
            ? null
            : PurchaseDebitNoteSupplier.fromMap(
                map["supplierId"] as Map<String, dynamic>),
        billingAddress: map["billingAddress"] == null
            ? null
            : PurchaseDebitNoteAddress.fromMap(
                map["billingAddress"] as Map<String, dynamic>),
        shippingAddress: map["shippingAddress"] == null
            ? null
            : PurchaseDebitNoteAddress.fromMap(
                map["shippingAddress"] as Map<String, dynamic>),
        debitNoteNo: map["debitNoteNo"]?.toString(),
        debitNoteDate: map["debitNoteDate"] != null
            ? DateTime.parse(map["debitNoteDate"].toString())
            : null,
        dueDate:
            map["dueDate"] != null ? DateTime.parse(map["dueDate"].toString()) : null,
        paymentTermsId: map["paymentTermsId"] == null
            ? null
            : PurchaseDebitNotePaymentTerms.fromMap(
                map["paymentTermsId"] as Map<String, dynamic>),
        purchaseId: map["purchaseId"] is Map
            ? map["purchaseId"]["_id"]?.toString()
            : map["purchaseId"]?.toString(),
        reverseCharge: map["reverseCharge"] as bool? ?? false,
        productDetails: map["productDetails"],
        additionalCharges: map["additionalCharges"],
        termsAndConditionIds: List<String>.from(
          (map["termsAndConditionIds"] as List<dynamic>?)?.map((x) => x.toString()) ??
              [],
        ),
        shippingDetails: map["shippingDetails"] == null
            ? null
            : PurchaseDebitNoteShipping.fromMap(
                map["shippingDetails"] as Map<String, dynamic>),
        summary: map["summary"] == null
            ? null
            : PurchaseDebitNoteSummary.fromMap(
                map["summary"] as Map<String, dynamic>),
        status: map["status"]?.toString(),
        createdAt: map["createdAt"] != null
            ? DateTime.parse(map["createdAt"].toString())
            : null,
        updatedAt: map["updatedAt"] != null
            ? DateTime.parse(map["updatedAt"].toString())
            : null,
        branchId: map["branchId"]?.toString(),
        placeOfSupply: map["placeOfSupply"]?.toString(),
        referenceBillNo: map["referenceBillNo"]?.toString(),
        shippingDate: map["shippingDate"] != null
            ? DateTime.parse(map["shippingDate"].toString())
            : null,
        reason: map["reason"]?.toString(),
        paymentTerm: map["paymentTerm"]?.toString(),
        exportSez: map["exportSez"]?.toString(),
        notes: map["notes"]?.toString(),
        accountLedgerId: map["accountLedgerId"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy?.toMap(),
        "updatedBy": updatedBy,
        "companyId": companyId?.toMap(),
        "supplierId": supplierId?.toMap(),
        "billingAddress": billingAddress?.toMap(),
        "shippingAddress": shippingAddress?.toMap(),
        "debitNoteNo": debitNoteNo,
        "debitNoteDate": debitNoteDate?.toIso8601String(),
        "dueDate": dueDate?.toIso8601String(),
        "paymentTermsId": paymentTermsId?.toMap(),
        "purchaseId": purchaseId,
        "reverseCharge": reverseCharge,
        "productDetails": productDetails,
        "additionalCharges": additionalCharges,
        "termsAndConditionIds": termsAndConditionIds,
        "shippingDetails": shippingDetails?.toMap(),
        "summary": summary?.toMap(),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "branchId": branchId,
        "placeOfSupply": placeOfSupply,
        "referenceBillNo": referenceBillNo,
        "shippingDate": shippingDate?.toIso8601String(),
        "reason": reason,
        "paymentTerm": paymentTerm,
        "exportSez": exportSez,
        "notes": notes,
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
        supplierId,
        billingAddress,
        shippingAddress,
        debitNoteNo,
        debitNoteDate,
        dueDate,
        paymentTermsId,
        purchaseId,
        reverseCharge,
        productDetails,
        additionalCharges,
        termsAndConditionIds,
        shippingDetails,
        summary,
        status,
        createdAt,
        updatedAt,
        branchId,
        placeOfSupply,
        referenceBillNo,
        shippingDate,
        reason,
        paymentTerm,
        exportSez,
        notes,
        accountLedgerId,
      ];

  @override
  bool get stringify => true;
}

class PurchaseDebitNoteCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const PurchaseDebitNoteCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  factory PurchaseDebitNoteCreatedBy.fromMap(Map<String, dynamic> map) =>
      PurchaseDebitNoteCreatedBy(
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

class PurchaseDebitNoteAddress extends Equatable {
  final String addressLine1;
  final String? addressLine2;
  final IdNameModel? country;
  final IdNameModel? state;
  final IdNameModel? city;
  final String? pinCode;
  final String id;

  const PurchaseDebitNoteAddress({
    required this.addressLine1,
    this.addressLine2,
    this.country,
    this.state,
    this.city,
    this.pinCode,
    required this.id,
  });

  factory PurchaseDebitNoteAddress.fromMap(Map<String, dynamic> map) =>
      PurchaseDebitNoteAddress(
        addressLine1: map["addressLine1"]?.toString() ?? "",
        addressLine2: map["addressLine2"]?.toString(),
        country: map["country"] == null ? null : IdNameModel.fromMap(map["country"]),
        state: map["state"] == null ? null : IdNameModel.fromMap(map["state"]),
        city: map["city"] == null ? null : IdNameModel.fromMap(map["city"]),
        pinCode: map["pinCode"]?.toString(),
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
  List<Object?> get props =>
      [addressLine1, addressLine2, country, state, city, pinCode, id];

  @override
  bool get stringify => true;
}

class PurchaseDebitNotePaymentTerms extends Equatable {
  final String id;
  final String name;
  final int day;

  const PurchaseDebitNotePaymentTerms({
    required this.id,
    required this.name,
    required this.day,
  });

  factory PurchaseDebitNotePaymentTerms.fromMap(Map<String, dynamic> map) =>
      PurchaseDebitNotePaymentTerms(
        id: map["_id"]?.toString() ?? "",
        name: map["name"]?.toString() ?? "",
        day: (map["day"] as num? ?? 0).toInt(),
      );

  Map<String, dynamic> toMap() => {"_id": id, "name": name, "day": day};

  @override
  List<Object?> get props => [id, name, day];

  @override
  bool get stringify => true;
}

class PurchaseDebitNoteShipping extends Equatable {
  final String? shippingType;
  final double weight;
  final DateTime? shippingDate;
  final String? referenceNo;
  final DateTime? transportDate;
  final String? modeOfTransport;
  final String? transporterId;
  final String? vehicleNo;

  const PurchaseDebitNoteShipping({
    this.shippingType,
    required this.weight,
    this.shippingDate,
    this.referenceNo,
    this.transportDate,
    this.modeOfTransport,
    this.transporterId,
    this.vehicleNo,
  });

  factory PurchaseDebitNoteShipping.fromMap(Map<String, dynamic> map) =>
      PurchaseDebitNoteShipping(
        shippingType: map["shippingType"]?.toString(),
        weight: (map["weight"] as num? ?? 0).toDouble(),
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

class PurchaseDebitNoteSummary extends Equatable {
  final double flatDiscount;
  final double grossAmount;
  final double discountAmount;
  final double taxableAmount;
  final double taxAmount;
  final double roundOff;
  final double netAmount;

  const PurchaseDebitNoteSummary({
    required this.flatDiscount,
    required this.grossAmount,
    required this.discountAmount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
  });

  factory PurchaseDebitNoteSummary.fromMap(Map<String, dynamic> map) =>
      PurchaseDebitNoteSummary(
        flatDiscount: (map["flatDiscount"] as num? ?? 0).toDouble(),
        grossAmount: (map["grossAmount"] as num? ?? 0).toDouble(),
        discountAmount: (map["discountAmount"] as num? ?? 0).toDouble(),
        taxableAmount: (map["taxableAmount"] as num? ?? 0).toDouble(),
        taxAmount: (map["taxAmount"] as num? ?? 0).toDouble(),
        roundOff: (map["roundOff"] as num? ?? 0).toDouble(),
        netAmount: (map["netAmount"] as num? ?? 0).toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "flatDiscount": flatDiscount,
        "grossAmount": grossAmount,
        "discountAmount": discountAmount,
        "taxableAmount": taxableAmount,
        "taxAmount": taxAmount,
        "roundOff": roundOff,
        "netAmount": netAmount,
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
      ];

  @override
  bool get stringify => true;
}

class PurchaseDebitNoteSupplier extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String companyName;
  final String? email;
  final PurchaseDebitNotePhone? phoneNo;
  final List<PurchaseDebitNoteAddress> address;
  final String? contactType;

  const PurchaseDebitNoteSupplier({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.companyName,
    this.email,
    this.phoneNo,
    required this.address,
    this.contactType,
  });

  factory PurchaseDebitNoteSupplier.fromMap(Map<String, dynamic> map) =>
      PurchaseDebitNoteSupplier(
        id: map["_id"]?.toString() ?? "",
        firstName: map["firstName"]?.toString() ?? "",
        lastName: map["lastName"]?.toString() ?? "",
        companyName: map["companyName"]?.toString() ?? "",
        email: map["email"]?.toString(),
        phoneNo: map["phoneNo"] == null
            ? null
            : PurchaseDebitNotePhone.fromMap(map["phoneNo"] as Map<String, dynamic>),
        address: List<PurchaseDebitNoteAddress>.from(
          (map["address"] as List<dynamic>?)?.map(
                (x) => PurchaseDebitNoteAddress.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        contactType: map["contactType"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "companyName": companyName,
        "email": email,
        "phoneNo": phoneNo?.toMap(),
        "address": address.map((x) => x.toMap()).toList(),
        "contactType": contactType,
      };

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        companyName,
        email,
        phoneNo,
        address,
        contactType,
      ];

  @override
  bool get stringify => true;
}

class PurchaseDebitNotePhone extends Equatable {
  final String countryCode;
  final int phoneNo;

  const PurchaseDebitNotePhone({required this.countryCode, required this.phoneNo});

  factory PurchaseDebitNotePhone.fromMap(Map<String, dynamic> map) =>
      PurchaseDebitNotePhone(
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
