import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:salon_provider/screens/app_pages_screens/add_new_service_screen/layouts/error_text_layout.dart';
import 'package:salon_provider/screens/app_pages_screens/add_new_service_screen/layouts/image_selection_layout.dart';
import 'package:salon_provider/widgets/cache_image.dart';

import '../../../../config.dart';

/// A layout widget that handles the service image and thumbnail image sections
/// of the add new service form.
class FormServiceImageLayout extends StatelessWidget {
  const FormServiceImageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AddNewServiceProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildServiceImagesSection(context, value),
        if (value.isEdit) _buildMainImageSection(context, value),
        _buildServiceNameSection(context, value),
      ],
    );
  }

  /// Builds the service images section with image preview and upload functionality
  Widget _buildServiceImagesSection(
      BuildContext context, AddNewServiceProvider value) {
    final imageCount = value.pathMainImageSystem.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(
          title: language(context,
              "${language(context, appFonts.serviceImages)} ($imageCount/5)"),
        ),
        const VSpace(Sizes.s12),
        _buildServiceImagesList(context, value),
      ],
    );
  }

  /// Builds the list of service images with preview and upload functionality
  Widget _buildServiceImagesList(
      BuildContext context, AddNewServiceProvider value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              if (value.pathMainImageUrl.isNotEmpty)
                _buildImagePreview(context, value.pathMainImageUrl)
                    .paddingOnly(right: Insets.i10),
              // if (value.image != null && value.image != "")
              //   _buildImagePreview(value.image!),
              if (value.pathMainImageSystem.isNotEmpty)
                ..._buildServiceImageList(value),
              if (appArray.serviceImageList.length <= 10 &&
                  value.isEdit == false)
                AddNewBoxLayout(onAdd: () => value.onImagePick(context, false)),

              if (value.isEdit == true && value.isDraft == true)
                AddNewBoxLayout(onAdd: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImageSelectionLayout(
                            serviceId: value.serviceSelected!.id!,
                            isMultiSelect: false,
                            onApply: (List<String> imageSelected) {},
                          )));
                }),
            ],
          ),
        ),
        const VSpace(Sizes.s8),
        _buildMaxImageText(context),
      ],
    ).paddingSymmetric(horizontal: Insets.i20);
  }

  /// Builds a single image preview container
  Widget _buildImagePreview(BuildContext context, String imagePath) {
    return GestureDetector(
      onTap: () async {
        await showImageViewer(
          context,
          NetworkImage(imagePath),
          // useSafeArea: true,
          doubleTapZoomable: true,
          // barrierColor: appColor(context).appTheme.primary,
          backgroundColor: Colors.black.withOpacity(0.5),
          swipeDismissible: true,
        );
      },
      child: ClipRRect(
          borderRadius: SmoothBorderRadius(
            cornerRadius: AppRadius.r8,
            cornerSmoothing: 2,
          ),
          child: SizedBox(
            height: Sizes.s75,
            width: Sizes.s75,
            // decoration: ShapeDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(imagePath),
            //     fit: BoxFit.cover,
            //   ),
            //   shape: RoundedRectangleBorder(
            //     borderRadius: SmoothBorderRadius(
            //       cornerRadius: AppRadius.r8,
            //       cornerSmoothing: 1,
            //     ),
            //   ),
            // ),
            child: CacheImageWidget(
              url: imagePath,
            ),
          )),
    );
  }

  /// Builds the list of service images with delete functionality
  List<Widget> _buildServiceImageList(AddNewServiceProvider value) {
    return value.pathMainImageSystem
        .asMap()
        .entries
        .map((e) => AddServiceImageLayout(
              image: e.value,
              onDelete: () => value.onRemoveServiceImage(false, index: e.key),
            ))
        .toList();
  }

  /// Builds the maximum image count text
  Widget _buildMaxImageText(BuildContext context) {
    return Text(
      language(context, appFonts.theMaximumImage),
      style: appCss.dmDenseRegular12.textColor(
        appColor(context).appTheme.lightText,
      ),
    );
  }

  /// Builds the thumbnail image section
  Widget _buildMainImageSection(
      BuildContext context, AddNewServiceProvider value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(
          title: language(context, appFonts.serviceImage),
        ).paddingOnly(top: Insets.i24, bottom: Insets.i12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VSpace(Sizes.s8),
            _buildThumbnailPreview(context, value),
            const VSpace(Sizes.s8),
            _buildMaxImageText(context),
          ],
        ).paddingSymmetric(horizontal: Insets.i20),
      ],
    );
  }

  /// Builds the thumbnail image preview
  Widget _buildThumbnailPreview(
      BuildContext context, AddNewServiceProvider value) {
    List<Widget> _listImage = [];
    _listImage.add(
      (value.isDraft == true)
          ? AddNewBoxLayout(onAdd: () {
              //show Dialog image
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageSelectionLayout(
                        serviceId: value.serviceSelected!.id!,
                        isMultiSelect: true,
                        onApply: (List<String> imageSelected) {},
                      )));
            })
          : (value.pathImageService.isEmpty)
              ? Text("No image",
                      style: appCss.dmDenseMedium14
                          .textColor(appColor(context).appTheme.lightText))
                  .paddingOnly(left: Insets.i5)
              : const SizedBox(),
    );

    // else {
    //   _listImage.add(AddNewBoxLayout(onAdd: () {
    //     //show Dialog image
    //     value.onImagePick(context, true);
    //   }));
    // }
    if (value.pathImageService.isNotEmpty) {
      value.pathImageService.map((e) {
        _listImage.add(_buildImagePreview(context, e));
      }).toList();
    }
    // if (value.thumbImage != null && value.thumbImage != "") {
    return Wrap(
      spacing: Insets.i10,
      runSpacing: Insets.i10,
      children: _listImage,
    );
    // return _buildImagePreview(value.thumbImage!);
    // }

    // if (value.thumbFile != null) {
    //   return AddServiceImageLayout(
    //     image: value.thumbFile!.path,
    //     onDelete: () => value.onRemoveServiceImage(true),
    //   );
    // }

    // return AddNewBoxLayout(
    //   onAdd: () => value.onImagePick(context, true),
    // );
  }

  /// Builds the service name input section
  Widget _buildServiceNameSection(
      BuildContext context, AddNewServiceProvider value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(
          title: language(context, appFonts.serviceName),
        ).paddingOnly(top: Insets.i24, bottom: Insets.i12),
        TextFieldCommon(
          focusNode: value.serviceNameFocus,
          controller: value.serviceName,
          hintText: appFonts.enterName,
          prefixIcon: eSvgAssets.serviceName,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return language(context, appFonts.pleaseEnterEmail);
            }
            return null;
          },
        ).paddingSymmetric(horizontal: Insets.i20),
        if (value.serviceName.text.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: Insets.i5, left: Insets.i20),
            child: errorTextLayout(
                context, value.errorServiceName ?? '', value.serviceName.text),
          ),
      ],
    );
  }
}
