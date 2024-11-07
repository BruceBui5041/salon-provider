import '../../../config.dart';

class PlanDetailsScreen extends StatelessWidget {
  const PlanDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanDetailsProvider>(builder: (context, value, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 50), () => value.onReady(value.isMonthly)),
          child: Scaffold(
              appBar: AppBarCommon(title: appFonts.planDetails),
              body: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MonthlyYearlyLayout(
                              isMonthly: value.isMonthly,
                              onToggle: (val) => value.onToggle(val)),
                          const VSpace(Sizes.s30),
                          CarouselSlider(
                              options: CarouselOptions(
                                autoPlayCurve: Easing.emphasizedAccelerate,
                                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
                                  enlargeCenterPage: true,
                                  height: 620,
                                  viewportFraction: 0.75,
                                  onPageChanged: (index, reason) =>
                                      value.onPageChange(index, reason),
                                  scrollDirection: Axis.horizontal),
                              items: value.planList.asMap().entries.map((i) {
                                return Builder(builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: PlanCardLayout(
                                      onTapSelectPlan: ()=> route.pushNamed(context, routeName.subscriptionPlan),
                                      isYear: value.isMonthly,
                                        data: i.value,
                                        selectIndex: value.selIndex,
                                        index: i.key)
                                  );
                                });
                              }).toList())

                        ]),
                    Text(language(context, appFonts.noteYouCanUpdate),
                        textAlign: TextAlign.center,
                        style: appCss.dmDenseRegular14
                            .textColor(appColor(context).appTheme.darkText))
                        .paddingSymmetric(
                        horizontal: Insets.i28, vertical: Insets.i20)
                        .decorated(color: appColor(context).appTheme.fieldCardBg)
                  ],
                ),
              )));
    });
  }
}
