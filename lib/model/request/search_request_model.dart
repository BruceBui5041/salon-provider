import 'package:json_annotation/json_annotation.dart';

part 'search_request_model.g.dart';

/**
 * SearchRequestBody class is used to define the request body for the search API.
 */
@JsonSerializable(explicitToJson: true)
class SearchRequestBody {
  final String model;
  @JsonKey(name: 'conditions')
  final List<List<Condition>> conditions;
  @JsonKey(name: 'order_by')
  final String? orderBy;

  @FieldItemConverter()
  final List<FieldItem> fields;

  SearchRequestBody({
    required this.model,
    required this.conditions,
    required this.fields,
    this.orderBy,
  });

  factory SearchRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SearchRequestBodyToJson(this);
}

/**
 * Condition class is used to define the conditions that are required in the response.
 */
@JsonSerializable()
class Condition {
  final String source;
  final String operator;
  final dynamic target;

  Condition({
    required this.source,
    required this.operator,
    required this.target,
  });

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionToJson(this);
}

/**
 * FieldItem class is used to define the fields that are required in the response.
 */
@JsonSerializable()
class FieldItem {
  final String field;
  @JsonKey(name: 'order_by')
  final String? orderBy;

  FieldItem({
    required this.field,
    this.orderBy,
  });

  factory FieldItem.fromJson(Map<String, dynamic> json) =>
      _$FieldItemFromJson(json);

  Map<String, dynamic> toJson() => _$FieldItemToJson(this);
}

class FieldItemConverter implements JsonConverter<FieldItem, dynamic> {
  const FieldItemConverter();

  @override
  FieldItem fromJson(dynamic json) {
    if (json is String) {
      return FieldItem(field: json);
    } else if (json is Map<String, dynamic>) {
      return FieldItem.fromJson(json);
    } else {
      throw Exception('Invalid type for FieldItem');
    }
  }

  @override
  dynamic toJson(FieldItem object) {
    if (object.orderBy == null) {
      return object.field;
    } else {
      return object.toJson();
    }
  }
}
