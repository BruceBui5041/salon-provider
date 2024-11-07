import '../../../config.dart';

class CompanyDetailsScreen extends StatelessWidget {
  const CompanyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CompanyDetailProvider,NewLocationProvider>(builder: (context, value,locationVal, child) {
      return StatefulWrapper(
        onInit: () => Future.delayed(
            const Duration(milliseconds: 50), () => value.onReady()),
        child: Scaffold(
            appBar: AppBarCommon(
                title: isFreelancer
                    ? appFonts.serviceLocation
                    : appFonts.companyDetails),
            body: SingleChildScrollView(
                child: Column(children: [
              const CompanyTopLayout(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                    width: Sizes.s180,
                    child: Text(language(context, appFonts.availableService),
                        overflow: TextOverflow.ellipsis,
                        style: appCss.dmDenseMedium16
                            .textColor(appColor(context).appTheme.darkText))),
                Text(language(context, "+ ${language(context, appFonts.add)}"),
                        style: appCss.dmDenseBold16
                            .textColor(appColor(context).appTheme.primary))
                    .inkWell(onTap: () => route.pushNamed(context, routeName.location,arg: true))
              ]).paddingOnly(top: Insets.i25, bottom: Insets.i15),
              Column(children: [
                SliderLayout(
                        val: value.slider,
                        onDragging: (handlerIndex, lowerValue, upperValue) =>
                            value.slidingValue(lowerValue))
                    .padding(horizontal: Insets.i8, bottom: Insets.i10)
                    .boxBorderExtension(context,
                        color: appColor(context).appTheme.fieldCardBg,
                        bColor: appColor(context).appTheme.stroke),
                if(locationVal.locationList.isNotEmpty)
                const VSpace(Sizes.s15),
                if(locationVal.locationList.isNotEmpty)
                ...locationVal.locationList
                    .asMap()
                    .entries
                    .map((e) => ServiceRangeLayout(
                  onEdit: ()=> value.onEditLocation(context, e.value,e.key),
                        onDelete: ()=> value.onDeleteLocation(context, e.key),
                        onToggle: (val) => value.onTapSwitch(val, e.value),
                        data: e.value,
                        index: e.key,
                        list: locationVal.locationList))
                    .toList()
              ])
                  .paddingAll(Insets.i15)
                  .boxBorderExtension(context, isShadow: true)
            ]).padding(horizontal: Insets.i20,bottom: Insets.i20))),
      );
    });
  }
}
