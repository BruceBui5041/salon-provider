import '../../../config.dart';
import '../../app_pages_screens/pending_booking_screen/layouts/custom_status_detail_layout.dart';

class CancelledBookingScreen extends StatelessWidget {
  const CancelledBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CancelledBookingProvider>(builder: (context, value, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 50), () => value.onReady(context)),
          child: Scaffold(
              appBar: AppBarCommon(title: appFonts.cancelledBookings),
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        CustomStatusDetailLayout(
                            onChat: () =>
                                route.pushNamed(context, routeName.chat),
                            data: value.cancelledBookingModel,
                            onMore: () => route.pushNamed(
                                context, routeName.servicemanDetail),
                            onTapStatus: () =>
                                value.showBookingStatus(context)),
                        Text(language(context, appFonts.billSummary),
                                style: appCss.dmDenseMedium14.textColor(
                                    appColor(context).appTheme.darkText))
                            .paddingOnly(top: Insets.i25, bottom: Insets.i10),
                        CancelledBillSummary(
                            booking: value.cancelledBookingModel),
                        const VSpace(Sizes.s20),
                      ]).padding(
                          horizontal: Insets.i20,
                          top: Insets.i20,
                          bottom: Insets.i100)),
                  Material(
                      elevation: 20,
                      child: AssignStatusLayout(
                          status: appFonts.reason,
                          title: isFreelancer
                              ? appFonts.youChangedTimeSlot
                              : appFonts.servicemenIsNotAvailable))
                ],
              )));
    });
  }
}
