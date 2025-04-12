import 'package:figma_squircle_updated/figma_squircle.dart';

import '../../../../config.dart';
import '../../../../model/response/booking_response.dart';

class BookingLayout extends StatelessWidget {
  final Booking? data;
  final GestureTapCallback? onTap;

  const BookingLayout({super.key, this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<BookingProvider>(context, listen: true);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(data!.id!,
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.primary)),
            const HSpace(Sizes.s5),
            if (data!.serviceVersions != null)
              BookingStatusLayout(title: appFonts.package)
          ]),
          Text(
                  language(context,
                      "${data!.user?.firstname} ${data!.user?.lastname}"),
                  style: appCss.dmDenseMedium16
                      .textColor(appColor(context).appTheme.darkText))
              .paddingOnly(top: Insets.i8, bottom: Insets.i3),
          Row(children: [
            Text(language(context, " ${data!.getDiscountedPrice()}"),
                style: appCss.dmDenseBold18
                    .textColor(appColor(context).appTheme.primary)),
            const HSpace(Sizes.s8),
            if (data!.discountAmount != null)
              Text(language(context, "(${data!.getDiscountAmount()})"),
                  style: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.red))
          ])
        ]),
        Container(
            height: Sizes.s84,
            width: Sizes.s84,
            decoration: ShapeDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        data!.user?.userProfile?.profilePictureUrl ?? ''),
                    fit: BoxFit.cover),
                shape: const SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius.all(SmoothRadius(
                        cornerRadius: AppRadius.r10, cornerSmoothing: 1)))))
      ]),
      Image.asset(eImageAssets.bulletDotted)
          .paddingSymmetric(vertical: Insets.i12),
      StatusRow(title: appFonts.status, statusText: data!.getBookingStatus()!),
      if (data!.getBookingStatus() != appFonts.cancelled.toLowerCase())
        StatusRow(
            title: appFonts.requiredServiceman,
            title2:
                "${data!.serviceMan?.firstname} ${data!.serviceMan?.lastname} ${language(context, appFonts.serviceman)}",
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.darkText)),
      StatusRow(
          title: appFonts.dateTime,
          title2: data!.bookingDate?.toString() ?? '',
          style: appCss.dmDenseMedium12
              .textColor(appColor(context).appTheme.darkText)),
      StatusRow(
          title: appFonts.location,
          title2: data!.user?.userProfile?.phoneNumber ?? '',
          style: appCss.dmDenseMedium12
              .textColor(appColor(context).appTheme.darkText)),
      if (data!.getBookingStatus() != appFonts.cancelled.toLowerCase())
        StatusRow(
            title: appFonts.payment,
            title2: data!.payment?.status ?? '',
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.online)),
      const DottedLines().paddingOnly(bottom: Insets.i15),
      Stack(alignment: Alignment.bottomCenter, children: [
        Column(children: [
          if (data!.user != null)
            ServiceProviderLayout(
                expand: value.isExpand,
                title: appFonts.customer,
                image: data!.user?.userProfile?.profilePictureUrl,
                name: "${data!.user?.firstname} ${data!.user?.lastname}",
                rate: "0",
                index: 0,
                list2: [],
                list: []),
          if (data!.serviceMan != null)
            ServiceProviderLayout(
                expand: value.isExpand,
                title: appFonts.serviceman,
                image: data!.serviceMan?.userProfile?.profilePictureUrl,
                name:
                    "${data!.serviceMan?.firstname} ${data!.serviceMan?.lastname}",
                rate: "0",
                index: 0,
                list: [])
        ])
            .paddingSymmetric(horizontal: Insets.i15, vertical: Insets.i5)
            .boxShapeExtension(
                color: appColor(context).appTheme.fieldCardBg,
                radius: AppRadius.r12)
            .paddingOnly(bottom: 0),
      ]),
      if (data!.serviceMan == null &&
          data!.getBookingStatus() == appFonts.pending.toLowerCase())
        Text(language(context, appFonts.noteServicemenNotSelectYet),
                style: appCss.dmDenseRegular12
                    .textColor(appColor(context).appTheme.lightText))
            .paddingOnly(top: Insets.i8),
      if (data!.serviceMan == null &&
              data!.getBookingStatus() == appFonts.accepted.toLowerCase() ||
          (data!.serviceMan == null &&
              data!.getBookingStatus() == appFonts.assigned.toLowerCase()))
        RichText(
            text: TextSpan(
                style: appCss.dmDenseMedium12
                    .textColor(appColor(context).appTheme.red),
                text: language(context, appFonts.note),
                children: [
              TextSpan(
                  style: appCss.dmDenseRegular12
                      .textColor(appColor(context).appTheme.red),
                  text: language(context, appFonts.youAssignedService))
            ])).paddingOnly(top: Insets.i8),
      if (data!.serviceMan == null &&
          data!.getBookingStatus() == appFonts.ongoing.toLowerCase())
        if (isFreelancer != true)
          RichText(
              text: TextSpan(
                  style: appCss.dmDenseMedium12
                      .textColor(appColor(context).appTheme.red),
                  text: language(context, appFonts.note),
                  children: [
                TextSpan(
                    style: appCss.dmDenseRegular12
                        .textColor(appColor(context).appTheme.red),
                    text: language(context, appFonts.youAssignedService))
              ])).paddingOnly(top: Insets.i8),
      if (data!.getBookingStatus() == appFonts.pending.toLowerCase() &&
          data!.serviceMan == null)
        Row(children: [
          Expanded(
              child: ButtonCommon(
                  title: appFonts.reject,
                  onTap: () => value.onRejectBooking(context),
                  style: appCss.dmDenseSemiBold16
                      .textColor(appColor(context).appTheme.primary),
                  color: appColor(context).appTheme.trans,
                  borderColor: appColor(context).appTheme.primary)),
          const HSpace(Sizes.s15),
          Expanded(
              child: ButtonCommon(
                  title: appFonts.accept,
                  onTap: () => value.onAcceptBooking(context)))
        ]).paddingOnly(top: Insets.i15)
    ])
        .padding(horizontal: Insets.i15, top: Insets.i15, bottom: Insets.i15)
        .boxBorderExtension(context,
            isShadow: true, bColor: appColor(context).appTheme.stroke)
        .paddingOnly(bottom: Insets.i15)
        .inkWell(onTap: onTap);
  }
}
