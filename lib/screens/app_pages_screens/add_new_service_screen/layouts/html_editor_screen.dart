import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/providers/app_pages_provider/add_new_service_provider.dart';

/// A full screen dedicated to HTML editing
class HtmlEditorScreen extends StatefulWidget {
  const HtmlEditorScreen({
    super.key,
  });

  @override
  State<HtmlEditorScreen> createState() => _HtmlEditorScreenState();
}

class _HtmlEditorScreenState extends State<HtmlEditorScreen> {
  late HtmlEditorController controller;
  bool _isSaving = false;
  String _initialContent = '';
  String _activeFormat = 'p'; // Default format is paragraph
  String _activeFont = 'Arial, sans-serif'; // Default font
  DateTime? _lastManualFontChange; // Track when font was last manually changed

  final List<String> _availableFonts = [
    'Arial, sans-serif',
    'Times New Roman, serif',
    'Courier New, monospace',
    'Georgia, serif',
    'Helvetica, sans-serif',
    'Impact, sans-serif',
    'Tahoma, sans-serif',
    'Trebuchet MS, sans-serif',
    'Verdana, sans-serif',
  ];

  final Map<String, bool> _activeFormats = {
    'bold': false,
    'italic': false,
    'underline': false,
    'insertUnorderedList': false,
    'insertOrderedList': false,
    'justifyLeft': false,
    'justifyCenter': false,
    'justifyRight': false,
  };

  @override
  void initState() {
    super.initState();
    controller = HtmlEditorController();

    // Get the initial content from the provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<AddNewServiceProvider>(context, listen: false);
      _initialContent = provider.featuredPoints.text;
      controller.setText(_initialContent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isSaving;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarCommon(
          title: language(context, appFonts.featuredPoints),
          actions: [
            TextButton(
              onPressed: _isSaving
                  ? null
                  : () async {
                      setState(() {
                        _isSaving = true;
                      });

                      try {
                        final html = await controller.getText();
                        final provider = Provider.of<AddNewServiceProvider>(
                            context,
                            listen: false);
                        provider.featuredPoints.text = html;

                        // Only call update API if we're editing an existing service
                        if (provider.serviceSelected != null &&
                            provider.serviceVersionSelected != null) {
                          await provider.updateServiceCraft(
                            callBack: () {
                              _showToast(
                                  context,
                                  language(
                                      context, 'Changes saved successfully'));
                              Navigator.pop(context);
                            },
                          );
                        } else {
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        // Show error message
                        _showToast(context, 'Failed to save: ${e.toString()}');

                        setState(() {
                          _isSaving = false;
                        });
                      }
                    },
              child: _isSaving
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
          onTap: _isSaving ? null : () => Navigator.pop(context),
        ),
        body: Row(
          children: [
            // Vertical toolbar
            Container(
              width: 60,
              color: appColor(context).appTheme.fieldCardBg,
              child: Column(
                children: [
                  _buildToolbarButton(Icons.format_bold, 'bold',
                      () => controller.execCommand('bold')),
                  _buildToolbarButton(Icons.format_italic, 'italic',
                      () => controller.execCommand('italic')),
                  _buildToolbarButton(Icons.format_underlined, 'underline',
                      () => controller.execCommand('underline')),
                  _buildToolbarButton(
                      Icons.format_list_bulleted,
                      'insertUnorderedList',
                      () => controller.execCommand('insertUnorderedList')),
                  _buildToolbarButton(
                      Icons.format_list_numbered,
                      'insertOrderedList',
                      () => controller.execCommand('insertOrderedList')),
                  _buildToolbarButton(Icons.format_align_left, 'justifyLeft',
                      () => controller.execCommand('justifyLeft')),
                  _buildToolbarButton(
                      Icons.format_align_center,
                      'justifyCenter',
                      () => controller.execCommand('justifyCenter')),
                  _buildToolbarButton(Icons.format_align_right, 'justifyRight',
                      () => controller.execCommand('justifyRight')),
                  _buildToolbarButton(Icons.link, 'link', () => _insertLink()),
                  _buildToolbarButton(
                      Icons.image, 'image', () => _insertImage()),
                ],
              ),
            ),
            // HTML Editor
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Insets.i8),
                child: Column(
                  children: [
                    // Horizontal formatting toolbar
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: appColor(context).appTheme.fieldCardBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          // Text format dropdown
                          Expanded(
                            flex: 1,
                            child: _buildFormatDropdown(context),
                          ),
                          const SizedBox(width: 8),
                          // Font family dropdown
                          Expanded(
                            flex: 1,
                            child: _buildFontDropdown(context),
                          ),
                          // Add more horizontal toolbar items here if needed
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Editor
                    Expanded(
                      child: HtmlEditor(
                        controller: controller,
                        htmlEditorOptions: HtmlEditorOptions(
                          hint: language(context, appFonts.writeANote),
                          initialText: _initialContent,
                          shouldEnsureVisible: false,
                          autoAdjustHeight: false,
                          adjustHeightForKeyboard: false,
                          androidUseHybridComposition: true,
                          spellCheck: false,
                        ),
                        htmlToolbarOptions: HtmlToolbarOptions(
                          toolbarType: ToolbarType.nativeGrid,
                          defaultToolbarButtons: [],
                          toolbarPosition: ToolbarPosition.custom,
                        ),
                        otherOptions: OtherOptions(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                          ),
                        ),
                        callbacks: Callbacks(
                          onInit: () {
                            controller.setText(_initialContent);
                          },
                          onFocus: () {
                            _checkActiveFormats();
                          },
                          onBlur: () {
                            _checkActiveFormats();
                          },
                          onKeyUp: (keyCode) {
                            _checkActiveFormats();
                          },
                          onKeyDown: (keyCode) {
                            _checkActiveFormats();
                          },
                          onMouseUp: () {
                            _checkActiveFormats();
                          },
                          onChangeContent: (String? changed) {
                            _checkActiveFormats();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbarButton(
      IconData icon, String formatCommand, VoidCallback onPressed) {
    final bool isActive = _activeFormats[formatCommand] ?? false;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: IconButton(
        icon: Icon(
          icon,
          color: isActive
              ? appColor(context).appTheme.primary
              : appColor(context).appTheme.darkText,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            // Toggle state for simple formatting options
            if (['bold', 'italic', 'underline'].contains(formatCommand)) {
              _activeFormats[formatCommand] = !isActive;
            }

            // For alignment options, only one can be active at a time
            if (['justifyLeft', 'justifyCenter', 'justifyRight']
                .contains(formatCommand)) {
              _activeFormats['justifyLeft'] =
                  formatCommand == 'justifyLeft' ? true : false;
              _activeFormats['justifyCenter'] =
                  formatCommand == 'justifyCenter' ? true : false;
              _activeFormats['justifyRight'] =
                  formatCommand == 'justifyRight' ? true : false;
            }

            // For list options, toggle the specific list type
            if (['insertUnorderedList', 'insertOrderedList']
                .contains(formatCommand)) {
              _activeFormats[formatCommand] = !isActive;
            }
          });

          onPressed();
        },
        style: IconButton.styleFrom(
          backgroundColor: isActive
              ? appColor(context).appTheme.primary.withOpacity(0.1)
              : appColor(context).appTheme.whiteBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  void _insertLink() {
    showDialog(
      context: context,
      builder: (context) {
        final urlController = TextEditingController();
        final textController = TextEditingController();

        return AlertDialog(
          title: Text('Insert Link'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: 'Link Text',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: urlController,
                decoration: InputDecoration(
                  labelText: 'URL',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (urlController.text.isNotEmpty &&
                    textController.text.isNotEmpty) {
                  controller.insertHtml(
                      '<a href="${urlController.text}">${textController.text}</a>');
                }
                Navigator.pop(context);
              },
              child: Text('Insert'),
            ),
          ],
        );
      },
    );
  }

  /// Updates UI to reflect active formats by checking the current selection state
  void _checkActiveFormats() async {
    try {
      // Use JavaScript to check the current formatting state
      String jsScript = '''
        (function() {
          var formats = {
            bold: document.queryCommandState('bold'),
            italic: document.queryCommandState('italic'),
            underline: document.queryCommandState('underline'),
            insertUnorderedList: document.queryCommandState('insertUnorderedList'),
            insertOrderedList: document.queryCommandState('insertOrderedList'),
            justifyLeft: document.queryCommandState('justifyLeft'),
            justifyCenter: document.queryCommandState('justifyCenter'),
            justifyRight: document.queryCommandState('justifyRight')
          };
          
          // Get the current block format
          var formatBlock = '';
          var fontName = '';
          var node = window.getSelection().focusNode;
          while (node && node.nodeType !== 1) {
            node = node.parentNode;
          }
          if (node) {
            var tagName = node.tagName.toLowerCase();
            if (['h1', 'h2', 'h3', 'h4', 'blockquote', 'pre', 'p'].includes(tagName)) {
              formatBlock = tagName;
            }
            
            // Get computed font family
            var computedStyle = window.getComputedStyle(node);
            fontName = computedStyle.fontFamily || document.queryCommandValue('fontName');
          }
          
          formats.formatBlock = formatBlock;
          formats.fontName = fontName;
          return JSON.stringify(formats);
        })()
      ''';

      // Execute JavaScript and get result
      final result = await controller.editorController
          ?.evaluateJavascript(source: jsScript);

      if (result != null && result.isNotEmpty) {
        try {
          // Parse result and update state
          final Map<String, dynamic> formats = jsonDecode(result);

          if (mounted) {
            setState(() {
              formats.forEach((key, value) {
                if (_activeFormats.containsKey(key)) {
                  _activeFormats[key] = value == true;
                }
              });

              // Update active format
              if (formats.containsKey('formatBlock') &&
                  formats['formatBlock'] != null &&
                  formats['formatBlock'].isNotEmpty) {
                _activeFormat = formats['formatBlock'];
              }

              // Update active font only if it wasn't manually changed or if we detect a different font in the selection
              if (formats.containsKey('fontName') &&
                  formats['fontName'] != null &&
                  formats['fontName'].isNotEmpty) {
                String detectedFont = formats['fontName'];

                // If font was manually changed recently, don't override it
                bool canUpdateFont = _lastManualFontChange == null ||
                    DateTime.now().difference(_lastManualFontChange!) >
                        Duration(seconds: 2);

                if (canUpdateFont) {
                  // Find the closest matching font from our available fonts
                  bool fontFound = false;
                  for (String font in _availableFonts) {
                    if (detectedFont
                        .toLowerCase()
                        .contains(font.split(',')[0].toLowerCase())) {
                      if (_activeFont != font) {
                        _activeFont = font;
                      }
                      fontFound = true;
                      break;
                    }
                  }
                  // If no match found and font wasn't manually changed, use default
                  if (!fontFound && _lastManualFontChange == null) {
                    _activeFont = _availableFonts[0];
                  }
                }
              }
            });
          }
        } catch (e) {
          // JSON parsing error, ignore
        }
      }
    } catch (e) {
      // Ignore JavaScript execution errors
    }
  }

  void _insertImage() {
    showDialog(
      context: context,
      builder: (context) {
        final urlController = TextEditingController();
        final altController = TextEditingController();

        return AlertDialog(
          title: Text('Insert Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: urlController,
                decoration: InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: altController,
                decoration: InputDecoration(
                  labelText: 'Alt Text',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (urlController.text.isNotEmpty) {
                  controller.insertHtml(
                      '<img src="${urlController.text}" alt="${altController.text}" style="max-width: 100%; height: auto;">');
                }
                Navigator.pop(context);
              },
              child: Text('Insert'),
            ),
          ],
        );
      },
    );
  }

  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Builds a button for the horizontal text style toolbar
  Widget _buildTextStyleButton(
      BuildContext context, String label, VoidCallback onPressed) {
    // Determine if this button is active
    bool isActive = false;
    String formatTag = 'p'; // Default

    switch (label) {
      case 'Normal':
        formatTag = 'p';
        break;
      case 'H1':
        formatTag = 'h1';
        break;
      case 'H2':
        formatTag = 'h2';
        break;
      case 'H3':
        formatTag = 'h3';
        break;
      case 'H4':
        formatTag = 'h4';
        break;
      case 'Quote':
        formatTag = 'blockquote';
        break;
      case 'Code':
        formatTag = 'pre';
        break;
    }

    isActive = _activeFormat == formatTag;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        onPressed: () {
          onPressed();
          setState(() {
            _activeFormat = formatTag;
          });
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          backgroundColor: isActive
              ? appColor(context).appTheme.primary.withOpacity(0.1)
              : appColor(context).appTheme.whiteBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              color: isActive
                  ? appColor(context).appTheme.primary
                  : appColor(context).appTheme.lightText.withOpacity(0.3),
            ),
          ),
        ),
        child: Text(
          label,
          style: appCss.dmDenseMedium14.textColor(
            isActive
                ? appColor(context).appTheme.primary
                : appColor(context).appTheme.darkText,
          ),
        ),
      ),
    );
  }

  Widget _buildFormatDropdown(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 36),
      decoration: BoxDecoration(
        color: appColor(context).appTheme.whiteBg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: appColor(context).appTheme.lightText.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Format:',
            style: appCss.dmDenseMedium12.textColor(
              appColor(context).appTheme.lightText,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _activeFormat,
                selectedItemBuilder: (BuildContext context) {
                  return ['p', 'h1', 'h2', 'h3', 'h4', 'blockquote', 'pre']
                      .map<Widget>((String value) {
                    String label = _getFormatLabel(value);
                    return Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        label,
                        style: _getFormatStyle(
                            value, appColor(context).appTheme.darkText),
                      ),
                    );
                  }).toList();
                },
                icon: Icon(Icons.arrow_drop_down,
                    color: appColor(context).appTheme.darkText, size: 20),
                elevation: 8,
                isDense: true,
                isExpanded: true,
                borderRadius: BorderRadius.circular(8),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _activeFormat = newValue;
                    });
                    controller.execCommand('formatBlock', argument: newValue);
                  }
                },
                items: [
                  _buildDropdownItem('p', 'Normal'),
                  _buildDropdownItem('h1', 'Heading 1'),
                  _buildDropdownItem('h2', 'Heading 2'),
                  _buildDropdownItem('h3', 'Heading 3'),
                  _buildDropdownItem('h4', 'Heading 4'),
                  _buildDropdownItem('blockquote', 'Quote'),
                  _buildDropdownItem('pre', 'Code'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> _buildDropdownItem(String value, String label) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        label,
        style: value.startsWith('h')
            ? TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: value == 'h1'
                    ? 18
                    : value == 'h2'
                        ? 16
                        : value == 'h3'
                            ? 14
                            : 12,
              )
            : value == 'blockquote'
                ? const TextStyle(fontStyle: FontStyle.italic)
                : value == 'pre'
                    ? const TextStyle(fontFamily: 'monospace')
                    : null,
      ),
    );
  }

  Widget _buildFontDropdown(BuildContext context) {
    // Make sure the active font is one of the available options
    if (!_availableFonts.contains(_activeFont)) {
      _activeFont =
          _availableFonts[0]; // Default to first font if font not found
    }

    return Container(
      constraints: const BoxConstraints(minHeight: 36),
      decoration: BoxDecoration(
        color: appColor(context).appTheme.whiteBg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: appColor(context).appTheme.lightText.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Font:',
            style: appCss.dmDenseMedium12.textColor(
              appColor(context).appTheme.lightText,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                key: ValueKey(_activeFont),
                value: _activeFont,
                selectedItemBuilder: (BuildContext context) {
                  return _availableFonts.map<Widget>((String font) {
                    String displayName = font.split(',')[0].trim();
                    String fontFamily = _getFontFamily(displayName);
                    return Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        displayName,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontWeight: displayName == 'Impact'
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: appColor(context).appTheme.darkText,
                        ),
                      ),
                    );
                  }).toList();
                },
                icon: Icon(Icons.arrow_drop_down,
                    color: appColor(context).appTheme.darkText, size: 20),
                elevation: 8,
                isDense: true,
                isExpanded: true,
                borderRadius: BorderRadius.circular(8),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    print('Font manually changed to: $newValue'); // Debug log
                    setState(() {
                      _activeFont = newValue;
                      _lastManualFontChange = DateTime.now();
                    });
                    controller.execCommand('fontName', argument: newValue);
                    print('Active font set to: $_activeFont'); // Debug log
                  }
                },
                items: _availableFonts.map((font) {
                  String displayName = font.split(',')[0].trim();
                  return _buildFontDropdownItem(font, displayName);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> _buildFontDropdownItem(String value, String label) {
    // Map font family names to system fonts that are available on the device
    String fontFamily;
    switch (label) {
      case 'Arial':
        fontFamily = 'sans-serif';
        break;
      case 'Times New Roman':
        fontFamily = 'serif';
        break;
      case 'Courier New':
        fontFamily = 'monospace';
        break;
      case 'Georgia':
        fontFamily = 'serif';
        break;
      case 'Helvetica':
        fontFamily = 'sans-serif';
        break;
      case 'Impact':
        fontFamily = 'sans-serif';
        break;
      case 'Tahoma':
        fontFamily = 'sans-serif';
        break;
      case 'Trebuchet MS':
        fontFamily = 'sans-serif';
        break;
      case 'Verdana':
        fontFamily = 'sans-serif';
        break;
      default:
        fontFamily = 'sans-serif';
    }

    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        label,
        style: TextStyle(
          fontFamily: fontFamily,
          fontWeight: label == 'Impact' ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  String _getFontFamily(String displayName) {
    // Map font family names to system fonts that are available on the device
    switch (displayName) {
      case 'Arial':
        return 'sans-serif';
      case 'Times New Roman':
        return 'serif';
      case 'Courier New':
        return 'monospace';
      case 'Georgia':
        return 'serif';
      case 'Helvetica':
        return 'sans-serif';
      case 'Impact':
        return 'sans-serif';
      case 'Tahoma':
        return 'sans-serif';
      case 'Trebuchet MS':
        return 'sans-serif';
      case 'Verdana':
        return 'sans-serif';
      default:
        return 'sans-serif';
    }
  }

  String _getFormatLabel(String value) {
    switch (value) {
      case 'p':
        return 'Normal';
      case 'h1':
        return 'H1';
      case 'h2':
        return 'H2';
      case 'h3':
        return 'H3';
      case 'h4':
        return 'H4';
      case 'blockquote':
        return 'Quote';
      case 'pre':
        return 'Code';
      default:
        return value;
    }
  }

  TextStyle _getFormatStyle(String value, Color color) {
    switch (value) {
      case 'p':
        return TextStyle(fontWeight: FontWeight.normal, color: color);
      case 'h1':
        return TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: color);
      case 'h2':
        return TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: color);
      case 'h3':
        return TextStyle(
            fontWeight: FontWeight.bold, fontSize: 14, color: color);
      case 'h4':
        return TextStyle(
            fontWeight: FontWeight.bold, fontSize: 12, color: color);
      case 'blockquote':
        return TextStyle(fontStyle: FontStyle.italic, color: color);
      case 'pre':
        return TextStyle(fontFamily: 'monospace', color: color);
      default:
        return TextStyle(color: color);
    }
  }
}
