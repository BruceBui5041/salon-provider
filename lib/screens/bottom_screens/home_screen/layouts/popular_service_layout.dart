import 'dart:ffi';

import '../../../../config.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../../widgets/flutter_switch_common.dart';

class FeaturedServicesLayout extends StatelessWidget {
  final dynamic data;
  final GestureTapCallback? onTap;

  const FeaturedServicesLayout({super.key, this.data,this.onTap});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<HomeProvider>(context,listen: true);
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Container(
              height: Sizes.s150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular( AppRadius.r6),
                  image: DecorationImage(image: AssetImage(data["image"]),fit: BoxFit.cover)
              )
          ),
          const VSpace(Sizes.s12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( language(context, data["title"]) ,
                      style: appCss.dmDenseSemiBold15
                          .textColor(appColor(context).appTheme.darkText)),
                  Text("\$${data["price"]}",
                      style: appCss.dmDenseBold16
                          .textColor(appColor(context).appTheme.darkText))
                ]),
            const VSpace(Sizes.s8),

            IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Row(
                  children: [
                    Text("\u2022 ${data["work"]}" ,
                        style: appCss.dmDenseMedium12
                            .textColor(appColor(context).appTheme.lightText)),
                    VerticalDivider(
                        width: 1,
                        color: appColor(context).appTheme.stroke,
                        thickness: 1,
                        indent: 3,
                        endIndent: 3)
                        .paddingSymmetric(horizontal: Insets.i6),
                    SvgPicture.asset(eSvgAssets.receipt),
                    const HSpace(Sizes.s5),
                    Text("${data["booked"]} ${language(context, appFonts.booked)}",style: appCss.dmDenseMedium12.textColor(appColor(context).appTheme.lightText))
                  ]
                ),
                Row(children: [
                  SvgPicture.asset(eSvgAssets.star),
                  const HSpace(Sizes.s3),
                  Text(data["rating"],
                      style: appCss.dmDenseMedium13
                          .textColor(appColor(context).appTheme.darkText))
                ])
              ])
            ),
            const VSpace(Sizes.s10),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                     Text(language(context, appFonts.activeStatus),style: appCss.dmDenseMedium12.textColor(appColor(context).appTheme.darkText)),
                  Theme(
                      data: ThemeData(useMaterial3: false),
                      child: FlutterSwitchCommon(value: data["isStatus"],onToggle: (val)=> value.onTapSwitch(val,data)))
                ]).paddingAll(Insets.i15).boxShapeExtension(color: appColor(context).appTheme.fieldCardBg,radius: AppRadius.r10)
          ])
        ])).paddingAll(Insets.i15)
        .boxBorderExtension(context,isShadow: true,bColor: appColor(context).appTheme.stroke).inkWell(onTap: onTap)
        .paddingOnly(bottom: Insets.i15);
  }
}