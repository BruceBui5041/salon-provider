import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/base_response.dart';
import 'package:salon_provider/model/response/notification_res.dart';
import 'package:salon_provider/model/response/user_response.dart';

part 'notification_details_res.g.dart';

@JsonSerializable()
class NotificationDetailsRes extends CommonResponse {
  @JsonKey(name: 'state')
  String? state;

  @JsonKey(name: 'send_at')
  DateTime? sendAt;

  @JsonKey(name: 'error')
  String? error;

  @JsonKey(name: 'read_at')
  String? readAt;

  @JsonKey(name: 'user')
  UserResponse? user;

  @JsonKey(name: 'notification')
  NotificationRes? notification;

  NotificationDetailsRes({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.status,
    this.state,
    this.sendAt,
    this.error,
    this.readAt,
    this.user,
    this.notification,
  });

  factory NotificationDetailsRes.fromJson(Map<String, dynamic> json) =>
      _$NotificationDetailsResFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NotificationDetailsResToJson(this);
}
