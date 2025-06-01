import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/cloud_message_response/base_message_response.dart';

part 'booking_message_response.g.dart';

@JsonSerializable()
class BookingNotificationMessage extends BaseMessageResponse {
  @JsonKey(name: 'booking_id')
  final String? bookingId;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'service_version_ids')
  final String? serviceVersionIds;
  @JsonKey(name: 'service_man_id')
  final String? serviceManId;
  @JsonKey(name: 'service_ids')
  final String? serviceIds;

  BookingNotificationMessage({
    this.bookingId,
    this.userId,
    this.serviceVersionIds,
    this.serviceIds,
    this.serviceManId,
    super.event,
  });

  factory BookingNotificationMessage.fromJson(Map<String, dynamic> json) =>
      _$BookingNotificationMessageFromJson(json);

  Map<String, dynamic> toJson() => _$BookingNotificationMessageToJson(this);
}
