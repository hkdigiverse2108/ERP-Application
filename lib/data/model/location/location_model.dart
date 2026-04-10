class LocationModel {}

class LocationDropdown {
  final String id;
  final String name;
  final String? code;

  LocationDropdown({required this.id, required this.name, this.code});

  LocationDropdown.empty() : this(id: "", name: "", code: null);

  factory LocationDropdown.fromJson(Map<String, dynamic> json) =>
      LocationDropdown(id: json["_id"], name: json["name"], code: json["code"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "code": code};
}
