import '../../../../config.dart';

  class ProfileSettingTopLayout extends StatelessWidget {
  const ProfileSettingTopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context,value,child) {
        return Stack(alignment: Alignment.bottomCenter, children: [
          Column(children: [
            ProfileLayout(onTap: ()=> route.pushNamed(context, routeName.profileDetails)),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(eSvgAssets.pLine),
                  SvgPicture.asset(eSvgAssets.pLine)
                ]).paddingSymmetric(horizontal: Insets.i40)
          ]).paddingOnly(bottom: Insets.i63),
          Container(
              height: Sizes.s66,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image:
                      AssetImage(eImageAssets.balanceContainer))),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(language(context, appFonts.typeOfProvider),
                          style: appCss.dmDenseRegular12.textColor(
                              appColor(context).appTheme.whiteBg)),
                      Text(language(context, isFreelancer ? appFonts.freelancer : appFonts.company),
                          style: appCss.dmDenseMedium12.textColor(
                              appColor(context).appTheme.whiteBg))
                    ]),
                const VSpace(Sizes.s4),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(language(context, isFreelancer ? appFonts.noOfCompletedService : appFonts.noOfServicemen),
                          style: appCss.dmDenseRegular12.textColor(
                              appColor(context).appTheme.whiteBg)),
                      Text("20",
                          style: appCss.dmDenseMedium12.textColor(
                              appColor(context).appTheme.whiteBg))
                    ])
              ]).paddingSymmetric(
                  vertical: Insets.i12, horizontal: Insets.i15))
        ]);
      }
    );
  }
}
