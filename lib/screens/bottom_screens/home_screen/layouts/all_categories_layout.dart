
import '../../../../config.dart';

class AllCategoriesLayout extends StatelessWidget {
  const AllCategoriesLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider,DashboardProvider>(
      builder: (context,value,dashCtrl,child) {
        return Column(
          children: [
            if(isFreelancer != true)
            HeadingRowCommon(
                title: appFonts.availableServiceman,
                onTap: () =>
                    route.pushNamed(context, routeName.servicemanList))
                .padding(
                horizontal: Insets.i20,
                top: Insets.i25,
                bottom: Insets.i15),
            if(isFreelancer != true)
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: appArray.availableServicemanList
                    .getRange(0, 4)
                    .length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 220,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
                itemBuilder: (context, index) {
                  return AvailableServiceLayout(
                      onTap: () => route.pushNamed(
                          context, routeName.servicemanDetail),
                      data: appArray.availableServicemanList[index]);
                })
                .paddingOnly(
                left: Insets.i20,
                right: Insets.i20,
                bottom: Insets.i25),
            if(value.recentBookingList.isNotEmpty)
            Column(children: [
              HeadingRowCommon(title: appFonts.recentBooking,onTap: ()=> value.onTapIndexOne(dashCtrl)),
              const VSpace(Sizes.s15),
              ...value.recentBookingList.getRange(0, 2).toList()
                  .asMap()
                  .entries
                  .map((e) => BookingLayout(data: e.value,onTap: ()=> value.onTapBookings(e.value, context),))
                  .toList()
            ])
                .padding(
                horizontal: Insets.i20,
                top: Insets.i25,
                bottom: Insets.i10)
                .decorated(color: appColor(context).appTheme.fieldCardBg),
            const VSpace(Sizes.s25),
            HeadingRowCommon(
                title: appFonts.popularService,
                onTap: () => route.pushNamed(
                    context, routeName.popularServiceScreen))
                .paddingSymmetric(horizontal: Insets.i20),
            const VSpace(Sizes.s15),
            ...appArray.popularServiceList
                .getRange(0, 2)
                .toList()
                .asMap()
                .entries
                .map((e) => FeaturedServicesLayout(
                data: e.value,
                onTap: () => route.pushNamed(
                    context, routeName.serviceDetails))
                .paddingSymmetric(horizontal: Insets.i20))
                .toList(),
            const VSpace(Sizes.s10),
            HeadingRowCommon(
                title: appFonts.latestBlog,
                onTap: () => route.pushNamed(
                    context, routeName.latestBlogViewAll))
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
      }
    );
  }
}
