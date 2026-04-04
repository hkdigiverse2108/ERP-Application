import 'dart:convert';

class CategoryWiseCustomersCountModel {
  final String category;
  final int count;

  CategoryWiseCustomersCountModel({
    required this.category,
    required this.count,
  });

  factory CategoryWiseCustomersCountModel.empty() =>
      CategoryWiseCustomersCountModel(category: 'Unknown', count: 0);

  factory CategoryWiseCustomersCountModel.fromRawJson(String str) =>
      CategoryWiseCustomersCountModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryWiseCustomersCountModel.fromJson(Map<String, dynamic> json) =>
      CategoryWiseCustomersCountModel(
        category: json["category"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {"category": category, "count": count};
}
