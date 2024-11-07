import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import '../../../../config.dart';


class BlogDetailsLayout extends StatelessWidget {
  const BlogDetailsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<LatestBLogDetailsProvider>(context, listen: true);
    return Column(children: [

      Image.asset(value.data!.media![0].originalUrl!),

      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
              width: Sizes.s190,
              child: Text(language(context, value.data!.title!),
                  overflow: TextOverflow.ellipsis,
                  style: appCss.dmDenseMedium16
                      .textColor(appColor(context).appTheme.darkText))),
          SizedBox(
              width: Sizes.s70,
              child: Text(value.data!.tags![0].name!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: appCss.dmDenseMedium11
                          .textColor(appColor(context).appTheme.primary))
                  .paddingSymmetric(horizontal: Insets.i7, vertical: Insets.i5)
                  .decorated(
                      borderRadius: BorderRadius.circular(AppRadius.r6),
                      color:
                          appColor(context).appTheme.primary.withOpacity(0.1)))
        ]),
        Row(children: [
          Expanded(
              child: Text(language(context, value.data!.categories![0].title!),
                  overflow: TextOverflow.ellipsis,
                  style: appCss.dmDenseRegular12
                      .textColor(appColor(context).appTheme.lightText)))
        ]),
        const VSpace(Sizes.s15),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              SvgPicture.asset(eSvgAssets.tag),
              const HSpace(Sizes.s4),
              Text(value.data!.createdAt!,
                  style: appCss.dmDenseRegular12
                      .textColor(appColor(context).appTheme.lightText)),
            ],
          ),
          Text("- By ${language(context, value.data!.createdBy!.name!)}",
              style: appCss.dmDenseRegular12
                  .textColor(appColor(context).appTheme.lightText))
        ]),
        const DottedLines().paddingSymmetric(vertical: Insets.i15),
        Text(language(context, appFonts.description),
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.lightText)),
        const VSpace(Sizes.s10),
        Html(data: value.data!.content!, style: {
          "body": Style(
              fontFamily: GoogleFonts.dmSans().fontFamily,
              fontSize: FontSize(12),
              fontWeight: FontWeight.w400)
        })
      ]).paddingAll(Insets.i12)
    ]);
  }
}
