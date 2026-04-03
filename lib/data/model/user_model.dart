import 'dart:convert';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final PhoneNo phoneNo;
  final BranchId role;
  final String username;
  final bool isDeleted;
  final bool isActive;
  final String createdBy;
  final String updatedBy;
  final BranchId companyId;
  final BranchId branchId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Address address;
  final BankDetails bankDetails;
  final int commission;
  final String designation;
  final int extraWages;
  final String panNumber;
  final int target;
  final int wages;
  final String showPassword;
  final String userType;
  final dynamic profileImage;
  final String token;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.role,
    required this.username,
    required this.isDeleted,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.companyId,
    required this.branchId,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    required this.bankDetails,
    required this.commission,
    required this.designation,
    required this.extraWages,
    required this.panNumber,
    required this.target,
    required this.wages,
    required this.showPassword,
    required this.userType,
    required this.profileImage,
    required this.token,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    phoneNo: PhoneNo.fromJson(json["phoneNo"]),
    role: BranchId.fromJson(json["role"]),
    username: json["username"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
    companyId: BranchId.fromJson(json["companyId"]),
    branchId: BranchId.fromJson(json["branchId"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    address: Address.fromJson(json["address"]),
    bankDetails: BankDetails.fromJson(json["bankDetails"]),
    commission: json["commission"],
    designation: json["designation"],
    extraWages: json["extraWages"],
    panNumber: json["panNumber"],
    target: json["target"],
    wages: json["wages"],
    showPassword: json["showPassword"],
    userType: json["userType"],
    profileImage: json["profileImage"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "phoneNo": phoneNo.toJson(),
    "role": role.toJson(),
    "username": username,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "companyId": companyId.toJson(),
    "branchId": branchId.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "address": address.toJson(),
    "bankDetails": bankDetails.toJson(),
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
  final String state;
  final String city;
  final int pinCode;

  Address({
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.pinCode,
  });

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    pinCode: json["pinCode"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "country": country,
    "state": state,
    "city": city,
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

class BranchId {
  final String id;
  final String name;

  BranchId({required this.id, required this.name});

  factory BranchId.fromRawJson(String str) =>
      BranchId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BranchId.fromJson(Map<String, dynamic> json) =>
      BranchId(id: json["_id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
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
