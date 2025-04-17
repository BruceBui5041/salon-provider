import 'package:salon_provider/common/booking_status.dart';
import 'package:salon_provider/config/auth_config.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/screens/bottom_screens/home_screen/layouts/all_service_layout.dart';
import 'package:salon_provider/repositories/booking_repository.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/screens/bottom_screens/booking_screen/layouts/booking_layout.dart';
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

      // Update the HomeProvider's recentBookingList with the API results
      homeProvider.updateRecentBookings(bookingResponse);

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
    Booking booking,
    BuildContext context,
    HomeProvider provider,
  ) {
    final status = booking.bookingStatus;

    if (status == BookingStatus.pending) {
      route.pushNamed(context, routeName.customPendingBooking, arg: booking.id);
    } else if (status == BookingStatus.confirmed) {
      route.pushNamed(context, routeName.assignBooking, arg: booking.id);
    } else if (status == appFonts.pendingApproval) {
      route.pushNamed(context, routeName.pendingApprovalBooking);
    } else if (status == BookingStatus.inProgress) {
      route.pushNamed(context, routeName.ongoingBooking, arg: booking.id);
    } else if (status == BookingStatus.completed) {
      route.pushNamed(context, routeName.completedBooking, arg: booking.id);
    } else if (status == BookingStatus.cancelled) {
      route.pushNamed(context, routeName.cancelledBooking, arg: booking.id);
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
            const VSpace(Sizes.s25),
          if (value.recentBookingList.isNotEmpty || isLoading)
            Column(children: [
              HeadingRowCommon(
                  title: appFonts.recentBooking,
                  onTap: () => value.onTapIndexOne(dashCtrl)),
              const VSpace(Sizes.s15),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ...value.recentBookingList.isNotEmpty
                    ? value.recentBookingList
                        .getRange(
                            0,
                            value.recentBookingList.length < 5
                                ? value.recentBookingList.length
                                : 5)
                        .map((booking) => BookingLayout(
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
                    horizontal: Insets.i20, top: Insets.i25, bottom: Insets.i10)
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
