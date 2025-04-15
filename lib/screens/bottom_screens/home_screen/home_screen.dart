import 'package:salon_provider/providers/app_pages_provider/all_service_provider.dart';
import 'package:salon_provider/providers/app_pages_provider/home_screen_provider.dart';

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
    initData();
    // TODO: implement initState
    super.initState();
  }

  Future<void> initData() async {
    Provider.of<AllServiceProvider>(context, listen: false).getAllServices();
    // Fetch earnings data
    Provider.of<HomeScreenProvider>(context, listen: false)
        .getProviderEarnings();
  }

  Future<void> _onRefresh() async {
    // Reload data from providers
    await Provider.of<AllServiceProvider>(context, listen: false)
        .getAllServices();
    await Provider.of<HomeScreenProvider>(context, listen: false)
        .getProviderEarnings();
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
            body: RefreshIndicator(
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(children: [
                      const VSpace(Sizes.s15),
                      WalletBalanceLayout(
                          onTap: () => value.onWithdraw(context)),
                      const VSpace(Sizes.s16),
                      Consumer<HomeScreenProvider>(
                          builder: (context, homeScreenProvider, _) {
                        // Generate earning data tiles based on the api response
                        final earningData = homeScreenProvider.earningData;

                        // Define our earnings grid data
                        final List<Map<String, dynamic>> earningGridItems = [
                          {
                            "title": appFonts.totalEarning,
                            "image": eSvgAssets.earning,
                            "price": (earningData?.totalEarnings ?? "0.00")
                                .toCurrencyVnd()
                          },
                          {
                            "title": appFonts.completed,
                            "image": eSvgAssets.booking,
                            "price":
                                earningData?.completedBookings?.toString() ??
                                    "0"
                          },
                          {
                            "title": appFonts.hour,
                            "image": eSvgAssets.box,
                            "price": earningData?.totalHours?.toString() ?? "0"
                          },
                          {
                            "title": appFonts.commission,
                            "image": eSvgAssets.category,
                            "price": (earningData?.totalCommission ?? "0.00")
                                .toCurrencyVnd()
                          },
                        ];

                        return StaggeredGrid.count(
                                crossAxisCount: 10,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                children: earningGridItems
                                    .asMap()
                                    .entries
                                    .map((e) => GridViewLayout(
                                        data: e.value,
                                        index: e.key,
                                        animation: animation,
                                        onTap: () =>
                                            value.onTapOption(e.key, context)))
                                    .toList())
                            .paddingSymmetric(horizontal: Insets.i20);
                      }),
                      // // const VSpace(Sizes.s25),
                      // const StaticDetailChart(),
                      const AllCategoriesLayout(),
                    ]).paddingOnly(bottom: Insets.i110))),
          ));
    });
  }
}
