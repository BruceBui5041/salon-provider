// To parse this JSON data, do
//
//     final genQrResponse = genQrResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'gen_qr_response.g.dart';

GenQrResponse genQrResponseFromJson(String str) =>
    GenQrResponse.fromJson(json.decode(str));

String genQrResponseToJson(GenQrResponse data) => json.encode(data.toJson());

@JsonSerializable()
class GenQrResponse {
  @JsonKey(name: "data")
  final String data;

  GenQrResponse({
    required this.data,
  });

  GenQrResponse copyWith({
    String? data,
  }) =>
      GenQrResponse(
        data: data ?? this.data,
      );

  factory GenQrResponse.fromJson(Map<String, dynamic> json) =>
      _$GenQrResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenQrResponseToJson(this);
}
