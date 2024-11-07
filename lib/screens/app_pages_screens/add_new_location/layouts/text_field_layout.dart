import '../../../../config.dart';

class LocationTextFieldLayout extends StatelessWidget {
  const LocationTextFieldLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewLocationProvider>(builder: (context2, value, child) {
        return Consumer<LocationProvider>(builder: (context2, locationCtrl, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textCommon.dmSensMediumDark14(context, text: appFonts.street),
                const VSpace(Sizes.s8),
                TextFieldCommon(
                  focusNode: value.streetFocus,
                    validator: (add) => validation.addressValidation(context, add),
                    controller: value.streetCtrl,
                    hintText: appFonts.street,
                    prefixIcon:
                        eSvgAssets.address),
                const VSpace(Sizes.s15),
                Row(children: [
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: [
                            Text(language(
                                context, appFonts.latitude),
                                style: appCss.dmDenseMedium14
                                    .textColor(
                                    appColor(context).appTheme
                                        .darkText)).paddingOnly(
                                bottom: Insets.i8),
                            TextFieldCommon(
                                keyboardType: TextInputType.number,
                                focusNode: value.latitudeFocus,
                                controller: value.latitudeCtrl,
                                hintText: appFonts.enterHere,
                                prefixIcon: eSvgAssets.locationOut)

                          ])),
                  const HSpace(Sizes.s15),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: [
                            Text(language(
                                context, appFonts.longitude),
                                style: appCss.dmDenseMedium14
                                    .textColor(
                                    appColor(context).appTheme
                                        .darkText)).paddingOnly(
                                bottom: Insets.i8),
                            TextFieldCommon(
                                keyboardType: TextInputType.number,
                                focusNode: value.longitudeFocus,
                                controller: value.longitudeCtrl,
                                hintText: appFonts.enterHere,
                                prefixIcon: eSvgAssets.locationOut)

                          ]))
                ]),
                const VSpace(Sizes.s15),
                textCommon.dmSensMediumDark14(context, text: appFonts.country),
                const VSpace(Sizes.s8),
          TextFieldCommon(
          focusNode: value.countryFocus,
          validator: (zip) => validation.cityValidation(context, zip),
          controller: value.countryCtrl,
          hintText: appFonts.country,
          prefixIcon: eSvgAssets.country),
                const VSpace(Sizes.s15),
                textCommon.dmSensMediumDark14(context, text: appFonts.state),
                const VSpace(Sizes.s8),
                TextFieldCommon(
                    focusNode: value.stateFocus,
                    validator: (zip) => validation.cityValidation(context, zip),
                    controller: value.stateCtrl,
                    hintText: appFonts.state,
                    prefixIcon: eSvgAssets.state),
                const VSpace(Sizes.s18),
                Row(children: [
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        textCommon.dmSensMediumDark14(context, text: appFonts.city),
                        const VSpace(Sizes.s8),
                        TextFieldCommon(
                          focusNode: value.cityFocus,
                            validator: (city) =>
                                validation.cityValidation(context, city),
                            controller: value.cityCtrl,
                            hintText: appFonts.city,
                            prefixIcon: eSvgAssets.locationOut)
                      ])),
                  const HSpace(Sizes.s18),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        textCommon.dmSensMediumDark14(context, text: appFonts.zipCode),
                        const VSpace(Sizes.s8),
                        TextFieldCommon(
                            keyboardType: TextInputType.number,
                          focusNode: value.zipFocus,
                            validator: (zip) => validation.cityValidation(context, zip),
                            controller: value.zipCtrl,
                            hintText: appFonts.zipCode,
                            prefixIcon: eSvgAssets.zipcode)
                      ]))
                ]),
              ]
            );
          }
        );
      }
    );
  }
}
