import '../../../../config.dart';

class WalletBalanceLayout extends StatelessWidget {
  final GestureTapCallback? onTap;
  const WalletBalanceLayout({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: Sizes.s72,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(eImageAssets.roundBg),fit: BoxFit.cover)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                SvgPicture.asset(eSvgAssets.walletFill)
                    .paddingAll(Insets.i8)
                    .decorated(
                    color: appColor(context)
                        .appTheme
                        .whiteColor,
                    shape: BoxShape.circle),
                const HSpace(Sizes.s10),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                          language(context, appFonts.walletBal),
                          style: appCss.dmDenseMedium15
                              .textColor(appColor(context)
                              .appTheme
                              .stroke)),
                      Text("\$2,562.23",
                          style: appCss.dmDenseBold20.textColor(
                              appColor(context)
                                  .appTheme
                                  .whiteColor))
                    ])
              ]),
              Text(language(context, appFonts.withdraw),
                  style: appCss.dmDenseBold14.textColor(
                      appColor(context).appTheme.primary))
                  .paddingSymmetric(
                  vertical: Insets.i11,
                  horizontal: Insets.i20)
                  .boxShapeExtension(
                  color:
                  appColor(context).appTheme.whiteColor).inkWell(onTap: onTap)
            ]).paddingSymmetric(horizontal: Insets.i12))
        .paddingSymmetric(horizontal: Insets.i20);
  }
}
