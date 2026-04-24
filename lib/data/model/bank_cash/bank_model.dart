import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class BankModel extends Equatable {
  final String id;
  final String name;
  final String ifscCode;
  final String branchName;
  final String accountHolderName;
  final String bankAccountNumber;
  final String swiftCode;
  final BankOpeningBalance openingBalance;
  final String upiId;
  final String addressLine1;
  final String addressLine2;
  final String country;
  final String state;
  final String city;
  final String zipCode;
  final List<IdNameModel> branchIds;
  final bool isDeleted;
  final bool isActive;
  final BankCreatedBy? createdBy;
  final String updatedBy;
  final IdNameModel? companyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BankModel({
    required this.id,
    required this.name,
    required this.ifscCode,
    required this.branchName,
    required this.accountHolderName,
    required this.bankAccountNumber,
    required this.swiftCode,
    required this.openingBalance,
    required this.upiId,
    required this.addressLine1,
    required this.addressLine2,
    required this.country,
    required this.state,
    required this.city,
    required this.zipCode,
    required this.branchIds,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    required this.updatedBy,
    this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  BankModel copyWith({
    String? id,
    String? name,
    String? ifscCode,
    String? branchName,
    String? accountHolderName,
    String? bankAccountNumber,
    String? swiftCode,
    BankOpeningBalance? openingBalance,
    String? upiId,
    String? addressLine1,
    String? addressLine2,
    String? country,
    String? state,
    String? city,
    String? zipCode,
    List<IdNameModel>? branchIds,
    bool? isDeleted,
    bool? isActive,
    BankCreatedBy? createdBy,
    String? updatedBy,
    IdNameModel? companyId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BankModel(
      id: id ?? this.id,
      name: name ?? this.name,
      ifscCode: ifscCode ?? this.ifscCode,
      branchName: branchName ?? this.branchName,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      swiftCode: swiftCode ?? this.swiftCode,
      openingBalance: openingBalance ?? this.openingBalance,
      upiId: upiId ?? this.upiId,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      zipCode: zipCode ?? this.zipCode,
      branchIds: branchIds ?? this.branchIds,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory BankModel.fromJson(String json) =>
      BankModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory BankModel.fromMap(Map<String, dynamic> map) => BankModel(
        id: map["_id"]?.toString() ?? "",
        name: map["name"]?.toString() ?? "",
        ifscCode: map["ifscCode"]?.toString() ?? "",
        branchName: map["branchName"]?.toString() ?? "",
        accountHolderName: map["accountHolderName"]?.toString() ?? "",
        bankAccountNumber: map["bankAccountNumber"]?.toString() ?? "",
        swiftCode: map["swiftCode"]?.toString() ?? "",
        openingBalance: map["openingBalance"] != null
            ? BankOpeningBalance.fromMap(
                map["openingBalance"] as Map<String, dynamic>)
            : const BankOpeningBalance(creditBalance: "0", debitBalance: "0"),
        upiId: map["upiId"]?.toString() ?? "",
        addressLine1: map["addressLine1"]?.toString() ?? "",
        addressLine2: map["addressLine2"]?.toString() ?? "",
        country: map["country"]?.toString() ?? "",
        state: map["state"]?.toString() ?? "",
        city: map["city"]?.toString() ?? "",
        zipCode: map["zipCode"]?.toString() ?? "",
        branchIds: List<IdNameModel>.from(
          (map["branchIds"] as List<dynamic>?)?.map(
                (x) => IdNameModel.fromMap(x),
              ) ??
              [],
        ),
        isDeleted: map["isDeleted"] as bool? ?? false,
        isActive: map["isActive"] as bool? ?? true,
        createdBy: map["createdBy"] == null
            ? null
            : BankCreatedBy.fromMap(map["createdBy"] as Map<String, dynamic>),
        updatedBy: map["updatedBy"]?.toString() ?? "",
        companyId:
            map["companyId"] == null ? null : IdNameModel.fromMap(map["companyId"]),
        createdAt: map["createdAt"] != null
            ? DateTime.parse(map["createdAt"].toString())
            : DateTime.now(),
        updatedAt: map["updatedAt"] != null
            ? DateTime.parse(map["updatedAt"].toString())
            : DateTime.now(),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "ifscCode": ifscCode,
        "branchName": branchName,
        "accountHolderName": accountHolderName,
        "bankAccountNumber": bankAccountNumber,
        "swiftCode": swiftCode,
        "openingBalance": openingBalance.toMap(),
        "upiId": upiId,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "country": country,
        "state": state,
        "city": city,
        "zipCode": zipCode,
        "branchIds": branchIds.map((e) => e.toMap()).toList(),
        "isDeleted": isDeleted,
        "isActive": isActive,
        "createdBy": createdBy?.toMap(),
        "updatedBy": updatedBy,
        "companyId": companyId?.toMap(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        ifscCode,
        branchName,
        accountHolderName,
        bankAccountNumber,
        swiftCode,
        openingBalance,
        upiId,
        addressLine1,
        addressLine2,
        country,
        state,
        city,
        zipCode,
        branchIds,
        isDeleted,
        isActive,
        createdBy,
        updatedBy,
        companyId,
        createdAt,
        updatedAt,
      ];

  @override
  bool get stringify => true;
}

class BankCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const BankCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  BankCreatedBy copyWith({
    String? id,
    String? fullName,
    String? userType,
  }) {
    return BankCreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory BankCreatedBy.fromJson(String json) =>
      BankCreatedBy.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory BankCreatedBy.fromMap(Map<String, dynamic> map) => BankCreatedBy(
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

class BankOpeningBalance extends Equatable {
  final String creditBalance;
  final String debitBalance;

  const BankOpeningBalance({
    required this.creditBalance,
    required this.debitBalance,
  });

  BankOpeningBalance copyWith({String? creditBalance, String? debitBalance}) {
    return BankOpeningBalance(
      creditBalance: creditBalance ?? this.creditBalance,
      debitBalance: debitBalance ?? this.debitBalance,
    );
  }

  factory BankOpeningBalance.fromJson(String json) =>
      BankOpeningBalance.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory BankOpeningBalance.fromMap(Map<String, dynamic> map) =>
      BankOpeningBalance(
        creditBalance: map["creditBalance"]?.toString() ?? "0",
        debitBalance: map["debitBalance"]?.toString() ?? "0",
      );

  Map<String, dynamic> toMap() => {
        "creditBalance": creditBalance,
        "debitBalance": debitBalance,
      };

  @override
  List<Object?> get props => [creditBalance, debitBalance];

  @override
  bool get stringify => true;
}
