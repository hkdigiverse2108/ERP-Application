import 'dart:convert';

import 'package:ai_setu/data/model/common/common_dropdown_model.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final PhoneNo phoneNo;
  final IdName? role;
  final String username;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy? createdBy;
  final CreatedBy? updatedBy;
  final IdName companyId;
  final IdName? branchId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Address address;
  final BankDetails? bankDetails;
  final int? commission;
  final String? designation;
  final int? extraWages;
  final String? panNumber;
  final int? target;
  final int? wages;
  final String? showPassword;
  final String userType;
  final String? profileImage;
  final String? token;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.role,
    required this.username,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    required this.companyId,
    required this.branchId,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    required this.bankDetails,
    this.commission,
    this.designation,
    this.extraWages,
    this.panNumber,
    this.target,
    this.wages,
    this.showPassword,
    required this.userType,
    this.profileImage,
    this.token,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    phoneNo: PhoneNo.fromJson(json["phoneNo"]),
    role: json["role"] != null ? IdName.fromJson(json["role"]) : null,
    username: json["username"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    createdBy: json["createdBy"] != null
        ? CreatedBy.fromJson(json["createdBy"])
        : null,
    updatedBy: json["updatedBy"] != null
        ? CreatedBy.fromJson(json["updatedBy"])
        : null,
    companyId: json["companyId"] != null
        ? IdName.fromJson(json["companyId"])
        : IdName(id: '', name: ''),
    branchId: json["branchId"] != null
        ? IdName.fromJson(json["branchId"])
        : null,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    address: json["address"] != null
        ? Address.fromJson(json["address"])
        : Address.empty(),
    bankDetails: json["bankDetails"] != null
        ? BankDetails.fromJson(json["bankDetails"])
        : BankDetails.empty(),
    commission: json["commission"],
    designation: json["designation"],
    extraWages: json["extraWages"],
    panNumber: json["panNumber"],
    target: json["target"],
    wages: json["wages"],
    showPassword: json["showPassword"],
    userType: json["userType"],
    profileImage: json["profileImage"],
    token: json["token"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "phoneNo": phoneNo.toJson(),
    "role": role?.toJson(),
    "username": username,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy?.toJson(),
    "updatedBy": updatedBy?.toJson(),
    "companyId": companyId.toJson(),
    "branchId": branchId?.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "address": address.toJson(),
    "bankDetails": bankDetails?.toJson(),
    "commission": commission,
    "designation": designation,
    "extraWages": extraWages,
    "panNumber": panNumber,
    "target": target,
    "wages": wages,
    "showPassword": showPassword,
    "userType": userType,
    "profileImage": profileImage,
    "token": token,
  };
}

class Address {
  final String address;
  final String country;
  final String countryId;
  final String state;
  final String stateId;
  final String city;
  final String cityId;
  final int pinCode;

  Address({
    required this.address,
    required this.country,
    required this.countryId,
    required this.state,
    required this.stateId,
    required this.city,
    required this.cityId,
    required this.pinCode,
  });

  factory Address.empty() => Address(
    address: '',
    country: '',
    countryId: '',
    state: '',
    stateId: '',
    city: '',
    cityId: '',
    pinCode: 0,
  );

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"] ?? '',
    country: json["country"] is Map ? json["country"]["name"] ?? '' : '',
    countryId: json["country"] is Map
        ? json["country"]["_id"] ?? json["country"]["id"] ?? ''
        : json["country"] ?? '',
    state: json["state"] is Map ? json["state"]["name"] ?? '' : '',
    stateId: json["state"] is Map
        ? json["state"]["_id"] ?? json["state"]["id"] ?? ''
        : json["state"] ?? '',
    city: json["city"] is Map ? json["city"]["name"] ?? '' : '',
    cityId: json["city"] is Map
        ? json["city"]["_id"] ?? json["city"]["id"] ?? ''
        : json["city"] ?? '',
    pinCode: int.tryParse(json["pinCode"]?.toString() ?? '') ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "country": country,
    "countryId": countryId,
    "state": state,
    "stateId": stateId,
    "city": city,
    "cityId": cityId,
    "pinCode": pinCode,
  };
}

class BankDetails {
  final String name;
  final String branchName;
  final String accountNumber;
  final String bankHolderName;
  final String swiftCode;
  final String ifscCode;

  BankDetails({
    required this.name,
    required this.branchName,
    required this.accountNumber,
    required this.bankHolderName,
    required this.swiftCode,
    required this.ifscCode,
  });

  factory BankDetails.empty() => BankDetails(
    name: '',
    branchName: '',
    accountNumber: '',
    bankHolderName: '',
    swiftCode: '',
    ifscCode: '',
  );

  factory BankDetails.fromRawJson(String str) =>
      BankDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
    name: json["name"],
    branchName: json["branchName"],
    accountNumber: json["accountNumber"],
    bankHolderName: json["bankHolderName"],
    swiftCode: json["swiftCode"],
    ifscCode: json["IFSCCode"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "branchName": branchName,
    "accountNumber": accountNumber,
    "bankHolderName": bankHolderName,
    "swiftCode": swiftCode,
    "IFSCCode": ifscCode,
  };
}

class IdName {
  final String id;
  final String name;
  final bool? isHeadBranch;

  IdName({required this.id, required this.name, this.isHeadBranch});

  factory IdName.fromJson(dynamic json) {
    // ✅ If API returns only ID string
    if (json is String) {
      return IdName(id: json, name: '');
    }

    // ✅ If API returns object
    return IdName(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      isHeadBranch: json["isHeadBranch"] ?? false,
    );
  }
  // add to json
  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    if (isHeadBranch != null) "isHeadBranch": isHeadBranch,
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

class CreatedBy {
  final String id;
  final String? fullName;
  final String? userType;

  CreatedBy({required this.id, this.fullName, this.userType});

  factory CreatedBy.fromJson(dynamic json) {
    // ✅ Case 1: If it's already a String (just ID)
    if (json is String) {
      return CreatedBy(id: json);
    }

    // ✅ Case 2: If it's a Map
    return CreatedBy(
      id: json["_id"] ?? '',
      fullName: json["fullName"],
      userType: json["userType"],
    );
  }
  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };
}

class UserDropDownModel {
  final String id;
  final String fullName;
  final CommonDropdownModel? role;
  final String userType;

  UserDropDownModel({
    required this.id,
    required this.fullName,
    required this.userType,
    required this.role,
  });

  factory UserDropDownModel.fromJson(Map<String, dynamic> json) =>
      UserDropDownModel(
        id: json["_id"],
        fullName: json["fullName"],
        userType: json["userType"],
        role: json["role"] != null
            ? CommonDropdownModel.fromJson(json["role"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
    "role": role?.toJson(),
  };
}
