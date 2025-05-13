import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/notification_details_res.dart';
import 'package:salon_provider/model/response/notification_res.dart';

class NotificationRepository extends RepositoryConfig {
  NotificationRepository();

  Future<List<NotificationDetailsRes>> getNotificationDetails({
    List<List<Condition>>? conditions,
    int? limit,
    int? offset,
  }) async {
    var userId = await AuthConfig.getUserId();

    var defaultCondition =
        Condition(source: "user_id", operator: "=", target: userId);

    if (conditions != null && conditions[0].isEmpty) {
      conditions[0].add(defaultCondition);
    }

    var requestBody = SearchRequestBody(
      model: EnumColumn.notification_details.name,
      conditions: conditions ??
          [
            [defaultCondition]
          ],
      limit: limit,
      offset: offset,
      fields: [
        FieldItem(field: "notification.booking.user.firstname"),
        FieldItem(field: "notification.booking.user.lastname"),
        FieldItem(field: "notification.booking.user.phone_number"),
        FieldItem(
            field:
                "notification.booking.user.user_profile.profile_picture_url"),
        FieldItem(field: "notification.metadata"),
        FieldItem(field: "notification.booking.service_man.firstname"),
        FieldItem(field: "notification.booking.service_man.lastname"),
        FieldItem(field: "notification.booking.service_man.phone_number"),
        FieldItem(
            field:
                "notification.booking.service_man.user_profile.profile_picture_url"),
      ],
    );

    var response = await commonRestClient
        .search<List<NotificationDetailsRes>>(requestBody.toJson());

    return (response as List<dynamic>)
        .map((e) => NotificationDetailsRes.fromJson(e))
        .toList();
  }

  Future<List<NotificationRes>> getNotifications({
    List<List<Condition>>? conditions,
    int? limit,
    int? offset,
  }) async {
    var userId = await AuthConfig.getUserId();

    var defaultCondition =
        Condition(source: "user_id", operator: "=", target: userId);

    if (conditions != null && conditions[0].isEmpty) {
      conditions[0].add(defaultCondition);
    }

    var requestBody = SearchRequestBody(
      model: EnumColumn.notifications.name,
      conditions: conditions ??
          [
            [defaultCondition]
          ],
      fields: [
        FieldItem(field: "booking.user.firstname"),
        FieldItem(field: "booking.user.lastname"),
        FieldItem(field: "booking.user.phone_number"),
        FieldItem(field: "booking.service_man.firstname"),
        FieldItem(field: "booking.service_man.lastname"),
        FieldItem(field: "booking.service_man.phone_number"),
        FieldItem(field: "booking.service_versions.title"),
      ],
      limit: limit,
      offset: offset,
    );

    var response = await commonRestClient
        .search<List<NotificationRes>>(requestBody.toJson());

    var res = (response as List<dynamic>)
        .map((e) => NotificationRes.fromJson(e))
        .toList();

    return res;
  }

  String getEventDescription(NotificationRes notification) {
    final metadata = notification.metadata ?? {};
    final event = metadata['event'] as String?;
    final booking = notification.booking;

    if (event == null || booking == null) return '';

    final user = booking.user;
    final serviceMan = booking.serviceMan;
    final serviceVersions = booking.serviceVersions;

    final userName = user != null ? '${user.firstname} ${user.lastname}' : '';
    final userPhone = user?.phoneNumber ?? '';
    final serviceManName = serviceMan != null
        ? '${serviceMan.firstname} ${serviceMan.lastname}'
        : '';
    final serviceManPhone = serviceMan?.phoneNumber ?? '';
    final serviceTitles =
        serviceVersions?.map((sv) => sv.title).join(', ') ?? '';

    switch (event) {
      case 'booking_placed':
        return 'Booking placed by Customer $userName ($userPhone) for services: $serviceTitles';
      case 'booking_confirmed':
        return 'Booking confirmed by service provider $serviceManName ($serviceManPhone)';
      case 'booking_cancelled':
        return 'Booking cancelled by ${metadata['cancelled_by'] == 'user' ? 'Customer $userName' : 'Provider $serviceManName'}';
      case 'booking_completed':
        return 'Booking completed by service provider $serviceManName';
      case 'booking_in_progress':
        return 'Service started by provider $serviceManName';
      default:
        return '';
    }
  }

  String getEventTitle(String? event) {
    switch (event) {
      case 'booking_placed':
        return 'Booking Placed';
      case 'booking_confirmed':
        return 'Booking Confirmed';
      case 'booking_cancelled':
        return 'Booking Cancelled';
      case 'booking_completed':
        return 'Booking Completed';
      case 'booking_in_progress':
        return 'Service Started';
      default:
        return event ?? '';
    }
  }
}
