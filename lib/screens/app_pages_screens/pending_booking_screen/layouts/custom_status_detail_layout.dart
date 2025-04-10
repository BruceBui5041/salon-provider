import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import '../../../../config.dart';

class CustomStatusDetailLayout extends StatelessWidget {
  final Booking? data;
  final GestureTapCallback? onChat, onPhone, onMore, onTapStatus, locationTap;

  const CustomStatusDetailLayout(
      {super.key,
      this.data,
      this.onChat,
      this.onTapStatus,
      this.onPhone,
      this.onMore,
      this.locationTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: data != null
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      height: Sizes.s140,
                      decoration: ShapeDecoration(
                          image: DecorationImage(
                              image: NetworkImage(data!.serviceVersions?.first
                                      ?.mainImageResponse?.url ??
                                  ""),
                              fit: BoxFit.cover),
                          shape: const SmoothRectangleBorder(
                              borderRadius: SmoothBorderRadius.all(SmoothRadius(
                                  cornerRadius: AppRadius.r10,
                                  cornerSmoothing: 1))))),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Text(data!.id ?? "",
                              style: appCss.dmDenseMedium16.textColor(
                                  appColor(context).appTheme.primary)),
                          if (data!.serviceVersions?.first.categoryResponse !=
                              null)
                            ButtonCommon(
                                    title: appFonts.package,
                                    width: Sizes.s68,
                                    height: Sizes.s22,
                                    color: appColor(context).appTheme.whiteBg,
                                    radius: AppRadius.r12,
                                    borderColor:
                                        appColor(context).appTheme.online,
                                    style: appCss.dmDenseMedium11.textColor(
                                        appColor(context).appTheme.online))
                                .paddingSymmetric(horizontal: Insets.i8)
                        ]),
                        Row(children: [
                          Text(language(context, appFonts.viewStatus),
                              style: appCss.dmDenseMedium12.textColor(
                                  appColor(context).appTheme.primary)),
                          const HSpace(Sizes.s5),
                          SvgPicture.asset(eSvgAssets.anchorArrowRight,
                              colorFilter: ColorFilter.mode(
                                  appColor(context).appTheme.primary,
                                  BlendMode.srcIn))
                        ])
                            .paddingSymmetric(
                                horizontal: Insets.i12, vertical: Insets.i8)
                            .boxShapeExtension(
                                radius: AppRadius.r4,
                                color: appColor(context)
                                    .appTheme
                                    .primary
                                    .withOpacity(0.1))
                            .inkWell(onTap: onTapStatus)
                      ]).paddingSymmetric(vertical: Insets.i15),
                  Text(data!.serviceVersions?.first.title ?? "",
                      style: appCss.dmDenseMedium16
                          .textColor(appColor(context).appTheme.darkText)),
                  const VSpace(Sizes.s15),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          DescriptionLayoutCommon(
                              icon: eSvgAssets.calender,
                              title: data!.bookingDate?.toString(),
                              subtitle: appFonts.date,
                              padding: 0),
                          Container(
                                  height: Sizes.s78,
                                  width: 1,
                                  color: appColor(context).appTheme.stroke)
                              .paddingSymmetric(horizontal: Insets.i20),
                          DescriptionLayoutCommon(
                              icon: eSvgAssets.clock,
                              title: data!.bookingDate?.toString(),
                              subtitle: appFonts.time)
                        ]).paddingSymmetric(horizontal: Insets.i10),
                        const DottedLines(),
                        const VSpace(Sizes.s17),
                        IntrinsicHeight(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              SvgPicture.asset(eSvgAssets.locationOut,
                                  fit: BoxFit.scaleDown,
                                  colorFilter: ColorFilter.mode(
                                      appColor(context).appTheme.darkText,
                                      BlendMode.srcIn)),
                              VerticalDivider(
                                      thickness: 1,
                                      indent: 2,
                                      endIndent: 20,
                                      width: 1,
                                      color: appColor(context).appTheme.stroke)
                                  .paddingSymmetric(horizontal: Insets.i9),
                              Expanded(
                                  child: Text(
                                      data!.serviceMan?.phoneNumber ?? "",
                                      overflow: TextOverflow.fade,
                                      style: appCss.dmDenseRegular12.textColor(
                                          appColor(context).appTheme.darkText)))
                            ])).padding(
                            horizontal: Insets.i10, bottom: Insets.i15),
                        if (data!.status != "Pending" &&
                            data!.status != "Completed" &&
                            data!.status != "Cancelled")
                          ViewLocationCommon(onTapArrow: locationTap)
                      ]).boxBorderExtension(context,
                      bColor: appColor(context).appTheme.stroke),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(language(context, appFonts.description),
                            style: appCss.dmDenseMedium12.textColor(
                                appColor(context).appTheme.lightText)),
                        const VSpace(Sizes.s6),
                        ReadMoreLayout(text: data!.notes ?? "")
                      ]).paddingSymmetric(vertical: Insets.i15),
                  data!.status == "Completed" || data!.status == "Cancelled"
                      ? CustomerLayout(
                          title: appFonts.customerDetails,
                          data: data!.serviceMan)
                      : CustomerServiceLayout(
                          title: appFonts.customerDetails,
                          image: data!.serviceMan?.firstname,
                          name: data!.serviceMan?.lastname,
                          status: data!.status,
                          chatTap: onChat,
                          moreTap: onMore,
                          phoneTap: onPhone),
                  if (isFreelancer != true) const VSpace(Sizes.s15),
                  if (isFreelancer != true)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DottedLines(),
                          const VSpace(Sizes.s10),
                          RichText(
                              text: TextSpan(
                                  style: appCss.dmDenseMedium12.textColor(data!
                                                  .status ==
                                              "Assigned" ||
                                          data!.status ==
                                              language(
                                                  context, appFonts.ongoing) ||
                                          data!.status == "Cancelled"
                                      ? appColor(context).appTheme.red
                                      : appColor(context).appTheme.darkText),
                                  text: language(context, appFonts.note),
                                  children: [
                                TextSpan(
                                    style: appCss.dmDenseRegular12.textColor(
                                        data!.status == "Assigned" ||
                                                data!.status ==
                                                    language(context,
                                                        appFonts.ongoing) ||
                                                data!.status == "Cancelled"
                                            ? appColor(context).appTheme.red
                                            : appColor(context)
                                                .appTheme
                                                .darkText),
                                    text: language(
                                        context,
                                        data!.status == "Assigned" ||
                                                data!.status ==
                                                    language(context,
                                                        appFonts.ongoing) ||
                                                data!.status == "Cancelled"
                                            ? appFonts.youAssignedService
                                            : appFonts.servicemenIsNotSelected))
                              ]))
                        ])
                ]).paddingAll(Insets.i15).boxBorderExtension(context,
                    bColor: appColor(context).appTheme.stroke,
                    color: appColor(context).appTheme.whiteBg,
                    isShadow: true)
              ])
            : Container());
  }
}
