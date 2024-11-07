import '../../../config.dart';

class ServiceReviewScreen extends StatelessWidget {
  const ServiceReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceReviewProvider>(builder: (context, value, child) {
      return StatefulWrapper(
        onInit: ()=> Future.delayed(const Duration(milliseconds: 20),() => value.onReady(context)),
        child: PopScope(
          canPop: true,
          onPopInvoked: (bool? popInvoke)=> value.onBackButton(),
          child: Scaffold(
              appBar: AppBarCommon(title: appFonts.review,onTap: ()=> value.onBack(context)),
              body: SingleChildScrollView(
                  child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const RatingLayout(),
                  Row(children: [
                    Text(language(context, appFonts.averageRate),
                        style: appCss.dmDenseMedium12
                            .textColor(appColor(context).appTheme.primary)),
                    const HSpace(Sizes.s4),
                    Text("4.5/5",
                        style: appCss.dmDenseSemiBold12
                            .textColor(appColor(context).appTheme.primary))
                  ])
                ])
                    .paddingSymmetric(vertical: Insets.i12, horizontal: Insets.i15)
                    .decorated(
                        color: appColor(context).appTheme.primary.withOpacity(0.1),
                        border:
                            Border.all(color: appColor(context).appTheme.primary),
                        borderRadius: BorderRadius.circular(AppRadius.r20))
                    .paddingSymmetric(horizontal: Insets.i40),
                const VSpace(Sizes.s15),
                Column(
                        children: appArray.reviewRating
                            .asMap()
                            .entries
                            .map((e) => ProgressBarLayout(
                                data: e.value,
                                index: e.key,
                                list: appArray.reviewRating))
                            .toList())
                    .paddingSymmetric(vertical: Insets.i15, horizontal: Insets.i20)
                    .boxBorderExtension(context, isShadow: true),
                const VSpace(Sizes.s25),
                Row(children: [
                  Expanded(
                      flex: 4,
                      child: Text(language(context, appFonts.review),
                          style: appCss.dmDenseMedium16
                              .textColor(appColor(context).appTheme.darkText))),
                  Expanded(
                      flex: 3,
                      child: DarkDropDownLayout(
                        isOnlyText: true,
                          isField: true,
                          isIcon: false,
                          hintText: appFonts.all,
                          val: value.exValue,
                          categoryList: appArray.reviewLowHighList,
                          onChanged: (val) => value.onReview(val)))
                ]),
                const VSpace(Sizes.s15),
                ...appArray.reviewList
                    .asMap()
                    .entries
                    .map((e) => ServiceReviewLayout(
                  isSetting: value.isSetting,
                        onTap: ()=> route.pushNamed(context, routeName.serviceDetails),
                        data: e.value, index: e.key, list: appArray.reviewList))
                    .toList()
              ]).padding(horizontal: Insets.i20,bottom: Insets.i20))),
        ),
      );
    });
  }
}
