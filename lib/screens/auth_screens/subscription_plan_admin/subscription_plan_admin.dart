import '../../../config.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  const SubscriptionPlanScreen({super.key});

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> with SingleTickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this
  )..repeat(reverse: true);
  // defining the Offset of the animation
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.1, 0.0)
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));



  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionPlanProvider>(builder: (context, value, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 50), () => value.onReady()),
          child: Scaffold(
              body: Stack(children: [
            Stack(alignment: Alignment.bottomCenter, children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(alignment: Alignment.topCenter, children: [
                    SizedBox(
                            height: Sizes.s290,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(eImageAssets.planBoy,
                                      height: Sizes.s200, width: Sizes.s300)
                                ]))
                        .decorated(
                            gradient: RadialGradient(colors: [
                      const Color(0xffad96ff).withOpacity(0.6),
                      appColor(context).appTheme.primary
                    ], stops: const [
                      0.06,
                      1
                    ], center: Alignment.center))
                  ])).decorated(color: appColor(context).appTheme.primary),
              SubscriptionPlanLayout(
                  position: _offsetAnimation,
                  data: value.subscriptionPlanModel)
            ]),
            CommonArrow(
                    onTap: ()=> route.pop(context),
                    arrow: eSvgAssets.cross,
                    svgColor: appColor(context).appTheme.whiteColor,
                    color:
                        appColor(context).appTheme.whiteColor.withOpacity(0.3))
                .paddingSymmetric(vertical: Insets.i40, horizontal: Insets.i20)
          ])));
    });
  }
}
