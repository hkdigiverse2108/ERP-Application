import 'dart:convert' hide json;
import 'package:equatable/equatable.dart';

class IdNameModel extends Equatable {
  final String id;
  final String name;

  const IdNameModel({required this.id, required this.name});

  IdNameModel copyWith({String? id, String? name}) {
    return IdNameModel(id: id ?? this.id, name: name ?? this.name);
  }

  factory IdNameModel.fromJson(String json) =>
      IdNameModel.fromMap(jsonDecode(json) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  factory IdNameModel.fromMap(dynamic json) {
    if (json is Map<String, dynamic>) {
      return IdNameModel(
        id: json["_id"]?.toString() ?? json["id"]?.toString() ?? '',
        name: (json["name"] ??
                json["fullName"] ??
                json["invoiceNo"] ??
                json["salesOrderNo"] ??
                json["deliveryChallanNo"] ??
                json["purchaseOrderNo"] ??
                json["supplierBillNo"] ??
                json["debitNoteNo"] ??
                json["creditNoteNo"] ??
                json["estimateNo"] ??
                '')
            .toString(),
      );
    }
    if (json is String) {
      return IdNameModel(id: json, name: '');
    }
    return IdNameModel.empty();
  }

  Map<String, dynamic> toMap() => {"_id": id, "name": name};

  factory IdNameModel.empty() => const IdNameModel(id: '', name: '');

  @override
  List<Object?> get props => [id, name];

  @override
  bool get stringify => true;

  @override
  String toString() => name;
}
