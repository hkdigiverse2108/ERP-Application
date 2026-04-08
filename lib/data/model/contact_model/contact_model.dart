import 'dart:convert';

class ContactModel {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy createdBy;
  final String updatedBy;
  final CompanyId companyId;
  final String firstName;
  final String lastName;
  final String? companyName;
  final String? email;
  final String? panNo;
  final String? telephoneNo;
  final String? remarks;
  final PhoneNo? phoneNo;
  final PhoneNo? whatsappNo;
  final DateTime? dob;
  final DateTime? anniversaryDate;
  final String? paymentMode;
  final String? paymentTerms;
  final OpeningBalance? openingBalance;
  final List<Address> address;
  final BankDetails? bankDetails;
  final List<String> productDetails;
  final String contactType;
  final String status;
  final double loyaltyPoints;
  final String? customerCategory;
  final String? supplierType;
  final String? customerType;
  final String? transporterId;
  final String? membershipId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ContactModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.firstName,
    required this.lastName,
    this.companyName,
    this.email,
    this.panNo,
    this.telephoneNo,
    this.remarks,
    this.phoneNo,
    this.whatsappNo,
    this.dob,
    this.anniversaryDate,
    this.paymentMode,
    this.paymentTerms,
    this.openingBalance,
    required this.address,
    this.bankDetails,
    required this.productDetails,
    required this.contactType,
    required this.status,
    required this.loyaltyPoints,
    this.customerCategory,
    this.supplierType,
    this.customerType,
    this.transporterId,
    this.membershipId,
    this.createdAt,
    this.updatedAt,
  });

  factory ContactModel.fromRawJson(String str) =>
      ContactModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
    id: json["_id"] ?? "",
    isDeleted: json["isDeleted"] ?? false,
    isActive: json["isActive"] ?? false,
    createdBy: CreatedBy.fromJson(json["createdBy"] ?? {}),
    updatedBy: json["updatedBy"] ?? "",
    companyId: CompanyId.fromJson(json["companyId"] ?? {}),
    firstName: json["firstName"] ?? "",
    lastName: json["lastName"] ?? "",
    companyName: json["companyName"],
    email: json["email"],
    panNo: json["panNo"],
    telephoneNo: json["telephoneNo"],
    remarks: json["remarks"],
    phoneNo: json["phoneNo"] == null ? null : PhoneNo.fromJson(json["phoneNo"]),
    whatsappNo: json["whatsappNo"] == null
        ? null
        : PhoneNo.fromJson(json["whatsappNo"]),
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    anniversaryDate: json["anniversaryDate"] == null
        ? null
        : DateTime.parse(json["anniversaryDate"]),
    paymentMode: json["paymentMode"],
    paymentTerms: json["paymentTerms"],
    openingBalance: json["openingBalance"] == null
        ? null
        : OpeningBalance.fromJson(json["openingBalance"]),
    address: json["address"] == null
        ? []
        : List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
    bankDetails: json["bankDetails"] == null
        ? null
        : BankDetails.fromJson(json["bankDetails"]),
    productDetails: json["productDetails"] == null
        ? []
        : List<String>.from(json["productDetails"].map((x) => x.toString())),
    contactType: json["contactType"] ?? "",
    status: json["status"] ?? "",
    loyaltyPoints: (json["loyaltyPoints"] ?? 0).toDouble(),
    customerCategory: json["customerCategory"],
    supplierType: json["supplierType"],
    customerType: json["customerType"],
    transporterId: json["transporterId"],
    membershipId: json["membershipId"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "firstName": firstName,
    "lastName": lastName,
    "companyName": companyName,
    "email": email,
    "panNo": panNo,
    "telephoneNo": telephoneNo,
    "remarks": remarks,
    "phoneNo": phoneNo?.toJson(),
    "whatsappNo": whatsappNo?.toJson(),
    "dob": dob?.toIso8601String(),
    "anniversaryDate": anniversaryDate?.toIso8601String(),
    "paymentMode": paymentMode,
    "paymentTerms": paymentTerms,
    "openingBalance": openingBalance?.toJson(),
    "address": List<dynamic>.from(address.map((x) => x.toJson())),
    "bankDetails": bankDetails?.toJson(),
    "productDetails": List<dynamic>.from(productDetails.map((x) => x)),
    "contactType": contactType,
    "status": status,
    "loyaltyPoints": loyaltyPoints,
    "customerCategory": customerCategory,
    "supplierType": supplierType,
    "customerType": customerType,
    "transporterId": transporterId,
    "membershipId": membershipId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Address {
  final String? gstType;
  final String? gstIn;
  final String? contactFirstName;
  final String? contactLastName;
  final String? contactCompanyName;
  final PhoneNo? contactNo;
  final String? contactEmail;
  final String? addressLine1;
  final String? addressLine2;
  final Location? country;
  final Location? state;
  final Location? city;
  final int? pinCode;
  final String id;

  Address({
    this.gstType,
    this.gstIn,
    this.contactFirstName,
    this.contactLastName,
    this.contactCompanyName,
    this.contactNo,
    this.contactEmail,
    this.addressLine1,
    this.addressLine2,
    this.country,
    this.state,
    this.city,
    this.pinCode,
    required this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    gstType: json["gstType"],
    gstIn: json["gstIn"],
    contactFirstName: json["contactFirstName"],
    contactLastName: json["contactLastName"],
    contactCompanyName: json["contactCompanyName"],
    contactNo: json["contactNo"] == null
        ? null
        : PhoneNo.fromJson(json["contactNo"]),
    contactEmail: json["contactEmail"],
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    country: json["country"] == null
        ? null
        : Location.fromJson(json["country"]),
    state: json["state"] == null ? null : Location.fromJson(json["state"]),
    city: json["city"] == null ? null : Location.fromJson(json["city"]),
    pinCode: json["pinCode"],
    id: json["_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "gstType": gstType,
    "gstIn": gstIn,
    "contactFirstName": contactFirstName,
    "contactLastName": contactLastName,
    "contactCompanyName": contactCompanyName,
    "contactNo": contactNo?.toJson(),
    "contactEmail": contactEmail,
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "country": country?.toJson(),
    "state": state?.toJson(),
    "city": city?.toJson(),
    "pinCode": pinCode,
    "_id": id,
  };
}

class Location {
  final String id;
  final String name;
  final String? code;

  Location({required this.id, required this.name, this.code});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["_id"] ?? "",
    name: json["name"] ?? "",
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "code": code};
}

class BankDetails {
  final String? ifscCode;
  final String? name;
  final String? branch;
  final String? accountNumber;

  BankDetails({this.ifscCode, this.name, this.branch, this.accountNumber});

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
    ifscCode: json["ifscCode"],
    name: json["name"],
    branch: json["branch"],
    accountNumber: json["accountNumber"],
  );

  Map<String, dynamic> toJson() => {
    "ifscCode": ifscCode,
    "name": name,
    "branch": branch,
    "accountNumber": accountNumber,
  };
}

class CompanyId {
  final String id;
  final String name;

  CompanyId({required this.id, required this.name});

  factory CompanyId.fromJson(Map<String, dynamic> json) =>
      CompanyId(id: json["_id"] ?? "", name: json["name"] ?? "");

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

class CreatedBy {
  final String id;
  final String fullName;
  final String userType;

  CreatedBy({required this.id, required this.fullName, required this.userType});

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["_id"] ?? "",
    fullName: json["fullName"] ?? "",
    userType: json["userType"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };
}

class OpeningBalance {
  final String debitBalance;
  final String creditBalance;

  OpeningBalance({required this.debitBalance, required this.creditBalance});

  factory OpeningBalance.fromJson(Map<String, dynamic> json) => OpeningBalance(
    debitBalance: json["debitBalance"] ?? "0",
    creditBalance: json["creditBalance"] ?? "0",
  );

  Map<String, dynamic> toJson() => {
    "debitBalance": debitBalance,
    "creditBalance": creditBalance,
  };
}

class PhoneNo {
  final dynamic phoneNo;
  final String countryCode;

  PhoneNo({required this.phoneNo, required this.countryCode});

  factory PhoneNo.fromJson(Map<String, dynamic> json) => PhoneNo(
    phoneNo: json["phoneNo"],
    countryCode: json["countryCode"] ?? "91",
  );

  Map<String, dynamic> toJson() => {
    "phoneNo": phoneNo,
    "countryCode": countryCode,
  };
}
