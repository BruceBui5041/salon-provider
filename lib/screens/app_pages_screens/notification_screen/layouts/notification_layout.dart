import 'package:salon_provider/model/notification_model.dart';
import '../../../../config.dart';

class NotificationLayout extends StatelessWidget {
  final NotificationModel? data;
  final GestureTapCallback? onTap;

  const NotificationLayout({super.key, this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                height: Sizes.s34,
                width: Sizes.s34,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: data!.isRead! == true
                        ? appColor(context).appTheme.fieldCardBg
                        : appColor(context).appTheme.whiteBg),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(data!.icon!,
                          height: Sizes.s18,
                          width: Sizes.s18,
                          colorFilter: ColorFilter.mode(
                              data!.isRead! == true
                                  ? appColor(context).appTheme.lightText
                                  : appColor(context).appTheme.darkText,
                              BlendMode.srcIn))
                    ])),
            const HSpace(Sizes.s12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(data!.title!,
                  style: appCss.dmDenseMedium14.textColor(data!.isRead! == true
                      ? appColor(context).appTheme.lightText
                      : appColor(context).appTheme.darkText)),
              const VSpace(Sizes.s11),
              SizedBox(
                  width: Sizes.s200,
                  child: Text(data!.message!,
                      style: appCss.dmDenseRegular12.textColor(
                          data!.isRead! == true
                              ? appColor(context).appTheme.lightText
                              : appColor(context).appTheme.darkText))),
              if (data!.image != null)
                if (data!.image! != [])
                  Row(
                      children: data!.image!
                          .map((e) => Image.asset(e, height: Sizes.s53)
                              .paddingOnly(top: Insets.i10)
                              .decorated(
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.r4))
                              .paddingOnly(right: Insets.i8))
                          .toList())
            ])
          ]),
          Text(data!.time!,
              style: appCss.dmDenseRegular12
                  .textColor(appColor(context).appTheme.lightText))
        ])
        .paddingAll(Insets.i12)
        .boxBorderExtension(context,
            bColor: appColor(context).appTheme.fieldCardBg,
            color: data!.isRead! == true
                ? appColor(context).appTheme.whiteBg
                : appColor(context).appTheme.fieldCardBg,
            isShadow: data!.isRead! == true ? true : false,
            radius: AppRadius.r12)
        .paddingOnly(bottom: Insets.i15);
  }
}
