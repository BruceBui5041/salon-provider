import 'package:salon_provider/config.dart';

class SignUpTwoFreelancer extends StatelessWidget {
  final TickerProvider? sync;
  const SignUpTwoFreelancer({super.key, this.sync});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpCompanyProvider>(builder: (context, value, child) {
      return Column(children: [
        ContainerWithTextLayout(title: appFonts.street)
            .paddingOnly(bottom: Insets.i8),
        TextFieldCommon(
                focusNode: value.streetFocus,
                controller: value.street,
                hintText: appFonts.street,
                prefixIcon: eSvgAssets.address)
            .paddingSymmetric(horizontal: Insets.i20),
        Row(children: [
          Expanded(
              child: Column(children: [
            ContainerWithTextLayout(title: appFonts.city)
                .paddingOnly(top: Insets.i24, bottom: Insets.i8),
            TextFieldCommon(
                    focusNode: value.cityFocus,
                    controller: value.city,
                    hintText: appFonts.city,
                    prefixIcon: eSvgAssets.locationOut)
                .paddingOnly(
                    left: rtl(context) ? 0 : Insets.i20,
                    right: rtl(context) ? Insets.i20 : 0)
          ])),
          const HSpace(Sizes.s15),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(language(context, appFonts.zipCode),
                        style: appCss.dmDenseSemiBold14
                            .textColor(appColor(context).appTheme.darkText))
                    .paddingOnly(top: Insets.i30, bottom: Insets.i8),
                TextFieldCommon(
                        keyboardType: TextInputType.number,
                        focusNode: value.zipcodeFocus,
                        controller: value.zipCode,
                        hintText: appFonts.zipCode,
                        prefixIcon: eSvgAssets.zipcode)
                    .paddingOnly(
                        right: rtl(context) ? 0 : Insets.i20,
                        left: rtl(context) ? Insets.i20 : 0)
              ]))
        ]),
        const VSpace(Sizes.s20),
        ContainerWithTextLayout(title: appFonts.country)
            .paddingOnly(bottom: Insets.i8),
        // StateCountryDropdown(
        //         items: value.countryList,
        //         selectedItem: value.countryCompany,
        //         onChanged: (val) => value.onChangeCountryCompany(val))
        //     .paddingSymmetric(horizontal: Insets.i20),
        // const VSpace(Sizes.s20),
        // ContainerWithTextLayout(title: appFonts.state)
        //     .paddingOnly(bottom: Insets.i8),
        // StateCountryDropdown(
        //         icon: eSvgAssets.state,
        //         items: value.stateList,
        //         selectedItem: value.stateCompany,
        //         onChanged: (val) => value.onChangeStateCompany(val))
        //     .paddingSymmetric(horizontal: Insets.i20),
        const DottedLines().paddingOnly(top: Insets.i13, bottom: Insets.i20),
        Text(language(context, appFonts.serviceAvailability).toUpperCase(),
            style: appCss.dmDenseSemiBold16
                .textColor(appColor(context).appTheme.darkText)),
        const VSpace(Sizes.s15),
        SliderLayout(
                val: value.slider,
                onDragging: (handlerIndex, lowerValue, upperValue) =>
                    value.slidingValue(lowerValue))
            .padding(horizontal: Insets.i8, bottom: Insets.i10)
            .boxShapeExtension(color: appColor(context).appTheme.whiteBg)
            .paddingSymmetric(horizontal: Insets.i20),
        const VSpace(Sizes.s20),
        if (appArray.serviceAvailableAreaList.isEmpty)
          Column(children: [
            Text(language(context, appFonts.listOfAvailableService),
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.lightText))
                .alignment(Alignment.centerLeft)
                .paddingSymmetric(horizontal: Insets.i20),
            const VSpace(Sizes.s30),
            SvgPicture.asset(eSvgAssets.location,
                    colorFilter: ColorFilter.mode(
                        appColor(context).appTheme.lightText, BlendMode.srcIn))
                .paddingAll(Insets.i14)
                .decorated(
                    color: appColor(context).appTheme.stroke,
                    shape: BoxShape.circle),
            Text(language(context, appFonts.addAtLeastOneArea),
                    textAlign: TextAlign.center,
                    style: appCss.dmDenseMedium12
                        .textColor(appColor(context).appTheme.darkText))
                .paddingSymmetric(horizontal: Insets.i30, vertical: Insets.i10),
            ButtonCommon(
                title: "+ ${language(context, appFonts.add)}",
                width: Sizes.s63,
                height: Sizes.s34,
                color: appColor(context).appTheme.trans,
                borderColor: appColor(context).appTheme.primary,
                style: appCss.dmDenseMedium12
                    .textColor(appColor(context).appTheme.primary),
                onTap: () => route.pushNamed(context, routeName.location))
          ]),
        if (appArray.serviceAvailableAreaList.isNotEmpty)
          Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(language(context, appFonts.serviceAvailableArea),
                  style: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.lightText)),
              Text(language(context, "+${language(context, appFonts.add)}"),
                      style: appCss.dmDenseMedium14
                          .textColor(appColor(context).appTheme.primary))
                  .inkWell(
                      onTap: () => route.pushNamed(context, routeName.location))
            ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i10),
            ...appArray.serviceAvailableAreaList
                .asMap()
                .entries
                .map((e) => ServicemanListLayout(
                        data: e.value,
                        onDelete: () =>
                            value.onLocationDelete(e.key, context, sync),
                        index: e.key,
                        list: appArray.serviceAvailableAreaList)
                    .paddingSymmetric(horizontal: Insets.i20))
                .toList()
          ]),
        const VSpace(Sizes.s30),
        const DottedLines(),
        const VSpace(Sizes.s15),
        Text(language(context, appFonts.theBasicPlanAllows),
                style: appCss.dmDenseMedium12
                    .textColor(appColor(context).appTheme.lightText))
            .paddingSymmetric(horizontal: Insets.i20)
      ]);
    });
  }
}
