import 'package:flutter/material.dart';
import 'package:salon_provider/screens/bottom_screens/booking_screen/layouts/booking_layout.dart';
import 'package:provider/provider.dart';
import 'package:salon_provider/screens/bottom_screens/home_screen/layouts/popular_service_layout.dart';

import '../../../../config.dart';

class AllCategoriesLayout extends StatefulWidget {
  const AllCategoriesLayout({super.key});

  @override
  State<AllCategoriesLayout> createState() => AllCategoriesLayoutState();
}

class AllCategoriesLayoutState extends State<AllCategoriesLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, DashboardProvider>(
        builder: (context, value, dashCtrl, child) {
      return Column(
        children: [
          if (isFreelancer != true) const VSpace(Sizes.s25),
          if (value.recentBookingList.isNotEmpty)
            Column(children: [
              HeadingRowCommon(
                  title: appFonts.recentBooking,
                  onTap: () => value.onTapIndexOne(dashCtrl)),
              const VSpace(Sizes.s15),
              ...value.recentBookingList
                  .getRange(
                      0,
                      value.recentBookingList.length < 5
                          ? value.recentBookingList.length
                          : 5)
                  .map((booking) => BookingLayout(
                        data: booking,
                        onTap: () => value.onTapBookings(booking, context),
                      ))
                  .toList()
            ])
                .padding(
                    horizontal: Insets.i20, top: Insets.i25, bottom: Insets.i10)
                .decorated(color: appColor(context).appTheme.fieldCardBg),
          const VSpace(Sizes.s25),
          HeadingRowCommon(
                  title: appFonts.popularService,
                  onTap: () =>
                      route.pushNamed(context, routeName.popularServiceScreen))
              .paddingSymmetric(horizontal: Insets.i20),
          const VSpace(Sizes.s15),
          const FeaturedServicesLayout(limit: 5)
              .paddingSymmetric(horizontal: Insets.i20),
        ],
      );
    });
  }
}
