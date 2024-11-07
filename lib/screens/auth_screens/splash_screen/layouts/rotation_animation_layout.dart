import '../../../../config.dart';

class RotationAnimationLayout extends StatelessWidget {
  const RotationAnimationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(
      builder: (context,splash,child) {

        return Roulette(
            animate: true,
            spins: 1,
            duration: const Duration(seconds: 3),
            child: AnimatedContainer(
                alignment: Alignment.center,
                height: splash.controller!.isCompleted
                    ? Sizes.s45
                    : splash.size,
                width: splash.controller!.isCompleted
                    ? Sizes.s45
                    : splash.size,
                duration: const Duration(seconds: 1),
                child: Text("ft",
                    style: splash.controller!.isCompleted
                        ? appCss.righteousSemiBold23.textColor(
                        const Color(0xff00162E))
                        : appCss.dmDenseExtraBold70.textColor(
                        appColor(context)
                            .appTheme
                            .whiteColor)))
                .decorated(
                color: splash.controller!.isCompleted
                    ? appColor(context).appTheme.whiteColor
                    : appColor(context).appTheme.primary,
                borderRadius: BorderRadius.all(Radius.circular(
                    splash.controller!.isCompleted ? AppRadius.r8 : AppRadius.r14))));
      }
    );
  }
}
