class IdNameModel {
  final String id;
  final String name;

  IdNameModel({required this.id, required this.name});

  factory IdNameModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return IdNameModel(
        id: json["_id"]?.toString() ?? '',
        name: (json["name"] ?? json["fullName"] ?? '').toString(),
      );
    }
    if (json is String) {
      return IdNameModel(id: json, name: '');
    }
    return IdNameModel.empty();
  }

  factory IdNameModel.empty() => IdNameModel(id: '', name: '');

  Map<String, dynamic> toJson() => {"_id": id, "name": name};

  @override
  String toString() => name;
}
