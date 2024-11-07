import '../../../config.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  AnimationStatus status = AnimationStatus.dismissed;

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    animation = Tween(end: 1.0, begin: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
        controller.repeat();
      })
      ..addStatusListener((status) {
        status = status;
      });
    controller.repeat();
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, value, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(const Duration(milliseconds: 100),
              () => value.onReady(context, this)),
          child: Scaffold(
              appBar: AppBar(
                  leadingWidth: MediaQuery.of(context).size.width,
                  leading: const HomeAppBar()),
              body: SingleChildScrollView(
                  child: Column(children: [
                const VSpace(Sizes.s15),
                    WalletBalanceLayout(onTap: ()=> value.onWithdraw(context)),
                const VSpace(Sizes.s16),
                StaggeredGrid.count(
                        crossAxisCount: 10,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        children: appArray.earningList
                            .asMap()
                            .entries
                            .map((e) => GridViewLayout(
                                data: e.value,
                                index: e.key,
                                animation: animation,
                                onTap: () => value.onTapOption(e.key, context)))
                            .toList())
                    .paddingSymmetric(horizontal: Insets.i20),
                const VSpace(Sizes.s25),
                    const StaticDetailChart(),
                    const AllCategoriesLayout()
              ]).paddingOnly(bottom: Insets.i110))));
    });
  }
}
