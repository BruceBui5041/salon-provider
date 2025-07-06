import 'dart:developer';

import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/repositories/user_repository.dart';
import 'package:salon_provider/common/enum_value.dart';

class TimeSlotProvider with ChangeNotifier {
  TextEditingController hourGap = TextEditingController();
  FocusNode hourGapFocus = FocusNode();

  CarouselController hourCtrl = CarouselController();
  CarouselController minCtrl = CarouselController();
  CarouselController amPmCtrl = CarouselController();
  int scrollDayIndex = 0;
  int scrollMinIndex = 0;
  int scrollHourIndex = 0;
  int indexs = 0;
  FixedExtentScrollController? controller;

  String? gapValue;
  String? userStatus = Status.pending.value; // Default to pending
  bool isUpdatingStatus = false;
  final UserRepository _userRepository = UserRepository();

  onToggle(data, val) {
    data["status"] = val;
    notifyListeners();
  }

  onMonthChange(val) {
    gapValue = val;
    notifyListeners();
  }

  onHourScroll(index) {
    scrollHourIndex = index;
    notifyListeners();
  }

  onMinScroll(index) {
    scrollMinIndex = index;
    notifyListeners();
  }

  onDayScroll(index) {
    scrollDayIndex = index;
    notifyListeners();
  }

  selectTimeBottomSheet(context, val, index, type) {
    scrollHourIndex = 0;
    scrollMinIndex = 0;
    notifyListeners();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context2) {
        return SelectTimeSheet(
            onTap: () => onAddTime(val, index, context, type));
      },
    );
  }

  onAddTime(val, index, context, type) {
    int hr = scrollHourIndex + 1;
    int mn = scrollMinIndex + 1;

    log("VALALA $val");
    log("INSDE $index");

    if (type == "start") {
      appArray.timeSlotList[index]["start_at"] =
          "${hr.toString()} : ${mn.toString()}";
    } else {
      appArray.timeSlotList[index]["end_at"] =
          "${hr.toString()} : ${mn.toString()}";
    }
    notifyListeners();
    route.pop(context);
  }

  onHourChange(index) {
    scrollHourIndex = index;
    notifyListeners();
  }

  onMinChange(index) {
    scrollMinIndex = index;
    notifyListeners();
  }

  onAmPmChange(index) {
    scrollDayIndex = index;
    notifyListeners();
  }

  onUpdateHour(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialogCommon(
            title: appFonts.updateSuccessfully,
            height: Sizes.s140,
            image: eGifAssets.successGif,
            subtext: language(context, appFonts.hurrayUpdateHour),
            bText1: language(context, appFonts.okay),
            b1OnTap: () => route.pop(context)));
  }

  // User Status Management Methods
  Future<void> updateUserStatus(BuildContext context, String status) async {
    try {
      isUpdatingStatus = true;
      notifyListeners();

      final userId = await AuthConfig.getUserId();
      if (userId == null) {
        throw Exception('User not logged in');
      }

      final success = await _userRepository.updateUserStatus(userId, status);
      if (success) {
        userStatus = status;
        showStatusUpdateDialog(context, status);
      } else {
        throw Exception('Failed to update status');
      }
    } catch (e) {
      log('Error updating user status: $e');
      showErrorDialog(context, e.toString());
    } finally {
      isUpdatingStatus = false;
      notifyListeners();
    }
  }

  void showStatusUpdateDialog(BuildContext context, String status) {
    showDialog(
      context: context,
      builder: (context) => AlertDialogCommon(
        title: appFonts.updateSuccessfully,
        height: Sizes.s140,
        image: eGifAssets.successGif,
        subtext: language(
            context, 'Status updated to ${_getStatusDisplayName(status)}'),
        bText1: language(context, appFonts.okay),
        b1OnTap: () => route.pop(context),
      ),
    );
  }

  void showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialogCommon(
        title: appFonts.errorOccur,
        height: Sizes.s140,
        image: eGifAssets.error,
        subtext: language(context, error),
        bText1: language(context, appFonts.okay),
        b1OnTap: () => route.pop(context),
      ),
    );
  }

  String _getStatusDisplayName(String status) {
    switch (status) {
      case 'draft':
        return 'Draft';
      case 'published':
        return 'Published';
      case 'publishing':
        return 'Publishing';
      default:
        return status;
    }
  }

  // Action handlers for app bar icons
  void onCalendarTap(BuildContext context) {
    // Calendar functionality - could show time slot calendar
    log('Calendar tapped');
  }

  void onCheckTap(BuildContext context) {
    // Toggle between active and inactive
    final newStatus = userStatus == Status.active.value
        ? Status.inactive.value
        : Status.active.value;
    _showStatusChangeAlert(context, newStatus);
  }

  void _showStatusChangeAlert(BuildContext context, String newStatus) {
    final isActivating = newStatus == Status.active.value;
    final statusText = isActivating ? 'active' : 'inactive';
    final bookingText = isActivating
        ? 'You will receive bookings when your status is active.'
        : 'You will not receive bookings when your status is inactive.';

    showDialog(
      context: context,
      builder: (context) => AlertDialogCommon(
        title: 'Change Status',
        height: Sizes.s180,
        image: eGifAssets.dateGif,
        subtext:
            'Are you sure you want to change your status to $statusText?\n\n$bookingText',
        isTwoButton: true,
        firstBText: language(context, appFonts.cancel),
        secondBText: language(context, appFonts.yes),
        firstBTap: () => route.pop(context),
        secondBTap: () {
          route.pop(context);
          updateUserStatus(context, newStatus);
        },
      ),
    );
  }

  Future<void> initializeUserStatus() async {
    try {
      final user = await _userRepository.getUser();
      userStatus = user.status ?? Status.pending.value;
      notifyListeners();
    } catch (e) {
      log('Error initializing user status: $e');
    }
  }
}
