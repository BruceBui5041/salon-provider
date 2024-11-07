import '../../../config.dart';

class PopularServiceScreen extends StatelessWidget {
  const PopularServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<DashboardProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBarCommon(title: appFonts.popularService),
        body: SingleChildScrollView(
            child: Column(children: [
              SearchTextFieldCommon(
                focusNode: value.searchFocus,
                  controller: value.searchCtrl
                  )
                  .padding(bottom: Insets.i20),
          ...appArray.popularServiceList.asMap().entries.map((e) =>
              FeaturedServicesLayout(
                  data: e.value,
                  onTap: () =>
                      route.pushNamed(context, routeName.serviceDetails)))
        ]).paddingSymmetric(horizontal: Insets.i20)));
  }
}
