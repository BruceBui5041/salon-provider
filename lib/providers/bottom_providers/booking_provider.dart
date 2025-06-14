import 'dart:async';
import 'package:salon_provider/common/booking_status.dart';
import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/repositories/booking_repository.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/screens/bottom_screens/booking_screen/layouts/booking_layout.dart';
import 'package:salon_provider/model/response/category_response.dart';

import '../../screens/bottom_screens/booking_screen/layouts/booking_filter_layout.dart';
import '../../widgets/year_dialog.dart';

class BookingProvider with ChangeNotifier {
  var repo = getIt.get<BookingRepository>();
  TextEditingController searchCtrl = TextEditingController();
  FocusNode searchFocus = FocusNode();
  FocusNode categoriesFocus = FocusNode();
  BuildContext? _context;
  Timer? _debounce;
  String _previousSearchText = "";

  // Pagination properties
  int currentOffset = 0;
  int pageSize = 5;
  bool hasMoreData = true;
  bool isLoadingMore = false;

  // Add these constants at the top of the class
  static const String bookingStatusPending = "pending";
  static const String bookingStatusConfirmed = "confirmed";
  static const String bookingStatusInProgress = "in_progress";
  static const String bookingStatusCompleted = "completed";
  static const String bookingStatusCancelled = "cancelled";

  BookingProvider() {
    searchCtrl.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchCtrl.dispose();
    super.dispose();
  }

  onBookingCreated(message) async {
    await loadBookings(loadMore: false);
  }

  void listenBooking(BuildContext context) {
    getIt.get<NotificationProvider>().onSubcribeCloudMessage(
        onCallBack: (message) async {
      await loadBookings(loadMore: false);
    });
  }

  Future<List<List<Condition>>> _buildConditions() async {
    List<List<Condition>> conditions = [];

    var userId = await AuthConfig.getUserId();
    var serviceManCondition = Condition(
      source: "service_man_id",
      operator: "=",
      target: userId ?? "",
    );

    conditions.add([serviceManCondition]);

    // Add search condition if search text exists
    if (searchCtrl.text.isNotEmpty) {
      conditions[0].add(Condition(
        source: "service_versions.title",
        operator: "like",
        target: searchCtrl.text,
      ));
    }

    // Add status filter condition
    if (statusIndex > 0 && statusIndex < appArray.bookingStatusList.length) {
      String status;
      switch (statusIndex) {
        case 1:
          status = bookingStatusPending;
          break;
        case 2:
          status = bookingStatusConfirmed;
          break;
        case 3:
          status = bookingStatusInProgress;
          break;
        case 4:
          status = bookingStatusCompleted;
          break;
        case 5:
          status = bookingStatusCancelled;
          break;
        default:
          status = bookingStatusPending;
      }
      conditions[0].add(
        Condition(
          source: "booking_status",
          operator: "=",
          target: status,
        ),
      );
    }

    // Add date range filter condition
    if (rangeStart != null && rangeEnd != null) {
      final startDate =
          DateTime(rangeStart!.year, rangeStart!.month, rangeStart!.day);
      final endDate =
          DateTime(rangeEnd!.year, rangeEnd!.month, rangeEnd!.day, 23, 59, 59);

      conditions[0].addAll([
        Condition(
          source: "booking_date",
          operator: ">=",
          target: startDate.toIso8601String(),
        ),
        Condition(
          source: "booking_date",
          operator: "<=",
          target: endDate.toIso8601String(),
        ),
      ]);
    }

    // Add category filter conditions
    if (statusList.isNotEmpty) {
      List<String> categoryIds = statusList
          .map((index) {
            if (index is int && index >= 0 && index < categories.length) {
              return categories[index].id.toString();
            }
            return null;
          })
          .where((id) => id != null)
          .cast<String>()
          .toList();

      if (categoryIds.isNotEmpty) {
        conditions[0].add(
          Condition(
            source: "service_versions.category.id",
            operator: "in",
            target: categoryIds,
          ),
        );
      }
    }

    return conditions;
  }

  Future<void> resetPagination() async {
    bookingList = [];
    freelancerBookingList = [];
    currentOffset = 0;
    hasMoreData = true;
    notifyListeners();
  }

  Future<void> refreshBookings(BuildContext context) async {
    _context = context;
    await resetPagination();
    await loadBookings();
  }

  Future<void> loadMoreBookings() async {
    if (isProcessing || isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;
    notifyListeners();

    await loadBookings(loadMore: true);
  }

  Future<void> loadBookings({bool loadMore = false}) async {
    if (!loadMore) {
      isProcessing = true;
    } else {
      isLoadingMore = true;
    }
    notifyListeners();

    try {
      List<List<Condition>> conditions = await _buildConditions();

      var res = await repo.getBookings(
        conditions: conditions,
        limit: pageSize,
        offset: loadMore ? currentOffset : 0,
      );

      if (loadMore) {
        bookingList.addAll(res);
        freelancerBookingList.addAll(res);
      } else {
        bookingList = res;
        freelancerBookingList = res;
      }

      hasMoreData = res.length >= pageSize;
      if (hasMoreData) {
        currentOffset += res.length;
      }
    } catch (e) {
      // Handle error if needed
      if (!loadMore) {
        bookingList = [];
        freelancerBookingList = [];
      }
    } finally {
      isProcessing = false;
      isLoadingMore = false;
      notifyListeners();
    }
  }

  void _onSearchChanged() {
    if (_context != null) {
      // Skip if both previous and current search texts are empty
      if (_previousSearchText.isEmpty && searchCtrl.text.isEmpty) {
        return;
      }

      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _previousSearchText = searchCtrl.text;
        refreshBookings(_context!);
      });
    }
  }

  Future<void> _searchBookings() async {
    await refreshBookings(_context!);
  }

  String? month;
  List<Booking> bookingList = [];
  List<Booking> freelancerBookingList = [];
  List statusList = [];
  List<CategoryItem> categories = [];
  bool isLoadingCategories = false;
  bool isExpand = false, isAssignMe = false;
  bool isProcessing = false;
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

  Widget buildBookingList(BuildContext context) {
    return Column(
      children: [
        SearchTextFieldCommon(
          focusNode: searchFocus,
          controller: searchCtrl,
        ).paddingSymmetric(horizontal: Insets.i20),
        const SizedBox(height: Insets.i15),
        Expanded(
          child: isProcessing
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : bookingList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            isFreelancer
                                ? eImageAssets.noListFree
                                : eImageAssets.noBooking,
                            height: Sizes.s180,
                            width: Sizes.s180,
                          ),
                          const SizedBox(height: Sizes.s15),
                          Text(
                            "Ohh no ! List is empty",
                            style: appCss.dmDenseMedium18.textColor(
                              appColor(context).appTheme.primary,
                            ),
                          ),
                          const SizedBox(height: Sizes.s8),
                          Text(
                            "Your booking list is empty because your user hasn't made any bookings yet.",
                            textAlign: TextAlign.center,
                            style: appCss.dmDenseMedium14.textColor(
                              appColor(context)
                                  .appTheme
                                  .darkText
                                  .withOpacity(0.5),
                            ),
                          ).paddingSymmetric(horizontal: Insets.i20),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: Insets.i20),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: isFreelancer
                          ? freelancerBookingList.length + (hasMoreData ? 1 : 0)
                          : bookingList.length + (hasMoreData ? 1 : 0),
                      itemBuilder: (context, index) {
                        // Show loading indicator at the end if we have more data
                        if (index == bookingList.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final booking = isFreelancer
                            ? freelancerBookingList[index]
                            : bookingList[index];
                        return BookingLayout(
                          data: booking,
                          onTap: () => onTapBookings(booking, context),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  onReady(context) async {
    _context = context;
    await refreshBookings(context);
    onInit();

    // Fetch categories
    await fetchCategories();
  }

  Future<void> fetchCategories() async {
    isLoadingCategories = true;
    notifyListeners();

    try {
      var res = await repo.getCategories();
      categories = res;
    } catch (e) {
      // Handle error if needed
      categories = [];
    } finally {
      isLoadingCategories = false;
      notifyListeners();
    }
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
            subtext: appFonts.doYouWantToAccept,
            firstBTap: () => route.pop(context),
            secondBTap: () {
              route.pop(context);
              route.pushNamed(context, routeName.acceptedBooking);
            }));
  }

  onTapBookings(Booking data, context) {
    if (data.bookingStatus == BookingStatus.pending) {
      // route.pushNamed(context, routeName.packageBookingScreen);
      // if (data.servicemanLists.isNotEmpty) {
      //   route.pushNamed(context, routeName.pendingBooking, arg: true);
      // } else {
      //   route.pushNamed(context, routeName.pendingBooking, arg: false);
      // }
      route.pushNamed(context, routeName.customPendingBooking, arg: data.id);
    } else if (data.bookingStatus == BookingStatus.confirmed) {
      route.pushNamed(context, routeName.assignBooking, arg: data.id);
      // if (isFreelancer) {
      //   route.pushNamed(context, routeName.assignBooking);
      // } else {
      //   if (data.assignMe == "Yes") {
      //     route.pushNamed(contex t, routeName.acceptedBooking,
      //         arg: {"amount": "0", "assign_me": true});
      //   } else {
      //     route.pushNamed(context, routeName.acceptedBooking,
      //         arg: {"amount": "0", "assign_me": false});
      //   }
      // }
    } else if (data.status == appFonts.pendingApproval) {
      route.pushNamed(context, routeName.pendingApprovalBooking);
    } else if (data.bookingStatus == BookingStatus.inProgress) {
      route.pushNamed(context, routeName.ongoingBooking, arg: data.id);
    } else if (data.bookingStatus == BookingStatus.completed) {
      route.pushNamed(context, routeName.completedBooking, arg: data.id);
    } else if (data.bookingStatus == BookingStatus.cancelled) {
      route.pushNamed(context, routeName.cancelledBooking, arg: data.id);
    }
    // else if (data.bookingStatus == BookingStatus.confirmed) {
    //   if (data.servicemanLists.isNotEmpty) {
    //     route.pushNamed(context, routeName.assignBooking, arg: {"bool": true});
    //   } else {
    //     route.pushNamed(context, routeName.assignBooking, arg: {"bool": false});
    //   }
    // }
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

  onCategoryChange(context, CategoryItem category) {
    var index = categories.indexOf(category);
    if (!statusList.contains(index)) {
      statusList.add(index);
    } else {
      statusList.remove(index);
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

  onApplyFilter(context) {
    route.pop(context);
    refreshBookings(_context!);
  }

  onClearFilter(context) {
    statusIndex = 0;
    statusList.clear();
    rangeStart = null;
    rangeEnd = null;
    isAssignMe = false;
    route.pop(context);
    refreshBookings(_context!);
  }

  bool get hasActiveFilters {
    return statusIndex > 0 || // Status filter is active
        statusList.isNotEmpty || // Category filter is active
        (rangeStart != null && rangeEnd != null); // Date range filter is active
  }
}
