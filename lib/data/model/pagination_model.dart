class PaginationModel<T> {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final List<T> items;

  PaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.items,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json, List<T> items) {
    final state = json['state'] as Map<String, dynamic>?;
    return PaginationModel(
      currentPage: state != null
          ? (int.tryParse(state['page'].toString()) ?? 1)
          : 1,
      totalPages: state != null
          ? (int.tryParse(state['totalPages'].toString()) ?? 1)
          : 1,
      totalItems: json['totalData'] ?? 0,
      items: items,
    );
  }
}
