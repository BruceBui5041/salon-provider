import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  bool isNotification = false;
  AnimationController? animationController;
  List<NotificationModel> notificationList = [];

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
