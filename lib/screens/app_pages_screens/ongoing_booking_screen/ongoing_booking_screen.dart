import 'dart:developer';

import '../../../config.dart';

class OngoingBookingScreen extends StatelessWidget {
  const OngoingBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<OngoingBookingProvider, AddExtraChargesProvider>(
        builder: (context, value, addValue, child) {
      log("Service cxharge ${addValue.chargeTitleCtrl.text}");
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 50), () => value.onReady(context)),
          child: Scaffold(
              appBar: AppBarCommon(title: appFonts.ongoingBooking),
              body: Stack(alignment: Alignment.bottomCenter, children: [
                SingleChildScrollView(
                    child: Column(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StatusDetailLayoutOld(
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
                            .paddingOnly(top: Insets.i25, bottom: Insets.i10),
                        value.isServicemen
                            ? PendingApprovalBillSummary()
                            : const OngoingBillSummary(),
                        const VSpace(Sizes.s20),
                        if (addValue.chargeTitleCtrl.text != "" &&
                            addValue.perServiceAmountCtrl.text != "")
                          Text(language(context, appFonts.addServiceDetails),
                              style: appCss.dmDenseMedium14.textColor(
                                  appColor(context).appTheme.darkText)),
                        if (addValue.chargeTitleCtrl.text != "" &&
                            addValue.perServiceAmountCtrl.text != "")
                          const VSpace(Sizes.s10),
                        if (addValue.chargeTitleCtrl.text != "" &&
                            addValue.perServiceAmountCtrl.text != "")
                          const AddServiceLayout(),
                        if (addValue.chargeTitleCtrl.text != "" &&
                            addValue.perServiceAmountCtrl.text != "")
                          const VSpace(Sizes.s25),
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
                      ]).paddingAll(Insets.i20),
                ]).paddingOnly(bottom: Insets.i100)),
                Material(
                    elevation: 20,
                    child: value.isServicemen
                        ? AssignStatusLayout(
                            status: appFonts.status,
                            title: appFonts.serviceInProgress,
                            isGreen: true)
                        : Row(children: [
                            Expanded(
                                child: ButtonCommon(
                                    onTap: () => route.pushNamed(
                                        context, routeName.completedBooking),
                                    title: appFonts.complete,
                                    color: appColor(context).appTheme.green)),
                            const HSpace(Sizes.s15),
                            Expanded(
                                child: ButtonCommon(
                                    title: appFonts.addCharges,
                                    onTap: () => route.pushNamed(
                                        context, routeName.addExtraCharges)))
                          ]).paddingAll(Insets.i20).decorated(
                            color: appColor(context).appTheme.whiteBg))
              ])));
    });
  }
}
