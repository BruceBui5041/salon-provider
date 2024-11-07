import '../../../config.dart';

class AddServicemenScreen extends StatelessWidget {
  const AddServicemenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddServicemenProvider>(builder: (context, value, child) {
      return StatefulWrapper(
        onInit: () => Future.delayed(
            const Duration(milliseconds: 100), () => value.onReady()),
        child: Scaffold(
            appBar: AppBarCommon(title: appFonts.addServicemen),
            body: SingleChildScrollView(
                child: Column(children: [
              Column(children: [
                AddServicemenProfileLayout(),
                const VSpace(Sizes.s35),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ServicemenDetailForm(),
                  ContainerWithTextLayout(title: appFonts.knownLanguage)
                      .paddingOnly(bottom: Insets.i8, top: Insets.i20),
                  KnownLanguageLayout(),
                  ExperienceLayout(),
                  Text(language(context, appFonts.location),
                          style: appCss.dmDenseSemiBold14
                              .textColor(appColor(context).appTheme.darkText))
                      .padding(
                          bottom: Insets.i8,
                          top: Insets.i20,
                          horizontal: Insets.i20),
                  DropDownLayout(
                          hintText: appFonts.selectLocation,
                          icon: eSvgAssets.locationOut,
                          val: value.locationValue,
                          isIcon: true,
                          categoryList: appArray.locationList,
                          onChanged: (val) => value.onLocation(val))
                      .paddingSymmetric(horizontal: Insets.i20),
                  ContainerWithTextLayout(title: appFonts.description)
                      .paddingOnly(top: Insets.i24, bottom: Insets.i8),
                  Stack(children: [
                    TextFieldCommon(
                      focusNode: value.descriptionFocus,
                            isNumber: true,
                            controller: value.description,
                            hintText: appFonts.enterDetails,
                            maxLines: 3,
                            minLines: 3,
                            isMaxLine: true)
                        .paddingSymmetric(horizontal: Insets.i20),
                    SvgPicture.asset(eSvgAssets.details, fit: BoxFit.scaleDown,colorFilter: ColorFilter.mode(!value.descriptionFocus.hasFocus ?
                    value.description.text.isNotEmpty
                        ? appColor(context).appTheme.darkText
                            : appColor(context).appTheme.lightText
                    : appColor(context).appTheme.darkText, BlendMode.srcIn))
                        .paddingOnly(
                        left: rtl(context) ? 0 : Insets.i35,
                        right: rtl(context) ? Insets.i35 : 0,
                        top: Insets.i13)
                  ]),
                  ContainerWithTextLayout(title: appFonts.password)
                      .paddingOnly(bottom: Insets.i8, top: Insets.i20),
                  TextFieldCommon(
                    focusNode: value.passwordFocus,
                          controller: value.password,
                          hintText: appFonts.enterPassword,
                          prefixIcon: eSvgAssets.lock)
                      .paddingSymmetric(horizontal: Insets.i20)
                ])
              ]).paddingSymmetric(vertical: Insets.i20).boxShapeExtension(
                  color: appColor(context).appTheme.fieldCardBg,
                  radius: AppRadius.r12),
              ButtonCommon(title: appFonts.update,onTap: ()=> route.pop(context))
                  .paddingOnly(top: Insets.i40, bottom: Insets.i10)
            ]).paddingAll(Insets.i20))),
      );
    });
  }
}
