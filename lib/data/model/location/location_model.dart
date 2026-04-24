import 'dart:convert';
import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  const LocationModel();
  
  @override
  List<Object?> get props => [];
}

class LocationDropdown extends Equatable {
  final String id;
  final String name;
  final String? code;

  const LocationDropdown({
    required this.id,
    required this.name,
    this.code,
  });

  factory LocationDropdown.empty() => const LocationDropdown(id: "", name: "", code: null);

  LocationDropdown copyWith({
    String? id,
    String? name,
    String? code,
  }) {
    return LocationDropdown(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  factory LocationDropdown.fromJson(String json) =>
      LocationDropdown.fromMap(jsonDecode(json) as Map<String, dynamic>);

  factory LocationDropdown.fromMap(Map<String, dynamic> map) => LocationDropdown(
        id: map["_id"] as String? ?? "",
        name: map["name"] as String? ?? "",
        code: map["code"] as String?,
      );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "code": code,
      };

  @override
  List<Object?> get props => [id, name, code];

  @override
  bool get stringify => true;
}
