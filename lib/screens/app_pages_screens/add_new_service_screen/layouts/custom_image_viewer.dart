import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

/// Shows a custom image viewer with sliding indicators and tap outside to close
Future<void> showCustomImageViewerPager(
  BuildContext context,
  EasyImageProvider imageProvider, {
  int initialIndex = 0,
  bool doubleTapZoomable = false,
  Color? backgroundColor,
  bool swipeDismissible = false,
  String? closeButtonTooltip,
  Color? closeButtonColor,
  Function(int)? onPageChanged,
  Function(int)? onViewerDismissed,
  bool infinitelyScrollable = false,
}) async {
  // Show the standard image viewer with customized parameters
  await showImageViewerPager(
    context,
    imageProvider,
    onViewerDismissed: onViewerDismissed,
    doubleTapZoomable: doubleTapZoomable,
    swipeDismissible: swipeDismissible,
    infinitelyScrollable: infinitelyScrollable,
    backgroundColor: backgroundColor ?? Colors.black.withOpacity(0.85),
    closeButtonColor: closeButtonColor ?? Colors.white,
    closeButtonTooltip: closeButtonTooltip ?? "Close",
    useSafeArea: false,
  );
}
