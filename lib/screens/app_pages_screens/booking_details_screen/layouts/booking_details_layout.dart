import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:intl/intl.dart';
import '../../../../config.dart';
import '../../../../model/response/booking_response.dart';

class BookingDetailsLayout extends StatelessWidget {
  final Booking? data;

  const BookingDetailsLayout({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingDetailsProvider>(builder: (context, value, child) {
      return data == null
          ? Container()
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      height: Sizes.s140,
                      width: Sizes.s84,
                      decoration: ShapeDecoration(
                          image: DecorationImage(
                              image: NetworkImage(data!.serviceVersions?.first
                                      .mainImageResponse?.url ??
                                  ""),
                              fit: BoxFit.cover),
                          shape: const SmoothRectangleBorder(
                              borderRadius: SmoothBorderRadius.all(SmoothRadius(
                                  cornerRadius: AppRadius.r10,
                                  cornerSmoothing: 1))))),
                  const HSpace(Sizes.s10),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("#${data!.id ?? ""}",
                            style: appCss.dmDenseMedium16
                                .textColor(appColor(context).appTheme.primary)),
                        const VSpace(Sizes.s10),
                        Text(data!.serviceVersions?.first.title ?? "",
                                style: appCss.dmDenseMedium16.textColor(
                                    appColor(context).appTheme.darkText))
                            .width(Sizes.s150)
                      ]).paddingOnly(top: Insets.i6)
                ]),
                const VSpace(Sizes.s15),
                Column(children: [
                  Row(children: [
                    DescriptionLayoutCommon(
                        icon: eSvgAssets.calender,
                        title: data!.bookingDate != null
                            ? DateFormat('dd/MM/yyyy')
                                .format(data!.bookingDate!)
                            : "",
                        subtitle: appFonts.date),
                    Container(
                            height: Sizes.s70,
                            width: 1,
                            color: appColor(context).appTheme.stroke)
                        .paddingOnly(left: Insets.i27, right: Insets.i20),
                    DescriptionLayoutCommon(
                        icon: eSvgAssets.clockOut,
                        title: data!.bookingDate != null
                            ? DateFormat('HH:mm a').format(data!.bookingDate!)
                            : "",
                        subtitle: appFonts.time)
                  ]).paddingSymmetric(horizontal: Insets.i10),
                  const DividerCommon(),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SvgPicture.asset(eSvgAssets.locationOut,
                        colorFilter: ColorFilter.mode(
                            appColor(context).appTheme.darkText,
                            BlendMode.srcIn)),
                    Container(
                            height: Sizes.s15,
                            width: 1,
                            color: appColor(context).appTheme.stroke)
                        .paddingSymmetric(horizontal: Insets.i9),
                    Expanded(
                        child: Text("",
                            style: appCss.dmDenseMedium12.textColor(
                                appColor(context).appTheme.darkText)))
                  ]).paddingSymmetric(
                      vertical: Insets.i15, horizontal: Insets.i10)
                ]).boxBorderExtension(context,
                    bColor: appColor(context).appTheme.stroke),
                Text(language(context, appFonts.description),
                        style: appCss.dmDenseRegular12
                            .textColor(appColor(context).appTheme.lightText))
                    .paddingOnly(top: Insets.i15, bottom: Insets.i5),
                Text(data!.notes ?? "",
                    style: appCss.dmDenseRegular14
                        .textColor(appColor(context).appTheme.darkText)),
                const VSpace(Sizes.s15),
                CustomerLayout(
                    title: appFonts.customerDetails, user: data!.user),
                const VSpace(Sizes.s15),
                if (data!.serviceMan != null)
                  CustomerDetailsLayout(
                      onTapMore: () =>
                          route.pushNamed(context, routeName.servicemanDetail),
                      onTapPhone: () => value.onTapPhone(),
                      title: appFonts.servicemanDetail,
                      data: data!.serviceMan!,
                      onTapChat: () => route.pushNamed(context, routeName.chat),
                      isMore: true)
              ]).paddingAll(Insets.i15).boxBorderExtension(context,
                  isShadow: true, radius: AppRadius.r12),
              Text(language(context, appFonts.commissionHistory),
                      style: appCss.dmDenseMedium14
                          .textColor(appColor(context).appTheme.darkText))
                  .paddingOnly(top: Insets.i20, bottom: Insets.i10),
              CancelledBillSummary(booking: data)
            ]);
    });
  }
}
