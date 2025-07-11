import '../../../config.dart';
import '../assign_booking_screen/layouts/assign_bill_layout.dart';
import '../pending_booking_screen/layouts/status_detail_layout.dart';

class OngoingBookingScreen extends StatelessWidget {
  const OngoingBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OngoingBookingProvider>(builder: (context, value, child) {
      return StatefulWrapper(
        onInit: () => Future.delayed(
            const Duration(milliseconds: 50), () => value.onReady(context)),
        child: Scaffold(
          appBar: AppBarCommon(
            title: appFonts.ongoingBooking,
            actions: [
              TextButton(
                onPressed: value.isPaymentCompleted
                    ? () => route.pushNamed(context, routeName.completedBooking,
                        arg: value.ongoingBooking?.id)
                    : null,
                child: Text(
                  language(context, appFonts.done).toUpperCase(),
                  style: appCss.dmDenseBold14.textColor(
                    value.isPaymentCompleted
                        ? appColor(context).appTheme.online
                        : appColor(context).appTheme.stroke,
                  ),
                ),
              ).paddingOnly(right: Insets.i10),
            ],
          ),
          body: value.ongoingBooking == null
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SingleChildScrollView(
                        child: Column(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StatusDetailLayout(
                                onChat: () =>
                                    route.pushNamed(context, routeName.chat),
                                data: value.ongoingBooking,
                                onMore: () => route.pushNamed(
                                    context, routeName.servicemanDetail,
                                    arg: false),
                                onTapStatus: () =>
                                    value.showBookingStatus(context)),
                            if (value.amount != null)
                              ServicemenPayableLayout(amount: value.amount),
                            Text(language(context, appFonts.billSummary),
                                    style: appCss.dmDenseMedium14.textColor(
                                        appColor(context).appTheme.darkText))
                                .paddingOnly(
                                    top: Insets.i25, bottom: Insets.i10),
                            value.isServicemen
                                ? PendingApprovalBillSummary()
                                : AssignBillLayout(
                                    booking: value.ongoingBooking,
                                  ),
                            const VSpace(Sizes.s20),
                            // HeadingRowCommon(
                            //         title: appFonts.review,
                            //         onTap: () => route.pushNamed(
                            //             context, routeName.serviceReview))
                            //     .paddingOnly(bottom: Insets.i12),
                            // ...appArray.reviewList
                            //     .asMap()
                            //     .entries
                            //     .map((e) => ServiceReviewLayout(
                            //         data: e.value,
                            //         index: e.key,
                            //         list: appArray.reviewList))
                            //     .toList()
                          ]).padding(
                          horizontal: Insets.i20,
                          top: Insets.i20,
                          bottom: value.isServicemen ? Insets.i20 : Insets.i100)
                    ])),
                    if (!value.isServicemen)
                      Material(
                        elevation: 20,
                        child: Row(children: [
                          Expanded(
                            child: ButtonCommon(
                                onTap: () => value.onCancelBooking(context),
                                title: appFonts.cancel,
                                style: appCss.dmDenseRegular16.textColor(
                                  appColor(context).appTheme.red,
                                ),
                                color: appColor(context).appTheme.trans,
                                borderColor: appColor(context).appTheme.red),
                          ),
                          const HSpace(Sizes.s15),
                          Expanded(
                            child: _buildSecondaryButton(context, value),
                          )
                        ]).paddingAll(Insets.i20).decorated(
                              color: appColor(context).appTheme.whiteBg,
                            ),
                      )
                    else
                      AssignStatusLayout(
                        status: appFonts.status,
                        title: appFonts.serviceInProgress,
                        isGreen: true,
                      )
                  ],
                ),
        ),
      );
    });
  }

  Widget _buildSecondaryButton(
    BuildContext context,
    OngoingBookingProvider value,
  ) {
    if (value.isPaymentPending) {
      return ButtonCommon(
        title: language(context, appFonts.paid),
        onTap: () => value.markPaymentPaid(context),
        color: appColor(context).appTheme.online,
      );
    }

    // Case 3: Payment status is completed (disabled button)
    else if (value.isPaymentCompleted) {
      return ButtonCommon(
        title: language(context, appFonts.payment),
        onTap: null, // Disabled button
        color: appColor(context)
            .appTheme
            .stroke, // Using stroke color as disabled color
      );
    }

    // Default case: Add extra charges
    else {
      return ButtonCommon(
        title: language(context, appFonts.addCharges),
        onTap: () => route.pushNamed(context, routeName.addExtraCharges),
      );
    }
  }
}
