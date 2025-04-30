import '../../../../config.dart';

class RotationAnimationLayout extends StatelessWidget {
  const RotationAnimationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(builder: (context, splash, child) {
      return Roulette(
          animate: true,
          spins: 1,
          duration: const Duration(seconds: 3),
          child: AnimatedContainer(
            alignment: Alignment.center,

            height: splash.controller!.isCompleted ? Sizes.s100 : splash.size,
            width: splash.controller!.isCompleted ? Sizes.s100 : splash.size,
            duration: const Duration(seconds: 1),
            child: Padding(
              padding: const EdgeInsets.all(Sizes.s20),
              child: Image.asset(eImageAssets.appLogoMeoMeoTransparent),
            ),
            // child: Text("MeoMeo",
            //     style: splash.controller!.isCompleted
            //         ? appCss.righteousSemiBold23
            //             .textColor(appColor(context).appTheme.darkText)
            //         : appCss.dmDenseExtraBold70
            //             .textColor(appColor(context).appTheme.whiteColor)),
          ).decorated(
              color: splash.controller!.isCompleted
                  ? appColor(context).appTheme.whiteColor
                  : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(
                  splash.controller!.isCompleted
                      ? AppRadius.r8
                      : AppRadius.r14))));
    });
  }
}
