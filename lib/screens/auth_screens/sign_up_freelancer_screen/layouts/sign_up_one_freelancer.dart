import 'package:flutter/cupertino.dart';

import '../../../../config.dart';

class SignUpOneFreelancer extends StatelessWidget {
  const SignUpOneFreelancer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpCompanyProvider>(builder: (context, value, child) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ContainerWithTextLayout(title: appFonts.userName)
            .paddingOnly(bottom: Insets.i8),
        TextFieldCommon(
                focusNode: value.ownerNameFocus,
                controller: value.ownerName,
                hintText: appFonts.enterName,
                prefixIcon: eSvgAssets.user)
            .paddingSymmetric(horizontal: Insets.i20),
        ContainerWithTextLayout(title: appFonts.phoneNo)
            .paddingOnly(bottom: Insets.i8, top: Insets.i20),
        RegisterWidgetClass().phoneTextBox(
            context, value.providerNumber, value.providerNumberFocus,
            onChanged: (CountryCodeCustom? code) => value.changeDialCode(code!),
            onFieldSubmitted: (values) => validation.fieldFocusChange(
                context, value.providerNumberFocus, value.emailFocus)),
        ContainerWithTextLayout(title: appFonts.email)
            .paddingOnly(bottom: Insets.i8, top: Insets.i20),
        TextFieldCommon(
                focusNode: value.providerEmailFocus,
                controller: value.providerEmail,
                hintText: appFonts.enterEmail,
                prefixIcon: eSvgAssets.email)
            .paddingSymmetric(horizontal: Insets.i20),
        ContainerWithTextLayout(title: appFonts.identityType)
            .paddingOnly(bottom: Insets.i8, top: Insets.i20),
        DropDownLayout(
                hintText: appFonts.selectType,
                icon: eSvgAssets.identity,
                val: value.countryValue,
                isIcon: true,
                // list: appArray.identityList,
                onChanged: (val) => value.onChangeCountry(val))
            .paddingSymmetric(horizontal: Insets.i20),
        Text(language(context, appFonts.identityNo),
                style: appCss.dmDenseSemiBold14
                    .textColor(appColor(context).appTheme.darkText))
            .padding(
                bottom: Insets.i8, top: Insets.i20, horizontal: Insets.i20),
        TextFieldCommon(
                focusNode: value.identityNumberFocus,
                controller: value.identityNumber,
                hintText: appFonts.enterIdentityNo,
                prefixIcon: eSvgAssets.identity)
            .paddingSymmetric(horizontal: Insets.i20),
        Text(language(context, appFonts.uploadPhoto),
                style: appCss.dmDenseSemiBold14
                    .textColor(appColor(context).appTheme.darkText))
            .padding(
                bottom: Insets.i8, top: Insets.i20, horizontal: Insets.i20),
        DottedBorder(
                color: appColor(context).appTheme.stroke,
                borderType: BorderType.RRect,
                radius: const Radius.circular(AppRadius.r10),
                child: ClipRRect(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppRadius.r8)),
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        color: appColor(context).appTheme.whiteBg,
                        child: Column(children: [
                          SvgPicture.asset(eSvgAssets.upload),
                          const VSpace(Sizes.s6),
                          Text(language(context, appFonts.uploadLogoImage),
                              style: appCss.dmDenseMedium12.textColor(
                                  appColor(context).appTheme.lightText))
                        ]).paddingSymmetric(vertical: Insets.i15))))
            .inkWell(onTap: () => value.onImagePick(context))
            .paddingSymmetric(horizontal: Insets.i20),
        ContainerWithTextLayout(title: appFonts.experience)
            .paddingOnly(top: Insets.i24, bottom: Insets.i8),
        Row(children: [
          Expanded(
              flex: 3,
              child: TextFieldCommon(
                      keyboardType: TextInputType.number,
                      focusNode: value.experienceFocus,
                      controller: value.experience,
                      hintText: appFonts.addExperience,
                      prefixIcon: eSvgAssets.timer)
                  .paddingOnly(
                      left: rtl(context) ? 0 : Insets.i20,
                      right: rtl(context) ? Insets.i20 : 0)),
          Expanded(
              flex: 2,
              child: DarkDropDownLayout(
                      isBig: true,
                      val: value.chosenValue,
                      hintText: appFonts.month,
                      isIcon: false,
                      categoryList: appArray.experienceList,
                      onChanged: (val) => value.onDropDownChange(val))
                  .paddingOnly(
                      right: rtl(context) ? Insets.i8 : Insets.i20,
                      left: rtl(context) ? Insets.i20 : Insets.i8))
        ]),
        ContainerWithTextLayout(title: appFonts.password)
            .paddingOnly(bottom: Insets.i8, top: Insets.i20),
        TextFieldCommon(
                focusNode: value.passwordFocus,
                controller: value.password,
                hintText: appFonts.enterPassword,
                prefixIcon: eSvgAssets.lock)
            .paddingSymmetric(horizontal: Insets.i20),
        ContainerWithTextLayout(title: appFonts.confirmPassword)
            .paddingOnly(bottom: Insets.i8, top: Insets.i20),
        TextFieldCommon(
                focusNode: value.reEnterPasswordFocus,
                controller: value.reEnterPassword,
                hintText: appFonts.reEnterPassword,
                prefixIcon: eSvgAssets.lock)
            .paddingSymmetric(horizontal: Insets.i20)
      ]);
    });
  }
}
