import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';

class TermsAndConditionModel extends Equatable {
  final String id;
  final String termsCondition;
  final bool isDefault;
  final bool isActive;
  final bool isDeleted;
  final String companyId;
  final IdNameModel? branchId;
  final IdNameModel? createdBy;
  final IdNameModel? updatedBy;
  final String? createdAt;
  final String? updatedAt;

  const TermsAndConditionModel({
    required this.id,
    required this.termsCondition,
    required this.isDefault,
    required this.isActive,
    required this.isDeleted,
    required this.companyId,
    this.branchId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  TermsAndConditionModel copyWith({
    String? id,
    String? termsCondition,
    bool? isDefault,
    bool? isActive,
    bool? isDeleted,
    String? companyId,
    IdNameModel? branchId,
    IdNameModel? createdBy,
    IdNameModel? updatedBy,
    String? createdAt,
    String? updatedAt,
  }) {
    return TermsAndConditionModel(
      id: id ?? this.id,
      termsCondition: termsCondition ?? this.termsCondition,
      isDefault: isDefault ?? this.isDefault,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      companyId: companyId ?? this.companyId,
      branchId: branchId ?? this.branchId,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory TermsAndConditionModel.fromMap(Map<String, dynamic> map) {
    return TermsAndConditionModel(
      id: map['_id'] ?? map['id'] ?? '',
      termsCondition: map['termsCondition'] ?? '',
      isDefault: map['isDefault'] ?? false,
      isActive: map['isActive'] ?? false,
      isDeleted: map['isDeleted'] ?? false,
      companyId: map['companyId'] ?? '',
      branchId: map['branchId'] != null
          ? IdNameModel.fromMap(map['branchId'])
          : null,
      createdBy: map['createdBy'] != null
          ? IdNameModel.fromMap(map['createdBy'])
          : null,
      updatedBy: map['updatedBy'] != null
          ? IdNameModel.fromMap(map['updatedBy'])
          : null,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'termsCondition': termsCondition,
      'isDefault': isDefault,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'companyId': companyId,
      'branchId': branchId?.toMap(),
      'createdBy': createdBy?.toMap(),
      'updatedBy': updatedBy?.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory TermsAndConditionModel.fromJson(String source) =>
      TermsAndConditionModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [
    id,
    termsCondition,
    isDefault,
    isActive,
    isDeleted,
    companyId,
    branchId,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
  ];
}
