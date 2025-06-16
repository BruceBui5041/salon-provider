import 'dart:convert';
import 'package:flutter_quill/flutter_quill.dart';
import '../../add_new_service_screen/layouts/description_editor_screen.dart';

import '../../../../config.dart';

class ReadMoreLayout extends StatelessWidget {
  final String? text;
  final Color? color;
  const ReadMoreLayout({super.key, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    if (text == null || text!.isEmpty) {
      return const SizedBox.shrink();
    }

    // Check if the text is in Quill format (JSON)
    if (_isQuillFormat(text!)) {
      return _buildQuillContent(context, text!);
    }

    // Fallback to regular ReadMoreText for plain text
    return ReadMoreText(text!,
        trimLines: 2,
        style: TextStyle(
            color: color ?? appColor(context).appTheme.darkText,
            fontFamily: GoogleFonts.dmSans().fontFamily,
            fontWeight: FontWeight.w500),
        colorClickableText: appColor(context).appTheme.darkText,
        trimMode: TrimMode.Line,
        lessStyle: TextStyle(
            decoration: TextDecoration.underline,
            color: appColor(context).appTheme.darkText,
            fontFamily: GoogleFonts.dmSans().fontFamily,
            fontWeight: FontWeight.w700),
        moreStyle: TextStyle(
            decoration: TextDecoration.underline,
            color: appColor(context).appTheme.darkText,
            fontFamily: GoogleFonts.dmSans().fontFamily,
            fontWeight: FontWeight.w700),
        trimCollapsedText: 'Read more.',
        trimExpandedText: 'Read less');
  }

  /// Checks if the text is in Quill format (JSON)
  bool _isQuillFormat(String content) {
    try {
      return content.startsWith('[') || content.startsWith('{');
    } catch (e) {
      return false;
    }
  }

  /// Builds a read-only Quill editor with the content
  Widget _buildQuillContent(BuildContext context, String content) {
    QuillController? controller;

    try {
      // Try to parse as Quill Delta JSON
      final delta = jsonDecode(content);

      if (delta != null) {
        controller = QuillController(
          document: Document.fromJson(delta),
          selection: const TextSelection.collapsed(offset: 0),
        );
      }
    } catch (e) {
      // If parsing fails, fallback to plain text ReadMoreText
      return ReadMoreText(content,
          trimLines: 2,
          style: TextStyle(
              color: color ?? appColor(context).appTheme.darkText,
              fontFamily: GoogleFonts.dmSans().fontFamily,
              fontWeight: FontWeight.w500),
          colorClickableText: appColor(context).appTheme.darkText,
          trimMode: TrimMode.Line,
          lessStyle: TextStyle(
              decoration: TextDecoration.underline,
              color: appColor(context).appTheme.darkText,
              fontFamily: GoogleFonts.dmSans().fontFamily,
              fontWeight: FontWeight.w700),
          moreStyle: TextStyle(
              decoration: TextDecoration.underline,
              color: appColor(context).appTheme.darkText,
              fontFamily: GoogleFonts.dmSans().fontFamily,
              fontWeight: FontWeight.w700),
          trimCollapsedText: 'Read more.',
          trimExpandedText: 'Read less');
    }

    if (controller != null) {
      return QuillEditor.basic(
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
      );
    }

    // Final fallback to plain text
    return SingleChildScrollView(
      child: Text(
        content,
        style: TextStyle(
          color: color ?? appColor(context).appTheme.darkText,
          fontFamily: GoogleFonts.dmSans().fontFamily,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
