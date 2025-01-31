import 'package:figma_squircle_updated/figma_squircle.dart';

import '../../../../config.dart';
import '../../../../model/booking_details_model.dart';

class BookingDetailsLayout extends StatelessWidget {
  final BookingDetailsModel? data;

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
                      height: Sizes.s84,
                      width: Sizes.s84,
                      decoration: ShapeDecoration(
                          image: DecorationImage(
                              image: AssetImage(eImageAssets.as3),
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
                        Text("#${data!.bookingId!}",
                            style: appCss.dmDenseMedium16
                                .textColor(appColor(context).appTheme.primary)),
                        const VSpace(Sizes.s10),
                        Text(data!.package!,
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
                        title: data!.date,
                        subtitle: appFonts.date),
                    Container(
                            height: Sizes.s70,
                            width: 1,
                            color: appColor(context).appTheme.stroke)
                        .paddingOnly(left: Insets.i27, right: Insets.i20),
                    DescriptionLayoutCommon(
                        icon: eSvgAssets.clockOut,
                        title: data!.time,
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
                        child: Text(language(context, data!.address),
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
                Text(data!.description!,
                    style: appCss.dmDenseRegular14
                        .textColor(appColor(context).appTheme.darkText)),
                const VSpace(Sizes.s15),
                CustomerLayout(
                    title: appFonts.customerDetails,
                    data: data!.customerDetails),
                const VSpace(Sizes.s15),
                ...data!.serviceMenDetails!.asMap().entries.map((e) =>
                    CustomerDetailsLayout(
                        onTapMore: () => route.pushNamed(
                            context, routeName.servicemanDetail),
                        onTapPhone: () => value.onTapPhone(),
                        title: appFonts.servicemanDetail,
                        data: e.value,
                        onTapChat: () =>
                            route.pushNamed(context, routeName.chat),
                        isMore: true,
                        index: e.key,
                        list: data!.serviceMenDetails))
              ]).paddingAll(Insets.i15).boxBorderExtension(context,
                  isShadow: true, radius: AppRadius.r12),
              Text(language(context, appFonts.commissionHistory),
                      style: appCss.dmDenseMedium14
                          .textColor(appColor(context).appTheme.darkText))
                  .paddingOnly(top: Insets.i20, bottom: Insets.i10),
              Container(
                  height: Sizes.s245,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(appColor(context).appTheme.isDark
                              ? eImageAssets.bookingDetailBg
                              : eImageAssets.commissionBg),
                          fit: BoxFit.fill)),
                  child: Column(children: [
                    CommissionRowLayout(
                        isCommission: true,
                        data: data!.commissionHistory!.totalReceivedAmount,
                        title: appFonts.totalReceivedCommission,
                        style: appCss.dmDenseblack14
                            .textColor(appColor(context).appTheme.darkText)),
                    CommissionRowLayout(
                        isCommission: true,
                        title: appFonts.adminCommission,
                        data: data!.commissionHistory!.adminCommission),
                    CommissionRowLayout(
                        isCommission: true,
                        title: appFonts.servicemenCommission,
                        data: data!.commissionHistory!.servicemenCommission),
                    CommissionRowLayout(
                        isCommission: true,
                        title: appFonts.platformFees,
                        data: data!.commissionHistory!.platformFees),
                    CommissionRowLayout(
                        title: appFonts.yourCommission,
                        color: appColor(context).appTheme.primary,
                        data: data!.commissionHistory!.yourCommission)
                  ]).paddingSymmetric(
                      horizontal: Insets.i15, vertical: Insets.i20))
            ]);
    });
  }
}
