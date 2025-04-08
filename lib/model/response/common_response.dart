import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  @JsonKey(name: 'data')
  final T? data;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'status_code')
  final bool? statusCode;
  @JsonKey(name: 'error_key')
  final String? errorKey;
  @JsonKey(name: 'log')
  final String? log;

  BaseResponse({
    this.data,
    this.message,
    this.statusCode,
    this.errorKey,
    this.log,
  });

  BaseResponse copyWith({
    T? data,
  }) =>
      BaseResponse(
        data: data ?? this.data,
      );

  factory BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}
