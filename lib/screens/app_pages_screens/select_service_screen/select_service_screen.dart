import '../../../config.dart';

class SelectServiceScreen extends StatelessWidget {
  const SelectServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectServiceProvider>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBarCommon(title: appFonts.selectServiceOnly),
          body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(language(context, appFonts.selectedService),
                        style: appCss.dmDenseRegular14
                            .textColor(appColor(context).appTheme.lightText))
                    .paddingSymmetric(horizontal: Insets.i20),
                const VSpace(Sizes.s15),
                value.selectServiceList.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: value.selectServiceList
                                      .asMap()
                                      .entries
                                      .map((e) => SelectServiceLayout(
                                          onTapCross: () => value.onImageRemove(
                                              e.value["id"], e.key, e.value),
                                          data: e.value))
                                      .toList())
                              .padding(left: Insets.i20, vertical: Insets.i15),
                        ).decorated(
                            color: appColor(context).appTheme.fieldCardBg))
                    : AddNewBoxLayout(
                            title: appFonts.addNewService,
                            width: MediaQuery.of(context).size.width)
                        .paddingSymmetric(
                            horizontal: Insets.i20, vertical: Insets.i15)
                        .decorated(
                            color: appColor(context).appTheme.fieldCardBg),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SearchTextFieldCommon(
                      controller: value.searchCtrl,
                      focusNode: value.searchFocus),
                  Text(language(context, appFonts.serviceList),
                          style: appCss.dmDenseRegular14
                              .textColor(appColor(context).appTheme.lightText))
                      .paddingSymmetric(vertical: Insets.i15),
                  ...appArray.serviceList.asMap().entries.map((e) =>
                      SelectListLayout(
                          data: e.value,
                          selectedCategory: value.serviceList,
                          onTap: () => value.onSelectService(
                              context, e.value["id"], e.value, e.key))),
                  ButtonCommon(
                          title: appFonts.addService,
                          onTap: () => route.pop(context))
                      .paddingOnly(bottom: Insets.i15, top: Insets.i15)
                ]).paddingSymmetric(
                    vertical: Insets.i25, horizontal: Insets.i20)
              ])));
    });
  }
}
