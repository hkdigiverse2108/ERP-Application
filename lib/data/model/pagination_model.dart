import 'package:equatable/equatable.dart';

class PaginationModel<T> extends Equatable {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final List<T> items;

  const PaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.items,
  });

  PaginationModel<T> copyWith({
    int? currentPage,
    int? totalPages,
    int? totalItems,
    List<T>? items,
  }) {
    return PaginationModel<T>(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      items: items ?? this.items,
    );
  }

  factory PaginationModel.fromMap(Map<String, dynamic> map, List<T> items) {
    final state = map['state'] as Map<String, dynamic>?;
    return PaginationModel<T>(
      currentPage: state != null
          ? (int.tryParse(state['page'].toString()) ?? 1)
          : 1,
      totalPages: state != null
          ? (int.tryParse(state['totalPages'].toString()) ?? 1)
          : 1,
      totalItems: map['totalData'] ?? 0,
      items: items,
    );
  }

  // Note: JSON methods are tricky with generics unless T is also serializable.
  // For PaginationModel, it's mostly used in repositories with already parsed items.
  
  @override
  List<Object?> get props => [currentPage, totalPages, totalItems, items];

  @override
  bool get stringify => true;
}
