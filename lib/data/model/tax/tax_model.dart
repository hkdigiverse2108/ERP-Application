import 'dart:convert';

class TaxModel {}

class TaxDropdownModel {
  final String id;
  final String name;
  final int percentage;

  TaxDropdownModel({
    required this.id,
    required this.name,
    required this.percentage,
  });

  factory TaxDropdownModel.fromRawJson(String str) =>
      TaxDropdownModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxDropdownModel.fromJson(Map<String, dynamic> json) =>
      TaxDropdownModel(
        id: json["_id"],
        name: json["name"],
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "percentage": percentage,
  };
}
