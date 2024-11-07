import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import '../../../config.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DashboardProvider, ThemeService>(
        builder: (contextTheme, value, theme, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 100), () => value.onReady()),
          child: PopScope(
            canPop: false,
            child: Scaffold(
                floatingActionButton: SizedBox(
                        height: Sizes.s50,
                        width: Sizes.s50,
                        child: SvgPicture.asset(eSvgAssets.add,colorFilter: ColorFilter.mode(appColor(context).appTheme.whiteColor, BlendMode.srcIn)).paddingAll(Insets.i10))
                    .decorated(
                        color: appColor(context).appTheme.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(AppRadius.r30))).inkWell(onTap: ()=> value.onAdd(context)),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                extendBody: true,
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: AnimatedBottomNavigationBar.builder(
                    elevation: 18,
                    activeIndex: value.selectIndex,
                    gapLocation: GapLocation.center,
                    shadow: BoxShadow(
                        color: appColor(context)
                            .appTheme
                            .darkText
                            .withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 20),
                    notchSmoothness: NotchSmoothness.softEdge,
                    leftCornerRadius: AppRadius.r18,
                    rightCornerRadius: AppRadius.r18,
                    height: Sizes.s76,
                    backgroundColor: appColor(context).appTheme.whiteBg,
                    onTap: (index) => value.onTap(index),
                    itemCount: appArray.dashboardList.length,
                    tabBuilder: (int index, bool isActive) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            appColor(context).isDarkMode
                                ? SvgPicture.asset(
                                    value.selectIndex == index
                                        ? appArray.dashboardList[index]
                                            ["icon2"]!
                                        : appArray.dashboardList[index]
                                            ["icon"]!,
                                    height: Sizes.s24,
                                    width: Sizes.s24,
                                    colorFilter: ColorFilter.mode(
                                        (appColor(context).isDarkMode &&
                                                value.selectIndex == index)
                                            ? appColor(context).appTheme.primary
                                            : appColor(context)
                                                .appTheme
                                                .darkText,
                                        BlendMode.srcIn),
                                    fit: BoxFit.scaleDown)
                                : SvgPicture.asset(
                                    value.selectIndex == index
                                        ? appArray.dashboardList[index]
                                            ["icon2"]!
                                        : appArray.dashboardList[index]
                                            ["icon"]!,
                                    height: Sizes.s24,
                                    width: Sizes.s24,
                                    fit: BoxFit.scaleDown),
                            const VSpace(Sizes.s5),
                            Text(
                                language(context,
                                    appArray.dashboardList[index]["title"]!),
                                overflow: TextOverflow.ellipsis,
                                style: value.selectIndex == index
                                    ? appCss.dmDenseMedium14.textColor(
                                        appColor(context).appTheme.primary)
                                    : appCss.dmDenseRegular14.textColor(
                                        appColor(context).appTheme.darkText))
                          ]);
                    }),
                body: Consumer<ThemeService>(builder: (context, theme, child) {
                  return Center(child: value.pages[value.selectIndex]);
                })),
          ));
    });
  }
}
