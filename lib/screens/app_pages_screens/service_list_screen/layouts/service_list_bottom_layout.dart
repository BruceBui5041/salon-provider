import '../../../../config.dart';

class ServiceListBottomLayout extends StatelessWidget {
  const ServiceListBottomLayout({super.key});

  @override
  Widget build(BuildContext context) {

    final value = Provider.of<ServiceListProvider>(context);

    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (value.categoryList[value.selectedIndex]
              .hasSubCategories!.isNotEmpty)
            const ServiceListTabBarCommon(),
          if (value.categoryList[value.selectedIndex]
              .hasSubCategories!.isNotEmpty)
          const VSpace(Sizes.s15),
          value.categoryList[value.selectedIndex]
              .hasSubCategories!.isNotEmpty ?
          SizedBox(

              height: MediaQuery.of(context).size.height / 0.62,

              child: TabBarView(
                  controller: value.controller,
                  children: <Widget>[
                    Column(children: [
                      ...appArray.popularServiceList
                          .toList()
                          .asMap()
                          .entries
                          .map((e) => FeaturedServicesLayout(
                        onTap: ()=> route.pushNamed(context, routeName.serviceDetails),
                          data: e.value)
                          .paddingSymmetric(
                          horizontal: Insets.i20))
                          .toList(),

                    ]),
                    Column(children: [
                      ...appArray.popularServiceList
                          .toList()
                          .asMap()
                          .entries
                          .map((e) => FeaturedServicesLayout(
                          onTap: ()=> route.pushNamed(context, routeName.serviceDetails),
                          data: e.value)
                          .paddingSymmetric(
                          horizontal: Insets.i20))
                          .toList(),

                    ]),
                    Column(children: [
                      ...appArray.popularServiceList
                          .toList()
                          .asMap()
                          .entries
                          .map((e) => FeaturedServicesLayout(
                          onTap: ()=> route.pushNamed(context, routeName.serviceDetails),
                          data: e.value)
                          .paddingSymmetric(
                          horizontal: Insets.i20))
                          .toList(),

                    ]),
                  ])) : SizedBox(
              height: MediaQuery.of(context).size.height / 0.6,
              child: TabBarView(
                  controller: value.controller,
                  children: <Widget>[
                    Column(children: [
                      ...appArray.popularServiceList
                          .toList()
                          .asMap()
                          .entries
                          .map((e) => FeaturedServicesLayout(
                          onTap: ()=> route.pushNamed(context, routeName.serviceDetails),
                          data: e.value)
                          .paddingSymmetric(
                          horizontal: Insets.i20))
                          .toList(),

                    ]),
                    Column(children: [
                      ...appArray.popularServiceList
                          .toList()
                          .asMap()
                          .entries
                          .map((e) => FeaturedServicesLayout(
                          onTap: ()=> route.pushNamed(context, routeName.serviceDetails),
                          data: e.value)
                          .paddingSymmetric(
                          horizontal: Insets.i20))
                          .toList(),

                    ]),
                    Column(children: [
                      ...appArray.popularServiceList
                          .toList()
                          .asMap()
                          .entries
                          .map((e) => FeaturedServicesLayout(
                          onTap: ()=> route.pushNamed(context, routeName.serviceDetails),
                          data: e.value)
                          .paddingSymmetric(
                          horizontal: Insets.i20))
                          .toList(),

                    ]),
                  ]))
        ]);
  }
}
