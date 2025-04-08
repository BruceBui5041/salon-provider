// import 'package:salon_provider/widgets/multi_dropdown_common.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import '../../../../config.dart';

// class SignUpThree extends StatelessWidget {
//   const SignUpThree({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SignUpCompanyProvider>(builder: (context, value, child) {
//       return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         ContainerWithTextLayout(
//                 title: isFreelancer ? appFonts.userName : appFonts.ownerName)
//             .paddingOnly(bottom: Insets.i8),
//         TextFieldCommon(
//                 focusNode: value.ownerNameFocus,
//                 controller: value.ownerName,
//                 hintText: appFonts.enterName,
//                 prefixIcon: eSvgAssets.user)
//             .paddingSymmetric(horizontal: Insets.i20),
//         ContainerWithTextLayout(title: appFonts.phoneNo)
//             .paddingOnly(bottom: Insets.i8, top: Insets.i20),
//         RegisterWidgetClass().phoneTextBox(
//             context, value.providerNumber, value.providerNumberFocus,
//             onChanged: (CountryCodeCustom? code) => value.changeDialCode(code!),
//             onFieldSubmitted: (values) => validation.fieldFocusChange(
//                 context, value.providerNumberFocus, value.emailFocus)),
//         ContainerWithTextLayout(title: appFonts.email)
//             .paddingOnly(bottom: Insets.i8, top: Insets.i20),
//         TextFieldCommon(
//                 focusNode: value.providerEmailFocus,
//                 controller: value.providerEmail,
//                 hintText: appFonts.enterEmail,
//                 prefixIcon: eSvgAssets.email)
//             .paddingSymmetric(horizontal: Insets.i20),
//         ContainerWithTextLayout(title: appFonts.knownLanguage)
//             .paddingOnly(bottom: Insets.i8, top: Insets.i20),
//         Stack(children: [
//           MultiSelectDropDownCustom(
//                   onOptionSelected: (options) =>
//                       value.onLanguageSelect(options),
//                   options: [
//                     ValueItem(
//                         label: language(context, appFonts.english), value: '1'),
//                     ValueItem(
//                         label: language(context, appFonts.german), value: '2'),
//                     ValueItem(
//                         label: language(context, appFonts.spanish), value: '3'),
//                     ValueItem(
//                         label: language(context, appFonts.japanese),
//                         value: '4'),
//                   ],
//                   selectionType: SelectionType.multi,
//                   hint: "Select language",
//                   hintStyle: appCss.dmDenseMedium14
//                       .textColor(appColor(context).appTheme.lightText),
//                   chipConfig: ChipConfig(
//                       wrapType: WrapType.scroll,
//                       deleteIcon: Icon(CupertinoIcons.multiply,
//                           color: appColor(context).appTheme.darkText,
//                           size: Sizes.s15),
//                       backgroundColor: appColor(context).appTheme.fieldCardBg,
//                       labelColor: appColor(context).appTheme.darkText,
//                       deleteIconColor: appColor(context).appTheme.darkText,
//                       labelStyle: appCss.dmDenseMedium14
//                           .textColor(appColor(context).appTheme.darkText)),
//                   padding: const EdgeInsets.only(
//                       left: Insets.i40, right: Insets.i10),
//                   showClearIcon: false,
//                   borderColor: appColor(context).appTheme.trans,
//                   borderRadius: AppRadius.r8,
//                   suffixIcon: SvgPicture.asset(eSvgAssets.dropDown,
//                       colorFilter: ColorFilter.mode(
//                           value.languageSelect != "[]"
//                               ? appColor(context).appTheme.darkText
//                               : appColor(context).appTheme.lightText,
//                           BlendMode.srcIn)),
//                   optionTextStyle: appCss.dmDenseMedium14
//                       .textColor(appColor(context).appTheme.darkText),
//                   selectedOptionIcon: Icon(Icons.check_box_rounded,
//                       color: appColor(context).appTheme.primary))
//               .paddingSymmetric(horizontal: Insets.i20),
//           SvgPicture.asset(
//             eSvgAssets.country,
//             colorFilter: ColorFilter.mode(
//                 value.languageSelect != "[]"
//                     ? appColor(context).appTheme.darkText
//                     : appColor(context).appTheme.lightText,
//                 BlendMode.srcIn),
//           ).paddingOnly(
//               left: rtl(context) ? 0 : Insets.i35,
//               right: rtl(context) ? Insets.i35 : 0,
//               top: Insets.i16)
//         ]),
//         ContainerWithTextLayout(title: appFonts.identityType)
//             .paddingOnly(bottom: Insets.i8, top: Insets.i20),
//         DropDownLayout(
//                 hintText: appFonts.selectType,
//                 icon: eSvgAssets.identity,
//                 val: value.countryValue,
//                 isIcon: true,
//                 categoryList: appArray.identityList,
//                 onChanged: (val) => value.onChangeCountry(val))
//             .paddingSymmetric(horizontal: Insets.i20),
//         Text(language(context, appFonts.identityNo),
//                 style: appCss.dmDenseSemiBold14
//                     .textColor(appColor(context).appTheme.darkText))
//             .padding(
//                 bottom: Insets.i8, top: Insets.i20, horizontal: Insets.i20),
//         TextFieldCommon(
//                 focusNode: value.identityNumberFocus,
//                 controller: value.identityNumber,
//                 hintText: appFonts.enterIdentityNo,
//                 prefixIcon: eSvgAssets.identity)
//             .paddingSymmetric(horizontal: Insets.i20),
//         Text(language(context, appFonts.uploadPhoto),
//                 style: appCss.dmDenseSemiBold14
//                     .textColor(appColor(context).appTheme.darkText))
//             .padding(
//                 bottom: Insets.i8, top: Insets.i20, horizontal: Insets.i20),
//         DottedBorder(
//                 color: appColor(context).appTheme.stroke,
//                 borderType: BorderType.RRect,
//                 radius: const Radius.circular(AppRadius.r10),
//                 child: ClipRRect(
//                     borderRadius:
//                         const BorderRadius.all(Radius.circular(AppRadius.r8)),
//                     child: Container(
//                         alignment: Alignment.center,
//                         width: MediaQuery.of(context).size.width,
//                         color: appColor(context).appTheme.whiteBg,
//                         child: Column(children: [
//                           SvgPicture.asset(eSvgAssets.upload),
//                           const VSpace(Sizes.s6),
//                           Text(language(context, appFonts.uploadLogoImage),
//                               style: appCss.dmDenseMedium12.textColor(
//                                   appColor(context).appTheme.lightText))
//                         ]).paddingSymmetric(vertical: Insets.i15))))
//             .inkWell(onTap: () => value.onImagePick(context))
//             .paddingSymmetric(horizontal: Insets.i20),
//         ContainerWithTextLayout(title: appFonts.password)
//             .paddingOnly(bottom: Insets.i8, top: Insets.i20),
//         TextFieldCommon(
//                 focusNode: value.passwordFocus,
//                 controller: value.password,
//                 hintText: appFonts.enterPassword,
//                 prefixIcon: eSvgAssets.lock)
//             .paddingSymmetric(horizontal: Insets.i20),
//         ContainerWithTextLayout(title: appFonts.confirmPassword)
//             .paddingOnly(bottom: Insets.i8, top: Insets.i20),
//         TextFieldCommon(
//                 focusNode: value.reEnterPasswordFocus,
//                 controller: value.reEnterPassword,
//                 hintText: appFonts.reEnterPassword,
//                 prefixIcon: eSvgAssets.lock)
//             .paddingSymmetric(horizontal: Insets.i20)
//       ]);
//     });
//   }
// }
