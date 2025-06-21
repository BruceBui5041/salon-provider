import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:salon_provider/screens/app_pages_screens/add_new_service_screen/layouts/custom_image_viewer.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(
          title: language(context, language(context, appFonts.mainImage)),
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
                _buildImagePreview(context, value.pathMainImageUrl,
                    [value.pathMainImageUrl]).paddingOnly(right: Insets.i10),
              if (value.serviceImages.isNotEmpty)
                ..._buildServiceImageList(value),
              if (appArray.serviceImageList.length <= 10 &&
                  value.isEdit == false)
                AddNewBoxLayout(onAdd: () => value.onImagePick(context, false)),
              if (value.isEdit == true && value.isDraft == true)
                AddNewBoxLayout(onAdd: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImageSelectionLayout(
                            idServiceVersionSelected:
                                value.serviceVersionSelected!.id ?? '',
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
  Widget _buildImagePreview(
      BuildContext context, String imagePath, List<String> allImages,
      {int initialIndex = 0}) {
    return GestureDetector(
      onTap: () async {
        // Create a list of network image providers from all images
        List<ImageProvider> imageProviders =
            allImages.map((path) => NetworkImage(path)).toList();

        // Create a multi image provider
        MultiImageProvider multiImageProvider =
            MultiImageProvider(imageProviders, initialIndex: initialIndex);

        // Show the custom image viewer pager
        await showCustomImageViewerPager(
          context,
          multiImageProvider,
          doubleTapZoomable: true,
          backgroundColor: Colors.black.withAlpha(50),
          swipeDismissible: true,
          closeButtonTooltip: "Close",
          closeButtonColor: appColor(context).appTheme.whiteColor,
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
            child: CacheImageWidget(
              url: imagePath,
            ),
          )),
    );
  }

  /// Builds the list of service images with delete functionality
  List<Widget> _buildServiceImageList(AddNewServiceProvider value) {
    return value.serviceImages.asMap().entries.map((e) {
      final index = e.key;
      final imagePath = e.value;

      return GestureDetector(
        onTap: () {
          // Get the current BuildContext
          final context = value.serviceNameFocus.context;
          if (context == null) return;

          // When tapped, show the image viewer with all service images
          List<String> allImages = value.serviceImages;
          List<ImageProvider> imageProviders =
              allImages.map((path) => FileImage(File(path))).toList();

          MultiImageProvider multiImageProvider =
              MultiImageProvider(imageProviders, initialIndex: index);

          showCustomImageViewerPager(
            context,
            multiImageProvider,
            doubleTapZoomable: true,
            backgroundColor: Colors.black.withAlpha(50),
            swipeDismissible: true,
            closeButtonTooltip: "Close",
            closeButtonColor: appColor(context).appTheme.whiteColor,
          );
        },
        child: AddServiceImageLayout(
          image: imagePath,
          onDelete: () => value.onRemoveServiceImage(false, index: index),
        ),
      );
    }).toList();
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
    final imageCount = value.serviceImages.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerWithTextLayout(
          title: "${language(context, appFonts.serviceImages)} ($imageCount/5)",
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
                        idServiceVersionSelected:
                            value.serviceVersionSelected!.id ?? '',
                        serviceId: value.serviceSelected!.id!,
                        isMultiSelect: true,
                        onApply: (List<String> imageSelected) {},
                      )));
            })
          : (value.serviceVersionImages.isEmpty)
              ? Text("No image",
                      style: appCss.dmDenseMedium14
                          .textColor(appColor(context).appTheme.lightText))
                  .paddingOnly(left: Insets.i5)
              : const SizedBox(),
    );

    if (value.serviceVersionImages.isNotEmpty) {
      for (int i = 0; i < value.serviceVersionImages.length; i++) {
        _listImage.add(_buildImagePreview(
            context, value.serviceVersionImages[i], value.serviceVersionImages,
            initialIndex: i));
      }
    }

    return Wrap(
      spacing: Insets.i10,
      runSpacing: Insets.i10,
      children: _listImage,
    );
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
