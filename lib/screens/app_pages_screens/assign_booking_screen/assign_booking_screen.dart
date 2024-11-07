import '../../../config.dart';

class AssignBookingScreen extends StatelessWidget {
  const AssignBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AssignBookingProvider>(builder: (context, value, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 50), () => value.onReady(context)),
          child: Scaffold(
              appBar: AppBarCommon(title: isFreelancer ? appFonts.acceptedBooking : appFonts.assignBooking),
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            StatusDetailLayout(
                                onChat: () => route.pushNamed(context, routeName.chat),
                                data: value.assignBookingModel,
                                onMore: ()=> route.pushNamed(context, routeName.servicemanDetail, arg: false),
                                onTapStatus: () => value.showBookingStatus(context)),
                                if(value.amount != null)
                                  ServicemenPayableLayout(amount: value.amount),
                            Text(language(context, appFonts.billSummary),
                                    style: appCss.dmDenseMedium14
                                        .textColor(appColor(context).appTheme.darkText))
                                .paddingOnly(top: Insets.i25, bottom: Insets.i10),
                              AssignBillLayout(),
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


                          ]).padding(horizontal: Insets.i20,top: Insets.i20,bottom: value.isServicemen != true ? Insets.i100 :Insets.i20)

                        ]
                      )),
                  if(value.isServicemen != true)
                  Material(
                      elevation: 20,
                      child: BottomSheetButtonCommon(
                          textOne: appFonts.cancelService,
                          textTwo: appFonts.startDriving,
                          clearTap: ()=> value.onCancel(context),
                          applyTap: () => value.onStartServicePass(context))
                          .paddingAll(Insets.i20)
                          .decorated(color: appColor(context).appTheme.whiteBg))
                ]
              )));
    });
  }
}
