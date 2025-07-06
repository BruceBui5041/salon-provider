import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/cloud_message_response/base_message_response.dart';
import 'package:salon_provider/model/cloud_message_response/booking_message_response.dart';
import 'package:salon_provider/model/response/notification_details_res.dart';
import 'package:salon_provider/repositories/notification_repository.dart';

class NotificationProvider with ChangeNotifier {
  final NotificationRepository _notificationRepository =
      NotificationRepository();

  bool isNotification = false;
  bool isLoading = false;
  String? error;
  AnimationController? animationController;
  List<NotificationDetailsRes> notificationDetailsList = [];
  final _cloudMessageController =
      StreamController<BaseMessageResponse>.broadcast();
  BookingNotificationMessage? _bookingNotificationMessage;

  void onSubcribeCloudMessage({
    required Function(BaseMessageResponse) onCallBack,
  }) {
    _cloudMessageController.stream.listen((message) {
      onCallBack(message);
    });
  }

  void pushMessage(RemoteMessage message) {
    final eventName = message.data['event'];
    if (eventName.toString().startsWith("booking_")) {
      _bookingNotificationMessage =
          BookingNotificationMessage.fromJson(message.data);
    }
    _cloudMessageController.sink.add(_bookingNotificationMessage!);
  }

  Future<void> onRefresh() async {
    await loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      notificationDetailsList =
          await _notificationRepository.getNotificationDetails();

      isNotification = notificationDetailsList.isNotEmpty;

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      isNotification = false;
      notifyListeners();
    }
  }

  onAnimate(TickerProvider sync) {
    animationController = AnimationController(
        vsync: sync, duration: const Duration(milliseconds: 1200));
    _runAnimation();

    // Load notifications when screen is initialized
    loadNotifications();
  }

  void _runAnimation() async {
    for (int i = 0; i < 300; i++) {
      await animationController!.forward();
      await animationController!.reverse();
    }
  }

  String getNotificationIcon(String? event) {
    return getBookingEventIcon(event);
  }

  String getNotificationTitle(NotificationDetailsRes notification) {
    final metadata = notification.notification?.metadata ?? {};
    final event = metadata['event'] as String?;
    return getBookingEventTitle(event);
  }

  String getNotificationDescription(
      BuildContext context, NotificationDetailsRes notification) {
    final metadata = notification.notification?.metadata ?? {};
    final event = metadata['event'] as String?;
    final booking = notification.notification?.booking;

    if (booking == null) return '';

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

  String getNotificationTime(
      BuildContext context, NotificationDetailsRes notification) {
    if (notification.sendAt != null) {
      final now = DateTime.now();
      final difference = now.difference(notification.sendAt!);

      if (difference.inMinutes < 1) {
        return language(context, appFonts.justNow);
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} ${language(context, appFonts.minAgo)}';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} ${language(context, appFonts.hrAgo)}';
      } else {
        return '${difference.inDays} ${language(context, appFonts.dayAgo)}';
      }
    }
    return '';
  }

  bool isNotificationRead(NotificationDetailsRes notification) {
    return notification.readAt != null;
  }

  onDeleteNotification(context, sync) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.notificationBell,
        appFonts.deleteNotification, appFonts.areYouDeleteNotification, () {
      route.pop(context);
      value.onResetPass(
          context,
          language(context, appFonts.hurrayNotificationCleared),
          language(context, appFonts.okay),
          () => route.pop(context));
    });
    value.notifyListeners();
  }
}
