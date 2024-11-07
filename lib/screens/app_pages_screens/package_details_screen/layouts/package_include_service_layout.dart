import '../../../../config.dart';

class PackageIncludeServiceLayout extends StatelessWidget {
  final dynamic data;
  final int? index;
  final List? list;
  const PackageIncludeServiceLayout({super.key, this.data, this.index, this.list});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Stack(
            alignment: rtl(context) ? Alignment.centerLeft : Alignment.centerRight,
            children: [
              Row(
                  children: [
                    Container(
                        height: Sizes.s70,
                        width: Sizes.s70,
                        decoration: ShapeDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(data.media[0].originalUrl)),
                            shape: SmoothRectangleBorder(
                                borderRadius:
                                SmoothBorderRadius(cornerRadius: 8, cornerSmoothing: 1)))
                    ),
                    const HSpace(Sizes.s10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.title,
                              overflow: TextOverflow.ellipsis,
                              style: appCss.dmDenseMedium14
                                  .textColor(appColor(context).appTheme.darkText)).width(Sizes.s135),
                          const VSpace(Sizes.s2),
                          Text("\$${data.price}",
                              style: appCss.dmDenseblack14
                                  .textColor(appColor(context).appTheme.darkText)),
                          const VSpace(Sizes.s6),
                          IntrinsicHeight(
                              child: Row(
                                  children: [
                                    SvgPicture.asset(eSvgAssets.clock),
                                    const HSpace(Sizes.s5),
                                    Text(data.duration,
                                        style: appCss.dmDenseMedium14
                                            .textColor(appColor(context).appTheme.online)),
                                    VerticalDivider(width: 1,thickness: 1,color: appColor(context).appTheme.stroke,endIndent: 4,indent: 4).paddingSymmetric(horizontal: Insets.i6),
                                    Text("${data.requiredServicemen} ${appFonts.serviceman}",
                                        overflow: TextOverflow.ellipsis,
                                        style: appCss.dmDenseMedium12
                                            .textColor(appColor(context).appTheme.darkText))
                                  ]
                              )
                          )
                        ]
                    )
                  ]
              ),
              StarLayout(star: eSvgAssets.star,rate: data.reviewRating)
            ],
          ).paddingSymmetric(horizontal: Insets.i15),
          Image.asset(eImageAssets.rightDashArrow,color: appColor(context).appTheme.stroke,).paddingOnly(top: Insets.i10,bottom: Insets.i5).paddingSymmetric(horizontal: Insets.i15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("\u2022",style: appCss.dmDenseMedium13.textColor(appColor(context).appTheme.lightText)),
              const HSpace(Sizes.s10),
              Expanded(child: Text("${data.description}",style: appCss.dmDenseMedium13.textColor(appColor(context).appTheme.lightText)))
            ]
          ).paddingSymmetric(horizontal: Insets.i20),
          if(index != list!.length - 1)
          const DividerCommon().paddingSymmetric(vertical: Insets.i20)
        ]
    );
  }
}
