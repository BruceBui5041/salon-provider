import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/repositories/booking_repository.dart';

import '../../model/booking_model.dart';
import '../../screens/bottom_screens/booking_screen/layouts/booking_filter_layout.dart';
import '../../widgets/year_dialog.dart';

class BookingProvider with ChangeNotifier {
  var repo = getIt.get<BookingRepository>();
  TextEditingController searchCtrl = TextEditingController();
  FocusNode searchFocus = FocusNode();
  FocusNode categoriesFocus = FocusNode();

  String? month;
  List bookingList = [];
  List freelancerBookingList = [];
  List statusList = [];
  bool isExpand = false, isAssignMe = false;
  int selectIndex = 0;
  int statusIndex = 0;
  dynamic slotChosenValue;
  DateTime? slotSelectedDay;
  DateTime slotSelectedYear = DateTime.now();
  dynamic chosenValue;
  DateTime? selectedDay;
  DateTime selectedYear = DateTime.now();
  final ValueNotifier<DateTime> focusedDay = ValueNotifier(DateTime.now());
  CalendarFormat calendarFormat = CalendarFormat.month;
  int demoInt = 0;
  PageController pageController = PageController();
  TextEditingController categoryCtrl = TextEditingController();
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime? rangeStart;
  DateTime? rangeEnd;
  DateTime currentDate = DateTime.now();
  String showYear = 'Select Year';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode reasonFocus = FocusNode();
  TextEditingController reasonCtrl = TextEditingController();

  onReady(context) async {
    bookingList = [];
    freelancerBookingList = [];
    notifyListeners();

    if (isFreelancer == true) {
      appArray.freelancerBookingList.asMap().entries.forEach((element) {
        if (!freelancerBookingList
            .contains(BookingModel.fromJson(element.value))) {
          freelancerBookingList.add(BookingModel.fromJson(element.value));
        }
      });
      notifyListeners();
    } else {
      appArray.bookingList.asMap().entries.forEach((element) {
        if (!bookingList.contains(BookingModel.fromJson(element.value))) {
          bookingList.add(BookingModel.fromJson(element.value));
        }
      });
    }

    // var res = await repo.getBookings();
    // if (res.data.isNotEmpty) {
    //   res.data.asMap().entries.forEach((element) {
    //     bookingList = res.data;
    //     freelancerBookingList = res.data;
    //   });
    // }
    // notifyListeners();
    onInit();
    notifyListeners();
  }

  onRejectBooking(context) {
    showDialog(
        context: context,
        builder: (context1) => AppAlertDialogCommon(
            isField: true,
            validator: (value) => validation.commonValidation(context, value),
            focusNode: reasonFocus,
            controller: reasonCtrl,
            title: appFonts.reasonOfRejectBooking,
            singleText: appFonts.send,
            globalKey: formKey,
            singleTap: () {
              if (formKey.currentState!.validate()) {
                route.pop(context);
              }
              notifyListeners();
            }));
  }

  onAcceptBooking(context) {
    showDialog(
        context: context,
        builder: (context1) => AppAlertDialogCommon(
            height: Sizes.s100,
            title: appFonts.assignBooking,
            firstBText: appFonts.doItLater,
            secondBText: appFonts.yes,
            image: eGifAssets.dateGif,
            subtext: appFonts.doYouWant,
            firstBTap: () => route.pop(context),
            secondBTap: () {
              route.pop(context);
              route.pushNamed(context, routeName.acceptedBooking);
            }));
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
        if (data.assignMe == "Yes") {
          route.pushNamed(context, routeName.acceptedBooking,
              arg: {"amount": "0", "assign_me": true});
        } else {
          route.pushNamed(context, routeName.acceptedBooking,
              arg: {"amount": "0", "assign_me": false});
        }
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
      route.pushNamed(context, routeName.completedBooking);
    } else if (data.status == appFonts.cancelled) {
      route.pushNamed(context, routeName.cancelledBooking);
    } else if (data.status == appFonts.assigned) {
      if (data.servicemanLists.isNotEmpty) {
        route.pushNamed(context, routeName.assignBooking, arg: {"bool": true});
      } else {
        route.pushNamed(context, routeName.assignBooking, arg: {"bool": false});
      }
    }
  }

  onTapSwitch(val) {
    isAssignMe = val;
    notifyListeners();
  }

  onTapMonth(val) {
    month = val;
    notifyListeners();
  }

  onRangeSelect(start, end, focusedDay) {
    selectedDay = null;
    currentDate = focusedDay;
    rangeStart = start;
    rangeEnd = end;
    rangeSelectionMode = RangeSelectionMode.toggledOn;
    notifyListeners();
  }

  selectYear(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context3) {
          return YearAlertDialog(
              selectedDate: selectedYear,
              onChanged: (DateTime dateTime) {
                selectedYear = dateTime;
                showYear = "${dateTime.year}";
                focusedDay.value = DateTime.utc(selectedYear.year,
                    chosenValue["index"], focusedDay.value.day + 0);
                onDaySelected(focusedDay.value, focusedDay.value);
                notifyListeners();
                route.pop(context);
              });
        });
  }

  onDropDownChange(choseVal) {
    notifyListeners();
    chosenValue = choseVal;

    notifyListeners();
    int index = choseVal['index'];
    focusedDay.value =
        DateTime.utc(focusedDay.value.year, index, focusedDay.value.day + 0);
    onDaySelected(focusedDay.value, focusedDay.value);
  }

  onRightArrow() {
    pageController.nextPage(
        duration: const Duration(microseconds: 200), curve: Curves.bounceIn);
    final newMonth = focusedDay.value.add(const Duration(days: 30));
    focusedDay.value = newMonth;
    int index = appArray.monthList
        .indexWhere((element) => element['index'] == focusedDay.value.month);
    chosenValue = appArray.monthList[index];
    selectedYear = DateTime.utc(focusedDay.value.year, focusedDay.value.month,
        focusedDay.value.day + 0);
    notifyListeners();
  }

  onLeftArrow() {
    if (focusedDay.value.month != DateTime.january ||
        focusedDay.value.year != DateTime.now().year) {
      pageController.previousPage(
          duration: const Duration(microseconds: 200), curve: Curves.bounceIn);
      final newMonth = focusedDay.value.subtract(const Duration(days: 30));
      focusedDay.value = newMonth;
      int index = appArray.monthList
          .indexWhere((element) => element['index'] == focusedDay.value.month);
      chosenValue = appArray.monthList[index];
      selectedYear = DateTime.utc(focusedDay.value.year, focusedDay.value.month,
          focusedDay.value.day + 0);
    }
    notifyListeners();
  }

  void onDaySelected(DateTime selectDay, DateTime fDay) {
    notifyListeners();
    focusedDay.value = selectDay;
  }

  onPageCtrl(dayFocused) {
    focusedDay.value = dayFocused;
    demoInt = dayFocused.year;
    notifyListeners();
  }

  onInit() {
    focusedDay.value = DateTime.utc(focusedDay.value.year,
        focusedDay.value.month, focusedDay.value.day + 0);
    onDaySelected(focusedDay.value, focusedDay.value);
    DateTime dateTime = DateTime.now();
    int index = appArray.monthList
        .indexWhere((element) => element['index'] == dateTime.month);
    chosenValue = appArray.monthList[index];
    notifyListeners();
  }

  onCalendarCreate(controller) {
    pageController = controller;
  }

  onCategoryChange(context, id) {
    if (!statusList.contains(id)) {
      statusList.add(id);
    } else {
      statusList.remove(id);
    }

    notifyListeners();
  }

  onStatus(index) {
    statusIndex = index;
    notifyListeners();
  }

  onFilter(index) {
    selectIndex = index;
    notifyListeners();
  }

  onExpand(data) {
    data.isExpand = !data.isExpand;
    notifyListeners();
  }

  onTapFilter(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BookingFilterLayout();
      },
    );
  }
}
