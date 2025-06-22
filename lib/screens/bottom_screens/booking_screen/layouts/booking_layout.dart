import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:salon_provider/common/fee_type.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/response/booking_location_res.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/model/response/fee_res.dart';
import 'package:salon_provider/screens/bottom_screens/booking_screen/layouts/service_provider_layout.dart'
    as booking;

/// A custom layout widget for displaying booking information.
///
/// This widget displays booking details including service information, pricing,
/// status, and service provider details. It also handles booking actions like
/// accept and reject.
class BookingLayout extends StatelessWidget {
  final Booking? data;
  final GestureTapCallback? onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const BookingLayout({
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
  final Booking? data;
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
  final Booking? data;
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
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ).paddingOnly(top: Insets.i8, bottom: Insets.i3),
        Row(
          children: [
            Text(
              data?.discountedPrice?.toCurrencyVnd() ?? '0'.toCurrencyVnd(),
              style: appCss.dmDenseBold18.textColor(theme.primary),
            ),
          ],
        ),
      ],
    );
  }
}

class _ServiceImage extends StatelessWidget {
  final Booking? data;

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
            data!.serviceVersions!.first.mainImageResponse!.url!,
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
  final Booking? data;
  final dynamic theme;

  const _BookingDetails({
    required this.data,
    required this.theme,
  });

  String _getLocationText(Booking? data) {
    if (data?.bookingLocation?.customerAddress?.text != null) {
      return data!.bookingLocation!.customerAddress!.text!;
    }
    return '';
  }

  String _getTravelDistanceText(Booking? data) {
    if (data?.bookingLocation != null) {
      final location = data!.bookingLocation!;
      if (location.initialDistanceText != null &&
          location.initialDurationText != null) {
        return '${location.initialDistanceText} (${location.initialDurationText})';
      } else if (location.initialDistanceText != null) {
        return location.initialDistanceText!;
      } else if (location.initialDurationText != null) {
        return location.initialDurationText!;
      }
    }
    return '';
  }

  String _getTravelFeeValue(Booking? data, BuildContext context) {
    if (data?.fees != null && data!.fees!.isNotEmpty) {
      final travelFee = data.fees!.firstWhere(
        (fee) => fee.type == FeeType.travelFeePerKm,
        orElse: () => Fee(
          id: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          status: '',
          travelFeePerKm: null,
        ),
      );

      if (travelFee.travelFeePerKm != null) {
        // Calculate actual charged fee if we have distance info
        if (data.bookingLocation?.initialDistance != null) {
          // Get the distance in km (initialDistance is in meters)
          double distanceInKm = data.bookingLocation!.initialDistance! / 1000.0;

          // Parse the fee per km as double
          double? feePerKm = double.tryParse(travelFee.travelFeePerKm!);

          if (feePerKm != null) {
            // Check if free travel applies
            double freeTravelThreshold = 0.0;
            if (travelFee.freeTravelFeeAt != null) {
              freeTravelThreshold =
                  double.tryParse(travelFee.freeTravelFeeAt!) ?? 0.0;
            }

            // Calculate the charged fee based on the distance exceeding the free threshold
            if (distanceInKm > freeTravelThreshold) {
              // Only charge for distance beyond the free threshold
              double chargeableDistance = distanceInKm - freeTravelThreshold;
              double chargedFee = feePerKm * chargeableDistance;
              return chargedFee.toStringAsFixed(0).toCurrencyVnd();
            } else {
              return language(context, appFonts.free);
            }
          }
        }
        return '${travelFee.travelFeePerKm} / km';
      }
    }
    return '';
  }

  String _getTravelFeeTooltip(Booking? data, BuildContext context) {
    String tooltip = '';

    // Add distance and duration info
    if (data?.bookingLocation != null) {
      final location = data!.bookingLocation!;
      if (location.initialDistanceText != null) {
        tooltip +=
            '${language(context, appFonts.distance)}: ${location.initialDistanceText}';
      }

      if (location.initialDurationText != null) {
        tooltip +=
            '\n${language(context, appFonts.travelTime)}: ${location.initialDurationText}';
      }
    }

    // Add fee info
    if (data?.fees != null && data!.fees!.isNotEmpty) {
      final travelFee = data.fees!.firstWhere(
        (fee) => fee.type == FeeType.travelFeePerKm,
        orElse: () => Fee(
          id: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          status: '',
          travelFeePerKm: null,
        ),
      );

      if (travelFee.travelFeePerKm != null) {
        // Add a separator if we already have content
        if (tooltip.isNotEmpty) {
          tooltip += '\n\n';
        }

        // Format the base fee text
        tooltip +=
            '${language(context, appFonts.travelFee)}: ${travelFee.travelFeePerKm} / km';

        // Add free travel info
        if (travelFee.freeTravelFeeAt != null) {
          tooltip +=
              '\n${language(context, appFonts.freeUnder)} ${travelFee.freeTravelFeeAt} km';
        }

        // Calculate actual charged fee if we have distance info
        if (data.bookingLocation?.initialDistance != null) {
          // Get the distance in km (initialDistance is in meters)
          double distanceInKm = data.bookingLocation!.initialDistance! / 1000.0;

          // Parse the fee per km as double
          double? feePerKm = double.tryParse(travelFee.travelFeePerKm!);

          if (feePerKm != null) {
            // Check if free travel applies
            double freeTravelThreshold = 0.0;
            if (travelFee.freeTravelFeeAt != null) {
              freeTravelThreshold =
                  double.tryParse(travelFee.freeTravelFeeAt!) ?? 0.0;
            }

            // Calculate the charged fee based on the distance exceeding the free threshold
            double chargedFee = 0.0;
            if (distanceInKm > freeTravelThreshold) {
              // Only charge for distance beyond the free threshold
              double chargeableDistance = distanceInKm - freeTravelThreshold;
              chargedFee = feePerKm * chargeableDistance;

              // Add charged distance information
              tooltip +=
                  '\n${language(context, appFonts.chargedDistance)}: ${chargeableDistance.toStringAsFixed(1)} km';

              // Add payment information
              tooltip +=
                  '\n${language(context, appFonts.payment)}: ${chargedFee.toStringAsFixed(0).toCurrencyVnd()}';
            } else if (freeTravelThreshold > 0) {
              tooltip +=
                  '\n${language(context, appFonts.payment)}: ${language(context, appFonts.free)}';
            }
          }
        }
      }
    }

    return tooltip;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatusRow(
          title: appFonts.status,
          statusText: data?.bookingStatus?.value ?? '',
        ),
        StatusRow(
          title: appFonts.dateTime,
          title2: data?.bookingDate.toString() ?? '',
          style: appCss.dmDenseMedium12.textColor(theme.darkText),
        ),
        StatusRow(
          title: appFonts.location,
          title2: _getLocationText(data),
          style: appCss.dmDenseMedium12.textColor(theme.darkText),
          maxLines: 2,
        ),
        StatusRow(
          title: language(context, appFonts.travelFee),
          title2: _getTravelFeeValue(data, context),
          style: appCss.dmDenseMedium12.textColor(theme.darkText),
          infoTooltip: _getTravelFeeTooltip(data, context),
        ),
        StatusRow(
          title: appFonts.payment,
          title2: data?.discountedPrice?.toCurrencyVnd() ?? '',
          style: appCss.dmDenseMedium12.textColor(theme.online),
        ),
      ],
    );
  }
}

class _ServiceProviderSection extends StatelessWidget {
  final Booking? data;

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
  final Booking? data;
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
