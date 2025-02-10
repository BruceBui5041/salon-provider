import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:flutter/cupertino.dart';

import '../../../../config.dart';

class FormServiceDefaultLayout extends StatelessWidget {
  const FormServiceDefaultLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AddNewServiceProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(
            title: language(context,
                "${language(context, appFonts.serviceImages)} (${value.image != null && value.image != "" ? "1" : appArray.serviceImageList.length}/5)")),
        const VSpace(Sizes.s12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              if (value.image != null && value.image != "")
                Container(
                        height: Sizes.s70,
                        width: Sizes.s70,
                        decoration: ShapeDecoration(
                            image: DecorationImage(
                                image: AssetImage(value.image!),
                                fit: BoxFit.cover),
                            shape: RoundedRectangleBorder(
                                borderRadius: SmoothBorderRadius(
                                    cornerRadius: AppRadius.r8,
                                    cornerSmoothing: 1))))
                    .paddingOnly(right: Insets.i15),
              if (value.image == null)
                ...appArray.serviceImageList
                    .asMap()
                    .entries
                    .map((e) => AddServiceImageLayout(
                        image: e.value,
                        onDelete: () =>
                            value.onRemoveServiceImage(false, index: e.key)))
                    .toList(),
              if (appArray.serviceImageList.length <= 4)
                AddNewBoxLayout(onAdd: () => value.onImagePick(context, false))
            ]),
          ),
          const VSpace(Sizes.s8),
          Text(language(context, appFonts.theMaximumImage),
              style: appCss.dmDenseRegular12
                  .textColor(appColor(context).appTheme.lightText))
        ]).paddingSymmetric(horizontal: Insets.i20),
        ContainerWithTextLayout(
                title: language(context, appFonts.thumbnailImage))
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        if (value.thumbImage != null && value.thumbImage != "")
          Container(
                  height: Sizes.s70,
                  width: Sizes.s70,
                  decoration: ShapeDecoration(
                      image: DecorationImage(
                          image: AssetImage(value.thumbImage!),
                          fit: BoxFit.cover),
                      shape: RoundedRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                              cornerRadius: AppRadius.r8, cornerSmoothing: 1))))
              .paddingSymmetric(horizontal: Insets.i20),
        if (value.thumbImage == null || value.thumbImage == "")
          value.thumbFile != null
              ? AddServiceImageLayout(
                      image: value.thumbFile!.path,
                      onDelete: () => value.onRemoveServiceImage(true))
                  .paddingSymmetric(horizontal: Insets.i20)
              : AddNewBoxLayout(onAdd: () => value.onImagePick(context, true))
                  .paddingSymmetric(horizontal: Insets.i20),
        const VSpace(Sizes.s8),
        ContainerWithTextLayout(title: language(context, appFonts.categories))
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Insets.i15,
          ),
          child: DropDownLayout(
            isBig: true,
            isField: true,
            onChanged: (val) => value.onChangeCategory(val),
            categoryList: value.categoryResponse?.data ?? [],
          ),
        ),
        // Text(language(context, appFonts.theMaximumImage),
        //         style: appCss.dmDenseRegular12
        //             .textColor(appColor(context).appTheme.lightText))
        //     .paddingSymmetric(horizontal: Insets.i20),
        ContainerWithTextLayout(
                title: language(context, appFonts.serviceDetail))
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        _slugInput(context, value),
        const VSpace(Sizes.s8),
        _titleInput(value),
        const VSpace(Sizes.s8),
        _durationInput(value),
        const VSpace(Sizes.s8),
        _priceInput(value),
        const VSpace(Sizes.s8),
        _discountedPriceInput(value),
      ],
    );
  }

  Widget _slugInput(BuildContext context, AddNewServiceProvider value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldCommon(
          focusNode: value.slugFocus,
          controller: value.slugController,
          onChanged: (val) {
            value.convertToSlug(val);
          },
          hintText: "Nhập slug",
        ).paddingSymmetric(horizontal: Insets.i20),
        if (value.slug.toString().isNotEmpty)
          Text(language(context, value.slug),
                  style: appCss.dmDenseRegular12
                      .textColor(appColor(context).appTheme.lightText))
              .paddingSymmetric(horizontal: Insets.i20),
      ],
    );
  }

  Widget _titleInput(AddNewServiceProvider value) {
    return TextFieldCommon(
      focusNode: value.titleFocus,
      controller: value.titleController,
      hintText: "Nhập tiêu đề",
    ).paddingSymmetric(horizontal: Insets.i20);
  }

  Widget _priceInput(AddNewServiceProvider value) {
    return TextFieldCommon(
      focusNode: value.priceFocus,
      controller: value.priceController,
      hintText: "Nhập giá",
    ).paddingSymmetric(horizontal: Insets.i20);
  }

  Widget _discountedPriceInput(AddNewServiceProvider value) {
    return TextFieldCommon(
      focusNode: value.discountedPriceFocus,
      controller: value.discountedPriceController,
      hintText: "Nhập giá giảm",
    ).paddingSymmetric(horizontal: Insets.i20);
  }

  Widget _durationInput(AddNewServiceProvider value) {
    return TextFieldCommon(
      focusNode: value.durationFocus,
      controller: value.durationController,
      hintText: "Nhập thời gian",
    ).paddingSymmetric(horizontal: Insets.i20);
  }
}
