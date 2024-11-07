import '../../../config.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(builder: (context, value, child) {
      return StatefulWrapper(
        onInit: () => Future.delayed(
            const Duration(milliseconds: 50), () => value.onReady(context)),
        child: Scaffold(
            appBar: AppBar(
                leadingWidth: 0,
                centerTitle: false,
                title: Text(language(context, appFonts.bookings),
                    style: appCss.dmDenseBold18
                        .textColor(appColor(context).appTheme.darkText)),
                actions: [
                  CommonArrow(arrow: eSvgAssets.filter,onTap: ()=> value.onTapFilter(context)),
                  CommonArrow(arrow: eSvgAssets.chat,onTap: ()=> route.pushNamed(context, routeName.chat))
                      .paddingSymmetric(horizontal: Insets.i10),
                  CommonArrow(arrow: eSvgAssets.notification,onTap: ()=> route.pushNamed(context, routeName.notification)),
                  const HSpace(Sizes.s20)
                ]),
            body: value.bookingList.isNotEmpty || value.freelancerBookingList.isNotEmpty ? SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  SearchTextFieldCommon(focusNode: value.searchFocus,controller: value.searchCtrl),
                  Text(language(context, appFonts.allBooking),
                          style: appCss.dmDenseMedium18
                              .textColor(appColor(context).appTheme.darkText))
                      .paddingOnly(top: Insets.i25, bottom: Insets.i15),
                      if(isFreelancer != true)
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        SizedBox(
                          width: Sizes.s200,
                          child: Text(language(context, appFonts.onlyViewBookings),
                              style: appCss.dmDenseMedium12
                                  .textColor(  value.isAssignMe ? appColor(context).appTheme.primary : appColor(context).appTheme.darkText))
                        ),
                        FlutterSwitchCommon(
                            value: value.isAssignMe,
                            onToggle: (val) => value.onTapSwitch(val))
                      ])
                          .paddingAll(Insets.i15)
                          .boxShapeExtension(
                          color: value.isAssignMe ?  appColor(context).appTheme.primary.withOpacity(0.15) :
                          appColor(context).appTheme.fieldCardBg,
                          radius: AppRadius.r10)
                          .paddingOnly( bottom: Insets.i20),

                      if(isFreelancer != true)
                  ...value.bookingList
                      .asMap()
                      .entries
                      .map((e) => BookingLayout(data: e.value, onTap: ()=> value.onTapBookings(e.value, context)))
                      .toList(),
                      if(isFreelancer == true)
                        ...value.freelancerBookingList
                            .asMap()
                            .entries
                            .map((e) => BookingLayout(data: e.value, onTap: ()=> value.onTapBookings(e.value, context)))
                            .toList(),
                ]).padding(
                    horizontal: Insets.i20,
                    top: Insets.i15,
                    bottom: Insets.i100)) : EmptyLayout(
              isButton: false,
                title: appFonts.ohhNoListEmpty,
                subtitle: appFonts.yourBookingList,

                widget: Stack(children: [
                  Image.asset( isFreelancer ? eImageAssets.noListFree : eImageAssets.noBooking, height: Sizes.s306)
                ])))
      );
    });
  }
}
