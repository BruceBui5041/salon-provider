
import '../../../config.dart';

class PendingApprovalBookingScreen extends StatelessWidget {
  const PendingApprovalBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PendingApprovalBookingProvider>(builder: (context, value, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 50), () => value.onReady(context)),
          child: Scaffold(
              appBar: AppBarCommon(title: appFonts.pendingApprovalBooking),
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StatusDetailLayout(
                                onChat: () => route.pushNamed(context, routeName.chat),
                                data: value.pendingApprovalBookingModel,
                                onMore: ()=> route.pushNamed(context, routeName.servicemanDetail, arg: false),
                                onTapStatus: () => value.showBookingStatus(context)),
                            if(isFreelancer != true )
                            const ServicemenPayableLayout(amount: "30.36"),
                            Text(language(context, appFonts.billSummary),
                                style: appCss.dmDenseMedium14
                                    .textColor(appColor(context).appTheme.darkText))
                                .paddingOnly(top: Insets.i25, bottom: Insets.i10),
                            const PendingApprovalBillSummary(),
                            const VSpace(Sizes.s20),
                            HeadingRowCommon(
                                title:  appFonts.review,
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


                          ]).padding(horizontal: Insets.i20,top: Insets.i20,bottom: Insets.i100)),
                  Material(
                      elevation: 20,
                      child: AssignStatusLayout(title: appFonts.theServicemenNotApprove, status: appFonts.status.toUpperCase()))
                ],
              )));
    });
  }
}
