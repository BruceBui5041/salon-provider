import 'package:salon_provider/model/response/notification_details_res.dart';
import '../../../../config.dart';

class NotificationLayout extends StatelessWidget {
  final NotificationDetailsRes? data;
  final GestureTapCallback? onTap;

  const NotificationLayout({super.key, this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, child) {
        if (data == null) return const SizedBox.shrink();

        final event = data!.notification?.metadata?['event'] as String?;
        final icon = provider.getNotificationIcon(event);
        final title = language(context, provider.getNotificationTitle(data!));
        final description = provider.getNotificationDescription(context, data!);
        final time = provider.getNotificationTime(context, data!);
        final isRead = provider.isNotificationRead(data!);

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
                        color: isRead
                            ? appColor(context).appTheme.fieldCardBg
                            : appColor(context).appTheme.whiteBg),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(icon,
                              height: Sizes.s18,
                              width: Sizes.s18,
                              colorFilter: ColorFilter.mode(
                                  isRead
                                      ? appColor(context).appTheme.lightText
                                      : appColor(context).appTheme.darkText,
                                  BlendMode.srcIn))
                        ])),
                const HSpace(Sizes.s12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title,
                      style: appCss.dmDenseMedium14.textColor(isRead
                          ? appColor(context).appTheme.lightText
                          : appColor(context).appTheme.darkText)),
                  const VSpace(Sizes.s11),
                  SizedBox(
                      width: Sizes.s200,
                      child: Text(description,
                          style: appCss.dmDenseRegular12.textColor(isRead
                              ? appColor(context).appTheme.lightText
                              : appColor(context).appTheme.darkText))),
                ])
              ]),
              Text(time,
                  style: appCss.dmDenseRegular12
                      .textColor(appColor(context).appTheme.lightText))
            ])
            .paddingAll(Insets.i12)
            .boxBorderExtension(context,
                bColor: appColor(context).appTheme.fieldCardBg,
                color: isRead
                    ? appColor(context).appTheme.whiteBg
                    : appColor(context).appTheme.fieldCardBg,
                isShadow: isRead ? true : false,
                radius: AppRadius.r12)
            .paddingOnly(bottom: Insets.i15);
      },
    );
  }
}
