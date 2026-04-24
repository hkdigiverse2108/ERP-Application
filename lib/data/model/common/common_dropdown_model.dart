import 'dart:convert';
import 'package:equatable/equatable.dart';

class CommonDropdownModel extends Equatable {
  final String id;
  final String name;

  const CommonDropdownModel({
    required this.id,
    required this.name,
  });

  const CommonDropdownModel.empty()
      : id = '',
        name = '';

  CommonDropdownModel copyWith({
    String? id,
    String? name,
  }) {
    return CommonDropdownModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory CommonDropdownModel.fromJson(String json) =>
      CommonDropdownModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory CommonDropdownModel.fromMap(Map<String, dynamic> map) =>
      CommonDropdownModel(
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
