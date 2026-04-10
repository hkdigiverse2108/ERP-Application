class CommonDropdownModel {
  final String id;
  final String name;

  CommonDropdownModel({required this.id, required this.name});

  CommonDropdownModel.empty() : this(id: "", name: "");

  factory CommonDropdownModel.fromJson(Map<String, dynamic> json) =>
      CommonDropdownModel(id: json["_id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}
