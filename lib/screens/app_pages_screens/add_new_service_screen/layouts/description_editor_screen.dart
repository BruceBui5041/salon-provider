import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/providers/app_pages_provider/add_new_service_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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
      // Network image
      imageWidget = Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey[300],
            child: Icon(Icons.broken_image, color: Colors.red),
          );
        },
      );
    } else {
      // Local image
      try {
        imageWidget = Image.file(
          File(imageUrl),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[300],
              child: Icon(Icons.broken_image, color: Colors.red),
            );
          },
        );
      } catch (e) {
        imageWidget = Container(
          width: double.infinity,
          height: 200,
          color: Colors.grey[300],
          child: Icon(Icons.broken_image, color: Colors.red),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Insets.i8),
      child: imageWidget,
    );
  }

  @override
  String toPlainText(Embed node) {
    return '[Image]';
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
  final ImagePicker _imagePicker = ImagePicker();
  bool _isImageProcessing = false;
  final TextEditingController _imageUrlController = TextEditingController();

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
    _imageUrlController.dispose();
    super.dispose();
  }

  // Function to show image source selection dialog
  Future<void> _showImageSourceDialog() async {
    if (_isImageProcessing) return; // Prevent multiple dialogs

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            language(context, "chooseImageSource"),
            style: appCss.dmDenseMedium16.textColor(
              appColor(context).appTheme.darkText,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.link,
                    color: appColor(context).appTheme.primary,
                  ),
                  title: Text(
                    language(context, "imageUrl"),
                    style: appCss.dmDenseMedium14.textColor(
                      appColor(context).appTheme.darkText,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _showImageUrlDialog();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo_library,
                    color: appColor(context).appTheme.primary,
                  ),
                  title: Text(
                    language(context, "gallery"),
                    style: appCss.dmDenseMedium14.textColor(
                      appColor(context).appTheme.darkText,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickAndInsertImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo_camera,
                    color: appColor(context).appTheme.primary,
                  ),
                  title: Text(
                    language(context, "camera"),
                    style: appCss.dmDenseMedium14.textColor(
                      appColor(context).appTheme.darkText,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickAndInsertImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to show image URL input dialog
  Future<void> _showImageUrlDialog() async {
    _imageUrlController.clear();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            language(context, "enterImageUrl"),
            style: appCss.dmDenseMedium16.textColor(
              appColor(context).appTheme.darkText,
            ),
          ),
          content: TextField(
            controller: _imageUrlController,
            decoration: InputDecoration(
              hintText: 'https://example.com/image.jpg',
              hintStyle: appCss.dmDenseMedium14.textColor(
                appColor(context).appTheme.lightText,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: appColor(context).appTheme.stroke,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: appColor(context).appTheme.primary,
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                language(context, "cancel"),
                style: appCss.dmDenseMedium14.textColor(
                  appColor(context).appTheme.darkText,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _insertImageFromUrl(_imageUrlController.text.trim());
              },
              child: Text(
                language(context, "insert"),
                style: appCss.dmDenseMedium14.textColor(
                  appColor(context).appTheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to insert image from URL
  void _insertImageFromUrl(String url) {
    if (url.isEmpty) return;

    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://' + url;
    }

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

  // Function to pick and insert an image
  Future<void> _pickAndInsertImage(ImageSource source) async {
    if (_isImageProcessing) return; // Prevent multiple image selections

    setState(() {
      _isImageProcessing = true;
    });

    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80, // Reduce image quality to save storage
        maxWidth: 1000, // Limit max width
      );

      // Check if widget is still mounted before proceeding
      if (!mounted) return;

      if (image == null) {
        setState(() {
          _isImageProcessing = false;
        });
        return;
      }

      try {
        // Add a line break before the image
        _controller.document.insert(_controller.selection.baseOffset, '\n');

        // Insert the image at current position
        final index = _controller.selection.baseOffset;
        _controller.document.insert(index, BlockEmbed.image(image.path));

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

      // Reset processing flag
      if (mounted) {
        setState(() {
          _isImageProcessing = false;
        });
      }
    } catch (e) {
      // Check if widget is still mounted before showing error
      if (mounted) {
        setState(() {
          _isImageProcessing = false;
        });

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
