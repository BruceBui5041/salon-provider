import 'package:salon_provider/config.dart';
import 'package:salon_provider/common/booking_status.dart';
import '../../model/response/booking_response.dart';
import '../../widgets/withdraw_amount_bottom_sheet.dart';

class HomeProvider with ChangeNotifier {
  List recentBookingList = [];
  bool isSwitch = true;
  int selectedIndex = 0;
  int selectType = 0;

  AnimationStatus status = AnimationStatus.dismissed;
  TextEditingController amountCtrl = TextEditingController();
  TextEditingController messageCtrl = TextEditingController();

  FocusNode amountFocus = FocusNode();
  FocusNode messageFocus = FocusNode();

  int touchedIndex = -1;

  bool isPlaying = false;
  bool isTouchBar = false;

  final double width = 12;
  String? withdrawValue;

  List<BarChartGroupData>? rawBarGroups;
  List<BarChartGroupData>? showingBarGroups;

  int touchedGroupIndex = -1;

  // Update recentBookingList from API data
  void updateRecentBookings(List<Booking> bookings) {
    recentBookingList = [];

    // Convert API bookings to Booking
    for (var booking in bookings) {
      String? serviceName;
      String? serviceImage;

      if (booking.serviceVersions != null &&
          booking.serviceVersions!.isNotEmpty) {
        serviceName = booking.serviceVersions![0].title;
        if (booking.serviceVersions![0].mainImageResponse != null) {
          serviceImage = booking.serviceVersions![0].mainImageResponse!.url;
        }
      }

      recentBookingList.add(booking);
    }

    notifyListeners();
  }

  onChangeType(index) {
    selectType = index;
    notifyListeners();
  }

  onWithdrawTap(val) {
    withdrawValue = val;
    notifyListeners();
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2, context) {
    return BarChartGroupData(barsSpace: 1, x: x, barRods: [
      BarChartRodData(
          toY: y1, color: appColor(context).appTheme.fieldCardBg, width: width)
    ]);
  }

  onToolTip(FlTouchEvent event, response, context) {
    if (response == null || response.spot == null) {
      touchedGroupIndex = -1;
      showingBarGroups = List.of(rawBarGroups!);
      return;
    }
    touchedGroupIndex = response.spot!.touchedBarGroupIndex;
    if (!event.isInterestedForInteractions) {
      touchedGroupIndex = -1;
      showingBarGroups = List.of(rawBarGroups!);
      return;
    }
    showingBarGroups = List.of(rawBarGroups!);
    if (touchedGroupIndex != -1) {
      var sum = 0.0;
      for (final rod in showingBarGroups![touchedGroupIndex].barRods) {
        sum += rod.toY;
      }
      final avg = sum / showingBarGroups![touchedGroupIndex].barRods.length;

      showingBarGroups![touchedGroupIndex] =
          showingBarGroups![touchedGroupIndex].copyWith(
        barRods: showingBarGroups![touchedGroupIndex].barRods.map((rod) {
          return rod.copyWith(
              toY: avg, color: appColor(context).appTheme.primary);
        }).toList(),
      );
    }
  }

  onTapWmy(index) {
    selectedIndex = index;
    notifyListeners();
  }

  onTapIndexOne(value) {
    value.selectIndex = 1;
    value.notifyListeners();
  }

  onTapBookings(data, context) {
    if (data.status == appFonts.pending) {
      //route.pushNamed(context, routeName.packageBookingScreen);
      if (data.servicemanLists.isNotEmpty) {
        route.pushNamed(context, routeName.pendingBooking, arg: true);
      } else {
        route.pushNamed(context, routeName.pendingBooking, arg: false);
      }
    } else if (data.status == appFonts.accepted) {
      if (isFreelancer) {
        route.pushNamed(context, routeName.assignBooking);
      } else {
        route.pushNamed(context, routeName.acceptedBooking);
      }
    } else if (data.status == appFonts.pendingApproval) {
      route.pushNamed(context, routeName.pendingApprovalBooking);
    } else if (data.status == appFonts.ongoing) {
      if (data.servicemanLists.isNotEmpty) {
        route
            .pushNamed(context, routeName.ongoingBooking, arg: {"bool": false});
      } else {
        route.pushNamed(context, routeName.ongoingBooking, arg: {"bool": true});
      }
    } else if (data.status == appFonts.hold) {
      route.pushNamed(context, routeName.holdBooking);
    } else if (data.status == appFonts.completed) {
      route.pushNamed(context, routeName.completedBooking, arg: data.id);
    } else if (data.status == appFonts.cancelled) {
      route.pushNamed(context, routeName.cancelledBooking);
    } else if (data.status == appFonts.assigned) {
      if (data.servicemanLists.isNotEmpty) {
        route.pushNamed(context, routeName.assignBooking, arg: {"bool": true});
      } else {
        route.pushNamed(context, routeName.assignBooking, arg: {"bool": false});
      }
    } else if (data.bookingStatus == BookingStatus.inProgress) {
      route.pushNamed(context, routeName.ongoingBooking, arg: data.id);
    } else if (data.bookingStatus == BookingStatus.completed) {
      route.pushNamed(context, routeName.completedBooking, arg: data.id);
    } else if (data.bookingStatus == BookingStatus.cancelled) {
      route.pushNamed(context, routeName.cancelledBooking, arg: data.id);
    }
  }

  onTapOption(index, context) {
    final value = Provider.of<DashboardProvider>(context, listen: false);
    if (index == 2) {
      route.pushNamed(context, routeName.serviceList);
    } else if (index == 3) {
      route.pushNamed(context, routeName.categories);
    } else if (index == 0) {
      route.pushNamed(context, routeName.earnings);
    } else {
      value.selectIndex = 1;
      value.notifyListeners();
    }
  }

  onTapSwitch(val, data) {
    data["isStatus"] = val;
    notifyListeners();
  }

  onReady(context, sync) {
    notifyListeners();
  }

  onWithdraw(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context1) {
        return WithdrawAmountBottomSheet();
      },
    );
  }
}
