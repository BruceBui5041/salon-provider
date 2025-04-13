import 'package:salon_provider/common/booking_status.dart';
import 'package:salon_provider/model/response/user_response.dart';
import 'package:salon_provider/widgets/cache_image.dart';

import '../../../../config.dart';

class CustomerLayout extends StatelessWidget {
  final UserResponse? user;
  final String? title;
  final GestureTapCallback? chatTap, phoneTap, moreTap;
  final String? status;

  const CustomerLayout(
      {super.key,
      this.user,
      this.title,
      this.chatTap,
      this.phoneTap,
      this.moreTap,
      this.status});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(language(context, title!),
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.lightText)),
        if (language(context, title!) ==
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
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: SizedBox(
              height: Sizes.s50,
              width: Sizes.s50,
              child: CacheImageWidget(
                url: user?.userProfile?.profilePictureUrl,
              ),
            ),
          ),
          const HSpace(Sizes.s12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${user?.firstname ?? ""} ${user?.lastname ?? ""}",
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.darkText)),
            if (user?.phoneNumber != null)
              Text(user?.phoneNumber ?? "",
                  style: appCss.dmDenseMedium12
                      .textColor(appColor(context).appTheme.lightText))
          ])
        ]),
        if (status != BookingStatus.pending.name)
          Row(children: [
            SocialIconCommon(icon: eSvgAssets.chatOut, onTap: chatTap),
            const HSpace(Sizes.s12),
            SocialIconCommon(icon: eSvgAssets.phone, onTap: phoneTap)
          ])
      ])
    ]))
        .paddingAll(Insets.i15)
        .boxShapeExtension(color: appColor(context).appTheme.fieldCardBg);
  }
}
