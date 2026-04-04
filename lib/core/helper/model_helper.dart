class ModelHelper {
  static T? getNestedField<T>(Map<String, dynamic> json, List<String> path) {
    dynamic current = json;

    for (int i = 0; i < path.length; i++) {
      final key = path[i];
      final isLast = i == path.length - 1;

      if (current is! Map<String, dynamic>) {
        // Unpopulated — raw value, return it directly if it's the target type
        return current as T?;
      }

      final value = current[key];

      if (value == null) return null;

      if (isLast) return value as T?;

      current = value;
    }

    return null;
  }
}
