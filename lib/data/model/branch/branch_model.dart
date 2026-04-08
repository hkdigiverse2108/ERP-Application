import 'dart:convert';

class BranchModel {}

class BranchDropdownModel {
  final String id;
  final String name;

  BranchDropdownModel({required this.id, required this.name});

  factory BranchDropdownModel.fromJson(Map<String, dynamic> json) =>
      BranchDropdownModel(id: json['_id'], name: json['name']);
}
