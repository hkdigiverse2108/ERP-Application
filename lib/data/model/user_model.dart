import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/common_dropdown_model.dart';

class UserModel extends Equatable {
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

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    this.role,
    required this.username,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    required this.companyId,
    this.branchId,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    this.bankDetails,
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

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    PhoneNo? phoneNo,
    IdName? role,
    String? username,
    bool? isDeleted,
    bool? isActive,
    CreatedBy? createdBy,
    CreatedBy? updatedBy,
    IdName? companyId,
    IdName? branchId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Address? address,
    BankDetails? bankDetails,
    int? commission,
    String? designation,
    int? extraWages,
    String? panNumber,
    int? target,
    int? wages,
    String? showPassword,
    String? userType,
    String? profileImage,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      role: role ?? this.role,
      username: username ?? this.username,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      branchId: branchId ?? this.branchId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      address: address ?? this.address,
      bankDetails: bankDetails ?? this.bankDetails,
      commission: commission ?? this.commission,
      designation: designation ?? this.designation,
      extraWages: extraWages ?? this.extraWages,
      panNumber: panNumber ?? this.panNumber,
      target: target ?? this.target,
      wages: wages ?? this.wages,
      showPassword: showPassword ?? this.showPassword,
      userType: userType ?? this.userType,
      profileImage: profileImage ?? this.profileImage,
      token: token ?? this.token,
    );
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['_id'] as String? ?? '',
        fullName: map['fullName'] as String? ?? '',
        email: map['email'] as String? ?? '',
        phoneNo: PhoneNo.fromMap(map['phoneNo'] as Map<String, dynamic>),
        role: map['role'] != null
            ? IdName.fromMap(map['role'])
            : null,
        username: map['username'] as String? ?? '',
        isDeleted: map['isDeleted'] as bool? ?? false,
        isActive: map['isActive'] as bool? ?? false,
        createdBy: map['createdBy'] != null
            ? CreatedBy.fromMap(map['createdBy'])
            : null,
        updatedBy: map['updatedBy'] != null
            ? CreatedBy.fromMap(map['updatedBy'])
            : null,
        companyId: map['companyId'] != null
            ? IdName.fromMap(map['companyId'])
            : const IdName(id: '', name: ''),
        branchId: map['branchId'] != null
            ? IdName.fromMap(map['branchId'])
            : null,
        createdAt: map['createdAt'] != null
            ? DateTime.parse(map['createdAt'] as String)
            : DateTime.now(),
        updatedAt: map['updatedAt'] != null
            ? DateTime.parse(map['updatedAt'] as String)
            : DateTime.now(),
        address: map['address'] != null
            ? Address.fromMap(map['address'] as Map<String, dynamic>)
            : Address.empty(),
        bankDetails: map['bankDetails'] != null
            ? BankDetails.fromMap(map['bankDetails'] as Map<String, dynamic>)
            : null,
        commission: map['commission'] as int?,
        designation: map['designation'] as String?,
        extraWages: map['extraWages'] as int?,
        panNumber: map['panNumber'] as String?,
        target: map['target'] as int?,
        wages: map['wages'] as int?,
        showPassword: map['showPassword'] as String?,
        userType: map['userType'] as String? ?? '',
        profileImage: map['profileImage'] as String?,
        token: map['token'] as String? ?? '',
      );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        '_id': id,
        'fullName': fullName,
        'email': email,
        'phoneNo': phoneNo.toMap(),
        'role': role?.toMap(),
        'username': username,
        'isDeleted': isDeleted,
        'isActive': isActive,
        'createdBy': createdBy?.toMap(),
        'updatedBy': updatedBy?.toMap(),
        'companyId': companyId.toMap(),
        'branchId': branchId?.toMap(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'address': address.toMap(),
        'bankDetails': bankDetails?.toMap(),
        'commission': commission,
        'designation': designation,
        'extraWages': extraWages,
        'panNumber': panNumber,
        'target': target,
        'wages': wages,
        'showPassword': showPassword,
        'userType': userType,
        'profileImage': profileImage,
        'token': token,
      };

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        phoneNo,
        role,
        username,
        isDeleted,
        isActive,
        createdBy,
        updatedBy,
        companyId,
        branchId,
        createdAt,
        updatedAt,
        address,
        bankDetails,
        commission,
        designation,
        extraWages,
        panNumber,
        target,
        wages,
        showPassword,
        userType,
        profileImage,
        token,
      ];

  @override
  bool get stringify => true;
}

class Address extends Equatable {
  final String address;
  final String country;
  final String countryId;
  final String state;
  final String stateId;
  final String city;
  final String cityId;
  final int pinCode;

  const Address({
    required this.address,
    required this.country,
    required this.countryId,
    required this.state,
    required this.stateId,
    required this.city,
    required this.cityId,
    required this.pinCode,
  });

  factory Address.empty() => const Address(
        address: '',
        country: '',
        countryId: '',
        state: '',
        stateId: '',
        city: '',
        cityId: '',
        pinCode: 0,
      );

  Address copyWith({
    String? address,
    String? country,
    String? countryId,
    String? state,
    String? stateId,
    String? city,
    String? cityId,
    int? pinCode,
  }) {
    return Address(
      address: address ?? this.address,
      country: country ?? this.country,
      countryId: countryId ?? this.countryId,
      state: state ?? this.state,
      stateId: stateId ?? this.stateId,
      city: city ?? this.city,
      cityId: cityId ?? this.cityId,
      pinCode: pinCode ?? this.pinCode,
    );
  }

  factory Address.fromJson(String json) =>
      Address.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory Address.fromMap(Map<String, dynamic> map) => Address(
        address: map['address'] as String? ?? '',
        country: map['country'] is Map ? map['country']['name'] ?? '' : '',
        countryId: map['country'] is Map
            ? map['country']['_id'] ?? map['country']['id'] ?? ''
            : map['country'] ?? '',
        state: map['state'] is Map ? map['state']['name'] ?? '' : '',
        stateId: map['state'] is Map
            ? map['state']['_id'] ?? map['state']['id'] ?? ''
            : map['state'] ?? '',
        city: map['city'] is Map ? map['city']['name'] ?? '' : '',
        cityId: map['city'] is Map
            ? map['city']['_id'] ?? map['city']['id'] ?? ''
            : map['city'] ?? '',
        pinCode: int.tryParse(map['pinCode']?.toString() ?? '') ?? 0,
      );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        'address': address,
        'country': country,
        'countryId': countryId,
        'state': state,
        'stateId': stateId,
        'city': city,
        'cityId': cityId,
        'pinCode': pinCode,
      };

  @override
  List<Object?> get props => [
        address,
        country,
        countryId,
        state,
        stateId,
        city,
        cityId,
        pinCode,
      ];

  @override
  bool get stringify => true;
}

class BankDetails extends Equatable {
  final String name;
  final String branchName;
  final String accountNumber;
  final String bankHolderName;
  final String swiftCode;
  final String ifscCode;

  const BankDetails({
    required this.name,
    required this.branchName,
    required this.accountNumber,
    required this.bankHolderName,
    required this.swiftCode,
    required this.ifscCode,
  });

  factory BankDetails.empty() => const BankDetails(
        name: '',
        branchName: '',
        accountNumber: '',
        bankHolderName: '',
        swiftCode: '',
        ifscCode: '',
      );

  BankDetails copyWith({
    String? name,
    String? branchName,
    String? accountNumber,
    String? bankHolderName,
    String? swiftCode,
    String? ifscCode,
  }) {
    return BankDetails(
      name: name ?? this.name,
      branchName: branchName ?? this.branchName,
      accountNumber: accountNumber ?? this.accountNumber,
      bankHolderName: bankHolderName ?? this.bankHolderName,
      swiftCode: swiftCode ?? this.swiftCode,
      ifscCode: ifscCode ?? this.ifscCode,
    );
  }

  factory BankDetails.fromJson(String json) =>
      BankDetails.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory BankDetails.fromMap(Map<String, dynamic> map) => BankDetails(
        name: map['name'] as String? ?? '',
        branchName: map['branchName'] as String? ?? '',
        accountNumber: map['accountNumber'] as String? ?? '',
        bankHolderName: map['bankHolderName'] as String? ?? '',
        swiftCode: map['swiftCode'] as String? ?? '',
        ifscCode: map['IFSCCode'] as String? ?? '',
      );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        'name': name,
        'branchName': branchName,
        'accountNumber': accountNumber,
        'bankHolderName': bankHolderName,
        'swiftCode': swiftCode,
        'IFSCCode': ifscCode,
      };

  @override
  List<Object?> get props => [
        name,
        branchName,
        accountNumber,
        bankHolderName,
        swiftCode,
        ifscCode,
      ];

  @override
  bool get stringify => true;
}

class IdName extends Equatable {
  final String id;
  final String name;
  final bool? isHeadBranch;

  const IdName({required this.id, required this.name, this.isHeadBranch});

  IdName copyWith({
    String? id,
    String? name,
    bool? isHeadBranch,
  }) {
    return IdName(
      id: id ?? this.id,
      name: name ?? this.name,
      isHeadBranch: isHeadBranch ?? this.isHeadBranch,
    );
  }

  factory IdName.fromJson(String json) =>
      IdName.fromMap(jsonDecode(json));

  factory IdName.fromMap(dynamic json) {
    if (json is String) {
      return IdName(id: json, name: '');
    }

    return IdName(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      isHeadBranch: json['isHeadBranch'] as bool? ?? false,
    );
  }

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        if (isHeadBranch != null) 'isHeadBranch': isHeadBranch,
      };

  @override
  List<Object?> get props => [id, name, isHeadBranch];

  @override
  bool get stringify => true;
}

class PhoneNo extends Equatable {
  final String countryCode;
  final int phoneNo;

  const PhoneNo({required this.countryCode, required this.phoneNo});

  PhoneNo copyWith({
    String? countryCode,
    int? phoneNo,
  }) {
    return PhoneNo(
      countryCode: countryCode ?? this.countryCode,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }

  factory PhoneNo.fromJson(String json) =>
      PhoneNo.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory PhoneNo.fromMap(Map<String, dynamic> map) => PhoneNo(
        countryCode: map['countryCode'] as String? ?? '',
        phoneNo: (map['phoneNo'] as num? ?? 0).toInt(),
      );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        'countryCode': countryCode,
        'phoneNo': phoneNo,
      };

  @override
  List<Object?> get props => [countryCode, phoneNo];

  @override
  bool get stringify => true;
}

class CreatedBy extends Equatable {
  final String id;
  final String? fullName;
  final String? userType;

  const CreatedBy({required this.id, this.fullName, this.userType});

  CreatedBy copyWith({
    String? id,
    String? fullName,
    String? userType,
  }) {
    return CreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory CreatedBy.fromJson(String json) =>
      CreatedBy.fromMap(jsonDecode(json));

  factory CreatedBy.fromMap(dynamic json) {
    if (json is String) {
      return CreatedBy(id: json);
    }

    return CreatedBy(
      id: json['_id'] as String? ?? '',
      fullName: json['fullName'] as String?,
      userType: json['userType'] as String?,
    );
  }

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        '_id': id,
        'fullName': fullName,
        'userType': userType,
      };

  @override
  List<Object?> get props => [id, fullName, userType];

  @override
  bool get stringify => true;
}

class UserDropDownModel extends Equatable {
  final String id;
  final String fullName;
  final CommonDropdownModel? role;
  final String userType;

  const UserDropDownModel({
    required this.id,
    required this.fullName,
    required this.userType,
    this.role,
  });

  UserDropDownModel copyWith({
    String? id,
    String? fullName,
    CommonDropdownModel? role,
    String? userType,
  }) {
    return UserDropDownModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      userType: userType ?? this.userType,
    );
  }

  factory UserDropDownModel.fromJson(String json) =>
      UserDropDownModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory UserDropDownModel.fromMap(Map<String, dynamic> map) =>
      UserDropDownModel(
        id: map['_id'] as String? ?? '',
        fullName: map['fullName'] as String? ?? '',
        userType: map['userType'] as String? ?? '',
        role: map['role'] != null
            ? CommonDropdownModel.fromMap(map['role'] as Map<String, dynamic>)
            : null,
      );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        '_id': id,
        'fullName': fullName,
        'userType': userType,
        'role': role?.toMap(),
      };

  @override
  List<Object?> get props => [id, fullName, role, userType];

  @override
  bool get stringify => true;
}
