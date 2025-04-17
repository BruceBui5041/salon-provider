import 'dart:developer';

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
                onPressed: () => route.pushNamed(
                    context, routeName.completedBooking,
                    arg: value.ongoingBookingModel?.id),
                child: Text(
                  language(context, appFonts.paid).toUpperCase(),
                  style: appCss.dmDenseBold16
                      .textColor(appColor(context).appTheme.online),
                ),
              ).paddingOnly(right: Insets.i10),
            ],
          ),
          body: value.ongoingBookingModel == null
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
                                data: value.ongoingBookingModel,
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
                                    booking: value.ongoingBookingModel,
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
                                  color: appColor(context).appTheme.red)),
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
      BuildContext context, OngoingBookingProvider value) {
    // Case 1: Payment method is transfer and status is pending
    if (value.isTransferPayment && value.isPaymentPending) {
      // Check if payment QR exists
      if (value.hasPaymentQr) {
        return ButtonCommon(
          title: language(context, appFonts.showQr),
          onTap: () => value.navigateToPaymentQr(context),
        );
      } else {
        return ButtonCommon(
          title: language(context, appFonts.generateQr),
          onTap: () => value.navigateToPaymentQr(context),
        );
      }
    }

    // Case 2: Payment method is cash and status is pending
    else if (value.isCashPayment && value.isPaymentPending) {
      return ButtonCommon(
        title: language(context, appFonts.payment),
        onTap: () => value.markPaymentCompleted(context),
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
