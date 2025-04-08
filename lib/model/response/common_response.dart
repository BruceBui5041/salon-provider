class BaseResponse<T> {
  final T data;

  BaseResponse({
    required this.data,
  });

  BaseResponse copyWith({
    T? data,
  }) =>
      BaseResponse(
        data: data ?? this.data,
      );

  /// Factory constructor để tạo BaseResponse từ JSON
  /// [fromJsonT] là hàm chuyển đổi từ Map<String, dynamic> sang T
  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) fromJsonT,
  ) {
    if (json["data"] == null) {
      throw Exception("Data is null");
    }

    if (json["data"] is List) {
      return BaseResponse<T>(
        data: json["data"].map<dynamic>((x) => fromJsonT(x)).toList() as T,
      );
    } else if (json["data"] is bool ||
        json["data"] is int ||
        json["data"] is String ||
        json["data"] is double) {
      return BaseResponse<T>(
        data: json["data"] as T,
      );
    } else {
      return BaseResponse<T>(
        data: fromJsonT(json["data"]),
      );
    }
  }

  /// Phương thức để chuyển BaseResponse sang JSON
  /// [toJsonT] là hàm chuyển đổi từ T sang Map<String, dynamic>
  Map<String, dynamic> toJson(
    Map<String, dynamic> Function(T value) toJsonT,
  ) {
    if (data is List) {
      return {
        "data": (data as List).map((x) => toJsonT(x)).toList(),
      };
    } else {
      return {
        "data": toJsonT(data),
      };
    }
  }
}
