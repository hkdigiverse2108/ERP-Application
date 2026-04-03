class ApiConstants {
  static const String baseUrl = "http://192.168.29.26:4001";

  // Helper method to build URLs with query parameters
  static String _buildUrl(String path, Map<String, dynamic> params) {
    final List<String> queryParts = [];
    params.forEach((key, value) {
      if (value != null && value.toString().isNotEmpty) {
        queryParts.add('$key=${Uri.encodeComponent(value.toString())}');
      }
    });

    if (queryParts.isEmpty) return path;
    return '$path?${queryParts.join('&')}';
  }

  // Auth
  static const String login = "/auth/login";
}
