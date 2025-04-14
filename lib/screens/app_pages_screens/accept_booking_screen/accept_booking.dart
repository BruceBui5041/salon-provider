import '../../../config.dart';

class AcceptBookingScreen extends StatelessWidget {
  const AcceptBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AcceptedBookingProvider, AssignBookingProvider>(
        builder: (context, value, assignValue, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 50), () => value.onReady(context)),
          child: Scaffold(
              appBar: AppBarCommon(title: appFonts.acceptedBooking),
              body: Stack(alignment: Alignment.bottomCenter, children: [
                SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      StatusDetailLayoutOld(
                          onMore: () => route.pushNamed(
                              context, routeName.servicemanDetail, arg: false),
                          onChat: () =>
                              route.pushNamed(context, routeName.chat),
                          data: value.acceptedBookingModel,
                          onTapStatus: () => value.showBookingStatus(context)),
                      if (isFreelancer != true && value.amount != "0")
                        ServicemenPayableLayout(amount: value.amount),
                      Text(language(context, appFonts.billSummary),
                              style: appCss.dmDenseMedium14.textColor(
                                  appColor(context).appTheme.darkText))
                          .paddingOnly(top: Insets.i25, bottom: Insets.i10),
                      const AcceptBillSummary(),
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
                          .toList(),
                    ]).padding(
                        horizontal: Insets.i20,
                        top: Insets.i20,
                        bottom: Insets.i100)),
                if (value.isAssign != true)
                  Material(
                      elevation: 20,
                      child: isFreelancer
                          ? BottomSheetButtonCommon(
                                  textOne: appFonts.cancelService,
                                  textTwo: appFonts.startService,
                                  clearTap: () => assignValue.onCancel(context),
                                  applyTap: () =>
                                      assignValue.onStartServicePass(context))
                              .paddingAll(Insets.i20)
                          : ButtonCommon(
                                  title: appFonts.assignNow,
                                  onTap: () => value.onAssignTap(context))
                              .paddingAll(Insets.i20))
              ])));
    });
  }
}
