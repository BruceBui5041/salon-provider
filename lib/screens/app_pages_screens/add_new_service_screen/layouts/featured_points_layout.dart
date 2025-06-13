import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:salon_provider/providers/app_pages_provider/add_new_service_provider.dart';

import '../../../../config.dart';

/// A widget that displays featured points with HTML support
class FeaturedPointsLayout extends StatelessWidget {
  const FeaturedPointsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewServiceProvider>(
      builder: (context, value, child) {
        print("featuredPoints: ${value.featuredPoints.text}");
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
            _buildHtmlPreview(context, value),
          ],
        );
      },
    );
  }

  /// Builds the HTML preview section
  Widget _buildHtmlPreview(BuildContext context, AddNewServiceProvider value) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: Insets.i20),
      padding: const EdgeInsets.all(Insets.i12),
      decoration: BoxDecoration(
        color: appColor(context).appTheme.whiteBg,
        borderRadius: BorderRadius.circular(AppRadius.r8),
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
          : SingleChildScrollView(
              child: Html(
                data: value.featuredPoints.text,
                style: {
                  "body": Style(
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                    fontSize: FontSize(14.0),
                    fontFamily: 'DM Sans',
                  ),
                },
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
