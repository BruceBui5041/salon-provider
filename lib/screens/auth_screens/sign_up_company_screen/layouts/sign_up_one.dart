import '../../../../config.dart';

class SignUpOne extends StatelessWidget {
  const SignUpOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpCompanyProvider>(builder: (context, value, child) {
      return Column(children: [
        ContainerWithTextLayout(title: appFonts.login),
        const VSpace(Sizes.s12),
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
                    child: Column(
                      children: [
                        SvgPicture.asset(eSvgAssets.upload),
                        const VSpace(Sizes.s6),
                        Text(language(context, appFonts.uploadLogoImage),
                            style: appCss.dmDenseMedium12
                                .textColor(appColor(context).appTheme.lightText))

                      ],
                    ).paddingSymmetric(vertical: Insets.i15)))).inkWell(onTap: ()=> value.onImagePick(context)).paddingSymmetric(horizontal: Insets.i20),
        ContainerWithTextLayout(title: appFonts.companyName)
            .paddingOnly(top: Insets.i24, bottom: Insets.i8),
        TextFieldCommon(
          controller: value.companyName,
                focusNode: value.companyNameFocus,
                hintText: appFonts.enterCompanyName,
                prefixIcon: eSvgAssets.companyName)
            .paddingSymmetric(horizontal: Insets.i20),
        ContainerWithTextLayout(title: appFonts.companyPhoneNo)
            .paddingOnly(top: Insets.i24, bottom: Insets.i8),
        RegisterWidgetClass().phoneTextBox(
            context, value.phoneName, value.phoneNameFocus,
            onChanged: (CountryCodeCustom? code) => value.changeDialCode(code!),
            onFieldSubmitted: (values) => validation.fieldFocusChange(
                context, value.phoneNameFocus, value.companyMailFocus)),
        ContainerWithTextLayout(title: appFonts.companyMail)
            .paddingOnly(top: Insets.i24, bottom: Insets.i8),
        TextFieldCommon(
            controller: value.companyMail,
                focusNode: value.companyMailFocus,
                hintText: appFonts.enterMail,
                prefixIcon:
                   eSvgAssets.email)
            .paddingSymmetric(horizontal: Insets.i20),
        ContainerWithTextLayout(title: appFonts.experience)
            .paddingOnly(top: Insets.i24, bottom: Insets.i8),
        Row(children: [
          Expanded(
              flex: 3,
              child: TextFieldCommon(keyboardType: TextInputType.number,
                focusNode: value.experienceFocus,
                  controller: value.experience,
                      hintText: appFonts.addExperience,
                      prefixIcon: eSvgAssets.timer)
                  .paddingOnly(left: rtl(context) ? 0 : Insets.i20,right: rtl(context) ? Insets.i20 : 0)),
          Expanded(
              flex: 2,
              child: DarkDropDownLayout(
                  isBig: true,
                  val: value.chosenValue,
                  hintText: appFonts.month,
                  isIcon: false,
                  categoryList: appArray.experienceList,
                  onChanged: (val) => value.onDropDownChange(val))
                  .paddingOnly(right:  rtl(context) ? Insets.i8 : Insets.i20, left: rtl(context) ? Insets.i20 : Insets.i8))
        ]),
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
          SvgPicture.asset(eSvgAssets.details, fit: BoxFit.scaleDown,colorFilter: ColorFilter.mode( !value.descriptionFocus.hasFocus ? value.description.text.isNotEmpty ?
            appColor(context).appTheme.darkText
          : appColor(context).appTheme.lightText
          : appColor(context).appTheme.darkText, BlendMode.srcIn))
              .paddingOnly(
                  left: rtl(context) ? 0 : Insets.i35,
                  right: rtl(context) ? Insets.i35 : 0,
                  top: Insets.i13)
        ])
      ]);
    });
  }
}
