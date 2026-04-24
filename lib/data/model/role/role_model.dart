import 'dart:convert';
import 'package:equatable/equatable.dart';

class RoleModel extends Equatable {
  final String id;
  final String name;
  final bool isDeleted;
  final bool isActive;
  final RoleCreatedBy? createdBy;
  final String updatedBy;
  final RoleCompanyId? companyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RoleModel({
    required this.id,
    required this.name,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    required this.updatedBy,
    this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  RoleModel copyWith({
    String? id,
    String? name,
    bool? isDeleted,
    bool? isActive,
    RoleCreatedBy? createdBy,
    String? updatedBy,
    RoleCompanyId? companyId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RoleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      companyId: companyId ?? this.companyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory RoleModel.fromJson(String json) =>
      RoleModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory RoleModel.fromMap(Map<String, dynamic> map) => RoleModel(
    id: map["_id"] as String? ?? '',
    name: map["name"] as String? ?? '',
    isDeleted: map["isDeleted"] as bool? ?? false,
    isActive: map["isActive"] as bool? ?? true,
    createdBy: map["createdBy"] == null
        ? null
        : RoleCreatedBy.fromMap(map["createdBy"] as Map<String, dynamic>),
    updatedBy: map["updatedBy"] as String? ?? '',
    companyId: map["companyId"] == null
        ? null
        : RoleCompanyId.fromMap(map["companyId"] as Map<String, dynamic>),
    createdAt: map["createdAt"] == null
        ? DateTime.now()
        : DateTime.parse(map["createdAt"] as String),
    updatedAt: map["updatedAt"] == null
        ? DateTime.now()
        : DateTime.parse(map["updatedAt"] as String),
  );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
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

class RoleCompanyId extends Equatable {
  final String id;
  final String name;

  const RoleCompanyId({required this.id, required this.name});

  factory RoleCompanyId.fromMap(Map<String, dynamic> map) => RoleCompanyId(
    id: map["_id"] as String? ?? '',
    name: map["name"] as String? ?? '',
  );

  Map<String, dynamic> toMap() => {"_id": id, "name": name};

  @override
  List<Object?> get props => [id, name];
}

class RoleCreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const RoleCreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  factory RoleCreatedBy.fromMap(Map<String, dynamic> map) => RoleCreatedBy(
    id: map["_id"] as String? ?? '',
    fullName: map["fullName"] as String? ?? '',
    userType: map["userType"] as String? ?? '',
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "fullName": fullName,
    "userType": userType,
  };

  @override
  List<Object?> get props => [id, fullName, userType];
}
