import '../../../config.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(builder: (context, value, child) {
      return StatefulWrapper(
        onInit: () => Future.delayed(
            const Duration(milliseconds: 100), () => value.onAnimate(this)),
        child: Scaffold(
          appBar: AppBar(
              leadingWidth: 80,
              title: Text(language(context, appFonts.notification),
                  style: appCss.dmDenseBold18
                      .textColor(appColor(context).appTheme.darkText)),
              centerTitle: true,
              leading:
              CommonArrow(arrow: rtl(context) ? eSvgAssets.arrowRight : eSvgAssets.arrowLeft, onTap: () => route.pop(context))
                  .paddingAll(Insets.i8),
              actions: [
                if(value.isNotification)
                CommonArrow(arrow: eSvgAssets.readAll),
                const HSpace(Sizes.s10),
                if(value.isNotification)
            CommonArrow(onTap: ()=> value.onDeleteNotification(context,this),arrow: eSvgAssets.delete,svgColor: appColor(context).appTheme.red,color: appColor(context).appTheme.red.withOpacity(0.1))
            .paddingOnly(right: rtl(context) ? 0 : Insets.i20,left: rtl(context) ? Insets.i20 : 0)
              ]),
          body: value.isNotification
              ? SingleChildScrollView(
                  child: Column(
                          children: value.notificationList
                              .asMap()
                              .entries
                              .map((e) => NotificationLayout(data: e.value))
                              .toList())
                      .paddingAll(Insets.i20))
              : EmptyLayout(
            isButton: true,
                  title: appFonts.nothingHere,
                  subtitle: appFonts.clickTheRefresh,
                  buttonText: appFonts.refresh,
                  bTap: () => value.onRefresh(),
                  widget: Stack(children: [
                    Image.asset(eImageAssets.notiBoy, height: Sizes.s346),
                    if (value.animationController != null)
                      Positioned(
                          top: MediaQuery.of(context).size.height * 0.04,
                          left: MediaQuery.of(context).size.height * 0.01,
                          child: RotationTransition(
                              turns: Tween(begin: 0.05, end: -.1)
                                  .chain(CurveTween(curve: Curves.elasticInOut))
                                  .animate(value.animationController!),
                              child: Image.asset(eImageAssets.notificationBell,
                                  height: Sizes.s40, width: Sizes.s40)))
                  ]))
        )
      );
    });
  }
}
