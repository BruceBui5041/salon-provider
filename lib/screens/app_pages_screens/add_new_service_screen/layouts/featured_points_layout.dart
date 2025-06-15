import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import 'package:salon_provider/providers/app_pages_provider/add_new_service_provider.dart';
import 'package:salon_provider/screens/app_pages_screens/add_new_service_screen/layouts/html_editor_screen.dart';

import '../../../../config.dart';

/// A widget that displays featured points with rich text support
class FeaturedPointsLayout extends StatelessWidget {
  const FeaturedPointsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewServiceProvider>(
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: Insets.i20,
                  right: Insets.i20,
                  top: Insets.i24,
                  bottom: Insets.i12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    language(context, appFonts.featuredPoints),
                    style: appCss.dmDenseSemiBold14.textColor(
                      appColor(context).appTheme.darkText,
                    ),
                  ),
                  TextButton(
                    onPressed: () => _navigateToHtmlEditor(context, value),
                    child: Text(
                      language(context, "Edit"),
                      style: appCss.dmDenseMedium14.textColor(
                        appColor(context).appTheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildQuillPreview(context, value),
          ],
        );
      },
    );
  }

  /// Builds the Quill preview section
  Widget _buildQuillPreview(BuildContext context, AddNewServiceProvider value) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: Insets.i20),
      padding: const EdgeInsets.all(Insets.i12),
      decoration: BoxDecoration(
        color: appColor(context).appTheme.whiteBg,
        borderRadius: BorderRadius.circular(AppRadius.r8),
        border: Border.all(
          color: appColor(context).appTheme.stroke,
          width: 1,
        ),
      ),
      child: value.featuredPoints.text.isEmpty
          ? Center(
              child: Text(
                language(context, appFonts.writeANote),
                style: appCss.dmDenseMedium14.textColor(
                  appColor(context).appTheme.lightText,
                ),
              ),
            )
          : _buildQuillContent(context, value.featuredPoints.text),
    );
  }

  /// Builds a read-only Quill editor with the content
  Widget _buildQuillContent(BuildContext context, String content) {
    QuillController? controller;

    try {
      // Try to parse as Quill Delta JSON
      final delta = content.startsWith('[') || content.startsWith('{')
          ? jsonDecode(content)
          : null;

      if (delta != null) {
        controller = QuillController(
          document: Document.fromJson(delta),
          selection: const TextSelection.collapsed(offset: 0),
        );
      }
    } catch (e) {
      // If parsing fails, show as plain text
    }

    if (controller != null) {
      return Theme(
        data: Theme.of(context).copyWith(
          textTheme: TextTheme(
            bodyMedium: appCss.dmDenseMedium14.textColor(
              appColor(context).appTheme.darkText,
            ),
            bodyLarge: appCss.dmDenseMedium16.textColor(
              appColor(context).appTheme.darkText,
            ),
            bodySmall: appCss.dmDenseMedium12.textColor(
              appColor(context).appTheme.darkText,
            ),
            labelLarge: appCss.dmDenseMedium14.textColor(
              appColor(context).appTheme.darkText,
            ),
          ),
          iconTheme: IconThemeData(
            color: appColor(context).appTheme.darkText,
          ),
        ),
        child: QuillEditor.basic(
          controller: controller,
          config: QuillEditorConfig(
            showCursor: false,
            autoFocus: false,
            scrollable: true,
            padding: EdgeInsets.zero,
            expands: false,
            scrollPhysics: const ClampingScrollPhysics(),
            embedBuilders: [
              CustomImageEmbedBuilder(),
            ],
          ),
        ),
      );
    }

    // Fallback to plain text display
    return SingleChildScrollView(
      child: Text(
        content,
        style: appCss.dmDenseMedium14.textColor(
          appColor(context).appTheme.darkText,
        ),
      ),
    );
  }

  /// Navigates to the HTML editor screen
  void _navigateToHtmlEditor(
      BuildContext context, AddNewServiceProvider value) {
    Navigator.of(context).pushNamed(routeName.htmlEditor);
  }
}
