import '../../../../config.dart';

class CustomerLayout extends StatelessWidget {
  final dynamic data;
  final String? title;
  const CustomerLayout({super.key, this.data, this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        language(context, title!),
        style: appCss.dmDenseMedium12.textColor(
          appColor(context).appTheme.lightText,
        ),
      ).padding(
        horizontal: Insets.i15,
        top: Insets.i15,
      ),
      Divider(height: 1, color: appColor(context).appTheme.stroke)
          .paddingSymmetric(vertical: Insets.i15),
      Row(children: [
        Row(children: [
          Container(
              height: Sizes.s40,
              width: Sizes.s40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(data!.media![0].originalUrl)))),
          const HSpace(Sizes.s12),
          Text(data.title,
              style: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.darkText))
        ])
      ]).padding(horizontal: Insets.i15),
      const VSpace(Sizes.s15),
      Column(
        children: [
          ContactDetailRowCommon(image: eSvgAssets.email, title: data.email),
          ContactDetailRowCommon(image: eSvgAssets.phone, title: data.phone)
              .paddingSymmetric(vertical: Insets.i15),
          ContactDetailRowCommon(
              image: eSvgAssets.locationOut, title: data.location),
        ],
      )
          .paddingAll(Insets.i15)
          .boxShapeExtension(color: appColor(context).appTheme.whiteBg)
          .padding(horizontal: Insets.i15, bottom: Insets.i15)
    ])).boxShapeExtension(color: appColor(context).appTheme.fieldCardBg);
  }
}
