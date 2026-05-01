import 'dart:convert';

class MediaModel {
  final String id;
  final String url;
  final String? name;
  final String? type;
  final int? size;
  final DateTime? createdAt;

  MediaModel({
    required this.id,
    required this.url,
    this.name,
    this.type,
    this.size,
    this.createdAt,
  });

  factory MediaModel.fromUrl(String url) {
    return MediaModel(
      id: url, // Use URL as ID for simple list responses
      url: url,
    );
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      id: map['_id'] ?? map['id'] ?? '',
      url: map['url'] ?? '',
      name: map['name'] ?? map['originalName'],
      type: map['type'] ?? map['mimetype'],
      size: map['size'],
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
    );
  }

  factory MediaModel.fromJson(String source) =>
      MediaModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'type': type,
      'size': size,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
}
