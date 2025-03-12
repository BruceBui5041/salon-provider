import 'dart:io';

import '../../../../config.dart';

class ServicemenDetailForm extends StatelessWidget {
  const ServicemenDetailForm({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AddServicemenProvider>(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ContainerWithTextLayout(title: appFonts.userName)
          .paddingOnly(bottom: Insets.i8),
      TextFieldCommon(
              focusNode: value.userNameFocus,
              controller: value.userName,
              hintText: appFonts.enterName,
              prefixIcon: eSvgAssets.user)
          .paddingSymmetric(horizontal: Insets.i20),
      ContainerWithTextLayout(title: appFonts.phoneNo)
          .paddingOnly(bottom: Insets.i8, top: Insets.i20),
      RegisterWidgetClass().phoneTextBox(
          context, value.number, value.providerNumberFocus,
          onChanged: (CountryCodeCustom? code) => value.changeDialCode(code!),
          onFieldSubmitted: (values) => validation.fieldFocusChange(
              context, value.providerNumberFocus, value.emailFocus)),
      ContainerWithTextLayout(title: appFonts.email)
          .paddingOnly(bottom: Insets.i8, top: Insets.i20),
      TextFieldCommon(
              focusNode: value.emailFocus,
              controller: value.email,
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
              list: appArray.identityList,
              onChanged: (val) => value.onChangeCountry(val))
          .paddingSymmetric(horizontal: Insets.i20),
      Text(language(context, appFonts.identityNo),
              style: appCss.dmDenseSemiBold14
                  .textColor(appColor(context).appTheme.darkText))
          .padding(bottom: Insets.i8, top: Insets.i20, horizontal: Insets.i20),
      TextFieldCommon(
              keyboardType: TextInputType.number,
              focusNode: value.identityNumberFocus,
              controller: value.identityNumber,
              hintText: appFonts.enterIdentityNo,
              prefixIcon: eSvgAssets.identity)
          .paddingSymmetric(horizontal: Insets.i20),
      Text(language(context, appFonts.uploadPhoto),
              style: appCss.dmDenseSemiBold14
                  .textColor(appColor(context).appTheme.darkText))
          .padding(bottom: Insets.i8, top: Insets.i20, horizontal: Insets.i20),
      value.imageFile != null
          ? Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Container(
                  height: Sizes.s70,
                  width: Sizes.s70,
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(AppRadius.r8)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(value.imageFile!.path))))),
              const HSpace(Sizes.s5),
              SizedBox(
                      child:
                          SvgPicture.asset(eSvgAssets.edit, height: Sizes.s14)
                              .paddingAll(Insets.i7))
                  .decorated(
                      color: appColor(context).appTheme.whiteBg,
                      shape: BoxShape.circle)
                  .inkWell(onTap: () => value.onImagePick(context, false))
            ]).padding(horizontal: Insets.i20)
          : UploadImageLayout(onTap: () => value.onImagePick(context, false))
    ]);
  }
}
