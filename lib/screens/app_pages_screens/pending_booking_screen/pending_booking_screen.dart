import '../../../config.dart';

class PendingBookingScreen extends StatelessWidget {
  const PendingBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PendingBookingProvider>(builder: (context, value, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 100), () => value.onReady(context)),
          child: Scaffold(
              appBar: AppBarCommon(title: appFonts.pendingBooking),
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                        StatusDetailLayout(
                            onMore: ()=> route.pushNamed(context, routeName.servicemanDetail, arg: false),
                            data: value.pendingBookingModel,
                            onTapStatus: () =>
                                value.showBookingStatus(context)),
                        if(value.isAmount)
                          ServicemenPayableLayout(amount: value.amountCtrl.text),
                        Text(language(context, appFonts.billSummary),
                                style: appCss.dmDenseMedium14.textColor(
                                    appColor(context).appTheme.darkText))
                            .paddingOnly(top: Insets.i25, bottom: Insets.i10),
                        const CancelledBillSummary(),
                        const VSpace(Sizes.s20),
                        HeadingRowCommon(
                                title: appFonts.review,
                                onTap: () => route.pushNamed(
                                    context, routeName.serviceReview))
                            .paddingOnly(bottom: Insets.i12),
                        ...appArray.reviewList
                            .asMap()
                            .entries
                            .map((e) => ServiceReviewLayout(
                                data: e.value,
                                index: e.key,
                                list: appArray.reviewList))
                            .toList()
                      ]).paddingAll(Insets.i20))
                      .paddingOnly(bottom: Insets.i100),
                  Material(
                      elevation: 20,
                      child: BottomSheetButtonCommon(
                              textOne: appFonts.reject,
                              textTwo: appFonts.accept,
                              clearTap: () => value.onRejectBooking(context),
                              applyTap: () => value.onAcceptBooking(context))
                          .paddingAll(Insets.i20)
                          .decorated(color: appColor(context).appTheme.whiteBg))
                ],
              )));
    });
  }
}
