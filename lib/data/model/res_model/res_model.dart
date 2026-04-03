class ResModel {
  final int status;
  final String? message;
  final dynamic data;
  final String? error;

  ResModel({required this.status, this.message, this.data, this.error});

  factory ResModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ResModel(
        status: 0,
        message: "Null response",
        data: null,
        error: "Null response",
      );
    }

    return ResModel(
      status: json["status"] ?? 0,
      message: json["message"],
      data: json["data"],
      error: json["error"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "error": error,
  };
}
