import 'dart:convert';

class SalesCreditNoteMode {
  final List<SalesCreditNoteDatum> salesCreditNoteData;
  final int totalData;
  final State state;

  SalesCreditNoteMode({
    required this.salesCreditNoteData,
    required this.totalData,
    required this.state,
  });

  factory SalesCreditNoteMode.fromRawJson(String str) =>
      SalesCreditNoteMode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesCreditNoteMode.fromJson(Map<String, dynamic> json) =>
      SalesCreditNoteMode(
        salesCreditNoteData: json["salesCreditNote_data"] == null
            ? []
            : List<SalesCreditNoteDatum>.from(
                json["salesCreditNote_data"].map(
                  (x) => SalesCreditNoteDatum.fromJson(x),
                ),
              ),
        totalData: json["totalData"] ?? 0,
        state: json["state"] == null
            ? State(page: 1, limit: 10, totalPages: 1)
            : State.fromJson(json["state"]),
      );

  Map<String, dynamic> toJson() => {
    "salesCreditNote_data": List<dynamic>.from(
      salesCreditNoteData.map((x) => x.toJson()),
    ),
    "totalData": totalData,
    "state": state.toJson(),
  };
}

class SalesCreditNoteDatum {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final UpdatedBy updatedBy;
  final CompanyId companyId;
  final CustomerId customerId;
  final PlaceOfSupply placeOfSupply;
  final Address billingAddress;
  final Address shippingAddress;
  final DateTime creditNoteDate;
  final String creditNoteNo;
  final DateTime? dueDate;
  final String? reason;
  final bool reverseCharge;
  final String? sez;
  final bool paymentReminder;
  final String productType;
  final dynamic productDetails;
  final dynamic additionalCharges;
  final List<TermsAndConditionId> termsAndConditionIds;
  final String? notes;
  final ShippingDetails shippingDetails;
  final Summary summary;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SalesManId? salesManId;
  final SalesId? salesId;
  final String? accountLedgerId;

  SalesCreditNoteDatum({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.customerId,
    required this.placeOfSupply,
    required this.billingAddress,
    required this.shippingAddress,
    required this.creditNoteDate,
    required this.creditNoteNo,
    this.dueDate,
    this.reason,
    required this.reverseCharge,
    this.sez,
    required this.paymentReminder,
    required this.productType,
    required this.productDetails,
    required this.additionalCharges,
    required this.termsAndConditionIds,
    this.notes,
    required this.shippingDetails,
    required this.summary,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.salesManId,
    this.salesId,
    this.accountLedgerId,
  });

  factory SalesCreditNoteDatum.fromRawJson(String str) =>
      SalesCreditNoteDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesCreditNoteDatum.fromJson(
    Map<String, dynamic> json,
  ) => SalesCreditNoteDatum(
    id: json["_id"] ?? "",
    isDeleted: json["isDeleted"] ?? false,
    isActive: json["isActive"] ?? true,
    createdBy: json["createdBy"] == null
        ? CreatedBy(id: "", fullName: "", userType: "")
        : CreatedBy.fromJson(json["createdBy"]),
    updatedBy: json["updatedBy"] == null
        ? UpdatedBy(id: "", userType: "")
        : UpdatedBy.fromJson(json["updatedBy"]),
    companyId: json["companyId"] == null
        ? CompanyId(
            id: UomIdEnum.THE_69982_A4_D9_F5643_C708711_E61,
            name: PlaceOfSupply.GUJARAT,
          )
        : CompanyId.fromJson(json["companyId"]),
    customerId: json["customerId"] == null
        ? CustomerId(
            id: "",
            firstName: "",
            lastName: "",
            phoneNo: PhoneNo(countryCode: "", phoneNo: 0),
            address: [],
            contactType: "",
          )
        : CustomerId.fromJson(json["customerId"]),
    placeOfSupply:
        placeOfSupplyValues.map[json["placeOfSupply"]] ?? PlaceOfSupply.GUJARAT,
    billingAddress: json["billingAddress"] == null
        ? Address(
            addressLine1: "",
            country: CompanyId(
              id: UomIdEnum.THE_69982_A4_D9_F5643_C708711_E61,
              name: PlaceOfSupply.GUJARAT,
            ),
            state: CompanyId(
              id: UomIdEnum.THE_69982_A4_D9_F5643_C708711_E61,
              name: PlaceOfSupply.GUJARAT,
            ),
            city: CompanyId(
              id: UomIdEnum.THE_69982_A4_D9_F5643_C708711_E61,
              name: PlaceOfSupply.GUJARAT,
            ),
            pinCode: 0,
            id: Id.THE_698980209_B8_C1_E41_C7226_EFF,
          )
        : Address.fromJson(json["billingAddress"]),
    shippingAddress: json["shippingAddress"] == null
        ? Address(
            addressLine1: "",
            country: CompanyId(
              id: UomIdEnum.THE_69982_A4_D9_F5643_C708711_E61,
              name: PlaceOfSupply.GUJARAT,
            ),
            state: CompanyId(
              id: UomIdEnum.THE_69982_A4_D9_F5643_C708711_E61,
              name: PlaceOfSupply.GUJARAT,
            ),
            city: CompanyId(
              id: UomIdEnum.THE_69982_A4_D9_F5643_C708711_E61,
              name: PlaceOfSupply.GUJARAT,
            ),
            pinCode: 0,
            id: Id.THE_698980209_B8_C1_E41_C7226_EFF,
          )
        : Address.fromJson(json["shippingAddress"]),
    creditNoteDate: json["creditNoteDate"] == null
        ? DateTime.now()
        : DateTime.parse(json["creditNoteDate"]),
    creditNoteNo: json["creditNoteNo"] ?? "",
    dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
    reason: json["reason"],
    reverseCharge: json["reverseCharge"] ?? false,
    sez: json["sez"],
    paymentReminder: json["paymentReminder"] ?? false,
    productType: json["productType"] ?? "",
    productDetails: json["productDetails"],
    additionalCharges: json["additionalCharges"],
    termsAndConditionIds: json["termsAndConditionIds"] == null
        ? []
        : List<TermsAndConditionId>.from(
            json["termsAndConditionIds"].map(
              (x) => TermsAndConditionId.fromJson(x),
            ),
          ),
    notes: json["notes"],
    shippingDetails: json["shippingDetails"] == null
        ? ShippingDetails(shippingType: "", weight: 0.0)
        : ShippingDetails.fromJson(json["shippingDetails"]),
    summary: json["summary"] == null
        ? Summary(
            flatDiscount: 0,
            grossAmount: 0,
            discountAmount: 0,
            taxableAmount: 0,
            taxAmount: 0.0,
            roundOff: 0.0,
            netAmount: 0.0,
          )
        : Summary.fromJson(json["summary"]),
    status: json["status"] ?? "pending",
    createdAt: json["createdAt"] == null
        ? DateTime.now()
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? DateTime.now()
        : DateTime.parse(json["updatedAt"]),
    salesManId: json["salesManId"] == null
        ? null
        : SalesManId.fromJson(json["salesManId"]),
    salesId: json["salesId"] == null ? null : SalesId.fromJson(json["salesId"]),
    accountLedgerId: json["accountLedgerId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy.toJson(),
    "companyId": companyId.toJson(),
    "customerId": customerId.toJson(),
    "placeOfSupply": placeOfSupplyValues.reverse[placeOfSupply],
    "billingAddress": billingAddress.toJson(),
    "shippingAddress": shippingAddress.toJson(),
    "creditNoteDate": creditNoteDate.toIso8601String(),
    "creditNoteNo": creditNoteNo,
    "dueDate": dueDate?.toIso8601String(),
    "reason": reason,
    "reverseCharge": reverseCharge,
    "sez": sez,
    "paymentReminder": paymentReminder,
    "productType": productType,
    "productDetails": productDetails,
    "additionalCharges": additionalCharges,
    "termsAndConditionIds": List<dynamic>.from(
      termsAndConditionIds.map((x) => x.toJson()),
    ),
    "notes": notes,
    "shippingDetails": shippingDetails.toJson(),
    "summary": summary.toJson(),
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "salesManId": salesManId?.toJson(),
    "salesId": salesId?.toJson(),
    "accountLedgerId": accountLedgerId,
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
  final String type;
  final String name;

  ChargeId({required this.id, required this.type, required this.name});

  factory ChargeId.fromRawJson(String str) =>
      ChargeId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChargeId.fromJson(Map<String, dynamic> json) =>
      ChargeId(id: json["_id"], type: json["type"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "type": type, "name": name};
}

class TaxId {
  final String id;
  final String name;
  final int percentage;

  TaxId({required this.id, required this.name, required this.percentage});

  factory TaxId.fromRawJson(String str) => TaxId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxId.fromJson(Map<String, dynamic> json) => TaxId(
    id: json["_id"],
    name: json["name"],
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "percentage": percentage,
  };
}

class AdditionalChargesClass {
  final List<AdditionalChargesItem> items;
  final int total;

  AdditionalChargesClass({required this.items, required this.total});

  factory AdditionalChargesClass.fromRawJson(String str) =>
      AdditionalChargesClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdditionalChargesClass.fromJson(Map<String, dynamic> json) =>
      AdditionalChargesClass(
        items: List<AdditionalChargesItem>.from(
          json["items"].map((x) => AdditionalChargesItem.fromJson(x)),
        ),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "total": total,
  };
}

class AdditionalChargesItem {
  final String chargeId;
  final String taxId;
  final int amount;
  final int totalAmount;
  final String id;

  AdditionalChargesItem({
    required this.chargeId,
    required this.taxId,
    required this.amount,
    required this.totalAmount,
    required this.id,
  });

  factory AdditionalChargesItem.fromRawJson(String str) =>
      AdditionalChargesItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdditionalChargesItem.fromJson(Map<String, dynamic> json) =>
      AdditionalChargesItem(
        chargeId: json["chargeId"],
        taxId: json["taxId"],
        amount: json["amount"],
        totalAmount: json["totalAmount"],
        id: json["_id"],
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
  final CompanyId country;
  final CompanyId state;
  final CompanyId city;
  final int pinCode;
  final Id id;

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
    id: idValues.map[json["_id"]] ?? Id.THE_698980209_B8_C1_E41_C7226_EFF,
  );

  Map<String, dynamic> toJson() => {
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "country": country.toJson(),
    "state": state.toJson(),
    "city": city.toJson(),
    "pinCode": pinCode,
    "_id": idValues.reverse[id],
  };
}

class CompanyId {
  final UomIdEnum id;
  final PlaceOfSupply name;

  CompanyId({required this.id, required this.name});

  factory CompanyId.fromRawJson(String str) =>
      CompanyId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyId.fromJson(Map<String, dynamic> json) => CompanyId(
    id:
        uomIdEnumValues.map[json["_id"]] ??
        UomIdEnum.THE_69982_A4_D9_F5643_C708711_E61,
    name: placeOfSupplyValues.map[json["name"]] ?? PlaceOfSupply.GUJARAT,
  );

  Map<String, dynamic> toJson() => {
    "_id": uomIdEnumValues.reverse[id],
    "name": placeOfSupplyValues.reverse[name],
  };
}

enum UomIdEnum {
  THE_694_A6_CCF473_CEDF2701_A6386,
  THE_696_E1_BD14_CBD5_D934_A9618_E5,
  THE_696_E1_CE64_CBD5_D934_A9618_ED,
  THE_696_F1735_F7033_F6945_F5_AFBF,
  THE_697053_AF229_EEC525_E68_C5_B1,
  THE_69706209229_EEC525_E68_D0_EC,
  THE_697_C761_BBCA4_EB2_E71_D246_F6,
  THE_69807_F4_A2_DB6_DA7_B0_F2_D79_FA,
  THE_69982_A4_D9_F5643_C708711_E61,
}

final uomIdEnumValues = EnumValues({
  "694a6ccf473cedf2701a6386": UomIdEnum.THE_694_A6_CCF473_CEDF2701_A6386,
  "696e1bd14cbd5d934a9618e5": UomIdEnum.THE_696_E1_BD14_CBD5_D934_A9618_E5,
  "696e1ce64cbd5d934a9618ed": UomIdEnum.THE_696_E1_CE64_CBD5_D934_A9618_ED,
  "696f1735f7033f6945f5afbf": UomIdEnum.THE_696_F1735_F7033_F6945_F5_AFBF,
  "697053af229eec525e68c5b1": UomIdEnum.THE_697053_AF229_EEC525_E68_C5_B1,
  "69706209229eec525e68d0ec": UomIdEnum.THE_69706209229_EEC525_E68_D0_EC,
  "697c761bbca4eb2e71d246f6": UomIdEnum.THE_697_C761_BBCA4_EB2_E71_D246_F6,
  "69807f4a2db6da7b0f2d79fa": UomIdEnum.THE_69807_F4_A2_DB6_DA7_B0_F2_D79_FA,
  "69982a4d9f5643c708711e61": UomIdEnum.THE_69982_A4_D9_F5643_C708711_E61,
});

enum PlaceOfSupply {
  DANG,
  DUO_FUSION1,
  GOA,
  GUJARAT,
  INDIA,
  KG,
  NORTH_GOA,
  PIECES,
  SURAT,
}

final placeOfSupplyValues = EnumValues({
  "Dang": PlaceOfSupply.DANG,
  "Duo Fusion1": PlaceOfSupply.DUO_FUSION1,
  "Goa": PlaceOfSupply.GOA,
  "Gujarat": PlaceOfSupply.GUJARAT,
  "India": PlaceOfSupply.INDIA,
  "KG": PlaceOfSupply.KG,
  "North Goa": PlaceOfSupply.NORTH_GOA,
  "PIECES": PlaceOfSupply.PIECES,
  "Surat": PlaceOfSupply.SURAT,
});

enum Id {
  THE_698980209_B8_C1_E41_C7226_EFF,
  THE_6989_D76_F3_A4_F37602_D500875,
  THE_69_B24_F85918_A03_C4936_A0_DC5,
  THE_69_B24_F85918_A03_C4936_A0_DC6,
}

final idValues = EnumValues({
  "698980209b8c1e41c7226eff": Id.THE_698980209_B8_C1_E41_C7226_EFF,
  "6989d76f3a4f37602d500875": Id.THE_6989_D76_F3_A4_F37602_D500875,
  "69b24f85918a03c4936a0dc5": Id.THE_69_B24_F85918_A03_C4936_A0_DC5,
  "69b24f85918a03c4936a0dc6": Id.THE_69_B24_F85918_A03_C4936_A0_DC6,
});

class CreatedBy {
  final String id;
  final String fullName;
  final String userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromRawJson(String str) =>
      CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["_id"],
    fullName: json["fullName"],
    userType: json["userType"],
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
  final String? companyName;
  final String? email;
  final PhoneNo phoneNo;
  final List<Address> address;
  final String contactType;

  CustomerId({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.companyName,
    this.email,
    required this.phoneNo,
    required this.address,
    required this.contactType,
  });

  factory CustomerId.fromRawJson(String str) =>
      CustomerId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    companyName: json["companyName"],
    email: json["email"],
    phoneNo: PhoneNo.fromJson(json["phoneNo"]),
    address: List<Address>.from(
      json["address"].map((x) => Address.fromJson(x)),
    ),
    contactType: json["contactType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "companyName": companyName,
    "email": email,
    "phoneNo": phoneNo.toJson(),
    "address": List<dynamic>.from(address.map((x) => x.toJson())),
    "contactType": contactType,
  };
}

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

class ProductDetail {
  final ProductId productId;
  final CompanyId uomId;
  final PlaceOfSupply unit;
  final int qty;
  final int freeQty;
  final int price;
  final int discount1;
  final int discount2;
  final TaxId taxId;
  final double tax;
  final double total;

  ProductDetail({
    required this.productId,
    required this.uomId,
    required this.unit,
    required this.qty,
    required this.freeQty,
    required this.price,
    required this.discount1,
    required this.discount2,
    required this.taxId,
    required this.tax,
    required this.total,
  });

  factory ProductDetail.fromRawJson(String str) =>
      ProductDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    productId: ProductId.fromJson(json["productId"]),
    uomId: CompanyId.fromJson(json["uomId"]),
    unit: placeOfSupplyValues.map[json["unit"]] ?? PlaceOfSupply.PIECES,
    qty: json["qty"],
    freeQty: json["freeQty"],
    price: json["price"],
    discount1: json["discount1"],
    discount2: json["discount2"],
    taxId: TaxId.fromJson(json["taxId"]),
    tax: json["tax"]?.toDouble(),
    total: json["total"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId.toJson(),
    "uomId": uomId.toJson(),
    "unit": placeOfSupplyValues.reverse[unit],
    "qty": qty,
    "freeQty": freeQty,
    "price": price,
    "discount1": discount1,
    "discount2": discount2,
    "taxId": taxId.toJson(),
    "tax": tax,
    "total": total,
  };
}

class ProductId {
  final String id;
  final String name;
  final int? sellingPrice;

  ProductId({required this.id, required this.name, this.sellingPrice});

  factory ProductId.fromRawJson(String str) =>
      ProductId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
    id: json["_id"],
    name: json["name"],
    sellingPrice: json["sellingPrice"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "sellingPrice": sellingPrice,
  };
}

class ProductDetailsClass {
  final List<ProductDetailsItem> items;
  final int totalQty;
  final int totalFreeQty;
  final int totalTax;
  final int totalAmount;

  ProductDetailsClass({
    required this.items,
    required this.totalQty,
    required this.totalFreeQty,
    required this.totalTax,
    required this.totalAmount,
  });

  factory ProductDetailsClass.fromRawJson(String str) =>
      ProductDetailsClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDetailsClass.fromJson(Map<String, dynamic> json) =>
      ProductDetailsClass(
        items: List<ProductDetailsItem>.from(
          json["items"].map((x) => ProductDetailsItem.fromJson(x)),
        ),
        totalQty: json["totalQty"],
        totalFreeQty: json["totalFreeQty"],
        totalTax: json["totalTax"],
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "totalQty": totalQty,
    "totalFreeQty": totalFreeQty,
    "totalTax": totalTax,
    "totalAmount": totalAmount,
  };
}

class ProductDetailsItem {
  final String productId;
  final UomIdEnum uomId;
  final PlaceOfSupply unit;
  final int qty;
  final int freeQty;
  final int price;
  final int discount1;
  final int discount2;
  final String taxId;
  final int tax;
  final int total;

  ProductDetailsItem({
    required this.productId,
    required this.uomId,
    required this.unit,
    required this.qty,
    required this.freeQty,
    required this.price,
    required this.discount1,
    required this.discount2,
    required this.taxId,
    required this.tax,
    required this.total,
  });

  factory ProductDetailsItem.fromRawJson(String str) =>
      ProductDetailsItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDetailsItem.fromJson(Map<String, dynamic> json) =>
      ProductDetailsItem(
        productId: json["productId"],
        uomId:
            uomIdEnumValues.map[json["uomId"]] ??
            UomIdEnum.THE_69982_A4_D9_F5643_C708711_E61,
        unit: placeOfSupplyValues.map[json["unit"]] ?? PlaceOfSupply.PIECES,
        qty: json["qty"],
        freeQty: json["freeQty"],
        price: json["price"],
        discount1: json["discount1"],
        discount2: json["discount2"],
        taxId: json["taxId"],
        tax: json["tax"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "uomId": uomIdEnumValues.reverse[uomId],
    "unit": placeOfSupplyValues.reverse[unit],
    "qty": qty,
    "freeQty": freeQty,
    "price": price,
    "discount1": discount1,
    "discount2": discount2,
    "taxId": taxId,
    "tax": tax,
    "total": total,
  };
}

class SalesId {
  final String id;
  final String invoiceNo;

  SalesId({required this.id, required this.invoiceNo});

  factory SalesId.fromRawJson(String str) => SalesId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesId.fromJson(Map<String, dynamic> json) =>
      SalesId(id: json["_id"], invoiceNo: json["invoiceNo"]);

  Map<String, dynamic> toJson() => {"_id": id, "invoiceNo": invoiceNo};
}

class SalesManId {
  final String id;

  SalesManId({required this.id});

  factory SalesManId.fromRawJson(String str) =>
      SalesManId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesManId.fromJson(Map<String, dynamic> json) =>
      SalesManId(id: json["_id"]);

  Map<String, dynamic> toJson() => {"_id": id};
}

class ShippingDetails {
  final String shippingType;
  final DateTime? shippingDate;
  final String? referenceNo;
  final DateTime? transportDate;
  final String? modeOfTransport;
  final TransporterId? transporterId;
  final String? vehicleNo;
  final double weight;

  ShippingDetails({
    required this.shippingType,
    this.shippingDate,
    this.referenceNo,
    this.transportDate,
    this.modeOfTransport,
    this.transporterId,
    this.vehicleNo,
    required this.weight,
  });

  factory ShippingDetails.fromRawJson(String str) =>
      ShippingDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingDetails.fromJson(Map<String, dynamic> json) =>
      ShippingDetails(
        shippingType: json["shippingType"],
        shippingDate: json["shippingDate"] == null
            ? null
            : DateTime.parse(json["shippingDate"]),
        referenceNo: json["referenceNo"],
        transportDate: json["transportDate"] == null
            ? null
            : DateTime.parse(json["transportDate"]),
        modeOfTransport: json["modeOfTransport"],
        transporterId: json["transporterId"] == null
            ? null
            : TransporterId.fromJson(json["transporterId"]),
        vehicleNo: json["vehicleNo"],
        weight: json["weight"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "shippingType": shippingType,
    "shippingDate": shippingDate?.toIso8601String(),
    "referenceNo": referenceNo,
    "transportDate": transportDate?.toIso8601String(),
    "modeOfTransport": modeOfTransport,
    "transporterId": transporterId?.toJson(),
    "vehicleNo": vehicleNo,
    "weight": weight,
  };
}

class TransporterId {
  final String id;
  final String firstName;
  final String lastName;

  TransporterId({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory TransporterId.fromRawJson(String str) =>
      TransporterId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransporterId.fromJson(Map<String, dynamic> json) => TransporterId(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
  };
}

class Summary {
  final int flatDiscount;
  final int grossAmount;
  final int discountAmount;
  final int taxableAmount;
  final double taxAmount;
  final double roundOff;
  final double netAmount;

  Summary({
    required this.flatDiscount,
    required this.grossAmount,
    required this.discountAmount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.roundOff,
    required this.netAmount,
  });

  factory Summary.fromRawJson(String str) => Summary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    flatDiscount: json["flatDiscount"],
    grossAmount: json["grossAmount"],
    discountAmount: json["discountAmount"],
    taxableAmount: json["taxableAmount"],
    taxAmount: json["taxAmount"]?.toDouble(),
    roundOff: json["roundOff"]?.toDouble(),
    netAmount: json["netAmount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "flatDiscount": flatDiscount,
    "grossAmount": grossAmount,
    "discountAmount": discountAmount,
    "taxableAmount": taxableAmount,
    "taxAmount": taxAmount,
    "roundOff": roundOff,
    "netAmount": netAmount,
  };
}

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

class UpdatedBy {
  final String id;
  final String userType;

  UpdatedBy({required this.id, required this.userType});

  factory UpdatedBy.fromRawJson(String str) =>
      UpdatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdatedBy.fromJson(Map<String, dynamic> json) =>
      UpdatedBy(id: json["_id"], userType: json["userType"]);

  Map<String, dynamic> toJson() => {"_id": id, "userType": userType};
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
