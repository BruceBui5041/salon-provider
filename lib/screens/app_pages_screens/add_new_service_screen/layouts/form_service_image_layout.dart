import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../../config.dart';
import '../../../../widgets/add_new_box_layout.dart';
import '../../../../widgets/add_service_image_layout.dart';

class FormServiceImageLayout extends StatelessWidget {
  const   FormServiceImageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AddNewServiceProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(
            title: language(context, "${language(context, appFonts.serviceImages)} (${ value.image != null && value.image != ""  ? "1" : appArray.serviceImageList.length}/5)")),
        const VSpace(Sizes.s12),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  if(value.image != null && value.image != "")
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
                                    cornerSmoothing: 1)))).paddingOnly(right: Insets.i15),
                  if(value.image == null)
                  ...appArray.serviceImageList.asMap().entries.map((e) => AddServiceImageLayout(image: e.value,onDelete: ()=> value.onRemoveServiceImage(false,index: e.key))).toList(),
                 if(appArray.serviceImageList.length <= 4)
                   AddNewBoxLayout(onAdd: ()=> value.onImagePick(context,false))
                ]),
              ),
              const VSpace(Sizes.s8),
              Text(language(context, appFonts.theMaximumImage),
                  style: appCss.dmDenseRegular12
                      .textColor(appColor(context).appTheme.lightText))
            ]
        ).paddingSymmetric(horizontal: Insets.i20),
        ContainerWithTextLayout(
            title: language(context, appFonts.thumbnailImage))
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        if(value.thumbImage != null && value.thumbImage != "")
          Container(
              height: Sizes.s70,
              width: Sizes.s70,
              decoration: ShapeDecoration(
                  image: DecorationImage(
                      image: AssetImage(value.thumbImage!),
                      fit: BoxFit.cover),
                  shape: RoundedRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                          cornerRadius: AppRadius.r8,
                          cornerSmoothing: 1)))).paddingSymmetric(horizontal: Insets.i20),
        if(value.thumbImage == null || value.thumbImage == "")
        value.thumbFile != null ?
        AddServiceImageLayout(image: value.thumbFile!.path,onDelete: ()=> value.onRemoveServiceImage(true))
            .paddingSymmetric(horizontal: Insets.i20) : AddNewBoxLayout(onAdd: ()=> value.onImagePick(context,true)).paddingSymmetric(horizontal: Insets.i20),
        const VSpace(Sizes.s8),
        Text(language(context, appFonts.theMaximumImage),
            style: appCss.dmDenseRegular12
                .textColor(appColor(context).appTheme.lightText)).paddingSymmetric(horizontal: Insets.i20),
        ContainerWithTextLayout(
            title: language(context, appFonts.serviceName))
            .paddingOnly(top: Insets.i24, bottom: Insets.i12),
        TextFieldCommon(
          focusNode: value.serviceNameFocus,
            controller: value.serviceName,
            hintText: appFonts.enterName,
            prefixIcon: eSvgAssets.serviceName)
            .paddingSymmetric(horizontal: Insets.i20),
      ],
    );
  }
}
