// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReverseGeocodeReq _$ReverseGeocodeReqFromJson(Map<String, dynamic> json) =>
    ReverseGeocodeReq(
      latlng: json['latlng'] as String?,
    );

Map<String, dynamic> _$ReverseGeocodeReqToJson(ReverseGeocodeReq instance) =>
    <String, dynamic>{
      'latlng': instance.latlng,
    };

AutoCompleteReq _$AutoCompleteReqFromJson(Map<String, dynamic> json) =>
    AutoCompleteReq(
      input: json['input'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$AutoCompleteReqToJson(AutoCompleteReq instance) =>
    <String, dynamic>{
      'input': instance.input,
      'location': instance.location,
    };

GeocodePlaceDetailReq _$GeocodePlaceDetailReqFromJson(
        Map<String, dynamic> json) =>
    GeocodePlaceDetailReq(
      placeId: json['place_id'] as String?,
    );

Map<String, dynamic> _$GeocodePlaceDetailReqToJson(
        GeocodePlaceDetailReq instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
    };
