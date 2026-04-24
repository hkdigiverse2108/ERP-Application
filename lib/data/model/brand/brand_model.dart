import 'dart:convert';
import 'package:equatable/equatable.dart';

class BrandModel extends Equatable {
  const BrandModel();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

class BrandDropdownModel extends Equatable {
  final String id;
  final String name;

  const BrandDropdownModel({required this.id, required this.name});

  BrandDropdownModel copyWith({String? id, String? name}) {
    return BrandDropdownModel(id: id ?? this.id, name: name ?? this.name);
  }

  factory BrandDropdownModel.fromJson(String json) =>
      BrandDropdownModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory BrandDropdownModel.fromMap(Map<String, dynamic> map) =>
      BrandDropdownModel(
        id: map['_id'] as String? ?? '',
        name: map['name'] as String? ?? '',
      );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {'_id': id, 'name': name};

  @override
  List<Object?> get props => [id, name];

  @override
  bool get stringify => true;
}
