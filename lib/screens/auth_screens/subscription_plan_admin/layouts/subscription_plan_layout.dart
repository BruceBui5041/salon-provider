import '../../../../config.dart';

class SubscriptionPlanLayout extends StatelessWidget {
  final SubscriptionPlanModel? data;
  final Animation<Offset> position;
  const SubscriptionPlanLayout({super.key, this.data, required this.position});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Sizes.s525,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(eImageAssets.subPlanBg), fit: BoxFit.fill)),
        child: SingleChildScrollView(
            child: data != null
                ? Column(children: [
                    Text(language(context, data!.title).toUpperCase(),
                        textAlign: TextAlign.center,
                        style: appCss.dmDenseSemiBold20
                            .textColor(appColor(context).appTheme.whiteColor)),
                    const VSpace(Sizes.s8),
                    Text(language(context, data!.subtext),
                        textAlign: TextAlign.center,
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.whiteColor)),
                    const VSpace(Sizes.s20),
                    ...data!.benefits!.map((e) => PlanRowCommon(
                        title: e, index: null, selectIndex: null)),
                    Stack(alignment: Alignment.bottomCenter, children: [
                      Image.asset(eImageAssets.cup),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Column(children: [
                          Text(language(context, appFonts.unlockYourFull),
                              style: appCss.dmDenseBold14.textColor(
                                  appColor(context).appTheme.darkText)),
                          Text(language(context, appFonts.stayAhead),
                              style: appCss.dmDenseRegular11.textColor(
                                  appColor(context).appTheme.darkText))
                        ]),
                        SizedBox(
                          height: Sizes.s30,
                          width: Sizes.s30,
                          child: SlideTransition(
                            position: position,
                            child: SvgPicture.asset(
                              eSvgAssets.arrowRightYellow,
                              fit: BoxFit.scaleDown,
                              colorFilter: const ColorFilter.mode(
                                  Color(0xffFFC412), BlendMode.srcIn),
                            ),
                          ),
                        )
                            .decorated(
                                shape: BoxShape.circle,
                                color: appColor(context).appTheme.whiteColor)
                            .inkWell(onTap: () {})
                            .paddingSymmetric(horizontal: Insets.i15)
                      ]).paddingOnly(bottom: Insets.i10)
                    ]),
                    const VSpace(Sizes.s15),
                    ButtonCommon(
                            onTap: () => route.pushNamedAndRemoveUntil(
                                context, routeName.loginProvider),
                            title: appFonts.startYourFreeTrial,
                            color: appColor(context).appTheme.red)
                        .paddingOnly(bottom: Insets.i10)
                  ]).padding(top: Insets.i60, horizontal: Insets.i25)
                : Container()));
  }
}
