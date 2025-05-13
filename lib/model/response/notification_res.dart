import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/base_response.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/model/response/notification_details_res.dart';

part 'notification_res.g.dart';

@JsonSerializable()
class NotificationRes extends CommonResponse {
  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'scheduled')
  DateTime? scheduled;

  @JsonKey(name: 'metadata')
  Map<String, dynamic>? metadata;

  @JsonKey(name: 'details')
  List<NotificationDetailsRes>? details;

  @JsonKey(name: 'booking')
  Booking? booking;

  NotificationRes({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.status,
    this.type,
    this.scheduled,
    this.metadata,
    this.booking,
  });

  factory NotificationRes.fromJson(Map<String, dynamic> json) =>
      _$NotificationResFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResToJson(this);
}
