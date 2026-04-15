import 'dart:convert';

class CompanyModel {
  final String id;
  final String accountingType;
  final String name;
  final String displayName;
  final String contactName;
  final CompanyPhone ownerNo;
  final String supportEmail;
  final String email;
  final CompanyPhone phoneNo;
  final String customerCareNumber;
  final CompanyAddress address;
  final String userName;
  final String enableFeedbackModule;
  final String allowRoundOff;
  final String logo;
  final String waterMark;
  final String financialYear;
  final String? timeZone;
  final String? webSite;
  final String? panNo;
  final String? gstRegistrationType;
  final String? gstIdentificationNumber;
  final String? financialMonthInterval;
  final String? defaultFinancialYear;
  final String? corporateIdentificationNumber;
  final String? letterOfUndertaking;
  final String? taxDeductionAndCollectionAccountNumber;
  final String? importerExporterCode;
  final String? outletSize;
  final String? printDateFormat;
  final String? decimalPoint;
  final String? reportFormatLogo;
  final String? authorizedSignature;
  final BankInfo? bankId;
  final bool? isActive;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CompanyModel({
    required this.id,
    required this.accountingType,
    required this.name,
    required this.displayName,
    required this.contactName,
    required this.ownerNo,
    required this.supportEmail,
    required this.email,
    required this.phoneNo,
    required this.customerCareNumber,
    required this.address,
    required this.userName,
    required this.enableFeedbackModule,
    required this.allowRoundOff,
    required this.logo,
    required this.waterMark,
    required this.financialYear,
    this.timeZone,
    this.webSite,
    this.panNo,
    this.gstRegistrationType,
    this.gstIdentificationNumber,
    this.financialMonthInterval,
    this.defaultFinancialYear,
    this.corporateIdentificationNumber,
    this.letterOfUndertaking,
    this.taxDeductionAndCollectionAccountNumber,
    this.importerExporterCode,
    this.outletSize,
    this.printDateFormat,
    this.decimalPoint,
    this.reportFormatLogo,
    this.authorizedSignature,
    this.bankId,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory CompanyModel.fromRawJson(String str) =>
      CompanyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    id: json["_id"],
    accountingType: json["accountingType"] ?? '',
    name: json["name"] ?? '',
    displayName: json["displayName"] ?? '',
    contactName: json["contactName"] ?? '',
    ownerNo: CompanyPhone.fromJson(json["ownerNo"] ?? {}),
    supportEmail: json["supportEmail"] ?? '',
    email: json["email"] ?? '',
    phoneNo: CompanyPhone.fromJson(json["phoneNo"] ?? {}),
    customerCareNumber: json["customerCareNumber"] ?? '',
    address: CompanyAddress.fromJson(json["address"] ?? {}),
    userName: json["userName"] ?? '',
    enableFeedbackModule: json["enableFeedbackModule"]?.toString() ?? 'false',
    allowRoundOff: json["allowRoundOff"]?.toString() ?? 'false',
    logo: json["logo"] ?? '',
    waterMark: json["waterMark"] ?? '',
    financialYear: json["financialYear"] ?? '',
    timeZone: json["timeZone"],
    webSite: json["webSite"],
    panNo: json["PanNo"],
    gstRegistrationType: json["GSTRegistrationType"],
    gstIdentificationNumber: json["GSTIdentificationNumber"],
    financialMonthInterval: json["financialMonthInterval"],
    defaultFinancialYear: json["defaultFinancialYear"],
    corporateIdentificationNumber: json["corporateIdentificationNumber"],
    letterOfUndertaking: json["letterOfUndertaking"],
    taxDeductionAndCollectionAccountNumber:
        json["taxDeductionAndCollectionAccountNumber"],
    importerExporterCode: json["importerExporterCode"],
    outletSize: json["outletSize"],
    printDateFormat: json["printDateFormat"],
    decimalPoint: json["decimalPoint"],
    reportFormatLogo: json["reportFormatLogo"],
    authorizedSignature: json["authorizedSignature"],
    bankId: json["bankId"] != null
        ? BankInfo.fromJson(json["bankId"])
        : (json["bankName"] != null ? BankInfo.fromFlatJson(json) : null),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdAt: (json["createdAt"] ?? json["created_at"]) != null
        ? DateTime.parse(json["createdAt"] ?? json["created_at"])
        : null,
    updatedAt: (json["updatedAt"] ?? json["updated_at"]) != null
        ? DateTime.parse(json["updatedAt"] ?? json["updated_at"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "accountingType": accountingType,
    "name": name,
    "displayName": displayName,
    "contactName": contactName,
    "ownerNo": ownerNo.toJson(),
    "supportEmail": supportEmail,
    "email": email,
    "phoneNo": phoneNo.toJson(),
    "customerCareNumber": customerCareNumber,
    "address": address.toJson(),
    "userName": userName,
    "enableFeedbackModule": enableFeedbackModule,
    "allowRoundOff": allowRoundOff,
    "logo": logo,
    "waterMark": waterMark,
    "financialYear": financialYear,
    "timeZone": timeZone,
    "webSite": webSite,
    "PanNo": panNo,
    "GSTRegistrationType": gstRegistrationType,
    "GSTIdentificationNumber": gstIdentificationNumber,
    "financialMonthInterval": financialMonthInterval,
    "defaultFinancialYear": defaultFinancialYear,
    "corporateIdentificationNumber": corporateIdentificationNumber,
    "letterOfUndertaking": letterOfUndertaking,
    "taxDeductionAndCollectionAccountNumber":
        taxDeductionAndCollectionAccountNumber,
    "importerExporterCode": importerExporterCode,
    "outletSize": outletSize,
    "printDateFormat": printDateFormat,
    "decimalPoint": decimalPoint,
    "reportFormatLogo": reportFormatLogo,
    "authorizedSignature": authorizedSignature,
    "bankId": bankId?.toJson(),
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class CompanyPhone {
  final String countryCode;
  final dynamic phoneNo;

  CompanyPhone({required this.countryCode, required this.phoneNo});

  factory CompanyPhone.fromJson(Map<String, dynamic> json) => CompanyPhone(
    countryCode: json["countryCode"]?.toString() ?? '',
    phoneNo: json["phoneNo"],
  );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "phoneNo": phoneNo,
  };

  @override
  String toString() => "+$countryCode $phoneNo";
}

class CompanyAddress {
  final String address;
  final LocationInfo city;
  final LocationInfo state;
  final LocationInfo country;
  final dynamic pinCode;

  CompanyAddress({
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.pinCode,
  });

  factory CompanyAddress.fromJson(Map<String, dynamic> json) => CompanyAddress(
    address: json["address"] ?? '',
    city: LocationInfo.fromJson(json["city"] ?? {}),
    state: LocationInfo.fromJson(json["state"] ?? {}),
    country: LocationInfo.fromJson(json["country"] ?? {}),
    pinCode: json["pinCode"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "city": city.toJson(),
    "state": state.toJson(),
    "country": country.toJson(),
    "pinCode": pinCode,
  };
}

class LocationInfo {
  final String id;
  final String name;
  final String? code;

  LocationInfo({required this.id, required this.name, this.code});

  factory LocationInfo.fromJson(Map<String, dynamic> json) => LocationInfo(
    id: json["_id"] ?? json["id"] ?? '',
    name: json["name"] ?? '',
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    if (code != null) "code": code,
  };
}

class BankInfo {
  final String id;
  final String name;
  final String ifscCode;
  final String branchName;
  final String accountHolderName;
  final String bankAccountNumber;
  final String? swiftCode;
  final String? upiId;

  BankInfo({
    required this.id,
    required this.name,
    required this.ifscCode,
    required this.branchName,
    required this.accountHolderName,
    required this.bankAccountNumber,
    this.swiftCode,
    this.upiId,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    ifscCode: json["ifscCode"] ?? '',
    branchName: json["branchName"] ?? '',
    accountHolderName: json["accountHolderName"] ?? '',
    bankAccountNumber: json["bankAccountNumber"]?.toString() ?? '',
    swiftCode: json["swiftCode"],
    upiId: json["upiId"],
  );

  factory BankInfo.fromFlatJson(Map<String, dynamic> json) => BankInfo(
    id: '',
    name: json["bankName"] ?? '',
    ifscCode: json["bankIFSC"] ?? '',
    branchName: json["branch"] ?? '',
    accountHolderName: json["accountHolderName"] ?? '',
    bankAccountNumber: json["bankAccountNumber"]?.toString() ?? '',
    upiId: json["upiId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "ifscCode": ifscCode,
    "branchName": branchName,
    "accountHolderName": accountHolderName,
    "bankAccountNumber": bankAccountNumber,
    "swiftCode": swiftCode,
    "upiId": upiId,
  };
}
