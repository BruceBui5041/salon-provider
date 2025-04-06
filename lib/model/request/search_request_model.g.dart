// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRequestBody _$SearchRequestBodyFromJson(Map<String, dynamic> json) =>
    SearchRequestBody(
      model: json['model'] as String,
      conditions: (json['conditions'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => Condition.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      fields: (json['fields'] as List<dynamic>)
          .map(const FieldItemConverter().fromJson)
          .toList(),
      orderBy: json['order_by'] as String?,
    );

Map<String, dynamic> _$SearchRequestBodyToJson(SearchRequestBody instance) =>
    <String, dynamic>{
      'model': instance.model,
      'conditions': instance.conditions
          .map((e) => e.map((e) => e.toJson()).toList())
          .toList(),
      'order_by': instance.orderBy,
      'fields': instance.fields.map(const FieldItemConverter().toJson).toList(),
    };

Condition _$ConditionFromJson(Map<String, dynamic> json) => Condition(
      source: json['source'] as String,
      operator: json['operator'] as String,
      target: json['target'],
    );

Map<String, dynamic> _$ConditionToJson(Condition instance) => <String, dynamic>{
      'source': instance.source,
      'operator': instance.operator,
      'target': instance.target,
    };

FieldItem _$FieldItemFromJson(Map<String, dynamic> json) => FieldItem(
      field: json['field'] as String,
      orderBy: json['order_by'] as String?,
    );

Map<String, dynamic> _$FieldItemToJson(FieldItem instance) => <String, dynamic>{
      'field': instance.field,
      'order_by': instance.orderBy,
    };
