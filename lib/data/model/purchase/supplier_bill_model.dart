import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class SupplierBillModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final SupplierBillCreatedBy? createdBy;
  final SupplierBillUpdatedBy? updatedBy;
  final IdNameModel? companyId;
  final SupplierBillSupplier? supplierId;
  final String? supplierBillNo;
  final String? referenceBillNo;
  final DateTime? supplierBillDate;
  final String? gstIn;
  final SupplierBillAddress? billingAddress;
  final SupplierBillPaymentTerms? paymentTermsId;
  final DateTime? dueDate;
  final bool reverseCharge;
  final DateTime? shippingDate;
  final String? taxType;
  final String? invoiceAmount;
  final dynamic productDetails;
  final SupplierBillReturn? returnProductDetails;
  final dynamic additionalCharges;
  final List<SupplierBillTerms> termsAndConditionIds;
  final SupplierBillSummary? summary;
  final double paidAmount;
  final double balanceAmount;
  final String? paymentStatus;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? placeOfSupply;
  final String? branchId;
  final String? notes;
  final String? paymentTerm;

  const SupplierBillModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    this.supplierId,
    this.supplierBillNo,
    this.referenceBillNo,
    this.supplierBillDate,
    this.gstIn,
    this.billingAddress,
    this.paymentTermsId,
    this.dueDate,
    required this.reverseCharge,
    this.shippingDate,
    this.taxType,
    this.invoiceAmount,
    this.productDetails,
    this.returnProductDetails,
    this.additionalCharges,
    required this.termsAndConditionIds,
    this.summary,
    required this.paidAmount,
    required this.balanceAmount,
    this.paymentStatus,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.placeOfSupply,
    this.branchId,
    this.notes,
    this.paymentTerm,
  });

  SupplierBillModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    SupplierBillCreatedBy? createdBy,
    SupplierBillUpdatedBy? updatedBy,
    IdNameModel? companyId,
    SupplierBillSupplier? supplierId,
    String? supplierBillNo,
    String? referenceBillNo,
    DateTime? supplierBillDate,
    String? gstIn,
    SupplierBillAddress? billingAddress,
    SupplierBillPaymentTerms? paymentTermsId,
    DateTime? dueDate,
    bool? reverseCharge,
    DateTime? shippingDate,
    String? taxType,
    String? invoiceAmount,
    dynamic productDetails,
    SupplierBillReturn? returnProductDetails,
    dynamic additionalCharges,
    List<SupplierBillTerms>? termsAndConditionIds,
    SupplierBillSummary? summary,
    double? paidAmount,
    double? balanceAmount,
    String? paymentStatus,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? placeOfSupply,
    String? branchId,
    String? notes,
    String? paymentTerm,
  }) {
    return SupplierBillModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      supplierId: supplierId ?? this.supplierId,
      supplierBillNo: supplierBillNo ?? this.supplierBillNo,
      referenceBillNo: referenceBillNo ?? this.referenceBillNo,
      supplierBillDate: supplierBillDate ?? this.supplierBillDate,
      gstIn: gstIn ?? this.gstIn,
      billingAddress: billingAddress ?? this.billingAddress,
      paymentTermsId: paymentTermsId ?? this.paymentTermsId,
      dueDate: dueDate ?? this.dueDate,
      reverseCharge: reverseCharge ?? this.reverseCharge,
      shippingDate: shippingDate ?? this.shippingDate,
      taxType: taxType ?? this.taxType,
      invoiceAmount: invoiceAmount ?? this.invoiceAmount,
      productDetails: productDetails ?? this.productDetails,
      returnProductDetails: returnProductDetails ?? this.returnProductDetails,
      additionalCharges: additionalCharges ?? this.additionalCharges,
      termsAndConditionIds: termsAndConditionIds ?? this.termsAndConditionIds,
      summary: summary ?? this.summary,
      paidAmount: paidAmount ?? this.paidAmount,
      balanceAmount: balanceAmount ?? this.balanceAmount,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      placeOfSupply: placeOfSupply ?? this.placeOfSupply,
      branchId: branchId ?? this.branchId,
      notes: notes ?? this.notes,
      paymentTerm: paymentTerm ?? this.paymentTerm,
    );
  }

  factory SupplierBillModel.fromJson(String json) =>
      SupplierBillModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory SupplierBillModel.fromMap(Map<String, dynamic> map) => SupplierBillModel(
        id: map["_id"]?.toString() ?? "",
        isDeleted: map["isDeleted"] as bool? ?? false,
        isActive: map["isActive"] as bool? ?? true,
        createdBy: map["createdBy"] == null
            ? null
            : SupplierBillCreatedBy.fromMap(
                map["createdBy"] as Map<String, dynamic>),
        updatedBy: map["updatedBy"] == null
            ? null
            : SupplierBillUpdatedBy.fromMap(
                map["updatedBy"] as Map<String, dynamic>),
        companyId:
            map["companyId"] == null ? null : IdNameModel.fromMap(map["companyId"]),
        supplierId: map["supplierId"] == null
            ? null
            : SupplierBillSupplier.fromMap(
                map["supplierId"] as Map<String, dynamic>),
        supplierBillNo: map["supplierBillNo"]?.toString(),
        referenceBillNo: map["referenceBillNo"]?.toString(),
        supplierBillDate: map["supplierBillDate"] != null
            ? DateTime.parse(map["supplierBillDate"].toString())
            : null,
        gstIn: map["gstIn"]?.toString(),
        billingAddress: map["billingAddress"] == null
            ? null
            : SupplierBillAddress.fromMap(
                map["billingAddress"] as Map<String, dynamic>),
        paymentTermsId: map["paymentTermsId"] == null
            ? null
            : SupplierBillPaymentTerms.fromMap(
                map["paymentTermsId"] as Map<String, dynamic>),
        dueDate:
            map["dueDate"] != null ? DateTime.parse(map["dueDate"].toString()) : null,
        reverseCharge: map["reverseCharge"] as bool? ?? false,
        shippingDate: map["shippingDate"] != null
            ? DateTime.parse(map["shippingDate"].toString())
            : null,
        taxType: map["taxType"]?.toString(),
        invoiceAmount: map["invoiceAmount"]?.toString(),
        productDetails: map["productDetails"],
        returnProductDetails: map["returnProductDetails"] == null
            ? null
            : SupplierBillReturn.fromMap(
                map["returnProductDetails"] as Map<String, dynamic>),
        additionalCharges: map["additionalCharges"],
        termsAndConditionIds: List<SupplierBillTerms>.from(
          (map["termsAndConditionIds"] as List<dynamic>?)?.map(
                (x) => SupplierBillTerms.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        summary: map["summary"] == null
            ? null
            : SupplierBillSummary.fromMap(map["summary"] as Map<String, dynamic>),
        paidAmount: (map["paidAmount"] as num? ?? 0).toDouble(),
        balanceAmount: (map["balanceAmount"] as num? ?? 0).toDouble(),
        paymentStatus: map["paymentStatus"]?.toString(),
        status: map["status"]?.toString(),
        createdAt: map["createdAt"] != null
            ? DateTime.parse(map["createdAt"].toString())
            : null,
        updatedAt: map["updatedAt"] != null
            ? DateTime.parse(map["updatedAt"].toString())
            : null,
        placeOfSupply: map["placeOfSupply"]?.toString(),
        branchId: map["branchId"]?.toString(),
        notes: map["notes"]?.toString(),
        paymentTerm: map["paymentTerm"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy?.toMap(),
        "updatedBy": updatedBy?.toMap(),
        "companyId": companyId?.toMap(),
        "supplierId": supplierId?.toMap(),
        "supplierBillNo": supplierBillNo,
        "referenceBillNo": referenceBillNo,
        "supplierBillDate": supplierBillDate?.toIso8601String(),
        "gstIn": gstIn,
        "billingAddress": billingAddress?.toMap(),
        "paymentTermsId": paymentTermsId?.toMap(),
        "dueDate": dueDate?.toIso8601String(),
        "reverseCharge": reverseCharge,
        "shippingDate": shippingDate?.toIso8601String(),
        "taxType": taxType,
        "invoiceAmount": invoiceAmount,
        "productDetails": productDetails,
        "returnProductDetails": returnProductDetails?.toMap(),
        "additionalCharges": additionalCharges,
        "termsAndConditionIds": termsAndConditionIds.map((x) => x.toMap()).toList(),
        "summary": summary?.toMap(),
        "paidAmount": paidAmount,
        "balanceAmount": balanceAmount,
        "paymentStatus": paymentStatus,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "placeOfSupply": placeOfSupply,
        "branchId": branchId,
        "notes": notes,
        "paymentTerm": paymentTerm,
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
        supplierBillNo,
        referenceBillNo,
        supplierBillDate,
        gstIn,
        billingAddress,
        paymentTermsId,
        dueDate,
        reverseCharge,
        shippingDate,
        taxType,
        invoiceAmount,
        productDetails,
        returnProductDetails,
        additionalCharges,
        termsAndConditionIds,
        summary,
        paidAmount,
        balanceAmount,
        paymentStatus,
        status,
        createdAt,
        updatedAt,
        placeOfSupply,
        branchId,
        notes,
        paymentTerm,
      ];

  @override
  bool get stringify => true;
}

class SupplierBillAddress extends Equatable {
  final String addressLine1;
  final String? addressLine2;
  final IdNameModel? country;
  final IdNameModel? state;
  final IdNameModel? city;
  final int? pinCode;
  final String id;

  const SupplierBillAddress({
    required this.addressLine1,
    this.addressLine2,
    this.country,
    this.state,
    this.city,
    this.pinCode,
    required this.id,
  });

  factory SupplierBillAddress.fromMap(Map<String, dynamic> map) =>
      SupplierBillAddress(
        addressLine1: map["addressLine1"]?.toString() ?? "",
        addressLine2: map["addressLine2"]?.toString(),
        country: map["country"] == null ? null : IdNameModel.fromMap(map["country"]),
        state: map["state"] == null ? null : IdNameModel.fromMap(map["state"]),
        city: map["city"] == null ? null : IdNameModel.fromMap(map["city"]),
        pinCode: (map["pinCode"] as num?)?.toInt(),
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

class SupplierBillCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const SupplierBillCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  factory SupplierBillCreatedBy.fromMap(Map<String, dynamic> map) =>
      SupplierBillCreatedBy(
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

class SupplierBillUpdatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const SupplierBillUpdatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  factory SupplierBillUpdatedBy.fromMap(Map<String, dynamic> map) =>
      SupplierBillUpdatedBy(
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

class SupplierBillPaymentTerms extends Equatable {
  final String id;
  final String name;
  final int day;

  const SupplierBillPaymentTerms({
    required this.id,
    required this.name,
    required this.day,
  });

  factory SupplierBillPaymentTerms.fromMap(Map<String, dynamic> map) =>
      SupplierBillPaymentTerms(
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

class SupplierBillSummary extends Equatable {
  final double flatDiscount;
  final double grossAmount;
  final double discountAmount;
  final double taxableAmount;
  final double taxAmount;
  final double roundOff;
  final double netAmount;

  const SupplierBillSummary({
    required this.flatDiscount,
    required this.grossAmount,
    required this.discountAmount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
  });

  factory SupplierBillSummary.fromMap(Map<String, dynamic> map) =>
      SupplierBillSummary(
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

class SupplierBillSupplier extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String companyName;
  final String? email;
  final SupplierBillPhone? phoneNo;
  final List<SupplierBillAddress> address;
  final String? contactType;

  const SupplierBillSupplier({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.companyName,
    this.email,
    this.phoneNo,
    required this.address,
    this.contactType,
  });

  factory SupplierBillSupplier.fromMap(Map<String, dynamic> map) =>
      SupplierBillSupplier(
        id: map["_id"]?.toString() ?? "",
        firstName: map["firstName"]?.toString() ?? "",
        lastName: map["lastName"]?.toString() ?? "",
        companyName: map["companyName"]?.toString() ?? "",
        email: map["email"]?.toString(),
        phoneNo: map["phoneNo"] == null
            ? null
            : SupplierBillPhone.fromMap(map["phoneNo"] as Map<String, dynamic>),
        address: List<SupplierBillAddress>.from(
          (map["address"] as List<dynamic>?)?.map(
                (x) => SupplierBillAddress.fromMap(x as Map<String, dynamic>),
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

class SupplierBillPhone extends Equatable {
  final String countryCode;
  final int phoneNo;

  const SupplierBillPhone({required this.countryCode, required this.phoneNo});

  factory SupplierBillPhone.fromMap(Map<String, dynamic> map) => SupplierBillPhone(
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

class SupplierBillReturn extends Equatable {
  final List<SupplierBillReturnItem> item;
  final SupplierBillReturnSummary? summary;
  final double? totalQty;
  final double? total;

  const SupplierBillReturn({
    required this.item,
    this.summary,
    this.totalQty,
    this.total,
  });

  factory SupplierBillReturn.fromMap(Map<String, dynamic> map) => SupplierBillReturn(
        item: List<SupplierBillReturnItem>.from(
          (map["item"] as List<dynamic>?)?.map(
                (x) => SupplierBillReturnItem.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        summary: map["summary"] == null
            ? null
            : SupplierBillReturnSummary.fromMap(
                map["summary"] as Map<String, dynamic>),
        totalQty: (map["totalQty"] as num?)?.toDouble(),
        total: (map["total"] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "item": item.map((x) => x.toMap()).toList(),
        "summary": summary?.toMap(),
        "totalQty": totalQty,
        "total": total,
      };

  @override
  List<Object?> get props => [item, summary, totalQty, total];

  @override
  bool get stringify => true;
}

class SupplierBillReturnItem extends Equatable {
  final IdNameModel? productId;
  final double qty;
  final double discount1;
  final double discount2;
  final IdNameModel? uomId;
  final String? unit;
  final double unitCost;
  final double? taxable;
  final SupplierBillTax? taxId;
  final dynamic tax;
  final double landingCost;
  final double total;

  const SupplierBillReturnItem({
    this.productId,
    required this.qty,
    required this.discount1,
    required this.discount2,
    this.uomId,
    this.unit,
    required this.unitCost,
    this.taxable,
    this.taxId,
    this.tax,
    required this.landingCost,
    required this.total,
  });

  factory SupplierBillReturnItem.fromMap(Map<String, dynamic> map) =>
      SupplierBillReturnItem(
        productId:
            map["productId"] == null ? null : IdNameModel.fromMap(map["productId"]),
        qty: (map["qty"] as num? ?? 0).toDouble(),
        discount1: (map["discount1"] as num? ?? 0).toDouble(),
        discount2: (map["discount2"] as num? ?? 0).toDouble(),
        uomId: map["uomId"] == null ? null : IdNameModel.fromMap(map["uomId"]),
        unit: map["unit"]?.toString(),
        unitCost: (map["unitCost"] as num? ?? 0).toDouble(),
        taxable: (map["taxable"] as num?)?.toDouble(),
        taxId: map["taxId"] == null
            ? null
            : SupplierBillTax.fromMap(map["taxId"] as Map<String, dynamic>),
        tax: map["tax"],
        landingCost: (map["landingCost"] as num? ?? 0).toDouble(),
        total: (map["total"] as num? ?? 0).toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "productId": productId?.toMap(),
        "qty": qty,
        "discount1": discount1,
        "discount2": discount2,
        "uomId": uomId?.toMap(),
        "unit": unit,
        "unitCost": unitCost,
        "taxable": taxable,
        "taxId": taxId?.toMap(),
        "tax": tax,
        "landingCost": landingCost,
        "total": total,
      };

  @override
  List<Object?> get props => [
        productId,
        qty,
        discount1,
        discount2,
        uomId,
        unit,
        unitCost,
        taxable,
        taxId,
        tax,
        landingCost,
        total,
      ];

  @override
  bool get stringify => true;
}

class SupplierBillReturnSummary extends Equatable {
  final double grossAmount;
  final double taxAmount;
  final double roundOff;
  final double netAmount;

  const SupplierBillReturnSummary({
    required this.grossAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
  });

  factory SupplierBillReturnSummary.fromMap(Map<String, dynamic> map) =>
      SupplierBillReturnSummary(
        grossAmount: (map["grossAmount"] as num? ?? 0).toDouble(),
        taxAmount: (map["taxAmount"] as num? ?? 0).toDouble(),
        roundOff: (map["roundOff"] as num? ?? 0).toDouble(),
        netAmount: (map["netAmount"] as num? ?? 0).toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "grossAmount": grossAmount,
        "taxAmount": taxAmount,
        "roundOff": roundOff,
        "netAmount": netAmount,
      };

  @override
  List<Object?> get props => [grossAmount, taxAmount, roundOff, netAmount];

  @override
  bool get stringify => true;
}

class SupplierBillTax extends Equatable {
  final String id;
  final String name;
  final double percentage;

  const SupplierBillTax({
    required this.id,
    required this.name,
    required this.percentage,
  });

  factory SupplierBillTax.fromMap(Map<String, dynamic> map) => SupplierBillTax(
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

class SupplierBillTerms extends Equatable {
  final String id;

  const SupplierBillTerms({required this.id});

  factory SupplierBillTerms.fromMap(Map<String, dynamic> map) =>
      SupplierBillTerms(id: map["_id"]?.toString() ?? "");

  Map<String, dynamic> toMap() => {"_id": id};

  @override
  List<Object?> get props => [id];

  @override
  bool get stringify => true;
}
