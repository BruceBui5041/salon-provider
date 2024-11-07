import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

import '../config.dart';

class CustomerServiceLayout extends StatelessWidget {
  final String? title, status, name, image;
  final double? rate;
  final GestureTapCallback? chatTap, phoneTap, moreTap;

  const CustomerServiceLayout(
      {super.key,
      this.title,
      this.status,
      this.chatTap,
      this.phoneTap,
      this.moreTap,
      this.name,
      this.image,
      this.rate});

  @override
  Widget build(BuildContext context) {
    log("RATEEE $rate");
    return SizedBox(
            child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(language(context, title),
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.lightText)),
        if (language(context, title) ==
            language(context, appFonts.servicemanDetail))
          Row(children: [
            Text(language(context, appFonts.more),
                style: appCss.dmDenseMedium12
                    .textColor(appColor(context).appTheme.primary)),
            const HSpace(Sizes.s4),
            SvgPicture.asset(eSvgAssets.anchorArrowRight,
                colorFilter: ColorFilter.mode(
                    appColor(context).appTheme.primary, BlendMode.srcIn))
          ]).inkWell(onTap: moreTap)
      ]),
      Divider(height: 1, color: appColor(context).appTheme.stroke)
          .paddingSymmetric(vertical: Insets.i15),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Container(
              height: Sizes.s40,
              width: Sizes.s40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(image!), fit: BoxFit.cover))),
          const HSpace(Sizes.s12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name!,
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.darkText)),
            if (language(context, title) != language(context, appFonts.customerDetails))
              Row(children: [
                RatingBar(
                    initialRating: rate ?? 3.5,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    maxRating: 5,
                    itemSize: Sizes.s13,
                    ignoreGestures: true,
                    ratingWidget: RatingWidget(
                        full: SvgPicture.asset(eSvgAssets.star),
                        empty: SvgPicture.asset(eSvgAssets.starOut,colorFilter: ColorFilter.mode(appColor(context).appTheme.lightText, BlendMode.srcIn)),
                        half: SvgPicture.asset(eSvgAssets.star
                    )),
                    onRatingUpdate: (double value) {}),
                /*SvgPicture.asset(starCondition(rate!)),*/
                const HSpace(Sizes.s4),
                Text(rate!.toString(),
                    style: appCss.dmDenseMedium12
                        .textColor(appColor(context).appTheme.darkText))
              ])
          ])
        ]),
        if (status != "Pending")
          Row(children: [
            SocialIconCommon(icon: eSvgAssets.chatOut, onTap: chatTap),
            const HSpace(Sizes.s12),
            SocialIconCommon(icon: eSvgAssets.phone, onTap: ()=> onTapPhone())
          ])
      ])
    ]))
        .paddingAll(Insets.i15)
        .boxShapeExtension(color: appColor(context).appTheme.fieldCardBg);
  }

  Future<void> makePhoneCall(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }}

  onTapPhone(){
    makePhoneCall(Uri.parse('tel:+91 8200798552'));

  }

}
