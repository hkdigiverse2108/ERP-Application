import 'dart:convert';

class EstimateModel {
  final List<EstimateDatum> estimateData;
  final int totalData;
  final Summary summary;
  final State state;

  EstimateModel({
    required this.estimateData,
    required this.totalData,
    required this.summary,
    required this.state,
  });

  factory EstimateModel.fromRawJson(String str) =>
      EstimateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EstimateModel.fromJson(Map<String, dynamic> json) => EstimateModel(
    estimateData: json["estimate_data"] == null
        ? []
        : List<EstimateDatum>.from(
            json["estimate_data"].map((x) => EstimateDatum.fromJson(x)),
          ),
    totalData: json["totalData"] ?? 0,
    summary: json["summary"] == null
        ? Summary(allEstimates: 0, pending: 0, orderCreated: 0, invoiceCreated: 0)
        : Summary.fromJson(json["summary"]),
    state: json["state"] == null
        ? State(page: 1, limit: 10, totalPages: 1)
        : State.fromJson(json["state"]),
  );

  Map<String, dynamic> toJson() => {
    "estimate_data": List<dynamic>.from(estimateData.map((x) => x.toJson())),
    "totalData": totalData,
    "summary": summary.toJson(),
    "state": state.toJson(),
  };
}

class EstimateDatum {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final UpdatedBy updatedBy;
  final CompanyId companyId;
  final String estimateNo;
  final DateTime date;
  final DateTime dueDate;
  final PlaceOfSupplyEnum? placeOfSupply;
  final dynamic billingAddress;
  final dynamic shippingAddress;
  final CustomerId customerId;
  final List<Item> items;
  final List<TermsAndConditionId> termsAndConditionIds;
  final bool reverseCharge;
  final Status status;
  final TransctionSummary? transactionSummary;
  final List<AdditionalCharge> additionalCharges;
  final PaymentTermsId? paymentTermsId;
  final TaxType taxType;
  final ShippingDetails? shippingDetails;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? sez;
  final PaymentTerms? paymentTerms;
  final String? notes;
  final TransctionSummary? transectionSummary;

  EstimateDatum({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.estimateNo,
    required this.date,
    required this.dueDate,
    this.placeOfSupply,
    this.billingAddress,
    this.shippingAddress,
    required this.customerId,
    required this.items,
    required this.termsAndConditionIds,
    required this.reverseCharge,
    required this.status,
    this.transactionSummary,
    required this.additionalCharges,
    this.paymentTermsId,
    required this.taxType,
    this.shippingDetails,
    required this.createdAt,
    required this.updatedAt,
    this.sez,
    this.paymentTerms,
    this.notes,
    this.transectionSummary,
  });

  factory EstimateDatum.fromRawJson(String str) =>
      EstimateDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EstimateDatum.fromJson(Map<String, dynamic> json) => EstimateDatum(
    id: json["_id"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    createdBy: CreatedBy.fromJson(json["createdBy"]),
    updatedBy: updatedByValues.map[json["updatedBy"]] ?? UpdatedBy.THE_694_D017_B7_CB4009_F97_A30854,
    companyId: CompanyId.fromJson(json["companyId"]),
    estimateNo: json["estimateNo"],
    date: DateTime.parse(json["date"]),
    dueDate: DateTime.parse(json["dueDate"]),
    placeOfSupply: placeOfSupplyEnumValues.map[json["placeOfSupply"]],
    billingAddress: json["billingAddress"],
    shippingAddress: json["shippingAddress"],
    customerId: CustomerId.fromJson(json["customerId"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    termsAndConditionIds: List<TermsAndConditionId>.from(
      json["termsAndConditionIds"].map((x) => TermsAndConditionId.fromJson(x)),
    ),
    reverseCharge: json["reverseCharge"],
    status: statusValues.map[json["status"]] ?? Status.PENDING,
    transactionSummary: json["transactionSummary"] == null
        ? null
        : TransctionSummary.fromJson(json["transactionSummary"]),
    additionalCharges: List<AdditionalCharge>.from(
      json["additionalCharges"].map((x) => AdditionalCharge.fromJson(x)),
    ),
    paymentTermsId: json["paymentTermsId"] == null
        ? null
        : PaymentTermsId.fromJson(json["paymentTermsId"]),
    taxType: taxTypeValues.map[json["taxType"]] ?? TaxType.DEFAULT,
    shippingDetails: json["shippingDetails"] == null
        ? null
        : ShippingDetails.fromJson(json["shippingDetails"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    sez: json["sez"],
    paymentTerms: paymentTermsValues.map[json["paymentTerms"]],
    notes: json["notes"],
    transectionSummary: json["transectionSummary"] == null
        ? null
        : TransctionSummary.fromJson(json["transectionSummary"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedByValues.reverse[updatedBy],
    "companyId": companyId.toJson(),
    "estimateNo": estimateNo,
    "date": date.toIso8601String(),
    "dueDate": dueDate.toIso8601String(),
    "placeOfSupply": placeOfSupplyEnumValues.reverse[placeOfSupply],
    "billingAddress": billingAddress,
    "shippingAddress": shippingAddress,
    "customerId": customerId.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "termsAndConditionIds": List<dynamic>.from(
      termsAndConditionIds.map((x) => x.toJson()),
    ),
    "reverseCharge": reverseCharge,
    "status": statusValues.reverse[status],
    "transactionSummary": transactionSummary?.toJson(),
    "additionalCharges": List<dynamic>.from(
      additionalCharges.map((x) => x.toJson()),
    ),
    "paymentTermsId": paymentTermsId?.toJson(),
    "taxType": taxTypeValues.reverse[taxType],
    "shippingDetails": shippingDetails?.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "sez": sez,
    "paymentTerms": paymentTermsValues.reverse[paymentTerms],
    "notes": notes,
    "transectionSummary": transectionSummary?.toJson(),
  };
}

class AdditionalCharge {
  final ChargeId chargeId;
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
        chargeId: ChargeId.fromJson(json["chargeId"]),
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

class ChargeId {
  final String id;
  final Type type;
  final String name;

  ChargeId({required this.id, required this.type, required this.name});

  factory ChargeId.fromRawJson(String str) =>
      ChargeId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChargeId.fromJson(Map<String, dynamic> json) => ChargeId(
    id: json["_id"],
    type: typeValues.map[json["type"]] ?? Type.SALES,
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "type": typeValues.reverse[type],
    "name": name,
  };
}

enum Type { PURCHASE, SALES }

final typeValues = EnumValues({"purchase": Type.PURCHASE, "sales": Type.SALES});

class TaxId {
  final TaxIdId id;
  final TaxIdName name;
  final int percentage;

  TaxId({required this.id, required this.name, required this.percentage});

  factory TaxId.fromRawJson(String str) => TaxId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxId.fromJson(Map<String, dynamic> json) => TaxId(
    id: taxIdIdValues.map[json["_id"]] ?? TaxIdId.THE_6964_B7_F820_D84261_D82_FB8_FA,
    name: taxIdNameValues.map[json["name"]] ?? TaxIdName.GST_18,
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": taxIdIdValues.reverse[id],
    "name": taxIdNameValues.reverse[name],
    "percentage": percentage,
  };
}

enum TaxIdId {
  THE_6964_B7_F820_D84261_D82_FB8_FA,
  THE_6964_B8176_BFCE325_EDE7_F9_E3,
  THE_6981_E7_A321_D8_B862_C136_B5_F0,
  THE_6985933_FF3_B7_E42_C7_AF62_D49,
  THE_69859353_F3_B7_E42_C7_AF62_D5_F,
}

final taxIdIdValues = EnumValues({
  "6964b7f820d84261d82fb8fa": TaxIdId.THE_6964_B7_F820_D84261_D82_FB8_FA,
  "6964b8176bfce325ede7f9e3": TaxIdId.THE_6964_B8176_BFCE325_EDE7_F9_E3,
  "6981e7a321d8b862c136b5f0": TaxIdId.THE_6981_E7_A321_D8_B862_C136_B5_F0,
  "6985933ff3b7e42c7af62d49": TaxIdId.THE_6985933_FF3_B7_E42_C7_AF62_D49,
  "69859353f3b7e42c7af62d5f": TaxIdId.THE_69859353_F3_B7_E42_C7_AF62_D5_F,
});

enum TaxIdName { GST_0, GST_12, GST_18, GST_28, NON_GST_0 }

final taxIdNameValues = EnumValues({
  "GST 0": TaxIdName.GST_0,
  "GST 12": TaxIdName.GST_12,
  "GST 18": TaxIdName.GST_18,
  "GST 28": TaxIdName.GST_28,
  "NON GST 0": TaxIdName.NON_GST_0,
});

class Address {
  final String addressLine1;
  final String? addressLine2;
  final CompanyId country;
  final CompanyId state;
  final CompanyId city;
  final int pinCode;
  final BillingAddressId id;

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
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    country: CompanyId.fromJson(json["country"]),
    state: CompanyId.fromJson(json["state"]),
    city: CompanyId.fromJson(json["city"]),
    pinCode: json["pinCode"],
    id: billingAddressIdValues.map[json["_id"]] ?? BillingAddressId.THE_699828_F0675_F1_C7_B8_DDF7212,
  );

  Map<String, dynamic> toJson() => {
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "country": country.toJson(),
    "state": state.toJson(),
    "city": city.toJson(),
    "pinCode": pinCode,
    "_id": billingAddressIdValues.reverse[id],
  };
}

class CompanyId {
  final CompanyIdId id;
  final PlaceOfSupplyEnum name;

  CompanyId({required this.id, required this.name});

  factory CompanyId.fromRawJson(String str) =>
      CompanyId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyId.fromJson(Map<String, dynamic> json) => CompanyId(
    id: companyIdIdValues.map[json["_id"]] ?? CompanyIdId.THE_694_A6_CCF473_CEDF2701_A6386,
    name: placeOfSupplyEnumValues.map[json["name"]] ?? PlaceOfSupplyEnum.GUJARAT,
  );

  Map<String, dynamic> toJson() => {
    "_id": companyIdIdValues.reverse[id],
    "name": placeOfSupplyEnumValues.reverse[name],
  };
}

enum CompanyIdId {
  THE_694_A6_CCF473_CEDF2701_A6386,
  THE_696_E1_BD14_CBD5_D934_A9618_E5,
  THE_696_E1_CE64_CBD5_D934_A9618_ED,
  THE_696_F1735_F7033_F6945_F5_AFBF,
  THE_697053_AF229_EEC525_E68_C5_B1,
  THE_69706209229_EEC525_E68_D0_EC,
  THE_697_C761_BBCA4_EB2_E71_D246_F6,
  THE_69807_F4_A2_DB6_DA7_B0_F2_D79_FA,
  THE_6995_D0762_D0_B02_D9836563_CD,
  THE_6995_D5_C02_D0_B02_D983656497,
  THE_6995_D8_E72_D0_B02_D98365650_D,
  THE_69_A67558689120492_D8_AC90_A,
  THE_69_A68214_D582_DEE46113_C995,
}

final companyIdIdValues = EnumValues({
  "694a6ccf473cedf2701a6386": CompanyIdId.THE_694_A6_CCF473_CEDF2701_A6386,
  "696e1bd14cbd5d934a9618e5": CompanyIdId.THE_696_E1_BD14_CBD5_D934_A9618_E5,
  "696e1ce64cbd5d934a9618ed": CompanyIdId.THE_696_E1_CE64_CBD5_D934_A9618_ED,
  "696f1735f7033f6945f5afbf": CompanyIdId.THE_696_F1735_F7033_F6945_F5_AFBF,
  "697053af229eec525e68c5b1": CompanyIdId.THE_697053_AF229_EEC525_E68_C5_B1,
  "69706209229eec525e68d0ec": CompanyIdId.THE_69706209229_EEC525_E68_D0_EC,
  "697c761bbca4eb2e71d246f6": CompanyIdId.THE_697_C761_BBCA4_EB2_E71_D246_F6,
  "69807f4a2db6da7b0f2d79fa": CompanyIdId.THE_69807_F4_A2_DB6_DA7_B0_F2_D79_FA,
  "6995d0762d0b02d9836563cd": CompanyIdId.THE_6995_D0762_D0_B02_D9836563_CD,
  "6995d5c02d0b02d983656497": CompanyIdId.THE_6995_D5_C02_D0_B02_D983656497,
  "6995d8e72d0b02d98365650d": CompanyIdId.THE_6995_D8_E72_D0_B02_D98365650_D,
  "69a67558689120492d8ac90a": CompanyIdId.THE_69_A67558689120492_D8_AC90_A,
  "69a68214d582dee46113c995": CompanyIdId.THE_69_A68214_D582_DEE46113_C995,
});

enum PlaceOfSupplyEnum {
  DANG,
  DUO_FUSION1,
  GOA,
  GUJARAT,
  INDIA,
  NORTH_GOA,
  PIECES,
  PLUM_CAKE,
  RED_VELVET_CAKE,
  SURAT,
  UPDATE,
  UPT,
  UTP,
}

final placeOfSupplyEnumValues = EnumValues({
  "Dang": PlaceOfSupplyEnum.DANG,
  "Duo Fusion1": PlaceOfSupplyEnum.DUO_FUSION1,
  "Goa": PlaceOfSupplyEnum.GOA,
  "Gujarat": PlaceOfSupplyEnum.GUJARAT,
  "India": PlaceOfSupplyEnum.INDIA,
  "North Goa": PlaceOfSupplyEnum.NORTH_GOA,
  "PIECES": PlaceOfSupplyEnum.PIECES,
  "Plum Cake": PlaceOfSupplyEnum.PLUM_CAKE,
  "Red Velvet Cake": PlaceOfSupplyEnum.RED_VELVET_CAKE,
  "Surat": PlaceOfSupplyEnum.SURAT,
  "update": PlaceOfSupplyEnum.UPDATE,
  "upt": PlaceOfSupplyEnum.UPT,
  "utp": PlaceOfSupplyEnum.UTP,
});

enum BillingAddressId {
  THE_698980209_B8_C1_E41_C7226_EFF,
  THE_699828_F0675_F1_C7_B8_DDF7212,
  THE_69_B24_F85918_A03_C4936_A0_DC5,
  THE_69_B24_F85918_A03_C4936_A0_DC6,
}

final billingAddressIdValues = EnumValues({
  "698980209b8c1e41c7226eff":
      BillingAddressId.THE_698980209_B8_C1_E41_C7226_EFF,
  "699828f0675f1c7b8ddf7212":
      BillingAddressId.THE_699828_F0675_F1_C7_B8_DDF7212,
  "69b24f85918a03c4936a0dc5":
      BillingAddressId.THE_69_B24_F85918_A03_C4936_A0_DC5,
  "69b24f85918a03c4936a0dc6":
      BillingAddressId.THE_69_B24_F85918_A03_C4936_A0_DC6,
});

class CreatedBy {
  final UpdatedBy id;
  final FullName fullName;
  final UserType userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromRawJson(String str) =>
      CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: updatedByValues.map[json["_id"]] ?? UpdatedBy.THE_694_D017_B7_CB4009_F97_A30854,
    fullName: fullNameValues.map[json["fullName"]] ?? FullName.HARSHITHKDIGIVERSE,
    userType: userTypeValues.map[json["userType"]] ?? UserType.ADMIN,
  );

  Map<String, dynamic> toJson() => {
    "_id": updatedByValues.reverse[id],
    "fullName": fullNameValues.reverse[fullName],
    "userType": userTypeValues.reverse[userType],
  };
}

enum FullName { HARSHITHKDIGIVERSE, KRISH_GEDIYA, SHAKIL_GAHA }

final fullNameValues = EnumValues({
  "harshithkdigiverse": FullName.HARSHITHKDIGIVERSE,
  "Krish Gediya": FullName.KRISH_GEDIYA,
  "Shakil Gaha": FullName.SHAKIL_GAHA,
});

enum UpdatedBy {
  THE_694_D017_B7_CB4009_F97_A30854,
  THE_699_BECB3_E36_A172238520458,
  THE_699_C40239_F9_E8_A56822_E8929,
}

final updatedByValues = EnumValues({
  "694d017b7cb4009f97a30854": UpdatedBy.THE_694_D017_B7_CB4009_F97_A30854,
  "699becb3e36a172238520458": UpdatedBy.THE_699_BECB3_E36_A172238520458,
  "699c40239f9e8a56822e8929": UpdatedBy.THE_699_C40239_F9_E8_A56822_E8929,
});

enum UserType { ADMIN, SUPER_ADMIN }

final userTypeValues = EnumValues({
  "admin": UserType.ADMIN,
  "super-admin": UserType.SUPER_ADMIN,
});

class CustomerId {
  final CustomerIdId id;
  final FirstName firstName;
  final LastName lastName;
  final Email? email;
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
    id: customerIdIdValues.map[json["_id"]] ?? CustomerIdId.THE_69897_CE48_FC4_AAE4_B354_E5_E5,
    firstName: firstNameValues.map[json["firstName"]] ?? FirstName.KRISH,
    lastName: lastNameValues.map[json["lastName"]] ?? LastName.RADADIYA,
    email: emailValues.map[json["email"]],
    phoneNo: PhoneNo.fromJson(json["phoneNo"]),
    address: List<Address>.from(
      json["address"].map((x) => Address.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "_id": customerIdIdValues.reverse[id],
    "firstName": firstNameValues.reverse[firstName],
    "lastName": lastNameValues.reverse[lastName],
    "email": emailValues.reverse[email],
    "phoneNo": phoneNo.toJson(),
    "address": List<dynamic>.from(address.map((x) => x.toJson())),
  };
}

enum Email { JEELBOARD_GMAIL_COM, KRISH_GMAIL_COM }

final emailValues = EnumValues({
  "jeelboard@gmail.com": Email.JEELBOARD_GMAIL_COM,
  "krish@gmail.com": Email.KRISH_GMAIL_COM,
});

enum FirstName { BUNTYLAL, JEEL, KRISH }

final firstNameValues = EnumValues({
  "Buntylal": FirstName.BUNTYLAL,
  "Jeel ": FirstName.JEEL,
  "Krish ": FirstName.KRISH,
});

enum CustomerIdId {
  THE_69897_CE48_FC4_AAE4_B354_E5_E5,
  THE_699806_A0675_F1_C7_B8_DDF709_E,
  THE_699828_F0675_F1_C7_B8_DDF7211,
}

final customerIdIdValues = EnumValues({
  "69897ce48fc4aae4b354e5e5": CustomerIdId.THE_69897_CE48_FC4_AAE4_B354_E5_E5,
  "699806a0675f1c7b8ddf709e": CustomerIdId.THE_699806_A0675_F1_C7_B8_DDF709_E,
  "699828f0675f1c7b8ddf7211": CustomerIdId.THE_699828_F0675_F1_C7_B8_DDF7211,
});

enum LastName { BORAD, OVER_SMART, RADADIYA }

final lastNameValues = EnumValues({
  "Borad": LastName.BORAD,
  "OverSmart": LastName.OVER_SMART,
  "Radadiya": LastName.RADADIYA,
});

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
  final CompanyId productId;
  final int qty;
  final int freeQty;
  final CompanyId uomId;
  final Unit? unit;
  final int price;
  final int discount1;
  final int discount2;
  final TaxId taxId;
  final double? tax;
  final double taxableAmount;
  final double totalAmount;

  Item({
    required this.productId,
    required this.qty,
    required this.freeQty,
    required this.uomId,
    this.unit,
    required this.price,
    required this.discount1,
    required this.discount2,
    required this.taxId,
    this.tax,
    required this.taxableAmount,
    required this.totalAmount,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    productId: CompanyId.fromJson(json["productId"]),
    qty: json["qty"],
    freeQty: json["freeQty"],
    uomId: CompanyId.fromJson(json["uomId"]),
    unit: unitValues.map[json["unit"]],
    price: json["price"],
    discount1: json["discount1"],
    discount2: json["discount2"],
    taxId: TaxId.fromJson(json["taxId"]),
    tax: json["tax"]?.toDouble(),
    taxableAmount: json["taxableAmount"]?.toDouble(),
    totalAmount: json["totalAmount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId.toJson(),
    "qty": qty,
    "freeQty": freeQty,
    "uomId": uomId.toJson(),
    "unit": unitValues.reverse[unit],
    "price": price,
    "discount1": discount1,
    "discount2": discount2,
    "taxId": taxId.toJson(),
    "tax": tax,
    "taxableAmount": taxableAmount,
    "totalAmount": totalAmount,
  };
}

enum Unit { PCS, PIECES }

final unitValues = EnumValues({"PCS": Unit.PCS, "PIECES": Unit.PIECES});

enum PaymentTerms { THE_15_DAYS, THE_30_DAYS, THE_7_DAYS }

final paymentTermsValues = EnumValues({
  "15_days": PaymentTerms.THE_15_DAYS,
  "30_days": PaymentTerms.THE_30_DAYS,
  "7_days": PaymentTerms.THE_7_DAYS,
});

class PaymentTermsId {
  final String id;
  final String name;
  final int day;

  PaymentTermsId({required this.id, required this.name, required this.day});

  factory PaymentTermsId.fromRawJson(String str) =>
      PaymentTermsId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentTermsId.fromJson(Map<String, dynamic> json) =>
      PaymentTermsId(id: json["_id"], name: json["name"], day: json["day"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "day": day};
}

class ShippingDetails {
  final ShippingType shippingType;
  final int weight;
  final String id;
  final DateTime? shippingDate;
  final String? referenceNo;
  final DateTime? transportDate;
  final String? modeOfTransport;
  final String? transporterId;
  final String? vehicleNo;

  ShippingDetails({
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

  factory ShippingDetails.fromRawJson(String str) =>
      ShippingDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingDetails.fromJson(Map<String, dynamic> json) =>
      ShippingDetails(
        shippingType: shippingTypeValues.map[json["shippingType"]] ?? ShippingType.DELIVERY,
        weight: json["weight"],
        id: json["_id"],
        shippingDate: json["shippingDate"] == null
            ? null
            : DateTime.parse(json["shippingDate"]),
        referenceNo: json["referenceNo"],
        transportDate: json["transportDate"] == null
            ? null
            : DateTime.parse(json["transportDate"]),
        modeOfTransport: json["modeOfTransport"],
        transporterId: json["transporterId"],
        vehicleNo: json["vehicleNo"],
      );

  Map<String, dynamic> toJson() => {
    "shippingType": shippingTypeValues.reverse[shippingType],
    "weight": weight,
    "_id": id,
    "shippingDate": shippingDate?.toIso8601String(),
    "referenceNo": referenceNo,
    "transportDate": transportDate?.toIso8601String(),
    "modeOfTransport": modeOfTransport,
    "transporterId": transporterId,
    "vehicleNo": vehicleNo,
  };
}

enum ShippingType { DELIVERY }

final shippingTypeValues = EnumValues({"delivery": ShippingType.DELIVERY});

enum Status { INVOICE_CREATED, ORDER_CREATED, PENDING }

final statusValues = EnumValues({
  "invoice-created": Status.INVOICE_CREATED,
  "order-created": Status.ORDER_CREATED,
  "pending": Status.PENDING,
});

enum TaxType { DEFAULT, TAX_INCLUSIVE }

final taxTypeValues = EnumValues({
  "default": TaxType.DEFAULT,
  "tax_inclusive": TaxType.TAX_INCLUSIVE,
});

class TermsAndConditionId {
  final String id;
  final String termsCondition;

  TermsAndConditionId({required this.id, required this.termsCondition});

  factory TermsAndConditionId.fromRawJson(String str) =>
      TermsAndConditionId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsAndConditionId.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionId(
        id: json["_id"],
        termsCondition: json["termsCondition"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "termsCondition": termsCondition,
  };
}

class TransctionSummary {
  final int flatDiscount;
  final int grossAmount;
  final int discountAmount;
  final double taxableAmount;
  final double taxAmount;
  final double roundOff;
  final double netAmount;
  final String id;

  TransctionSummary({
    required this.flatDiscount,
    required this.grossAmount,
    required this.discountAmount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
    required this.id,
  });

  factory TransctionSummary.fromRawJson(String str) =>
      TransctionSummary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransctionSummary.fromJson(Map<String, dynamic> json) =>
      TransctionSummary(
        flatDiscount: json["flatDiscount"],
        grossAmount: json["grossAmount"],
        discountAmount: json["discountAmount"],
        taxableAmount: json["taxableAmount"]?.toDouble(),
        taxAmount: json["taxAmount"]?.toDouble(),
        roundOff: json["roundOff"]?.toDouble(),
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
  final int allEstimates;
  final int pending;
  final int orderCreated;
  final int invoiceCreated;

  Summary({
    required this.allEstimates,
    required this.pending,
    required this.orderCreated,
    required this.invoiceCreated,
  });

  factory Summary.fromRawJson(String str) => Summary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    allEstimates: json["allEstimates"],
    pending: json["pending"],
    orderCreated: json["orderCreated"],
    invoiceCreated: json["invoiceCreated"],
  );

  Map<String, dynamic> toJson() => {
    "allEstimates": allEstimates,
    "pending": pending,
    "orderCreated": orderCreated,
    "invoiceCreated": invoiceCreated,
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
