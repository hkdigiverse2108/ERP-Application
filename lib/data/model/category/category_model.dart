import 'dart:convert';
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  const CategoryModel();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

class CategoryDropdownModel extends Equatable {
  final String id;
  final String name;

  const CategoryDropdownModel({
    required this.id,
    required this.name,
  });

  CategoryDropdownModel copyWith({
    String? id,
    String? name,
  }) {
    return CategoryDropdownModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory CategoryDropdownModel.fromJson(String json) =>
      CategoryDropdownModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory CategoryDropdownModel.fromMap(Map<String, dynamic> map) =>
      CategoryDropdownModel(
        id: map['_id'] as String? ?? '',
        name: map['name'] as String? ?? '',
      );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
      };

  @override
  List<Object?> get props => [id, name];

  @override
  bool get stringify => true;
}
