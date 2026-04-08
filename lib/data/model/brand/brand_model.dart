import 'dart:convert';

class BrandModel {}

class BrandDropdownModel {
  final String id;
  final String name;

  BrandDropdownModel({required this.id, required this.name});

  factory BrandDropdownModel.fromRawJson(String str) =>
      BrandDropdownModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BrandDropdownModel.fromJson(Map<String, dynamic> json) =>
      BrandDropdownModel(id: json["_id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}
