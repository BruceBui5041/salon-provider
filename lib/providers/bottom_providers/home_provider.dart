import 'package:salon_provider/config.dart';
import 'package:salon_provider/common/booking_status.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import '../../model/response/booking_response.dart';
import '../../widgets/withdraw_amount_bottom_sheet.dart';
import '../../repositories/booking_repository.dart';

class HomeProvider with ChangeNotifier {
  List<Booking> recentBookingList = [];
  bool isSwitch = true;
  int selectedIndex = 0;
  int selectType = 0;
  final BookingRepository _bookingRepository = BookingRepository();
  String? error;

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

  Future<void> getRecentBookings() async {
    try {
      var userId = await AuthConfig.getUserId();
      var conditions = [
        [
          Condition(
            source: "service_man_id",
            operator: "=",
            target: userId ?? "",
          ),
          Condition(
            source: "booking_status",
            operator: "not in",
            target: ["completed", "cancelled"],
          ),
        ]
      ];
      final bookingResponse = await _bookingRepository.getBookings(
        conditions: conditions,
        limit: 5,
      );

      updateRecentBookings(bookingResponse);
    } catch (e) {
      error = "Failed to load bookings";
      notifyListeners();
    }
  }

  // Update recentBookingList from API data
  void updateRecentBookings(List<Booking> bookings) {
    recentBookingList = bookings;
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

  void onTapBookings(Booking booking, BuildContext context) {
    final status = booking.bookingStatus;
    switch (status) {
      case BookingStatus.pending:
        route.pushNamed(context, routeName.pendingBooking, arg: booking.id);
        break;
      case BookingStatus.confirmed:
        if (isFreelancer) {
          route.pushNamed(context, routeName.acceptedBooking, arg: booking.id);
        } else {
          route.pushNamed(context, routeName.assignBooking, arg: booking.id);
        }
        break;
      case BookingStatus.inProgress:
        route.pushNamed(context, routeName.ongoingBooking, arg: booking.id);
        break;
      case BookingStatus.completed:
        route.pushNamed(context, routeName.completedBooking, arg: booking.id);
        break;
      case BookingStatus.cancelled:
        route.pushNamed(context, routeName.cancelledBooking, arg: booking.id);
        break;
      default:
        // For any other status, do nothing
        break;
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
