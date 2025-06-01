import 'package:json_annotation/json_annotation.dart';
part 'base_message_response.g.dart';

@JsonSerializable()
class BaseMessageResponse {
  final String? event;

  BaseMessageResponse({this.event});

  factory BaseMessageResponse.fromJson(Map<String, dynamic> json) {
    return BaseMessageResponse(event: json['event']);
  }
}
