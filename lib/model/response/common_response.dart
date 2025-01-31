class BaseResponse<T> {
  final List<T> data;

  BaseResponse({
    required this.data,
  });

  BaseResponse copyWith({
    List<T>? data,
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
    return BaseResponse<T>(
      data: json["data"] == null
          ? []
          : List<T>.from(
              json["data"].map((x) => fromJsonT(x as Map<String, dynamic>)),
            ),
    );
  }

  /// Phương thức để chuyển BaseResponse sang JSON
  /// [toJsonT] là hàm chuyển đổi từ T sang Map<String, dynamic>
  Map<String, dynamic> toJson(
    Map<String, dynamic> Function(T value) toJsonT,
  ) {
    return {
      "data": List<dynamic>.from(data.map((x) => toJsonT(x))),
    };
  }
}
