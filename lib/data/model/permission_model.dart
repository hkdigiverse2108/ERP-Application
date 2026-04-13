class PermissionModel {
  final String id;
  final String tabName;
  final String displayName;
  final String tabUrl;
  final bool view;
  final bool add;
  final bool edit;
  final bool delete;
  final int number;
  final List<PermissionModel> children;

  // parentId comes from the API as a full nested object (or null for root tabs).
  // We only need the parentName string for display/debugging purposes.
  final String parentName;

  PermissionModel({
    required this.id,
    required this.tabName,
    required this.displayName,
    required this.tabUrl,
    required this.view,
    required this.add,
    required this.edit,
    required this.delete,
    required this.number,
    this.children = const [],
    this.parentName = '',
  });

  factory PermissionModel.fromJson(
    Map<String, dynamic> json, {
    String inheritedParentName = '',
  }) {
    // Resolve parentName from three possible sources (in priority order):
    //   1. json['parentId'] — API format: a nested object { "tabName": "accounting", ... }
    //   2. json['parentName'] — persisted/storage format (from our toJson)
    //   3. inheritedParentName — passed down when parsing nested children
    String resolvedParentName = '';
    final parentIdField = json['parentId'];
    if (parentIdField is Map<String, dynamic>) {
      resolvedParentName = (parentIdField['tabName'] as String?) ?? '';
    }
    if (resolvedParentName.isEmpty) {
      resolvedParentName = (json['parentName'] as String?) ?? '';
    }
    if (resolvedParentName.isEmpty) {
      resolvedParentName = inheritedParentName;
    }

    // The current tab's own tabName — used as inheritedParentName for children.
    final ownTabName = (json['tabName'] as String?) ?? '';

    return PermissionModel(
      id: json['_id'] ?? '',
      tabName: ownTabName,
      displayName: json['displayName'] ?? '',
      tabUrl: json['tabUrl'] ?? '',
      view: json['view'] ?? json['hasView'] ?? false,
      add: json['add'] ?? json['hasAdd'] ?? false,
      edit: json['edit'] ?? json['hasEdit'] ?? false,
      delete: json['delete'] ?? json['hasDelete'] ?? false,
      number: json['number'] ?? 0,
      parentName: resolvedParentName,
      children: json['children'] != null
          ? List<PermissionModel>.from(
              (json['children'] as List).map(
                (x) => PermissionModel.fromJson(
                  x as Map<String, dynamic>,
                  inheritedParentName: ownTabName,
                ),
              ),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'tabName': tabName,
      'displayName': displayName,
      'tabUrl': tabUrl,
      'view': view,
      'add': add,
      'edit': edit,
      'delete': delete,
      'number': number,
      'parentName': parentName,
      'children': children.map((x) => x.toJson()).toList(),
    };
  }

  /// Human-readable identifier for logging/debugging.
  /// e.g. "accounting > credit note" or "sales > sales credit note"
  String get fullName =>
      parentName.isNotEmpty ? '$parentName > $tabName' : tabName;
}
