import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class PurchaseOrderModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final PurchaseOrderCreatedBy? createdBy;
  final String? updatedBy;
  final IdNameModel? companyId;
  final PurchaseOrderSupplier? supplierId;
  final DateTime? orderDate;
  final String? orderNo;
  final String? placeOfSupply;
  final PurchaseOrderAddress? billingAddress;
  final PurchaseOrderAddress? shippingAddress;
  final DateTime? shippingDate;
  final String? shippingNote;
  final String? taxType;
  final List<PurchaseOrderItem> items;
  final List<PurchaseOrderTerms> termsAndConditionIds;
  final String? notes;
  final String? totalQty;
  final String? totalTax;
  final String? total;
  final PurchaseOrderSummary? summary;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final IdNameModel? branchId;
  final String? gstIn;

  const PurchaseOrderModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    this.companyId,
    this.supplierId,
    this.orderDate,
    this.orderNo,
    this.placeOfSupply,
    this.billingAddress,
    this.shippingAddress,
    this.shippingDate,
    this.shippingNote,
    this.taxType,
    required this.items,
    required this.termsAndConditionIds,
    this.notes,
    this.totalQty,
    this.totalTax,
    this.total,
    this.summary,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.branchId,
    this.gstIn,
  });

  PurchaseOrderModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    PurchaseOrderCreatedBy? createdBy,
    String? updatedBy,
    IdNameModel? companyId,
    PurchaseOrderSupplier? supplierId,
    DateTime? orderDate,
    String? orderNo,
    String? placeOfSupply,
    PurchaseOrderAddress? billingAddress,
    PurchaseOrderAddress? shippingAddress,
    DateTime? shippingDate,
    String? shippingNote,
    String? taxType,
    List<PurchaseOrderItem>? items,
    List<PurchaseOrderTerms>? termsAndConditionIds,
    String? notes,
    String? totalQty,
    String? totalTax,
    String? total,
    PurchaseOrderSummary? summary,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    IdNameModel? branchId,
    String? gstIn,
  }) {
    return PurchaseOrderModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      supplierId: supplierId ?? this.supplierId,
      orderDate: orderDate ?? this.orderDate,
      orderNo: orderNo ?? this.orderNo,
      placeOfSupply: placeOfSupply ?? this.placeOfSupply,
      billingAddress: billingAddress ?? this.billingAddress,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      shippingDate: shippingDate ?? this.shippingDate,
      shippingNote: shippingNote ?? this.shippingNote,
      taxType: taxType ?? this.taxType,
      items: items ?? this.items,
      termsAndConditionIds: termsAndConditionIds ?? this.termsAndConditionIds,
      notes: notes ?? this.notes,
      totalQty: totalQty ?? this.totalQty,
      totalTax: totalTax ?? this.totalTax,
      total: total ?? this.total,
      summary: summary ?? this.summary,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      branchId: branchId ?? this.branchId,
      gstIn: gstIn ?? this.gstIn,
    );
  }

  factory PurchaseOrderModel.fromJson(String json) =>
      PurchaseOrderModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory PurchaseOrderModel.fromMap(Map<String, dynamic> map) =>
      PurchaseOrderModel(
        id: map["_id"]?.toString() ?? "",
        isDeleted: map["isDeleted"] as bool? ?? false,
        isActive: map["isActive"] as bool? ?? true,
        createdBy: map["createdBy"] == null
            ? null
            : PurchaseOrderCreatedBy.fromMap(
                map["createdBy"] as Map<String, dynamic>,
              ),
        updatedBy: map["updatedBy"]?.toString(),
        companyId: map["companyId"] == null
            ? null
            : IdNameModel.fromMap(map["companyId"]),
        supplierId: map["supplierId"] == null
            ? null
            : PurchaseOrderSupplier.fromMap(
                map["supplierId"] as Map<String, dynamic>,
              ),
        orderDate: map["orderDate"] != null
            ? DateTime.parse(map["orderDate"].toString())
            : null,
        orderNo: map["orderNo"]?.toString(),
        placeOfSupply: map["placeOfSupply"]?.toString(),
        billingAddress: map["billingAddress"] == null
            ? null
            : PurchaseOrderAddress.fromMap(
                map["billingAddress"] as Map<String, dynamic>,
              ),
        shippingAddress: map["shippingAddress"] == null
            ? null
            : PurchaseOrderAddress.fromMap(
                map["shippingAddress"] as Map<String, dynamic>,
              ),
        shippingDate: map["shippingDate"] != null
            ? DateTime.parse(map["shippingDate"].toString())
            : null,
        shippingNote: map["shippingNote"]?.toString(),
        taxType: map["taxType"]?.toString(),
        items: List<PurchaseOrderItem>.from(
          (map["items"] as List<dynamic>?)?.map(
                (x) => PurchaseOrderItem.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        termsAndConditionIds: List<PurchaseOrderTerms>.from(
          (map["termsAndConditionIds"] as List<dynamic>?)?.map(
                (x) => PurchaseOrderTerms.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        notes: map["notes"]?.toString(),
        totalQty: map["totalQty"]?.toString(),
        totalTax: map["totalTax"]?.toString(),
        total: map["total"]?.toString(),
        summary: map["summary"] == null
            ? null
            : PurchaseOrderSummary.fromMap(
                map["summary"] as Map<String, dynamic>,
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
        gstIn: map["gstIn"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy?.toMap(),
    "updatedBy": updatedBy,
    "companyId": companyId?.toMap(),
    "supplierId": supplierId?.toMap(),
    "orderDate": orderDate?.toIso8601String(),
    "orderNo": orderNo,
    "placeOfSupply": placeOfSupply,
    "billingAddress": billingAddress?.toMap(),
    "shippingAddress": shippingAddress?.toMap(),
    "shippingDate": shippingDate?.toIso8601String(),
    "shippingNote": shippingNote,
    "taxType": taxType,
    "items": items.map((x) => x.toMap()).toList(),
    "termsAndConditionIds": termsAndConditionIds.map((x) => x.toMap()).toList(),
    "notes": notes,
    "totalQty": totalQty,
    "totalTax": totalTax,
    "total": total,
    "summary": summary?.toMap(),
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "branchId": branchId?.toMap(),
    "gstIn": gstIn,
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
    orderDate,
    orderNo,
    placeOfSupply,
    billingAddress,
    shippingAddress,
    shippingDate,
    shippingNote,
    taxType,
    items,
    termsAndConditionIds,
    notes,
    totalQty,
    totalTax,
    total,
    summary,
    status,
    createdAt,
    updatedAt,
    branchId,
    gstIn,
  ];

  @override
  bool get stringify => true;
}

class PurchaseOrderAddress extends Equatable {
  final String addressLine1;
  final String? addressLine2;
  final IdNameModel? country;
  final IdNameModel? state;
  final IdNameModel? city;
  final int? pinCode;
  final String id;

  const PurchaseOrderAddress({
    required this.addressLine1,
    this.addressLine2,
    this.country,
    this.state,
    this.city,
    this.pinCode,
    required this.id,
  });

  PurchaseOrderAddress copyWith({
    String? addressLine1,
    String? addressLine2,
    IdNameModel? country,
    IdNameModel? state,
    IdNameModel? city,
    int? pinCode,
    String? id,
  }) {
    return PurchaseOrderAddress(
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      pinCode: pinCode ?? this.pinCode,
      id: id ?? this.id,
    );
  }

  factory PurchaseOrderAddress.fromJson(String json) =>
      PurchaseOrderAddress.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory PurchaseOrderAddress.fromMap(Map<String, dynamic> map) =>
      PurchaseOrderAddress(
        addressLine1: map["addressLine1"]?.toString() ?? "",
        addressLine2: map["addressLine2"]?.toString(),
        country: map["country"] == null
            ? null
            : IdNameModel.fromMap(map["country"]),
        state: map["state"] == null ? null : IdNameModel.fromMap(map["state"]),
        city: map["city"] == null ? null : IdNameModel.fromMap(map["city"]),
        pinCode: map["pinCode"] as int?,
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

class PurchaseOrderCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const PurchaseOrderCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  PurchaseOrderCreatedBy copyWith({
    String? id,
    String? fullName,
    String? userType,
  }) {
    return PurchaseOrderCreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory PurchaseOrderCreatedBy.fromMap(Map<String, dynamic> map) =>
      PurchaseOrderCreatedBy(
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

class PurchaseOrderItem extends Equatable {
  final IdNameModel? productId;
  final double qty;
  final dynamic uomId;
  final String? unit;
  final double unitCost;
  final PurchaseOrderTax? taxId;
  final String? tax;
  final String? landingCost;
  final String? margin;
  final double? mrp;
  final double? sellingPrice;
  final double total;
  final String? variantId;

  const PurchaseOrderItem({
    this.productId,
    required this.qty,
    this.uomId,
    this.unit,
    required this.unitCost,
    this.taxId,
    this.tax,
    this.landingCost,
    this.margin,
    this.mrp,
    this.sellingPrice,
    required this.total,
    this.variantId,
  });

  PurchaseOrderItem copyWith({
    IdNameModel? productId,
    double? qty,
    dynamic uomId,
    String? unit,
    double? unitCost,
    PurchaseOrderTax? taxId,
    String? tax,
    String? landingCost,
    String? margin,
    double? mrp,
    double? sellingPrice,
    double? total,
    String? variantId,
  }) {
    return PurchaseOrderItem(
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      uomId: uomId ?? this.uomId,
      unit: unit ?? this.unit,
      unitCost: unitCost ?? this.unitCost,
      taxId: taxId ?? this.taxId,
      tax: tax ?? this.tax,
      landingCost: landingCost ?? this.landingCost,
      margin: margin ?? this.margin,
      mrp: mrp ?? this.mrp,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      total: total ?? this.total,
      variantId: variantId ?? this.variantId,
    );
  }

  factory PurchaseOrderItem.fromMap(Map<String, dynamic> map) =>
      PurchaseOrderItem(
        productId: map["productId"] == null
            ? null
            : IdNameModel.fromMap(map["productId"]),
        qty: (map["qty"] as num? ?? 0).toDouble(),
        uomId: map["uomId"],
        unit: map["unit"]?.toString(),
        unitCost: (map["unitCost"] as num? ?? 0).toDouble(),
        taxId: map["taxId"] == null
            ? null
            : PurchaseOrderTax.fromMap(map["taxId"] as Map<String, dynamic>),
        tax: map["tax"]?.toString(),
        landingCost: map["landingCost"]?.toString(),
        margin: map["margin"]?.toString(),
        mrp: (map["mrp"] as num? ?? 0).toDouble(),
        sellingPrice: (map["sellingPrice"] as num? ?? 0).toDouble(),
        total: (map["total"] as num? ?? 0).toDouble(),
        variantId: map['variantId'],
      );

  Map<String, dynamic> toMap() => {
    "productId": productId?.toMap(),
    "qty": qty,
    "uomId": uomId,
    "unit": unit,
    "unitCost": unitCost,
    "taxId": taxId?.toMap(),
    "tax": tax,
    "landingCost": landingCost,
    "margin": margin,
    "mrp": mrp,
    "sellingPrice": sellingPrice,
    "total": total,
    "variantId": variantId,
  };

  @override
  List<Object?> get props => [
    productId,
    qty,
    uomId,
    unit,
    unitCost,
    taxId,
    tax,
    landingCost,
    margin,
    mrp,
    sellingPrice,
    total,
    variantId,
  ];

  @override
  bool get stringify => true;
}

class PurchaseOrderTax extends Equatable {
  final String id;
  final String name;
  final double percentage;

  const PurchaseOrderTax({
    required this.id,
    required this.name,
    required this.percentage,
  });

  PurchaseOrderTax copyWith({String? id, String? name, double? percentage}) {
    return PurchaseOrderTax(
      id: id ?? this.id,
      name: name ?? this.name,
      percentage: percentage ?? this.percentage,
    );
  }

  factory PurchaseOrderTax.fromMap(Map<String, dynamic> map) =>
      PurchaseOrderTax(
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

class PurchaseOrderSummary extends Equatable {
  final double flatDiscount;
  final double grossAmount;
  final double discountAmount;
  final double taxableAmount;
  final double taxAmount;
  final double roundOff;
  final double netAmount;

  const PurchaseOrderSummary({
    required this.flatDiscount,
    required this.grossAmount,
    required this.discountAmount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
  });

  PurchaseOrderSummary copyWith({
    double? flatDiscount,
    double? grossAmount,
    double? discountAmount,
    double? taxableAmount,
    double? taxAmount,
    double? roundOff,
    double? netAmount,
  }) {
    return PurchaseOrderSummary(
      flatDiscount: flatDiscount ?? this.flatDiscount,
      grossAmount: grossAmount ?? this.grossAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      taxableAmount: taxableAmount ?? this.taxableAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      roundOff: roundOff ?? this.roundOff,
      netAmount: netAmount ?? this.netAmount,
    );
  }

  factory PurchaseOrderSummary.fromMap(Map<String, dynamic> map) =>
      PurchaseOrderSummary(
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

class PurchaseOrderSupplier extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String companyName;
  final String? email;
  final PurchaseOrderPhone? phoneNo;
  final List<PurchaseOrderAddress> address;
  final String? contactType;

  const PurchaseOrderSupplier({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.companyName,
    this.email,
    this.phoneNo,
    required this.address,
    this.contactType,
  });

  PurchaseOrderSupplier copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? companyName,
    String? email,
    PurchaseOrderPhone? phoneNo,
    List<PurchaseOrderAddress>? address,
    String? contactType,
  }) {
    return PurchaseOrderSupplier(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      companyName: companyName ?? this.companyName,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      address: address ?? this.address,
      contactType: contactType ?? this.contactType,
    );
  }

  factory PurchaseOrderSupplier.fromMap(Map<String, dynamic> map) =>
      PurchaseOrderSupplier(
        id: map["_id"]?.toString() ?? "",
        firstName: map["firstName"]?.toString() ?? "",
        lastName: map["lastName"]?.toString() ?? "",
        companyName: map["companyName"]?.toString() ?? "",
        email: map["email"]?.toString(),
        phoneNo: map["phoneNo"] == null
            ? null
            : PurchaseOrderPhone.fromMap(
                map["phoneNo"] as Map<String, dynamic>,
              ),
        address: List<PurchaseOrderAddress>.from(
          (map["address"] as List<dynamic>?)?.map(
                (x) => PurchaseOrderAddress.fromMap(x as Map<String, dynamic>),
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

class PurchaseOrderPhone extends Equatable {
  final String countryCode;
  final int phoneNo;

  const PurchaseOrderPhone({required this.countryCode, required this.phoneNo});

  PurchaseOrderPhone copyWith({String? countryCode, int? phoneNo}) {
    return PurchaseOrderPhone(
      countryCode: countryCode ?? this.countryCode,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }

  factory PurchaseOrderPhone.fromMap(Map<String, dynamic> map) =>
      PurchaseOrderPhone(
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

class PurchaseOrderTerms extends Equatable {
  final String id;

  const PurchaseOrderTerms({required this.id});

  PurchaseOrderTerms copyWith({String? id}) {
    return PurchaseOrderTerms(id: id ?? this.id);
  }

  factory PurchaseOrderTerms.fromMap(Map<String, dynamic> map) =>
      PurchaseOrderTerms(id: map["_id"]?.toString() ?? "");

  Map<String, dynamic> toMap() => {"_id": id};

  @override
  List<Object?> get props => [id];

  @override
  bool get stringify => true;
}
