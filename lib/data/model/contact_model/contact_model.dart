import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class ContactModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final ContactCreatedBy? createdBy;
  final String updatedBy;
  final IdNameModel? companyId;
  final String firstName;
  final String lastName;
  final String? companyName;
  final String? email;
  final String? panNo;
  final String? telephoneNo;
  final String? remarks;
  final ContactPhone? phoneNo;
  final ContactPhone? whatsappNo;
  final DateTime? dob;
  final DateTime? anniversaryDate;
  final String? paymentMode;
  final String? paymentTerms;
  final ContactOpeningBalance? openingBalance;
  final List<ContactAddress> address;
  final ContactBankDetails? bankDetails;
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

  const ContactModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    required this.updatedBy,
    this.companyId,
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

  ContactModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    ContactCreatedBy? createdBy,
    String? updatedBy,
    IdNameModel? companyId,
    String? firstName,
    String? lastName,
    String? companyName,
    String? email,
    String? panNo,
    String? telephoneNo,
    String? remarks,
    ContactPhone? phoneNo,
    ContactPhone? whatsappNo,
    DateTime? dob,
    DateTime? anniversaryDate,
    String? paymentMode,
    String? paymentTerms,
    ContactOpeningBalance? openingBalance,
    List<ContactAddress>? address,
    ContactBankDetails? bankDetails,
    List<String>? productDetails,
    String? contactType,
    String? status,
    double? loyaltyPoints,
    String? customerCategory,
    String? supplierType,
    String? customerType,
    String? transporterId,
    String? membershipId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ContactModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      companyName: companyName ?? this.companyName,
      email: email ?? this.email,
      panNo: panNo ?? this.panNo,
      telephoneNo: telephoneNo ?? this.telephoneNo,
      remarks: remarks ?? this.remarks,
      phoneNo: phoneNo ?? this.phoneNo,
      whatsappNo: whatsappNo ?? this.whatsappNo,
      dob: dob ?? this.dob,
      anniversaryDate: anniversaryDate ?? this.anniversaryDate,
      paymentMode: paymentMode ?? this.paymentMode,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      openingBalance: openingBalance ?? this.openingBalance,
      address: address ?? this.address,
      bankDetails: bankDetails ?? this.bankDetails,
      productDetails: productDetails ?? this.productDetails,
      contactType: contactType ?? this.contactType,
      status: status ?? this.status,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      customerCategory: customerCategory ?? this.customerCategory,
      supplierType: supplierType ?? this.supplierType,
      customerType: customerType ?? this.customerType,
      transporterId: transporterId ?? this.transporterId,
      membershipId: membershipId ?? this.membershipId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ContactModel.fromJson(String json) =>
      ContactModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory ContactModel.fromMap(Map<String, dynamic> map) => ContactModel(
        id: map["_id"]?.toString() ?? "",
        isDeleted: map["isDeleted"] as bool? ?? false,
        isActive: map["isActive"] as bool? ?? true,
        createdBy: map["createdBy"] == null
            ? null
            : ContactCreatedBy.fromMap(map["createdBy"] as Map<String, dynamic>),
        updatedBy: map["updatedBy"]?.toString() ?? "",
        companyId:
            map["companyId"] == null ? null : IdNameModel.fromMap(map["companyId"]),
        firstName: map["firstName"]?.toString() ?? "",
        lastName: map["lastName"]?.toString() ?? "",
        companyName: map["companyName"]?.toString(),
        email: map["email"]?.toString(),
        panNo: map["panNo"]?.toString(),
        telephoneNo: map["telephoneNo"]?.toString(),
        remarks: map["remarks"]?.toString(),
        phoneNo: map["phoneNo"] == null
            ? null
            : ContactPhone.fromMap(map["phoneNo"] as Map<String, dynamic>),
        whatsappNo: map["whatsappNo"] == null
            ? null
            : ContactPhone.fromMap(map["whatsappNo"] as Map<String, dynamic>),
        dob: map["dob"] != null ? DateTime.parse(map["dob"].toString()) : null,
        anniversaryDate: map["anniversaryDate"] != null
            ? DateTime.parse(map["anniversaryDate"].toString())
            : null,
        paymentMode: map["paymentMode"]?.toString(),
        paymentTerms: map["paymentTerms"]?.toString(),
        openingBalance: map["openingBalance"] == null
            ? null
            : ContactOpeningBalance.fromMap(
                map["openingBalance"] as Map<String, dynamic>),
        address: List<ContactAddress>.from(
          (map["address"] as List<dynamic>?)?.map(
                (x) => ContactAddress.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        bankDetails: map["bankDetails"] == null
            ? null
            : ContactBankDetails.fromMap(
                map["bankDetails"] as Map<String, dynamic>),
        productDetails: List<String>.from(
          (map["productDetails"] as List<dynamic>?)?.map((x) => x.toString()) ??
              [],
        ),
        contactType: map["contactType"]?.toString() ?? "",
        status: map["status"]?.toString() ?? "",
        loyaltyPoints: (map["loyaltyPoints"] as num? ?? 0).toDouble(),
        customerCategory: map["customerCategory"]?.toString(),
        supplierType: map["supplierType"]?.toString(),
        customerType: map["customerType"]?.toString(),
        transporterId: map["transporterId"]?.toString(),
        membershipId: map["membershipId"]?.toString(),
        createdAt: map["createdAt"] != null
            ? DateTime.parse(map["createdAt"].toString())
            : null,
        updatedAt: map["updatedAt"] != null
            ? DateTime.parse(map["updatedAt"].toString())
            : null,
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy?.toMap(),
        "updatedBy": updatedBy,
        "companyId": companyId?.toMap(),
        "firstName": firstName,
        "lastName": lastName,
        "companyName": companyName,
        "email": email,
        "panNo": panNo,
        "telephoneNo": telephoneNo,
        "remarks": remarks,
        "phoneNo": phoneNo?.toMap(),
        "whatsappNo": whatsappNo?.toMap(),
        "dob": dob?.toIso8601String(),
        "anniversaryDate": anniversaryDate?.toIso8601String(),
        "paymentMode": paymentMode,
        "paymentTerms": paymentTerms,
        "openingBalance": openingBalance?.toMap(),
        "address": address.map((x) => x.toMap()).toList(),
        "bankDetails": bankDetails?.toMap(),
        "productDetails": productDetails,
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

  @override
  List<Object?> get props => [
        id,
        isDeleted,
        isActive,
        createdBy,
        updatedBy,
        companyId,
        firstName,
        lastName,
        companyName,
        email,
        panNo,
        telephoneNo,
        remarks,
        phoneNo,
        whatsappNo,
        dob,
        anniversaryDate,
        paymentMode,
        paymentTerms,
        openingBalance,
        address,
        bankDetails,
        productDetails,
        contactType,
        status,
        loyaltyPoints,
        customerCategory,
        supplierType,
        customerType,
        transporterId,
        membershipId,
        createdAt,
        updatedAt,
      ];

  @override
  bool get stringify => true;
}

class ContactAddress extends Equatable {
  final String? gstType;
  final String? gstIn;
  final String? contactFirstName;
  final String? contactLastName;
  final String? contactCompanyName;
  final ContactPhone? contactNo;
  final String? contactEmail;
  final String? addressLine1;
  final String? addressLine2;
  final ContactLocation? country;
  final ContactLocation? state;
  final ContactLocation? city;
  final int? pinCode;
  final String id;

  const ContactAddress({
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

  ContactAddress copyWith({
    String? gstType,
    String? gstIn,
    String? contactFirstName,
    String? contactLastName,
    String? contactCompanyName,
    ContactPhone? contactNo,
    String? contactEmail,
    String? addressLine1,
    String? addressLine2,
    ContactLocation? country,
    ContactLocation? state,
    ContactLocation? city,
    int? pinCode,
    String? id,
  }) {
    return ContactAddress(
      gstType: gstType ?? this.gstType,
      gstIn: gstIn ?? this.gstIn,
      contactFirstName: contactFirstName ?? this.contactFirstName,
      contactLastName: contactLastName ?? this.contactLastName,
      contactCompanyName: contactCompanyName ?? this.contactCompanyName,
      contactNo: contactNo ?? this.contactNo,
      contactEmail: contactEmail ?? this.contactEmail,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      pinCode: pinCode ?? this.pinCode,
      id: id ?? this.id,
    );
  }

  factory ContactAddress.fromJson(String json) =>
      ContactAddress.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory ContactAddress.fromMap(Map<String, dynamic> map) => ContactAddress(
        gstType: map["gstType"]?.toString(),
        gstIn: map["gstIn"]?.toString(),
        contactFirstName: map["contactFirstName"]?.toString(),
        contactLastName: map["contactLastName"]?.toString(),
        contactCompanyName: map["contactCompanyName"]?.toString(),
        contactNo: map["contactNo"] == null
            ? null
            : ContactPhone.fromMap(map["contactNo"] as Map<String, dynamic>),
        contactEmail: map["contactEmail"]?.toString(),
        addressLine1: map["addressLine1"]?.toString(),
        addressLine2: map["addressLine2"]?.toString(),
        country: map["country"] == null
            ? null
            : ContactLocation.fromMap(map["country"] as Map<String, dynamic>),
        state: map["state"] == null
            ? null
            : ContactLocation.fromMap(map["state"] as Map<String, dynamic>),
        city: map["city"] == null
            ? null
            : ContactLocation.fromMap(map["city"] as Map<String, dynamic>),
        pinCode: map["pinCode"] as int?,
        id: map["_id"]?.toString() ?? "",
      );

  Map<String, dynamic> toMap() => {
        "gstType": gstType,
        "gstIn": gstIn,
        "contactFirstName": contactFirstName,
        "contactLastName": contactLastName,
        "contactCompanyName": contactCompanyName,
        "contactNo": contactNo?.toMap(),
        "contactEmail": contactEmail,
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
        gstType,
        gstIn,
        contactFirstName,
        contactLastName,
        contactCompanyName,
        contactNo,
        contactEmail,
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

class ContactLocation extends Equatable {
  final String id;
  final String name;
  final String? code;

  const ContactLocation({required this.id, required this.name, this.code});

  ContactLocation copyWith({String? id, String? name, String? code}) {
    return ContactLocation(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  factory ContactLocation.fromJson(String json) =>
      ContactLocation.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory ContactLocation.fromMap(Map<String, dynamic> map) => ContactLocation(
        id: map["_id"]?.toString() ?? "",
        name: map["name"]?.toString() ?? "",
        code: map["code"]?.toString(),
      );

  Map<String, dynamic> toMap() => {"_id": id, "name": name, "code": code};

  @override
  List<Object?> get props => [id, name, code];

  @override
  bool get stringify => true;
}

class ContactBankDetails extends Equatable {
  final String? ifscCode;
  final String? name;
  final String? branch;
  final String? accountNumber;

  const ContactBankDetails({
    this.ifscCode,
    this.name,
    this.branch,
    this.accountNumber,
  });

  ContactBankDetails copyWith({
    String? ifscCode,
    String? name,
    String? branch,
    String? accountNumber,
  }) {
    return ContactBankDetails(
      ifscCode: ifscCode ?? this.ifscCode,
      name: name ?? this.name,
      branch: branch ?? this.branch,
      accountNumber: accountNumber ?? this.accountNumber,
    );
  }

  factory ContactBankDetails.fromJson(String json) =>
      ContactBankDetails.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory ContactBankDetails.fromMap(Map<String, dynamic> map) =>
      ContactBankDetails(
        ifscCode: map["ifscCode"]?.toString(),
        name: map["name"]?.toString(),
        branch: map["branch"]?.toString(),
        accountNumber: map["accountNumber"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
        "ifscCode": ifscCode,
        "name": name,
        "branch": branch,
        "accountNumber": accountNumber,
      };

  @override
  List<Object?> get props => [ifscCode, name, branch, accountNumber];

  @override
  bool get stringify => true;
}

class ContactCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const ContactCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  ContactCreatedBy copyWith({
    String? id,
    String? fullName,
    String? userType,
  }) {
    return ContactCreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory ContactCreatedBy.fromJson(String json) =>
      ContactCreatedBy.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory ContactCreatedBy.fromMap(Map<String, dynamic> map) => ContactCreatedBy(
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

class ContactOpeningBalance extends Equatable {
  final String debitBalance;
  final String creditBalance;

  const ContactOpeningBalance({
    required this.debitBalance,
    required this.creditBalance,
  });

  ContactOpeningBalance copyWith({String? debitBalance, String? creditBalance}) {
    return ContactOpeningBalance(
      debitBalance: debitBalance ?? this.debitBalance,
      creditBalance: creditBalance ?? this.creditBalance,
    );
  }

  factory ContactOpeningBalance.fromJson(String json) =>
      ContactOpeningBalance.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory ContactOpeningBalance.fromMap(Map<String, dynamic> map) =>
      ContactOpeningBalance(
        debitBalance: map["debitBalance"]?.toString() ?? "0",
        creditBalance: map["creditBalance"]?.toString() ?? "0",
      );

  Map<String, dynamic> toMap() => {
        "debitBalance": debitBalance,
        "creditBalance": creditBalance,
      };

  @override
  List<Object?> get props => [debitBalance, creditBalance];

  @override
  bool get stringify => true;
}

class ContactPhone extends Equatable {
  final dynamic phoneNo;
  final String countryCode;

  const ContactPhone({required this.phoneNo, required this.countryCode});

  ContactPhone copyWith({dynamic phoneNo, String? countryCode}) {
    return ContactPhone(
      phoneNo: phoneNo ?? this.phoneNo,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  factory ContactPhone.fromJson(String json) =>
      ContactPhone.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory ContactPhone.fromMap(Map<String, dynamic> map) => ContactPhone(
        phoneNo: map["phoneNo"],
        countryCode: map["countryCode"]?.toString() ?? "91",
      );

  Map<String, dynamic> toMap() => {
        "phoneNo": phoneNo,
        "countryCode": countryCode,
      };

  @override
  List<Object?> get props => [phoneNo, countryCode];

  @override
  bool get stringify => true;
}

class ContactDropdownModel extends Equatable {
  final String id;
  final String name;
  final String firstName;
  final String lastName;
  final ContactType contactType;
  final List<ContactAddress> address;
  final String? email;
  final ContactPhone phoneNo;
  final String? customerType;
  final DateTime? dob;
  final ContactPhone? whatsappNo;

  const ContactDropdownModel({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.contactType,
    required this.address,
    this.email,
    required this.phoneNo,
    this.customerType,
    this.dob,
    this.whatsappNo,
  });

  ContactDropdownModel copyWith({
    String? id,
    String? name,
    String? firstName,
    String? lastName,
    ContactType? contactType,
    List<ContactAddress>? address,
    String? email,
    ContactPhone? phoneNo,
    String? customerType,
    DateTime? dob,
    ContactPhone? whatsappNo,
  }) {
    return ContactDropdownModel(
      id: id ?? this.id,
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      contactType: contactType ?? this.contactType,
      address: address ?? this.address,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      customerType: customerType ?? this.customerType,
      dob: dob ?? this.dob,
      whatsappNo: whatsappNo ?? this.whatsappNo,
    );
  }

  factory ContactDropdownModel.fromJson(String json) =>
      ContactDropdownModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory ContactDropdownModel.fromMap(Map<String, dynamic> map) =>
      ContactDropdownModel(
        id: map["_id"]?.toString() ?? "",
        name: map["name"]?.toString() ?? "",
        firstName: map["firstName"]?.toString() ?? "",
        lastName: map["lastName"]?.toString() ?? "",
        contactType: ContactType.values.firstWhere(
          (e) => e.name == map["contactType"],
          orElse: () => ContactType.customer,
        ),
        address: List<ContactAddress>.from(
          (map["address"] as List<dynamic>?)?.map(
                (x) => ContactAddress.fromMap(x as Map<String, dynamic>),
              ) ??
              [],
        ),
        email: map["email"]?.toString(),
        phoneNo: ContactPhone.fromMap(map["phoneNo"] as Map<String, dynamic>),
        customerType: map["customerType"]?.toString(),
        dob: map["dob"] != null ? DateTime.parse(map["dob"].toString()) : null,
        whatsappNo: map["whatsappNo"] == null
            ? null
            : ContactPhone.fromMap(map["whatsappNo"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "firstName": firstName,
        "lastName": lastName,
        "contactType": contactType.name,
        "address": address.map((x) => x.toMap()).toList(),
        "email": email,
        "phoneNo": phoneNo.toMap(),
        "customerType": customerType,
        "dob": dob?.toIso8601String(),
        "whatsappNo": whatsappNo?.toMap(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        firstName,
        lastName,
        contactType,
        address,
        email,
        phoneNo,
        customerType,
        dob,
        whatsappNo,
      ];

  @override
  bool get stringify => true;
}
