import '../../../../config.dart';

class HomeAppBar extends StatelessWidget {
  final String? location;
  final GestureTapCallback? onTap;

  const HomeAppBar({super.key, this.location, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        const HSpace(Sizes.s20),
         Image.asset(eImageAssets.homeIcon,height: Sizes.s40,width: Sizes.s40),
        const HSpace(Sizes.s10),
        Text(language(context, appFonts.helloThere),style: appCss.dmDenseBold14.textColor(appColor(context).appTheme.darkText))
      ]),
      Row(children: [
        CommonArrow(arrow: eSvgAssets.chat)
            .inkWell(onTap: ()=> route.pushNamed(context, routeName.chatHistory)),
        const HSpace(Sizes.s10),
        Container(
                alignment: Alignment.center,
                height: Sizes.s40,
                width: Sizes.s40,
                child: Stack(alignment: Alignment.topRight, children: [
                  SvgPicture.asset(eSvgAssets.notification,
                      alignment: Alignment.center,
                      fit: BoxFit.scaleDown,
                      colorFilter: ColorFilter.mode(
                          appColor(context).appTheme.darkText,
                          BlendMode.srcIn)),
                  Positioned(
                      top: 2,
                      right: 2,
                      child: Icon(Icons.circle,
                          size: Sizes.s7,
                          color: appColor(context).appTheme.red))
                ]))
            .decorated(
                shape: BoxShape.circle,
                color: appColor(context).appTheme.fieldCardBg)
            .inkWell(
                onTap: ()=> route.pushNamed(context, routeName.notification))
            .paddingOnly(right: rtl(context) ? 0 : Insets.i20 , left:  rtl(context) ? Insets.i20 : 0)
      ])
    ]);
  }
}
