import 'dart:async';
import '../../../config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    final SplashProvider splash =
        Provider.of<SplashProvider>(context, listen: false);
    splash.onReady(this, context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(builder: (context, splash, child) {
      return StatefulWrapper(
        onInit: () => Timer(
            const Duration(milliseconds: 200), () => splash.onChangeSize()),
        onDispose: () => splash.onDispose(),
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Stack(alignment: Alignment.center, children: [
                  if (splash.animation2 != null)
                    CircularRevealAnimation(
                        animation: splash.animation2!,
                        centerAlignment: Alignment.center,
                        minRadius: 12,
                        maxRadius: 600,
                        child: Container(
                            color: splash.animation2!.isCompleted
                                ? appColor(context).appTheme.bluePrimary
                                : appColor(context).appTheme.whiteBg,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Opacity(
                                opacity: 0.15,
                                child: Image.asset(eImageAssets.splashBg,
                                    fit: BoxFit.cover)))),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (splash.controller != null)
                          const RotationAnimationLayout(),
                        const VSpace(Sizes.s15),
                        if (splash.controller != null)
                          if (splash.controller!.isCompleted)
                            SlideTransition(
                              position: Tween<Offset>(
                                      begin: const Offset(0, 2),
                                      end: const Offset(0, -0.1))
                                  .animate(splash.popUpAnimationController!),
                              child: SizedBox(
                                  // height: Sizes.s100,
                                  width: Sizes.s200,
                                  child: Image.asset(
                                      eImageAssets.appTextMeoMeoTransparent)),
                            )
                      ]),
                ])
              ],
            ),
          ),
        ),
      );
    });
  }
}
