import 'dart:convert';

class CategoryModel {}

class CategoryDropdownModel {
  final String id;
  final String name;

  CategoryDropdownModel({required this.id, required this.name});

  factory CategoryDropdownModel.fromRawJson(String str) =>
      CategoryDropdownModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryDropdownModel.fromJson(Map<String, dynamic> json) =>
      CategoryDropdownModel(id: json["_id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}
