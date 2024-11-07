import '../../../../config.dart';

class ServiceListTabBarCommon extends StatelessWidget {
  const ServiceListTabBarCommon({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<ServiceListProvider>(context);
    return DecoratedTabBar(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: appColor(context).appTheme.stroke, width: 3.0))),
        tabBar: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            indicator:
                CustomTabIndicator(color: appColor(context).appTheme.primary),
            onTap: (val) => value.onTapTab(val),
            indicatorPadding: const EdgeInsets.symmetric(
                horizontal: Insets.i20, vertical: 0.5),
            controller: value.controller,
            tabs: [
              ...value.categoryList[value.selectedIndex].hasSubCategories!
                  .asMap()
                  .entries
                  .map((e) => Text(e.value.title!,
                          style: appCss.dmDenseMedium14.textColor(
                              value.controller!.index == e.key
                                  ? appColor(context).appTheme.primary
                                  : appColor(context).appTheme.lightText),
                          textAlign: TextAlign.center)
                      .paddingOnly(bottom: Insets.i10))
                  .toList()
            ]));
  }
}
