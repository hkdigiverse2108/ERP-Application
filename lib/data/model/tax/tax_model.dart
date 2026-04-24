import 'dart:convert';
import 'package:equatable/equatable.dart';

class TaxItemModel extends Equatable {
  final String id;
  final bool isDeleted;
  final bool isActive;
  final CreatedBy? createdBy;
  final UpdatedBy? updatedBy;
  final String name;
  final int percentage;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaxItemModel({
    required this.id,
    required this.isDeleted,
    required this.isActive,
    this.createdBy,
    this.updatedBy,
    required this.name,
    required this.percentage,
    required this.createdAt,
    required this.updatedAt,
  });

  TaxItemModel copyWith({
    String? id,
    bool? isDeleted,
    bool? isActive,
    CreatedBy? createdBy,
    UpdatedBy? updatedBy,
    String? name,
    int? percentage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaxItemModel(
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      name: name ?? this.name,
      percentage: percentage ?? this.percentage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory TaxItemModel.fromJson(String json) =>
      TaxItemModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory TaxItemModel.fromMap(Map<String, dynamic> map) => TaxItemModel(
    id: map['_id'] as String? ?? '',
    isDeleted: map['isDeleted'] as bool? ?? false,
    isActive: map['isActive'] as bool? ?? false,
    createdBy: map['createdBy'] == null
        ? null
        : CreatedBy.fromMap(map['createdBy'] as Map<String, dynamic>),
    updatedBy: map['updatedBy'] == null
        ? null
        : UpdatedBy.fromMap(map['updatedBy'] as Map<String, dynamic>),
    name: map['name'] as String? ?? '',
    percentage: (map['percentage'] as num? ?? 0).toInt(),
    createdAt: map['createdAt'] != null
        ? DateTime.parse(map['createdAt'] as String)
        : DateTime.now(),
    updatedAt: map['updatedAt'] != null
        ? DateTime.parse(map['updatedAt'] as String)
        : DateTime.now(),
  );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
    '_id': id,
    'isDeleted': isDeleted,
    'isActive': isActive,
    'createdBy': createdBy?.toMap(),
    'updatedBy': updatedBy?.toMap(),
    'name': name,
    'percentage': percentage,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  @override
  List<Object?> get props => [
    id,
    isDeleted,
    isActive,
    createdBy,
    updatedBy,
    name,
    percentage,
    createdAt,
    updatedAt,
  ];

  @override
  bool get stringify => true;
}

class CreatedBy extends Equatable {
  final String id;
  final String fullName;
  final String userType;

  const CreatedBy({
    required this.id,
    required this.fullName,
    required this.userType,
  });

  CreatedBy copyWith({String? id, String? fullName, String? userType}) {
    return CreatedBy(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userType: userType ?? this.userType,
    );
  }

  factory CreatedBy.fromJson(String json) =>
      CreatedBy.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory CreatedBy.fromMap(Map<String, dynamic> map) => CreatedBy(
    id: map['_id'] as String? ?? '',
    fullName: map['fullName'] as String? ?? '',
    userType: map['userType'] as String? ?? '',
  );

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

class UpdatedBy extends Equatable {
  final String id;
  final String userType;

  const UpdatedBy({required this.id, required this.userType});

  UpdatedBy copyWith({String? id, String? userType}) {
    return UpdatedBy(id: id ?? this.id, userType: userType ?? this.userType);
  }

  factory UpdatedBy.fromJson(String json) =>
      UpdatedBy.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory UpdatedBy.fromMap(Map<String, dynamic> map) => UpdatedBy(
    id: map['_id'] as String? ?? '',
    userType: map['userType'] as String? ?? '',
  );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {'_id': id, 'userType': userType};

  @override
  List<Object?> get props => [id, userType];

  @override
  bool get stringify => true;
}

class TaxDropdownModel extends Equatable {
  final String id;
  final String name;
  final num percentage;

  const TaxDropdownModel({
    required this.id,
    required this.name,
    required this.percentage,
  });

  TaxDropdownModel copyWith({String? id, String? name, num? percentage}) {
    return TaxDropdownModel(
      id: id ?? this.id,
      name: name ?? this.name,
      percentage: percentage ?? this.percentage,
    );
  }

  factory TaxDropdownModel.fromJson(String json) =>
      TaxDropdownModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory TaxDropdownModel.fromMap(Map<String, dynamic> map) =>
      TaxDropdownModel(
        id: map['_id'] as String? ?? '',
        name: map['name'] as String? ?? '',
        percentage: map['percentage'] as num? ?? 0,
      );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
    '_id': id,
    'name': name,
    'percentage': percentage,
  };

  @override
  List<Object?> get props => [id, name, percentage];

  @override
  bool get stringify => true;
}
