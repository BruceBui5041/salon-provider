import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/screens/bottom_screens/home_screen/layouts/all_service_layout.dart';
import 'package:salon_provider/repositories/booking_repository.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/screens/bottom_screens/booking_screen/layouts/custom_booking_layout.dart';
import 'package:salon_provider/model/booking_model.dart';
import 'package:provider/provider.dart';

import '../../../../config.dart';

class AllCategoriesLayout extends StatefulWidget {
  const AllCategoriesLayout({super.key});

  @override
  State<AllCategoriesLayout> createState() => _AllCategoriesLayoutState();
}

class _AllCategoriesLayoutState extends State<AllCategoriesLayout> {
  final BookingRepository _bookingRepository = BookingRepository();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchRecentBookings();
  }

  Future<void> _fetchRecentBookings() async {
    setState(() {
      isLoading = true;
    });

    try {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      var userId = await AuthConfig.getUserId();
      var conditions = [
        [
          Condition(
            source: "service_man_id",
            operator: "=",
            target: userId ?? "",
          ),
        ]
      ];
      final bookingResponse = await _bookingRepository.getBookings(
        conditions: conditions,
        limit: 5,
      );

      // Update the HomeProvider's recentBookingList with the API results
      homeProvider.updateRecentBookings(bookingResponse ?? []);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching recent bookings: $e');
    }
  }

  // Handler for tapping on a booking in CustomBookingLayout
  void _onTapBooking(
      Booking booking, BuildContext context, HomeProvider provider) {
    final status = booking.bookingStatus?.toLowerCase();

    if (status == appFonts.pending.toLowerCase()) {
      route.pushNamed(context, routeName.pendingBooking, arg: booking.id);
    } else if (status == appFonts.accepted.toLowerCase()) {
      if (isFreelancer) {
        route.pushNamed(context, routeName.assignBooking);
      } else {
        route.pushNamed(context, routeName.acceptedBooking);
      }
    } else if (status == "pending_approval") {
      route.pushNamed(context, routeName.pendingApprovalBooking);
    } else if (status == appFonts.ongoing.toLowerCase()) {
      route.pushNamed(context, routeName.ongoingBooking, arg: {"bool": true});
    } else if (status == appFonts.hold.toLowerCase()) {
      route.pushNamed(context, routeName.holdBooking);
    } else if (status == appFonts.completed.toLowerCase()) {
      route.pushNamed(context, routeName.completedBooking);
    } else if (status == appFonts.cancelled.toLowerCase()) {
      route.pushNamed(context, routeName.cancelledBooking);
    } else if (status == appFonts.assigned.toLowerCase()) {
      route.pushNamed(context, routeName.assignBooking, arg: {"bool": false});
    }
  }

  // For backward compatibility with the old BookingLayout
  Widget _buildLegacyBookingLayout(
      Booking data, BuildContext context, HomeProvider provider) {
    return BookingLayout(
      data: data,
      onTap: () => provider.onTapBookings(data, context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, DashboardProvider>(
        builder: (context, value, dashCtrl, child) {
      return Column(
        children: [
          if (isFreelancer != true)
            // if (isFreelancer != true)
            //   GridView.builder(
            //           shrinkWrap: true,
            //           physics: const NeverScrollableScrollPhysics(),
            //           padding: EdgeInsets.zero,
            //           itemCount: appArray.availableServicemanList
            //               .getRange(0, 4)
            //               .length,
            //           gridDelegate:
            //               const SliverGridDelegateWithFixedCrossAxisCount(
            //                   crossAxisCount: 2,
            //                   mainAxisExtent: 220,
            //                   crossAxisSpacing: 15,
            //                   mainAxisSpacing: 15),
            //           itemBuilder: (context, index) {
            //             return AvailableServiceLayout(
            //                 onTap: () => route.pushNamed(
            //                     context, routeName.servicemanDetail),
            //                 data: appArray.availableServicemanList[index]);
            //           })
            //       .paddingOnly(
            //           left: Insets.i20, right: Insets.i20, bottom: Insets.i25),
            // HeadingRowCommon(
            //         title: "Tất cả service ",
            //         onTap: () {
            //           // route.pushNamed(context, routeName.servicemanList);
            //         })
            //     .padding(
            //         horizontal: Insets.i20, top: Insets.i25, bottom: Insets.i15),
            if (value.recentBookingList.isNotEmpty ||
                isLoading ||
                value.bookingsApiData.isNotEmpty)
              Column(children: [
                HeadingRowCommon(
                    title: appFonts.recentBooking,
                    onTap: () => value.onTapIndexOne(dashCtrl)),
                const VSpace(Sizes.s15),
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  ...value.bookingsApiData.isNotEmpty
                      ? value.bookingsApiData
                          .getRange(
                              0,
                              value.bookingsApiData.length < 5
                                  ? value.bookingsApiData.length
                                  : 5)
                          .map((booking) => CustomBookingLayout(
                                data: booking,
                                onTap: () =>
                                    _onTapBooking(booking, context, value),
                              ))
                          .toList()
                      : value.recentBookingList
                          .getRange(
                              0,
                              value.recentBookingList.length < 5
                                  ? value.recentBookingList.length
                                  : 5)
                          .map((booking) => _buildLegacyBookingLayout(
                              booking as Booking, context, value))
                          .toList()
              ])
                  .padding(
                      horizontal: Insets.i20,
                      top: Insets.i25,
                      bottom: Insets.i10)
                  .decorated(color: appColor(context).appTheme.fieldCardBg),
          const VSpace(Sizes.s25),
          HeadingRowCommon(
              title: appFonts.serviceAvailable,
              onTap: () =>
                  route.pushNamed(context, routeName.servicemanList)).padding(
              horizontal: Insets.i20, top: Insets.i25, bottom: Insets.i15),
          AllServiceLayout(),
          HeadingRowCommon(
                  title: appFonts.popularService,
                  onTap: () =>
                      route.pushNamed(context, routeName.popularServiceScreen))
              .paddingSymmetric(horizontal: Insets.i20),
          const VSpace(Sizes.s15),
          ...appArray.popularServiceList
              .getRange(0, 2)
              .toList()
              .asMap()
              .entries
              .map((e) => FeaturedServicesLayout(
                      data: e.value,
                      onTap: () =>
                          route.pushNamed(context, routeName.serviceDetails))
                  .paddingSymmetric(horizontal: Insets.i20))
              .toList(),
          const VSpace(Sizes.s10),
          HeadingRowCommon(
                  title: appFonts.latestBlog,
                  onTap: () =>
                      route.pushNamed(context, routeName.latestBlogViewAll))
              .paddingSymmetric(horizontal: Insets.i20),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                      children: dashCtrl.blogList
                          .asMap()
                          .entries
                          .map((e) => LatestBlogLayout(data: e.value))
                          .toList())
                  .paddingOnly(left: Insets.i20))
        ],
      );
    });
  }
}
