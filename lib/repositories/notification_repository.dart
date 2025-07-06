import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/model/response/notification_details_res.dart';
import 'package:salon_provider/model/response/notification_res.dart';
import 'package:salon_provider/config.dart';

class NotificationRepository extends RepositoryConfig {
  NotificationRepository();

  Future<List<NotificationDetailsRes>> getNotificationDetails({
    List<List<Condition>>? conditions,
    int? limit = 10,
    int? offset = 0,
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
      orderBy: "id desc",
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

  String getEventDescription(
      BuildContext context, NotificationRes notification) {
    final metadata = notification.metadata ?? {};
    final event = metadata['event'] as String?;
    final booking = notification.booking;

    if (event == null || booking == null) return '';

    final user = booking.user;
    final serviceMan = booking.serviceMan;
    final serviceVersions = booking.serviceVersions;
    final bookingId = booking.id ?? '';

    final userName = user != null
        ? '${user.firstname ?? ''} ${user.lastname ?? ''}'.trim()
        : language(context, appFonts.customer);
    final userPhone = user?.phoneNumber ?? '';
    final serviceManName = serviceMan != null
        ? '${serviceMan.firstname ?? ''} ${serviceMan.lastname ?? ''}'.trim()
        : 'Serviceman';
    final serviceTitles =
        serviceVersions?.map((sv) => sv.title).join(', ') ?? 'Service';

    return getBookingEventDescription(
      context,
      event: event,
      metadata: metadata,
      bookingId: bookingId,
      userName: userName,
      userPhone: userPhone,
      serviceManName: serviceManName,
      serviceTitles: serviceTitles,
    );
  }

  String getEventTitle(String? event) {
    return getBookingEventTitle(event);
  }
}
