import 'dart:io';

import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:salon_provider/common/booking_status.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/screens/app_pages_screens/completed_booking_screen/layouts/completed_bill_summary.dart';
import 'package:salon_provider/screens/app_pages_screens/completed_booking_screen/layouts/completed_payment_summary.dart';
import 'package:salon_provider/screens/app_pages_screens/pending_booking_screen/layouts/status_detail_layout.dart';

class CompletedBookingScreen extends StatelessWidget {
  const CompletedBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CompletedBookingProvider, AddServiceProofProvider>(
        builder: (context, value, serviceProofVal, child) {
      return StatefulWrapper(
          onInit: () => value.onReady(context),
          child: Scaffold(
              appBar: AppBarCommon(title: appFonts.completedBookings),
              body: value.completedBookingModel == null
                  ? Center(
                      child: CircularProgressIndicator(
                          color: appColor(context).appTheme.primary))
                  : Stack(alignment: Alignment.bottomCenter, children: [
                      SingleChildScrollView(
                          child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                            StatusDetailLayout(
                                onChat: () =>
                                    route.pushNamed(context, routeName.chat),
                                data: value.completedBookingModel,
                                onMore: () => route.pushNamed(
                                    context, routeName.servicemanDetail,
                                    arg: false),
                                onTapStatus: () =>
                                    value.showBookingStatus(context)),
                            Text(language(context, appFonts.billSummary),
                                    style: appCss.dmDenseMedium14.textColor(
                                        appColor(context).appTheme.darkText))
                                .paddingOnly(
                                    top: Insets.i25, bottom: Insets.i10),
                            CompletedBillSummary(
                                booking: value.completedBookingModel),
                            const VSpace(Sizes.s20),
                            Text(language(context, appFonts.paymentSummary),
                                style: appCss.dmDenseMedium14.textColor(
                                    appColor(context).appTheme.darkText)),
                            const VSpace(Sizes.s10),
                            CompletedPaymentSummary(
                                booking: value.completedBookingModel),
                            const VSpace(Sizes.s20),
                            if (serviceProofVal.proofList.isNotEmpty)
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: Sizes.s200,
                                        child: Text(
                                            language(
                                                context, appFonts.serviceProof),
                                            overflow: TextOverflow.ellipsis,
                                            style: appCss.dmDenseBold18
                                                .textColor(appColor(context)
                                                    .appTheme
                                                    .darkText))),
                                    Text(language(context, appFonts.editProof),
                                            style: appCss.dmDenseRegular14
                                                .textColor(appColor(context)
                                                    .appTheme
                                                    .primary))
                                        .inkWell(
                                            onTap: () => route.pushNamed(
                                                context,
                                                routeName.addServiceProof))
                                  ]),
                            if (serviceProofVal.proofList.isNotEmpty)
                              SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                              children: serviceProofVal
                                                  .proofList
                                                  .asMap()
                                                  .entries
                                                  .map((e) => Container(
                                                          height: Sizes.s70,
                                                          width: Sizes.s70,
                                                          decoration: ShapeDecoration(
                                                              image: DecorationImage(
                                                                  image: FileImage(
                                                                      File(e.value)),
                                                                  fit: BoxFit.cover),
                                                              shape: RoundedRectangleBorder(borderRadius: SmoothBorderRadius(cornerRadius: AppRadius.r8, cornerSmoothing: 1))))
                                                      .paddingOnly(right: e.key != serviceProofVal.proofList.length - 1 ? Insets.i10 : 0))
                                                  .toList())
                                          .paddingAll(Insets.i15)
                                          .boxBorderExtension(context, bColor: appColor(context).appTheme.stroke))
                                  .paddingOnly(top: Insets.i10, bottom: Insets.i20),
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
                          ])
                              .paddingAll(Insets.i20)
                              .paddingOnly(bottom: Insets.i100)),
                      Material(
                          elevation: 20,
                          child: Row(children: [
                            if (value.completedBookingModel?.bookingStatus !=
                                BookingStatus.completed)
                              Expanded(
                                child: ButtonCommon(
                                  onTap: () => value.onCompleteBooking(context),
                                  title: appFonts.complete,
                                  color: appColor(context).appTheme.green,
                                ),
                              ),
                            if (value.completedBookingModel?.bookingStatus !=
                                BookingStatus.completed)
                              const HSpace(Sizes.s15),
                            Expanded(
                              child: ButtonCommon(
                                onTap: () => route.pushNamed(
                                    context, routeName.addServiceProof),
                                title: appFonts.addServiceProof,
                                style: appCss.dmDenseRegular16.textColor(
                                    appColor(context).appTheme.primary),
                                color: appColor(context).appTheme.trans,
                                borderColor: appColor(context).appTheme.primary,
                              ),
                            ),
                          ]).paddingAll(Insets.i20).decorated(
                                color: appColor(context).appTheme.whiteBg,
                              ))
                    ])));
    });
  }
}
