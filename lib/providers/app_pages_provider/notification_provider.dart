import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/cloud_message_response/base_message_response.dart';
import 'package:salon_provider/model/cloud_message_response/booking_message_response.dart';
import 'package:salon_provider/model/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  bool isNotification = false;
  AnimationController? animationController;
  List<NotificationModel> notificationList = [];
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

  onRefresh() {
    isNotification = true;
    notifyListeners();
  }

  onAnimate(TickerProvider sync) {
    animationController = AnimationController(
        vsync: sync, duration: const Duration(milliseconds: 1200));
    _runAnimation();
    notificationList = [];
    notifyListeners();
    appArray.notificationList.asMap().entries.forEach((element) {
      if (!notificationList
          .contains(NotificationModel.fromJson(element.value))) {
        notificationList.add(NotificationModel.fromJson(element.value));
      }
    });
    notifyListeners();
  }

  void _runAnimation() async {
    for (int i = 0; i < 300; i++) {
      await animationController!.forward();
      await animationController!.reverse();
    }
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
