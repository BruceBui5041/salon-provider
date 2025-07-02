import 'dart:convert';
import 'dart:io';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:salon_provider/config.dart';

// Custom image embed builder class
class CustomImageEmbedBuilder extends EmbedBuilder {
  @override
  String get key => BlockEmbed.imageType;

  @override
  Widget build(
    BuildContext context,
    EmbedContext embedContext,
  ) {
    final node = embedContext.node;
    final imageUrl = node.value.data;
    Widget imageWidget;

    if (imageUrl.startsWith('http')) {
      // Network image with loading indicator
      imageWidget = Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Container(
            width: double.infinity,
            height: 200,
            color: appColor(context).appTheme.fieldCardBg,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: appColor(context).appTheme.primary,
                    strokeWidth: 2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    language(context, appFonts.loading),
                    style: appCss.dmDenseRegular12.textColor(
                      appColor(context).appTheme.lightText,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 200,
            color: appColor(context).appTheme.fieldCardBg,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.broken_image,
                  color: appColor(context).appTheme.red,
                  size: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  language(context, appFonts.errorOccur),
                  style: appCss.dmDenseRegular12.textColor(
                    appColor(context).appTheme.lightText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      );
    } else {
      // Local image with loading indicator
      imageWidget = FutureBuilder<bool>(
        future: _checkFileExists(imageUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: double.infinity,
              height: 200,
              color: appColor(context).appTheme.fieldCardBg,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: appColor(context).appTheme.primary,
                      strokeWidth: 2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      language(context, appFonts.loading),
                      style: appCss.dmDenseRegular12.textColor(
                        appColor(context).appTheme.lightText,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (snapshot.hasError || !snapshot.data!) {
            return Container(
              width: double.infinity,
              height: 200,
              color: appColor(context).appTheme.fieldCardBg,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.broken_image,
                    color: appColor(context).appTheme.red,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    language(context, appFonts.errorOccur),
                    style: appCss.dmDenseRegular12.textColor(
                      appColor(context).appTheme.lightText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return Image.file(
            File(imageUrl),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: 200,
                color: appColor(context).appTheme.fieldCardBg,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.broken_image,
                      color: appColor(context).appTheme.red,
                      size: 40,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      language(context, appFonts.errorOccur),
                      style: appCss.dmDenseRegular12.textColor(
                        appColor(context).appTheme.lightText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Insets.i8),
      child: GestureDetector(
        onTap: () => _showCustomImageViewerPager(context, imageUrl),
        child: imageWidget,
      ),
    );
  }

  Future<bool> _checkFileExists(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  void _showCustomImageViewerPager(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageViewerPage(imageUrl: imageUrl),
      ),
    );
  }

  @override
  String toPlainText(Embed node) {
    return '[Image]';
  }
}

/// Full screen image viewer page
class ImageViewerPage extends StatelessWidget {
  final String imageUrl;

  const ImageViewerPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: imageUrl.startsWith('http')
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 300,
                      color: Colors.grey[800],
                      child: const Icon(Icons.broken_image,
                          color: Colors.red, size: 50),
                    );
                  },
                )
              : Image.file(
                  File(imageUrl),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 300,
                      color: Colors.grey[800],
                      child: const Icon(Icons.broken_image,
                          color: Colors.red, size: 50),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

/// A full screen dedicated to rich text editing
class HtmlEditorScreen extends StatefulWidget {
  const HtmlEditorScreen({
    super.key,
  });

  @override
  State<HtmlEditorScreen> createState() => _HtmlEditorScreenState();
}

class _HtmlEditorScreenState extends State<HtmlEditorScreen> {
  late QuillController _controller;
  bool _isSaving = false;
  String _initialContent = '';
  bool _isImageProcessing = false;

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();

    // Get the initial content from the provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<AddNewServiceProvider>(context, listen: false);
      _initialContent = provider.featuredPoints.text;

      if (_initialContent.isNotEmpty) {
        try {
          // Try to parse as Quill Delta JSON
          final delta =
              _initialContent.startsWith('[') || _initialContent.startsWith('{')
                  ? jsonDecode(_initialContent)
                  : null;

          if (delta != null) {
            _controller.document = Document.fromJson(delta);
          } else {
            // If not valid JSON, insert as plain text or HTML
            _controller.document.insert(0, _initialContent);
          }
        } catch (e) {
          // If parsing fails, insert as plain text
          _controller.document.insert(0, _initialContent);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to show image source selection dialog
  Future<void> _showImageSourceDialog() async {
    if (_isImageProcessing) return; // Prevent multiple dialogs

    final provider = Provider.of<AddNewServiceProvider>(context, listen: false);
    final serviceImages = provider.listAllImage;

    if (serviceImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(language(context, appFonts.noImagesAvailable)),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  language(context, appFonts.selectImage),
                  style: appCss.dmDenseMedium16.textColor(
                    appColor(context).appTheme.darkText,
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: serviceImages.map((image) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            _insertImageFromUrl(image.url ?? "");
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appColor(context).appTheme.stroke,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                image.url ?? "",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.broken_image,
                                        color: Colors.red),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    language(context, appFonts.cancel),
                    style: appCss.dmDenseMedium14.textColor(
                      appColor(context).appTheme.darkText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to insert image from URL
  void _insertImageFromUrl(String url) {
    if (url.isEmpty) return;

    try {
      // Add a line break before the image
      _controller.document.insert(_controller.selection.baseOffset, '\n');

      // Insert the image at current position
      final index = _controller.selection.baseOffset;
      _controller.document.insert(index, BlockEmbed.image(url));

      // Add a line break after the image
      _controller.document.insert(index + 1, '\n');

      // Move cursor after the image and line break
      _controller.updateSelection(
        TextSelection.collapsed(offset: index + 2),
        ChangeSource.local,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to insert image: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isSaving && !_isImageProcessing;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarCommon(
          title: language(context, appFonts.featuredPoints),
          actions: [
            TextButton(
              onPressed: (_isSaving || _isImageProcessing)
                  ? null
                  : () async {
                      setState(() {
                        _isSaving = true;
                      });

                      try {
                        final json =
                            jsonEncode(_controller.document.toDelta().toJson());
                        final provider = Provider.of<AddNewServiceProvider>(
                            context,
                            listen: false);
                        provider.featuredPoints.text = json;

                        // Only call update API if we're editing an existing service
                        if (provider.serviceSelected != null &&
                            provider.serviceVersionSelected != null) {
                          await provider.updateServiceCraft(
                            callBack: () {
                              if (mounted) {
                                _showToast(
                                    context,
                                    language(
                                        context, 'Changes saved successfully'));
                                Navigator.pop(context);
                              }
                            },
                          );
                        } else {
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        }
                      } catch (e) {
                        // Show error message if still mounted
                        if (mounted) {
                          _showToast(
                              context, 'Failed to save: ${e.toString()}');
                          setState(() {
                            _isSaving = false;
                          });
                        }
                      }
                    },
              child: _isSaving || _isImageProcessing
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: appColor(context).appTheme.primary,
                      ),
                    )
                  : Text(
                      language(context, appFonts.done),
                      style: appCss.dmDenseMedium14.textColor(
                        appColor(context).appTheme.primary,
                      ),
                    ),
            ),
          ],
          onTap: (_isSaving || _isImageProcessing)
              ? null
              : () => Navigator.pop(context),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: Row(
                children: [
                  // Left vertical toolbar
                  Container(
                    width: 50,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: appColor(context).appTheme.fieldCardBg,
                      border: Border(
                        right: BorderSide(
                          color: appColor(context).appTheme.stroke,
                          width: 1,
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Theme(
                        data: ThemeData(
                          // Force light theme for the vertical toolbar
                          brightness: Brightness.light,
                          scaffoldBackgroundColor:
                              appColor(context).appTheme.whiteBg,
                          cardColor: appColor(context).appTheme.whiteBg,
                          dialogBackgroundColor:
                              appColor(context).appTheme.whiteBg,
                          canvasColor: appColor(context).appTheme.whiteBg,
                          // Text colors
                          textTheme: Typography.blackMountainView.apply(
                            bodyColor: appColor(context).appTheme.darkText,
                            displayColor: appColor(context).appTheme.darkText,
                          ),
                          // Icon theme
                          iconTheme: IconThemeData(
                            color: appColor(context).appTheme.darkText,
                            size: 20,
                          ),
                          // Dropdown styling
                          popupMenuTheme: PopupMenuThemeData(
                            color: appColor(context).appTheme.whiteBg,
                            textStyle: TextStyle(
                                color: appColor(context).appTheme.darkText,
                                fontSize: 14),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            QuillToolbarHistoryButton(
                              isUndo: true,
                              controller: _controller,
                            ),
                            QuillToolbarHistoryButton(
                              isUndo: false,
                              controller: _controller,
                            ),
                            Divider(
                                height: 2,
                                color: appColor(context).appTheme.stroke),
                            QuillToolbarToggleStyleButton(
                              options:
                                  const QuillToolbarToggleStyleButtonOptions(),
                              controller: _controller,
                              attribute: Attribute.bold,
                            ),
                            QuillToolbarToggleStyleButton(
                              options:
                                  const QuillToolbarToggleStyleButtonOptions(),
                              controller: _controller,
                              attribute: Attribute.italic,
                            ),
                            QuillToolbarToggleStyleButton(
                              controller: _controller,
                              attribute: Attribute.underline,
                            ),
                            QuillToolbarClearFormatButton(
                              controller: _controller,
                            ),
                            Divider(
                                height: 2,
                                color: appColor(context).appTheme.stroke),
                            // Alignment tools
                            QuillToolbarToggleStyleButton(
                              controller: _controller,
                              attribute: Attribute.leftAlignment,
                            ),
                            QuillToolbarToggleStyleButton(
                              controller: _controller,
                              attribute: Attribute.centerAlignment,
                            ),
                            QuillToolbarToggleStyleButton(
                              controller: _controller,
                              attribute: Attribute.rightAlignment,
                            ),
                            QuillToolbarToggleStyleButton(
                              controller: _controller,
                              attribute: Attribute.justifyAlignment,
                            ),
                            Divider(
                                height: 2,
                                color: appColor(context).appTheme.stroke),
                            IconButton(
                              icon: Icon(
                                Icons.image,
                                color: appColor(context).appTheme.darkText,
                                size: 20,
                              ),
                              tooltip: 'Insert Image',
                              onPressed: _isImageProcessing
                                  ? null
                                  : _showImageSourceDialog,
                            ),
                            Divider(
                                height: 2,
                                color: appColor(context).appTheme.stroke),
                            QuillToolbarColorButton(
                              controller: _controller,
                              isBackground: false,
                            ),
                            QuillToolbarColorButton(
                              controller: _controller,
                              isBackground: true,
                            ),
                            Divider(
                                height: 2,
                                color: appColor(context).appTheme.stroke),
                            QuillToolbarToggleCheckListButton(
                              controller: _controller,
                            ),
                            QuillToolbarToggleStyleButton(
                              controller: _controller,
                              attribute: Attribute.ol,
                            ),
                            QuillToolbarToggleStyleButton(
                              controller: _controller,
                              attribute: Attribute.ul,
                            ),
                            Divider(
                                height: 2,
                                color: appColor(context).appTheme.stroke),
                            QuillToolbarToggleStyleButton(
                              controller: _controller,
                              attribute: Attribute.inlineCode,
                            ),
                            QuillToolbarToggleStyleButton(
                              controller: _controller,
                              attribute: Attribute.blockQuote,
                            ),
                            Divider(
                                height: 2,
                                color: appColor(context).appTheme.stroke),
                            QuillToolbarIndentButton(
                              controller: _controller,
                              isIncrease: true,
                            ),
                            QuillToolbarIndentButton(
                              controller: _controller,
                              isIncrease: false,
                            ),
                            Divider(
                                height: 2,
                                color: appColor(context).appTheme.stroke),
                            QuillToolbarLinkStyleButton(
                                controller: _controller),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Main content area (horizontal toolbar + editor)
                  Expanded(
                    child: Column(
                      children: [
                        // Top horizontal toolbar
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: appColor(context).appTheme.fieldCardBg,
                            border: Border(
                              bottom: BorderSide(
                                color: appColor(context).appTheme.stroke,
                                width: 1,
                              ),
                            ),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Theme(
                              data: ThemeData(
                                // Force light theme for the horizontal toolbar
                                brightness: Brightness.light,
                                scaffoldBackgroundColor:
                                    appColor(context).appTheme.whiteBg,
                                cardColor: appColor(context).appTheme.whiteBg,
                                dialogBackgroundColor:
                                    appColor(context).appTheme.whiteBg,
                                canvasColor: appColor(context).appTheme.whiteBg,
                                // Text colors
                                textTheme: Typography.blackMountainView.apply(
                                  bodyColor:
                                      appColor(context).appTheme.darkText,
                                  displayColor:
                                      appColor(context).appTheme.darkText,
                                ),
                                // Icon theme
                                iconTheme: IconThemeData(
                                  color: appColor(context).appTheme.darkText,
                                  size: 20,
                                ),
                                // Dropdown styling
                                popupMenuTheme: PopupMenuThemeData(
                                  color: appColor(context).appTheme.whiteBg,
                                  textStyle: TextStyle(
                                      color:
                                          appColor(context).appTheme.darkText,
                                      fontSize: 14),
                                ),
                                // Dropdown button theme
                                buttonTheme: ButtonThemeData(
                                  textTheme: ButtonTextTheme.normal,
                                  buttonColor:
                                      appColor(context).appTheme.whiteBg,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: Row(
                                  children: [
                                    QuillToolbarFontFamilyButton(
                                      controller: _controller,
                                    ),
                                    const SizedBox(width: 8),
                                    QuillToolbarFontSizeButton(
                                      controller: _controller,
                                    ),
                                    const SizedBox(width: 8),
                                    QuillToolbarSelectHeaderStyleDropdownButton(
                                      controller: _controller,
                                    ),
                                    const SizedBox(width: 8),
                                    QuillToolbarSelectLineHeightStyleDropdownButton(
                                      controller: _controller,
                                    ),
                                    // Removed alignment button as it's now in the vertical toolbar
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Editor area
                        Expanded(
                          child: Container(
                            color: appColor(context).appTheme.whiteBg,
                            child: QuillEditor.basic(
                              controller: _controller,
                              config: QuillEditorConfig(
                                placeholder:
                                    language(context, appFonts.writeANote),
                                padding: const EdgeInsets.all(16),
                                autoFocus: false,
                                scrollable: true,
                                expands: false,
                                scrollPhysics: const ClampingScrollPhysics(),
                                embedBuilders: [
                                  CustomImageEmbedBuilder(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Loading overlay
            if (_isImageProcessing)
              Container(
                color: appColor(context).appTheme.whiteBg.withAlpha(30),
                child: Center(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            color: appColor(context).appTheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            language(context, "processingImage"),
                            style: appCss.dmDenseMedium14.textColor(
                              appColor(context).appTheme.darkText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: appColor(context).appTheme.primary,
      ),
    );
  }
}
