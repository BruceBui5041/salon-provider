import 'dart:developer';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:salon_provider/model/response/image_response.dart';
import 'package:salon_provider/providers/app_pages_provider/image_service_provider.dart';
import 'package:salon_provider/widgets/cache_image.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../config.dart';

/// A widget that displays a grid of selectable images with single or multi-select capability.
///
/// This widget allows users to select one or multiple images from a grid layout and
/// includes an apply button to confirm the selection.
class ImageSelectionLayout extends StatefulWidget {
  final bool isMultiSelect;
  final List<int>? selectedIndices;
  final Function(int)? onImageSelected;
  final Function(List<String>)? onApply;
  final List<String>? imageSelected;
  final String? imageId;
  final String serviceId;
  const ImageSelectionLayout({
    super.key,
    this.isMultiSelect = false,
    this.selectedIndices,
    this.onImageSelected,
    this.onApply,
    this.imageSelected,
    this.imageId,
    required this.serviceId,
  });

  @override
  State<ImageSelectionLayout> createState() => _ImageSelectionLayoutState();
}

class _ImageSelectionLayoutState extends State<ImageSelectionLayout> {
  List<ImageResponse> imageSelected = [];
  ImageResponse? groupValueImage;
  @override
  void initState() {
    imageSelected = [];
    initData();
    super.initState();
  }

  Future<void> initData() async {
    Provider.of<ImageServiceProvider>(context, listen: false)
        .fetchServiceById(widget.serviceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        title: language(context, appFonts.uploadImageProof),
        onTap: () => Navigator.of(context).pop(),
      ),
      body: Consumer<ImageServiceProvider>(builder: (context, value, _) {
        return Column(
          children: [
            Expanded(child: _buildImageWrap(context, value)),
            _buildApplyButton(context),
          ],
        );
      }),
    );
  }

  Widget _buildImageWrap(BuildContext context, ImageServiceProvider value) {
    // Calculate item width based on screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - (Insets.i20 * 2 + Insets.i10)) / 2;
    final itemHeight = itemWidth * 3 / 4; // 4:3 aspect ratio
    List<Widget> listImage = [];
    listImage.add(_buildAddNewImage(context));
    for (int index = 0; index < value.imageService.length; index++) {
      listImage.add(SizedBox(
        width: itemWidth,
        height: itemHeight,
        child: widget.isMultiSelect
            ? SelectableImageItemMultiSelected(
                idImage: value.imageService[index].id ?? '',
                image: value.imageService[index],
                isSelected: widget.selectedIndices?.contains(index) ?? false,
                isMultiSelect: widget.isMultiSelect,
                selectedValue: widget.selectedIndices?.isNotEmpty == true
                    ? widget.selectedIndices!.first
                    : -1,
                index: index,
                onSelected: (ImageResponse image) {
                  setState(() {
                    imageSelected.add(image);
                  });
                  log(imageSelected.length.toString());
                },
                onRemove: (ImageResponse image) {
                  setState(() {
                    imageSelected.remove(image);
                  });
                  log(imageSelected.length.toString());
                },
              )
            : SelectableImageItemSingleSelected(
                groupValue: value.groupValueImage,
                idImage: value.imageService[index].id ?? '',
                image: value.imageService[index],
                isSelected: widget.selectedIndices?.contains(index) ?? false,
                selectedValue: widget.selectedIndices?.isNotEmpty == true
                    ? widget.selectedIndices!.first
                    : -1,
                index: index,
                onSelected: (ImageResponse image) {
                  // log("imageSelected: ${image.id}");
                  // imageSelected.clear();

                  // imageSelected.add(image);
                },
              ),
      ));
    }
    return SingleChildScrollView(
        padding: const EdgeInsets.all(Insets.i20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: Insets.i10,
                  runSpacing: Insets.i10,
                  children: listImage),
            ),
          ],
        ));
  }

  Widget _buildAddNewImage(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - (Insets.i20 * 2 + Insets.i10)) / 2;
    final itemHeight = itemWidth * 3 / 4; // 4:3 aspect ratio
    return GestureDetector(
      onTap: () {
        Provider.of<ImageServiceProvider>(context, listen: false)
            .onImagePick(context, onSuccess: (XFile image) {
          Provider.of<AddNewServiceProvider>(context, listen: false)
              .uploadMainImage(image, callBack: () {
            Provider.of<AddNewServiceProvider>(context, listen: false)
                .updateServiceCraft(callBack: () {
              Provider.of<ImageServiceProvider>(context, listen: false)
                  .fetchServiceById(widget.serviceId);
            });
          });
        });
      },
      child: SizedBox(
        width: itemWidth,
        height: itemHeight,
        child: DottedBorder(
          color: appColor(context).appTheme.stroke,
          borderType: BorderType.RRect,
          radius: const Radius.circular(AppRadius.r10),
          child: Container(
            alignment: Alignment.center,
            // width: itemWidth,
            // height: itemHeight,
            decoration: BoxDecoration(
              color: appColor(context).appTheme.whiteBg,
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(eSvgAssets.addOutline),
                const VSpace(Sizes.s6),
                Text(language(context, appFonts.addNew),
                    overflow: TextOverflow.clip,
                    style: appCss.dmDenseMedium12
                        .textColor(appColor(context).appTheme.lightText))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    final theme = appColor(context).appTheme;
    var groupValueImage =
        Provider.of<ImageServiceProvider>(context, listen: false)
            .groupValueImage;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Insets.i20),
      decoration: BoxDecoration(
        color: theme.whiteBg,
        boxShadow: [
          BoxShadow(
            color: theme.darkText.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(language(context, "Please select image"),
          //     style: appCss.dmDenseMedium14
          //         .textColor(appColor(context).appTheme.darkText)),
          ButtonCommon(
            title: language(context, appFonts.apply),
            onTap: () {
              if (widget.isMultiSelect) {
                Provider.of<AddNewServiceProvider>(context, listen: false)
                    .onApplyImage(imageSelected, isMainImage: false,
                        callBack: () {
                  Navigator.of(context).pop();
                });
              } else {
                if (groupValueImage != null) {
                  Provider.of<AddNewServiceProvider>(context, listen: false)
                      .onApplyImage([groupValueImage], isMainImage: true,
                          callBack: () {
                    Navigator.of(context).pop();
                  });
                } else {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      icon: const SizedBox(),
                      backgroundColor: appColor(context).appTheme.red,
                      message: language(context, "Please select image!"),
                    ),
                  );
                  //show snackbar
                }
              }

              //
            },
          ),
        ],
      ),
    );
  }
}

/// A selectable image item that displays an image with a selection indicator.
class SelectableImageItemMultiSelected extends StatefulWidget {
  final ImageResponse image;
  final bool isSelected;
  final bool isMultiSelect;
  final int selectedValue;
  final int index;
  final String idImage;
  final Function(ImageResponse image) onSelected;
  final Function(ImageResponse image) onRemove;

  const SelectableImageItemMultiSelected({
    required this.image,
    required this.isSelected,
    required this.isMultiSelect,
    required this.selectedValue,
    required this.index,
    required this.idImage,
    required this.onSelected,
    required this.onRemove,
  });

  @override
  State<SelectableImageItemMultiSelected> createState() =>
      SelectableImageItemMultiSelectedState();
}

class SelectableImageItemMultiSelectedState
    extends State<SelectableImageItemMultiSelected> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final theme = appColor(context).appTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - (Insets.i20 * 2 + Insets.i10)) / 2;
    final itemHeight = itemWidth * 3 / 4; // 4:3 aspect ratio

    return GestureDetector(
      onLongPress: () async {
        await showImageViewer(
          context,
          NetworkImage(widget.image.url ?? ''),
          // useSafeArea: true,
          doubleTapZoomable: true,
          // barrierColor: appColor(context).appTheme.primary,
          backgroundColor: Colors.black.withOpacity(0.5),
          swipeDismissible: true,
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: ShapeDecoration(
              color: Colors.grey.shade200,
              shape: SmoothRectangleBorder(
                side: BorderSide(
                  color: widget.isSelected ? theme.primary : theme.trans,
                  width: 1,
                ),
                borderRadius: SmoothBorderRadius(
                  cornerRadius: AppRadius.r8,
                  cornerSmoothing: 1,
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.r6),
              child: CacheImageWidget(
                url: widget.image.url ?? '',
                width: itemWidth,
                height: itemHeight,
              ),
            ),
          ),
          Positioned(
            top: Insets.i8,
            right: Insets.i8,
            child: _buildSelectionIndicator(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionIndicator(BuildContext context) {
    final theme = appColor(context).appTheme;

    return Container(
      decoration: BoxDecoration(
        color: theme.whiteBg,
        shape: BoxShape.circle,
      ),
      child: CheckBoxCommon(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
          if (isSelected) {
            widget.onSelected(widget.image);
          } else {
            widget.onRemove(widget.image);
          }
        },
        isCheck: isSelected,
      ),
    );
  }
}

class SelectableImageItemSingleSelected extends StatefulWidget {
  final ImageResponse image;
  final ImageResponse? groupValue;
  final bool isSelected;
  final int selectedValue;
  final int index;
  final String idImage;
  final Function(ImageResponse image)? onSelected;
  final Function(ImageResponse image)? onRemove;

  const SelectableImageItemSingleSelected({
    super.key,
    required this.image,
    required this.isSelected,
    required this.selectedValue,
    required this.index,
    required this.idImage,
    this.onSelected,
    this.onRemove,
    required this.groupValue,
  });

  @override
  State<SelectableImageItemSingleSelected> createState() =>
      SelectableImageItemSingleSelectedState();
}

class SelectableImageItemSingleSelectedState
    extends State<SelectableImageItemSingleSelected> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final theme = appColor(context).appTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - (Insets.i20 * 2 + Insets.i10)) / 2;
    final itemHeight = itemWidth * 3 / 4; // 4:3 aspect ratio

    return Stack(
      children: [
        Container(
          decoration: ShapeDecoration(
            color: Colors.grey.shade200,
            shape: SmoothRectangleBorder(
              side: BorderSide(
                color: widget.isSelected ? theme.primary : theme.trans,
                width: 1,
              ),
              borderRadius: SmoothBorderRadius(
                cornerRadius: AppRadius.r8,
                cornerSmoothing: 1,
              ),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.r6),
            child: CacheImageWidget(
              url: widget.image.url ?? '',
              width: itemWidth,
              height: itemHeight,
            ),
          ),
        ),
        Positioned(
          top: Insets.i8,
          right: Insets.i8,
          child: _buildSelectionIndicator(context),
        ),
      ],
    );
  }

  Widget _buildSelectionIndicator(BuildContext context) {
    return Container(
      height: Insets.i20,
      width: Insets.i20,
      decoration: BoxDecoration(
        color: appColor(context).appTheme.darkText,
        shape: BoxShape.circle,
      ),
      child: Radio<ImageResponse>(
          value: widget.image,
          groupValue: widget.groupValue,
          onChanged: (val) {
            // widget.onSelected?.call(val!);
            Provider.of<ImageServiceProvider>(context, listen: false)
                .setGroupValueImage(val);
          }),
    );
  }
}
