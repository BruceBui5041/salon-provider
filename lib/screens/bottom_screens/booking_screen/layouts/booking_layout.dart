import '../../../../config.dart';
import '../../../../model/booking_model.dart';

class BookingLayout extends StatelessWidget {
  final BookingModel? data;
  final GestureTapCallback? onTap;

  const BookingLayout({super.key, this.data,this.onTap});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<BookingProvider>(context, listen: true);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(data!.bookingNumber!,
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.primary)),
            const HSpace(Sizes.s5),
            if (data!.packageId != null)
              BookingStatusLayout(title: appFonts.package)
          ]),

          Text(language(context, data!.name!),
              style: appCss.dmDenseMedium16
                  .textColor(appColor(context).appTheme.darkText)).paddingOnly(top: Insets.i8,bottom: Insets.i3),
          Row(children: [
            Text(language(context, "\$${data!.price!}"),
                style: appCss.dmDenseBold18
                    .textColor(appColor(context).appTheme.primary)),
            const HSpace(Sizes.s8),
            if (data!.offer != null)
              Text(language(context, "(${data!.offer!})"),
                  style: appCss.dmDenseMedium14
                      .textColor(appColor(context).appTheme.red))
          ])
        ]),
        Container(
            height: Sizes.s84,
            width: Sizes.s84,
            decoration: ShapeDecoration(
                image: DecorationImage(
                    image: AssetImage(data!.image!), fit: BoxFit.cover),
                shape: const SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius.all(SmoothRadius(
                        cornerRadius: AppRadius.r10, cornerSmoothing: 1)))))
      ]),
      Image.asset(eImageAssets.bulletDotted)
          .paddingSymmetric(vertical: Insets.i12),
      StatusRow(title: appFonts.status, statusText: data!.status!),
      if (data!.status != appFonts.cancelled)
        StatusRow(
            title: appFonts.requiredServiceman,
            title2:
                "${data!.requiredServicemen} ${language(context, appFonts.serviceman)}",
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.darkText)),
      StatusRow(
          title: appFonts.dateTime,
          title2: data!.dateTime!,

          style: appCss.dmDenseMedium12
              .textColor(appColor(context).appTheme.darkText)),
     /* if (data!.status! == appFonts.pending &&
          data!.status != appFonts.cancelled)*/
        StatusRow(
            title: appFonts.location,
            title2: data!.location!,
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.darkText)),
      if (data!.status != appFonts.cancelled  )
        StatusRow(
            title: appFonts.payment,
            title2: data!.payment!,
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.online)),
          const DottedLines().paddingOnly(bottom: Insets.i15),
      Stack(alignment: Alignment.bottomCenter, children: [
        Column(children: [
          if (data!.customerList != null)
            ...data!.customerList!
                .asMap()
                .entries
                .map((s) => ServiceProviderLayout(
              expand: value.isExpand,
                title: appFonts.customer,
                image: s.value.image,
                name: s.value.title,
                rate: s.value.rate,
                index: s.key,
                list2: data!.servicemanLists,
                list: data!.servicemanLists))
                .toList(),
          if (data!.servicemanLists!.isNotEmpty)
            data!.isExpand == true
                ? Column(
                    children: data!.servicemanLists!.asMap().entries.map((s) {
                    return ServiceProviderLayout(
                        expand: value.isExpand,
                        title: appFonts.serviceman,
                        image: s.value.image,
                        name: s.value.title,
                        rate: s.value.rate,
                        index: s.key,
                        list: data!.servicemanLists);
                  }).toList())
                : Column(
                    children: data!.servicemanLists!
                        .getRange(0, 1)
                        .toList()
                        .asMap()
                        .entries
                        .map((s) {
                    return ServiceProviderLayout(
                        expand: value.isExpand,
                        title: appFonts.serviceman,
                        image: s.value.image,
                        name: s.value.title,
                        rate: s.value.rate,
                        index: s.key,
                        list:  []);
                  }).toList()),

        ])
            .paddingSymmetric(horizontal: Insets.i15,vertical: Insets.i5)
            .boxShapeExtension(
                color: appColor(context).appTheme.fieldCardBg,
                radius: AppRadius.r12)
            .paddingOnly(
                bottom: data!.servicemanLists!.length > 1 ? Insets.i15 : 0),

        if (data!.servicemanLists != null)
          if (data!.servicemanLists!.length > 1)
            CommonArrow(
                arrow: data!.isExpand == true
                    ? eSvgAssets.upDoubleArrow
                    : eSvgAssets.downDoubleArrow,
                isThirteen: true,
                onTap: () => value.onExpand(data),
                color: appColor(context).appTheme.whiteBg)
      ]),
      if(data!.servicemanLists!.isEmpty && data!.status == appFonts.pending )
        Text(language(context, appFonts.noteServicemenNotSelectYet),style: appCss.dmDenseRegular12.textColor(appColor(context).appTheme.lightText)).paddingOnly(top: Insets.i8),

          if(data!.servicemanLists!.isEmpty && data!.status == appFonts.assigned || (data!.servicemanLists!.isEmpty && data!.status == appFonts.accepted))
            RichText(
                text: TextSpan(
                    style: appCss.dmDenseMedium12.textColor(appColor(context).appTheme.red),
                    text: language(context, appFonts.note),
                    children: [
                      TextSpan(
                          style: appCss.dmDenseRegular12.textColor(appColor(context).appTheme.red),
                          text: language(context,appFonts.youAssignedService))
                    ])).paddingOnly(top: Insets.i8),

          if(data!.servicemanLists!.isEmpty && data!.status == appFonts.ongoing)
            if(isFreelancer != true)
            RichText(
                text: TextSpan(
                    style: appCss.dmDenseMedium12.textColor(appColor(context).appTheme.red),
                    text: language(context, appFonts.note),
                    children: [
                      TextSpan(
                          style: appCss.dmDenseRegular12.textColor(appColor(context).appTheme.red),
                          text: language(context,appFonts.youAssignedService))
                    ])).paddingOnly(top: Insets.i8),
          if(data!.status == appFonts.pending && data!.servicemanLists!.isEmpty)
        Row(children: [
          Expanded(
              child: ButtonCommon(
                  title: appFonts.reject,
                  onTap: ()=> value.onRejectBooking(context),
                  style: appCss.dmDenseSemiBold16
                      .textColor(appColor(context).appTheme.primary),
                  color: appColor(context).appTheme.trans,
                  borderColor: appColor(context).appTheme.primary)),
          const HSpace(Sizes.s15),
          Expanded(child: ButtonCommon(title: appFonts.accept,onTap: ()=> value.onAcceptBooking(context)))
        ]).paddingOnly(top: Insets.i15)
    ])
        .padding(horizontal: Insets.i15,top: Insets.i15, bottom: data!.servicemanLists!.length > 1 ? 0 : Insets.i15 )
        .boxBorderExtension(context,isShadow: true,bColor: appColor(context).appTheme.stroke)
        .paddingOnly(bottom: Insets.i15).inkWell(onTap: onTap);
  }
}
