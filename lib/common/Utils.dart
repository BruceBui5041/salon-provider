import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:logger/logger.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/common/fee_type.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/model/response/fee_res.dart';

class Utils {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  // Get travel fee tooltip for booking layouts
  static String getTravelFeeTooltip(Booking? booking, BuildContext context) {
    String tooltip = '';

    // Add distance and duration info
    if (booking?.bookingLocation != null) {
      final location = booking!.bookingLocation!;

      // Add customer address if available
      if (location.customerAddress?.text != null) {
        tooltip +=
            '${language(context, appFonts.location)}: ${location.customerAddress!.text}';
      }

      // Add serviceman address if available
      if (location.serviceManAddress?.text != null) {
        if (tooltip.isNotEmpty) tooltip += '\n\n';
        tooltip +=
            '${language(context, appFonts.servicemanLocation)}: ${location.serviceManAddress!.text}';
      }

      // Add a separator before distance info if we already have content
      if (tooltip.isNotEmpty &&
          (location.initialDistanceText != null ||
              location.initialDurationText != null)) {
        tooltip += '\n\n';
      }

      // Add distance info
      if (location.initialDistanceText != null) {
        tooltip +=
            '${language(context, appFonts.distance)}: ${location.initialDistanceText}';
      }

      // Add duration info
      if (location.initialDurationText != null) {
        tooltip +=
            '\n${language(context, appFonts.travelTime)}: ${location.initialDurationText}';
      }
    }

    // Add fee info
    if (booking?.fees != null && booking!.fees!.isNotEmpty) {
      final travelFee = booking.fees!.firstWhere(
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
        if (booking.bookingLocation?.initialDistance != null) {
          // Get the distance in km (initialDistance is in meters)
          double distanceInKm =
              booking.bookingLocation!.initialDistance! / 1000.0;

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

  // Debug level log
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  // Info level log
  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  // Warning level log
  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  // Error level log
  static void error(DioException e, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(e.response!.data['message'].toString(),
        error: error, stackTrace: stackTrace);
    // _logger.e(e)
    _logger.e(e.response!.data['log'], error: error, stackTrace: stackTrace);
  }

  // Verbose level log
  static void verbose(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(message, error: error, stackTrace: stackTrace);
  }

  // 2. compress file and get file.
  static Future<XFile?> compressAndGetFile(
      XFile file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 88,
      rotate: 180,
    );

    return result;
  }

  static void logError(DioException e) {
    _logger.e(
      "API Error",
      error: e,
      stackTrace: e.stackTrace,
    );
    if (e.response != null) {
      _logger.e(
        "Response Data",
        error: e.response?.data,
      );
    }
  }

  static void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    //show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Copied to clipboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
      ),
    );
  }
}
