import 'dart:developer';

import 'package:figma_squircle_updated/figma_squircle.dart';

import '../../../../config.dart';

class FormCategoryLayout extends StatelessWidget {
  const FormCategoryLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AddNewServiceProvider>(context);
    log("value.categoryValue :${value.categoryValue}");
    return Column(children: [
      ContainerWithTextLayout(title: language(context, appFonts.category))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      DropDownLayout(
              icon: eSvgAssets.categorySmall,
              val: value.categoryValue!.name,
              hintText: appFonts.select,
              isIcon: true,
              list: appArray.allCategories,
              onChanged: (val) => value.onChangeCategory(val))
          .paddingSymmetric(horizontal: Insets.i20),
      ContainerWithTextLayout(title: language(context, appFonts.subCategory))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      DropDownLayout(
              icon: eSvgAssets.subCategory,
              val: value.subCategoryValue?.name,
              isIcon: true,
              hintText: appFonts.select,
              list: appArray.allCategories,
              onChanged: (val) => value.onChangeSubCategory(val))
          .paddingSymmetric(horizontal: Insets.i20),
      ContainerWithTextLayout(
              title: language(context, appFonts.applicableCommission))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      Column(children: [
        Container(
            decoration: ShapeDecoration(
                color: appColor(context).appTheme.stroke,
                shape: RoundedRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                        cornerRadius: AppRadius.r8, cornerSmoothing: 0))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    SvgPicture.asset(eSvgAssets.commission,
                        colorFilter: ColorFilter.mode(
                            appColor(context).appTheme.lightText,
                            BlendMode.srcIn)),
                    const HSpace(Sizes.s10),
                    Text("30%",
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.lightText))
                  ]),
                  Text(language(context, appFonts.percentage),
                      style: appCss.dmDenseRegular12
                          .textColor(appColor(context).appTheme.lightText))
                ]).paddingAll(Insets.i15)),
        const VSpace(Sizes.s2),
        Text(language(context, appFonts.noteHighest),
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.red))
      ]).paddingSymmetric(horizontal: Insets.i20),
      ContainerWithTextLayout(title: language(context, appFonts.description))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      Stack(children: [
        TextFieldCommon(
                focusNode: value.descriptionFocus,
                isNumber: true,
                controller: value.description,
                hintText: appFonts.enterDescription,
                maxLines: 3,
                minLines: 3,
                isMaxLine: true)
            .paddingSymmetric(horizontal: Insets.i20),
        SvgPicture.asset(eSvgAssets.details,
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                    !value.descriptionFocus.hasFocus
                        ? value.featuredPoints.text.isNotEmpty
                            ? appColor(context).appTheme.darkText
                            : appColor(context).appTheme.lightText
                        : appColor(context).appTheme.darkText,
                    BlendMode.srcIn))
            .paddingOnly(
                left: rtl(context) ? 0 : Insets.i35,
                right: rtl(context) ? Insets.i35 : 0,
                top: Insets.i13)
      ]),
      ContainerWithTextLayout(title: language(context, appFonts.duration))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      Row(children: [
        Expanded(
            flex: 2,
            child: TextFieldCommon(
                keyboardType: TextInputType.number,
                focusNode: value.durationFocus,
                controller: value.duration,
                hintText: appFonts.addServiceTime,
                prefixIcon: eSvgAssets.timer)),
        const HSpace(Sizes.s6),
        Expanded(
            flex: 1,
            child: DarkDropDownLayout(
                isBig: true,
                val: value.durationValue,
                hintText: appFonts.hour,
                isIcon: false,
                categoryList: appArray.durationList,
                onChanged: (val) => value.onChangeDuration(val)))
      ]).paddingSymmetric(horizontal: Insets.i20),
      ContainerWithTextLayout(
              title: language(context, appFonts.availableServiceAt))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      TextFieldCommon(
              isEnable: false,
              focusNode: value.availableServiceFocus,
              controller: value.availableService,
              hintText: appFonts.selectLocation,
              prefixIcon: eSvgAssets.locationOut)
          .inkWell(onTap: () => value.onAvailableServiceTap(context))
          .paddingSymmetric(horizontal: Insets.i20),
      ContainerWithTextLayout(
              title: language(context, appFonts.minRequiredServiceman))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      TextFieldCommon(
              keyboardType: TextInputType.number,
              focusNode: value.minRequiredFocus,
              controller: value.minRequired,
              hintText: appFonts.addNoOfServiceman,
              prefixIcon: eSvgAssets.tagUser)
          .paddingSymmetric(horizontal: Insets.i20)
    ]);
  }
}
