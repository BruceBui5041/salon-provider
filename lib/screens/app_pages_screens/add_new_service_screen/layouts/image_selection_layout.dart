import 'dart:developer';

import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:salon_provider/model/response/image_response.dart';
import 'package:salon_provider/widgets/cache_image.dart';

import '../../../../config.dart';

/// A widget that displays a grid of selectable images with single or multi-select capability.
///
/// This widget allows users to select one or multiple images from a grid layout and
/// includes an apply button to confirm the selection.
class ImageSelectionLayout extends StatefulWidget {
  final List<ImageResponse> images;
  final bool isMultiSelect;
  final List<int>? selectedIndices;
  final Function(int)? onImageSelected;
  final Function(List<String>)? onApply;
  final List<String>? imageSelected;
  final String? imageId;
  const ImageSelectionLayout({
    super.key,
    required this.images,
    this.isMultiSelect = false,
    this.selectedIndices,
    this.onImageSelected,
    this.onApply,
    this.imageSelected,
    this.imageId,
  });

  @override
  State<ImageSelectionLayout> createState() => _ImageSelectionLayoutState();
}

class _ImageSelectionLayoutState extends State<ImageSelectionLayout> {
  List<ImageResponse> imageSelected = [];

  @override
  void initState() {
    imageSelected = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(language(context, appFonts.uploadImageProof),
            style: appCss.dmDenseMedium16
                .textColor(appColor(context).appTheme.darkText)),
      ),
      body: Column(
        children: [
          Expanded(child: _buildImageWrap(context)),
          _buildApplyButton(context),
        ],
      ),
    );
  }

  Widget _buildImageWrap(BuildContext context) {
    // Calculate item width based on screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - (Insets.i20 * 2 + Insets.i10)) / 2;
    final itemHeight = itemWidth * 3 / 4; // 4:3 aspect ratio

    return SingleChildScrollView(
      padding: const EdgeInsets.all(Insets.i20),
      child: Wrap(
        spacing: Insets.i10,
        runSpacing: 4 / 3,
        children: List.generate(
          widget.images.length,
          (index) => SizedBox(
            width: itemWidth,
            height: itemHeight,
            child: _SelectableImageItem(
              idImage: widget.images[index].id ?? '',
              image: widget.images[index],
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    final theme = appColor(context).appTheme;

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
      child: ButtonCommon(
        title: language(context, appFonts.apply),
        onTap: () {
          Provider.of<AddNewServiceProvider>(context, listen: false)
              .onApplyImage(imageSelected, callBack: () {
            Navigator.of(context).pop();
          });
          //
        },
      ),
    );
  }
}

/// A selectable image item that displays an image with a selection indicator.
class _SelectableImageItem extends StatefulWidget {
  final ImageResponse image;
  final bool isSelected;
  final bool isMultiSelect;
  final int selectedValue;
  final int index;
  final String idImage;
  final Function(ImageResponse image) onSelected;
  final Function(ImageResponse image) onRemove;

  const _SelectableImageItem({
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
  State<_SelectableImageItem> createState() => _SelectableImageItemState();
}

class _SelectableImageItemState extends State<_SelectableImageItem> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final theme = appColor(context).appTheme;

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
            child: CacheImageWidget(url: widget.image.url ?? ''),
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
      // child: isMultiSelect
      //     ? Checkbox(
      //         value: isSelected,
      //         onChanged: (_) => onSelected(index),
      //         activeColor: theme.primary,
      //       )
      //     : Radio<int>(
      //         value: index,
      //         groupValue: selectedValue,
      //         onChanged: (_) => onSelected(index),
      //         activeColor: theme.primary,
      //       ),
    );
  }
}
