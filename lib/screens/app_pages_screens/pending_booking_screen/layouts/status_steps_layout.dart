import 'package:salon_provider/model/response/notification_res.dart';
import 'package:salon_provider/providers/app_pages_provider/booking_status_provider.dart';
import '../../../../config.dart';
import 'package:intl/intl.dart';

class StatusStepsLayout extends StatelessWidget {
  final NotificationRes data;
  final int? index, selectIndex;
  final List<NotificationRes>? list;
  final BookingStatusProvider provider;

  const StatusStepsLayout({
    super.key,
    required this.data,
    required this.provider,
    this.index,
    this.selectIndex,
    this.list,
  });

  @override
  Widget build(BuildContext context) {
    final eventTitle = provider.getEventTitle(data.metadata?['event']);
    final eventDescription = provider.getEventDescription(data);
    final statusColor =
        provider.getStatusColor(context, data.metadata?['event']);
    final createdAt = data.createdAt;
    final formattedDate =
        createdAt != null ? DateFormat('dd MMM, yyyy').format(createdAt) : '';
    final formattedTime =
        createdAt != null ? DateFormat('hh:mm a').format(createdAt) : '';

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        selectIndex == index
            ? DottedBorder(
                color: appColor(context).appTheme.primary,
                borderType: BorderType.RRect,
                radius: const Radius.circular(AppRadius.r30),
                child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: statusColor, shape: BoxShape.circle))
                    .paddingAll(Insets.i1))
            : Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                    color: appColor(context).appTheme.lightText,
                    shape: BoxShape.circle),
                child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: appColor(context).appTheme.whiteColor,
                                width: 2),
                            color: selectIndex == index
                                ? appColor(context).appTheme.primary
                                : appColor(context).appTheme.lightText,
                            shape: BoxShape.circle))
                    .paddingAll(Insets.i1)),
        SvgPicture.asset(eSvgAssets.anchorStatusArrow,
            colorFilter: ColorFilter.mode(
                selectIndex == index
                    ? appColor(context).appTheme.primary
                    : appColor(context).appTheme.stroke,
                BlendMode.srcIn))
      ]),
      const HSpace(Sizes.s12),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        IntrinsicHeight(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(formattedDate,
                  style: appCss.dmDenseMedium12.textColor(selectIndex == index
                      ? appColor(context).appTheme.darkText
                      : appColor(context).appTheme.lightText)),
              Text(formattedTime,
                  style: appCss.dmDenseMedium12.textColor(selectIndex == index
                      ? appColor(context).appTheme.darkText
                      : appColor(context).appTheme.lightText))
            ]),
            VerticalDivider(
                    width: 1,
                    thickness: 1,
                    endIndent: 2,
                    indent: 2,
                    color: appColor(context).appTheme.stroke)
                .paddingSymmetric(horizontal: Insets.i9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(eventTitle,
                      style: appCss.dmDenseMedium12
                          .textColor(appColor(context).appTheme.darkText)),
                  Text(eventDescription,
                      style: appCss.dmDenseMedium12
                          .textColor(appColor(context).appTheme.lightText))
                ],
              ),
            )
          ],
        )),
        const VSpace(Sizes.s15),
        if (index != list!.length - 1)
          const DottedLines().paddingOnly(bottom: Insets.i15)
      ]))
    ]).paddingSymmetric(horizontal: Insets.i15);
  }
}
