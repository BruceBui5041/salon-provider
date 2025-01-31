import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:fixit_provider/config.dart';
import 'package:flutter/cupertino.dart';

class DeleteDialogProvider with ChangeNotifier {
  AnimationController? controller;
  Animation<Offset>? offsetAnimation;
  bool isPositionedRight = false;
  bool isAnimateOver = false;

  onDispose() {
    controller!.dispose();
  }

  double height = 6;
  double width = 6;

  onAnimate() {
    height = 6;
    width = 6;
    Future.delayed(Duration(milliseconds: 500), () {
      height = 120;
      width = 120;

      notifyListeners();
      Future.delayed(const Duration(milliseconds: 800), () {
        height = 50;
        width = 50;
        notifyListeners();
      });
    });
    notifyListeners();
  }

  onResetPass(context, subtext, buttonText, onTap, {title}) {
    onAnimate();
    showDialog(
        context: context,
        builder: (context1) {
          return Consumer<DeleteDialogProvider>(
              builder: (context, value, child) {
            return AlertDialogCommon(
                isBooked: true,
                title: title ?? appFonts.deleteSuccessfully,
                widget: Stack(alignment: Alignment.center, children: [
                  SizedBox(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            eGifAssets.success,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ))
                      .paddingSymmetric(vertical: Insets.i8)
                      .decorated(
                          color: appColor(context).appTheme.fieldCardBg,
                          borderRadius: BorderRadius.circular(AppRadius.r10)),
                  AnimatedContainer(
                      height: height,
                      width: width,
                      curve: Curves.easeInToLinear,
                      duration: const Duration(milliseconds: 800),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(eImageAssets.successTick))))
                ]),
                subtext: subtext,
                bText1: buttonText,
                height: Sizes.s145,
                b1OnTap: onTap);
          });
        });
  }

  animateDesign(TickerProvider sync) {
    Future.delayed(DurationsDelay.s1).then((value) {
      isPositionedRight = true;
      notifyListeners();
    }).then((value) {
      Future.delayed(DurationsDelay.s2).then((value) {
        isAnimateOver = true;
        notifyListeners();
      }).then((value) {
        controller = AnimationController(
            vsync: sync, duration: const Duration(seconds: 2))
          ..forward();
        offsetAnimation = Tween<Offset>(
                begin: const Offset(0, 0.5), end: const Offset(0, 1.7))
            .animate(
                CurvedAnimation(parent: controller!, curve: Curves.elasticOut));
        notifyListeners();
      });
    });

    notifyListeners();
  }

  onDeleteDialog(sync, context, image, title, subtitle, onDelete) {
    animateDesign(sync);
    showDialog(
        context: context,
        builder: (context1) {
          return StatefulBuilder(builder: (context2, setState) {
            return Consumer<DeleteDialogProvider>(
                builder: (context3, value, child) {
              return AlertDialog(
                  insetPadding:
                      const EdgeInsets.symmetric(horizontal: Insets.i20),
                  contentPadding: EdgeInsets.zero,
                  shape: const SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius.all(SmoothRadius(
                          cornerRadius: AppRadius.r14, cornerSmoothing: 1))),
                  backgroundColor: appColor(context).appTheme.whiteBg,
                  content: Stack(alignment: Alignment.topRight, children: [
                    Column(mainAxisSize: MainAxisSize.min, children: [
                      // Gif
                      Stack(alignment: Alignment.topCenter, children: [
                        Stack(alignment: Alignment.bottomCenter, children: [
                          SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                            height: Sizes.s180,
                                            width: Sizes.s150,
                                            child: AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                curve: isPositionedRight
                                                    ? Curves.bounceIn
                                                    : Curves.bounceOut,
                                                alignment: isPositionedRight
                                                    ? isAnimateOver
                                                        ? Alignment.center
                                                        : Alignment.topCenter
                                                    : Alignment.centerLeft,
                                                child: AnimatedContainer(
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    height: isPositionedRight
                                                        ? 39
                                                        : 13,
                                                    child:
                                                        Image.asset(image)))),
                                        Image.asset(eImageAssets.dustbin,
                                            height: Sizes.s88, width: Sizes.s88)
                                      ]))
                              .paddingOnly(top: 50)
                              .decorated(
                                  color: appColor(context).appTheme.fieldCardBg,
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.r10)),
                        ]),
                        if (offsetAnimation != null)
                          SlideTransition(
                              position: offsetAnimation!,
                              child: (offsetAnimation != null &&
                                      isAnimateOver == true)
                                  ? Image.asset(eImageAssets.dustbinCover,
                                      height: 38)
                                  : const SizedBox())
                      ]),
                      // Sub text
                      const VSpace(Sizes.s15),
                      Text(language(context, subtitle),
                          textAlign: TextAlign.center,
                          style: appCss.dmDenseRegular14
                              .textColor(appColor(context).appTheme.lightText)
                              .textHeight(1.3)),
                      const VSpace(Sizes.s20),
                      Row(children: [
                        Expanded(
                            child: ButtonCommon(
                                onTap: () => route.pop(context),
                                title: appFonts.no,
                                borderColor: appColor(context).appTheme.primary,
                                color: appColor(context).appTheme.whiteBg,
                                style: appCss.dmDenseSemiBold16.textColor(
                                    appColor(context).appTheme.primary))),
                        const HSpace(Sizes.s15),
                        Expanded(
                            child: ButtonCommon(
                                onTap: onDelete, title: appFonts.yes))
                      ])
                    ]).padding(
                        horizontal: Insets.i20,
                        top: Insets.i60,
                        bottom: Insets.i20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Title
                          Text(language(context, title!),
                              overflow: TextOverflow.ellipsis,
                              style: appCss.dmDenseMedium18.textColor(
                                  appColor(context).appTheme.darkText)),
                          Icon(CupertinoIcons.multiply,
                                  size: Sizes.s20,
                                  color: appColor(context).appTheme.darkText)
                              .inkWell(onTap: () => route.pop(context))
                        ]).paddingAll(Insets.i20)
                  ]));
            });
          });
        }).then((value) {
      isPositionedRight = false;
      isAnimateOver = false;
      notifyListeners();
    });
  }

  onDeleteAccount(TickerProvider sync, context) {
    animateDesign(sync);
    showDialog(
        context: context,
        builder: (context1) {
          return StatefulBuilder(builder: (context2, setState) {
            return Consumer<DeleteDialogProvider>(
                builder: (context3, value, child) {
              return AlertDialog(
                  insetPadding:
                      const EdgeInsets.symmetric(horizontal: Insets.i20),
                  contentPadding: EdgeInsets.zero,
                  shape: const SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius.all(SmoothRadius(
                          cornerRadius: AppRadius.r14, cornerSmoothing: 1))),
                  backgroundColor: appColor(context).appTheme.whiteBg,
                  content: Stack(alignment: Alignment.topRight, children: [
                    Column(mainAxisSize: MainAxisSize.min, children: [
                      // Gif
                      Stack(alignment: Alignment.topCenter, children: [
                        Stack(alignment: Alignment.bottomCenter, children: [
                          SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                            height: Sizes.s180,
                                            width: Sizes.s150,
                                            child: AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                curve: isPositionedRight
                                                    ? Curves.bounceIn
                                                    : Curves.bounceOut,
                                                alignment: isPositionedRight
                                                    ? isAnimateOver
                                                        ? Alignment.center
                                                        : Alignment.topCenter
                                                    : Alignment.centerLeft,
                                                child: AnimatedContainer(
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    height: isPositionedRight
                                                        ? 88
                                                        : 13,
                                                    child: Image.asset(
                                                        eImageAssets
                                                            .accountDel)))),
                                        Image.asset(eImageAssets.dustbin,
                                            height: Sizes.s88, width: Sizes.s88)
                                      ]))
                              .paddingOnly(top: 50)
                              .decorated(
                                  color: appColor(context).appTheme.fieldCardBg,
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.r10)),
                        ]),
                        if (offsetAnimation != null)
                          SlideTransition(
                              position: offsetAnimation!,
                              child: (offsetAnimation != null &&
                                      isAnimateOver == true)
                                  ? Image.asset(eImageAssets.dustbinCover,
                                      height: 38)
                                  : const SizedBox())
                      ]),
                      // Sub text
                      const VSpace(Sizes.s15),
                      Text(language(context, appFonts.yourAccountWill),
                          textAlign: TextAlign.center,
                          style: appCss.dmDenseRegular14
                              .textColor(appColor(context).appTheme.lightText)
                              .textHeight(1.2)),
                      const VSpace(Sizes.s20),
                      Row(children: [
                        Expanded(
                            child: ButtonCommon(
                                onTap: () => route.pop(context),
                                title: appFonts.cancel,
                                borderColor: appColor(context).appTheme.red,
                                color: appColor(context).appTheme.whiteBg,
                                style: appCss.dmDenseSemiBold16.textColor(
                                    appColor(context).appTheme.red))),
                        const HSpace(Sizes.s15),
                        Expanded(
                            child: ButtonCommon(
                                color: appColor(context).appTheme.red,
                                onTap: () => route.pop(context),
                                title: appFonts.delete))
                      ])
                    ]).padding(
                        horizontal: Insets.i20,
                        top: Insets.i60,
                        bottom: Insets.i20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Title
                          Text(language(context, appFonts.deleteAccount),
                              style: appCss.dmDenseExtraBold18.textColor(
                                  appColor(context).appTheme.darkText)),
                          Icon(CupertinoIcons.multiply,
                                  size: Sizes.s20,
                                  color: appColor(context).appTheme.darkText)
                              .inkWell(onTap: () => route.pop(context))
                        ]).paddingAll(Insets.i20)
                  ]));
            });
          });
        }).then((value) {
      isPositionedRight = false;
      isAnimateOver = false;
      notifyListeners();
    });
  }
}
