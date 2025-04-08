import '../../../config.dart';

class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({super.key});

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceListProvider>(builder: (context1, value, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 100), () => value.onReady(this)),
          child: Scaffold(
              appBar: AppBar(
                  leadingWidth: 80,
                  title: Text(language(context, appFonts.serviceList),
                      style: appCss.dmDenseBold18
                          .textColor(appColor(context).appTheme.darkText)),
                  centerTitle: true,
                  leading: CommonArrow(
                      arrow: rtl(context)
                          ? eSvgAssets.arrowRight
                          : eSvgAssets.arrowLeft,
                      onTap: () => route.pop(context)).paddingAll(Insets.i8),
                  actions: [
                    CommonArrow(
                            arrow: eSvgAssets.search,
                            onTap: () =>
                                route.pushNamed(context, routeName.search))
                        .paddingOnly(right: Insets.i10),
                    CommonArrow(
                            arrow: eSvgAssets.add,
                            onTap: () => route.pushNamed(
                                context, routeName.addNewService))
                        .paddingOnly(right: Insets.i20)
                  ]),
              body: SingleChildScrollView(
                  child: Column(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(language(context, appFonts.categories),
                          style: appCss.dmDenseMedium12
                              .textColor(appColor(context).appTheme.lightText))
                      .paddingSymmetric(horizontal: Insets.i20),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                              children: value.categoryList
                                  .asMap()
                                  .entries
                                  .map((e) => TopCategoriesLayout(
                                      index: e.key,
                                      data: e.value,
                                      selectedIndex: value.selectedIndex,
                                      rPadding: Insets.i20,
                                      onTap: () =>
                                          value.onCategories(e.key, this)))
                                  .toList())
                          .paddingOnly(left: Insets.i20, top: Insets.i15))
                ])
                    .paddingSymmetric(vertical: Insets.i15)
                    .decorated(color: appColor(context).appTheme.fieldCardBg)
                    .paddingOnly(top: Insets.i10, bottom: Insets.i25),
                // if (value.categoryList.isNotEmpty &&
                //     value.categoryList[value.selectedIndex].hasSubCategories !=
                //         null)
                //   const ServiceListBottomLayout()
              ]))));
    });
  }
}
