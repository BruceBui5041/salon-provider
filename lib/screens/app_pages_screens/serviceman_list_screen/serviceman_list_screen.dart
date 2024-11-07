import '../../../config.dart';

class ServicemanListScreen extends StatelessWidget {
  const ServicemanListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ServicemanListProvider>(
      builder: (context,value,child) {
        return Scaffold(
          appBar: AppBar(
              leadingWidth: 80,
              title: Text(language(context, appFonts.servicemanList),
                  style: appCss.dmDenseBold18
                      .textColor(appColor(context).appTheme.darkText)),
              centerTitle: true,
              leading: CommonArrow(
                  arrow:
                      rtl(context) ? eSvgAssets.arrowRight : eSvgAssets.arrowLeft,
                  onTap: () => route.pop(context)).paddingAll(Insets.i8),
              actions: [
                CommonArrow(arrow: eSvgAssets.add, onTap: ()=> route.pushNamed(context, routeName.addServicemen))
                    .paddingSymmetric(horizontal: Insets.i20)
              ]),
          body: SingleChildScrollView(
            child: Column(children: [
              SearchTextFieldCommon(
                controller: value.searchCtrl,
                      focusNode: value.searchFocus).paddingOnly(top: Insets.i15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(
                      flex: 3,
                      child: Text(language(context, appFonts.filterBy),style: appCss.dmDenseRegular14.textColor(appColor(context).appTheme.lightText))),
                  Expanded(
                    flex: 4,
                    child: DarkDropDownLayout(
                      isField: true,
                        isOnlyText: true,
                        hintText: appFonts.allServicemen,
                        val: value.expValue,
                        categoryList: appArray.servicemenExperienceList,
                        onChanged: (val) => value.onExperience(val)),
                  )
                ],)
                  .paddingSymmetric(vertical: Insets.i20),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount:
                  appArray.availableServicemanList.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 220,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  itemBuilder: (context, index) {
                    return AvailableServiceLayout(
                      onTap: ()=> route.pushNamed(context, routeName.servicemanDetail),
                        data: appArray.availableServicemanList[index]);
                  })
            ]).paddingSymmetric(horizontal: Insets.i20)
          )
        );
      }
    );
  }
}
