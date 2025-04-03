import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/screens/bottom_screens/booking_screen/layouts/service_provider_layout.dart'
    as booking;

/// A custom layout widget for displaying booking information.
///
/// This widget displays booking details including service information, pricing,
/// status, and service provider details. It also handles booking actions like
/// accept and reject.
class CustomBookingLayout extends StatelessWidget {
  final ItemBooking? data;
  final GestureTapCallback? onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const CustomBookingLayout({
    super.key,
    this.data,
    this.onTap,
    this.onAccept,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final theme = appColor(context).appTheme;

    return _BookingCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BookingHeader(data: data, theme: theme),
          const VSpace(Sizes.s12),
          Image.asset(eImageAssets.bulletDotted),
          const VSpace(Sizes.s12),
          _BookingDetails(data: data, theme: theme),
          if (data?.serviceMan != null) ...[
            const VSpace(Sizes.s12),
            _ServiceProviderSection(data: data),
          ],
          const DottedLines(),
          if (data?.notes?.isNotEmpty == true) ...[
            const VSpace(Sizes.s8),
            _BookingNotes(data: data, theme: theme),
          ],
          if (data?.status == appFonts.pending && data?.serviceMan == null) ...[
            const VSpace(Sizes.s15),
            _BookingActions(
              onAccept: onAccept,
              onReject: onReject,
              theme: theme,
            ),
          ],
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onTap;

  const _BookingCard({
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .padding(
          horizontal: Insets.i15,
          top: Insets.i15,
          bottom: Insets.i15,
        )
        .boxBorderExtension(
          context,
          isShadow: true,
          bColor: appColor(context).appTheme.stroke,
        )
        .paddingOnly(bottom: Insets.i15)
        .inkWell(onTap: onTap);
  }
}

class _BookingHeader extends StatelessWidget {
  final ItemBooking? data;
  final dynamic theme;

  const _BookingHeader({
    required this.data,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _BookingInfo(data: data, theme: theme),
        if (data?.serviceVersions?.firstOrNull?.mainImageResponse?.url != null)
          _ServiceImage(data: data),
      ],
    );
  }
}

class _BookingInfo extends StatelessWidget {
  final ItemBooking? data;
  final dynamic theme;

  const _BookingInfo({
    required this.data,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              data?.id ?? '',
              style: appCss.dmDenseMedium14.textColor(theme.primary),
            ),
          ],
        ),
        Text(
          data?.serviceVersions?.firstOrNull?.title ?? '',
          style: appCss.dmDenseMedium16.textColor(theme.darkText),
        ).paddingOnly(top: Insets.i8, bottom: Insets.i3),
        Row(
          children: [
            Text(
              "\$${data?.discountedPrice?.toCurrencyVnd() ?? '0'.toCurrencyVnd()}",
              style: appCss.dmDenseBold18.textColor(theme.primary),
            ),
          ],
        ),
      ],
    );
  }
}

class _ServiceImage extends StatelessWidget {
  final ItemBooking? data;

  const _ServiceImage({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.s84,
      width: Sizes.s84,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(
            data!.serviceVersions!.first!.mainImageResponse!.url!,
          ),
          fit: BoxFit.cover,
        ),
        shape: const SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius.all(
            SmoothRadius(cornerRadius: AppRadius.r10, cornerSmoothing: 1),
          ),
        ),
      ),
    );
  }
}

class _BookingDetails extends StatelessWidget {
  final ItemBooking? data;
  final dynamic theme;

  const _BookingDetails({
    required this.data,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatusRow(
          title: appFonts.status,
          statusText: data?.bookingStatus ?? '',
        ),
        StatusRow(
          title: appFonts.dateTime,
          title2: data?.bookingDate.toString() ?? '',
          style: appCss.dmDenseMedium12.textColor(theme.darkText),
        ),
        StatusRow(
          title: appFonts.location,
          title2: data?.serviceVersions?.firstOrNull?.description ?? '',
          style: appCss.dmDenseMedium12.textColor(theme.darkText),
        ),
        StatusRow(
          title: appFonts.payment,
          title2: data?.price?.toCurrencyVnd() ?? '',
          style: appCss.dmDenseMedium12.textColor(theme.online),
        ),
      ],
    );
  }
}

class _ServiceProviderSection extends StatelessWidget {
  final ItemBooking? data;

  const _ServiceProviderSection({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            booking.ServiceProviderLayout(
              title: appFonts.serviceman,
              name:
                  "${data?.serviceMan?.firstname ?? ''} ${data?.serviceMan?.lastname ?? ''}",
              image: eImageAssets.user,
              rate: "5.0",
              index: 0,
              list: [data?.serviceMan],
            ),
          ],
        )
            .paddingSymmetric(horizontal: Insets.i15, vertical: Insets.i5)
            .boxShapeExtension(
              color: appColor(context).appTheme.fieldCardBg,
              radius: AppRadius.r12,
            )
            .paddingOnly(bottom: Insets.i15),
      ],
    );
  }
}

class _BookingNotes extends StatelessWidget {
  final ItemBooking? data;
  final dynamic theme;

  const _BookingNotes({
    required this.data,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data!.notes!,
      style: appCss.dmDenseRegular12.textColor(theme.lightText),
    );
  }
}

class _BookingActions extends StatelessWidget {
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final dynamic theme;

  const _BookingActions({
    required this.onAccept,
    required this.onReject,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonCommon(
            title: appFonts.reject,
            onTap: onReject,
            style: appCss.dmDenseSemiBold16.textColor(theme.primary),
            color: theme.trans,
            borderColor: theme.primary,
          ),
        ),
        const HSpace(Sizes.s15),
        Expanded(
          child: ButtonCommon(
            title: appFonts.accept,
            onTap: onAccept,
          ),
        ),
      ],
    );
  }
}
