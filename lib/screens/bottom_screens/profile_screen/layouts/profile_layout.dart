import '../../../../config.dart';

class ProfileLayout extends StatelessWidget {
  final GestureTapCallback? onTap;

  const ProfileLayout({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (contextTheme, theme, child) {
      return Stack(alignment: Alignment.topRight, children: [
        SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  const ProfilePicCommon(imageUrl: null, isProfile: true),
                  const VSpace(Sizes.s5),
                  Text(language(context, "Zain Dorwart"),
                      style: appCss.dmDenseSemiBold14
                          .textColor(appColor(context).appTheme.darkText)),
                  const VSpace(Sizes.s3),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SvgPicture.asset(eSvgAssets.email),
                    const HSpace(Sizes.s5),
                    Text(language(context, "zaindorwart12@gmail.com"),
                        style: appCss.dmDenseMedium12
                            .textColor(appColor(context).appTheme.lightText))
                  ]),
                ]).paddingSymmetric(
                    vertical: Insets.i15, horizontal: Insets.i13))
            .boxShapeExtension(
                color: appColor(contextTheme).appTheme.fieldCardBg,
                radius: AppRadius.r12),
        SvgPicture.asset(eSvgAssets.edit)
            .paddingAll(Insets.i15)
            .inkWell(onTap: onTap)
      ]);
    });
  }
}
