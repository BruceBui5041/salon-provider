import '../config.dart';

Color colorCondition(String? text, context) {
  if (text == appFonts.pending) {
    return appColor(context).appTheme.pending;
  } else if (text == appFonts.accepted) {
    return appColor(context).appTheme.accepted;
  } else if (text == appFonts.ongoing) {
    return appColor(context).appTheme.ongoing;
  } else if (text == appFonts.cancelled) {
    return appColor(context).appTheme.red;
  } else if (text == appFonts.pendingApproval) {
    return appColor(context).appTheme.pendingApproval;
  } else if (text == appFonts.hold) {
    return appColor(context).appTheme.hold;
  } else if (text == appFonts.assigned) {
    return appColor(context).appTheme.assign;
  } else {
    return appColor(context).appTheme.primary;
  }
}

starCondition(String? rate) {
  if (rate == "0") {
    return eSvgAssets.star;
  } else if (rate == "0.5") {
    return eSvgAssets.star;
  } else if (rate == "1") {
    return eSvgAssets.star1;
  } else if (rate == "1.5") {
    return eSvgAssets.star1;
  } else if (rate == "2") {
    return eSvgAssets.star2;
  } else if (rate == "3") {
    return eSvgAssets.star3;
  } else if (rate == "4") {
    return eSvgAssets.star4;
  } else if (rate == "5") {
    return eSvgAssets.star5;
  } else {
    return eSvgAssets.star3;
  }
}

String monthCondition(String? text) {
  if (text == '1') {
    return "JAN";
  } else if (text == '2') {
    return "FEB";
  } else if (text == '3') {
    return "MAR";
  } else if (text == '4') {
    return "APR";
  } else if (text == '5') {
    return "MAY";
  } else if (text == '6') {
    return "JUN";
  } else if (text == '7') {
    return "JUL";
  } else if (text == '8') {
    return "AUG";
  } else if (text == '9') {
    return "SEP";
  } else if (text == '10') {
    return "OCT";
  } else if (text == "11") {
    return "NOV";
  } else if (text == '12') {
    return "DEC";
  } else {
    return "JAN";
  }
}

String getBookingEventTitle(String? event) {
  switch (event) {
    case 'booking_placed':
    case 'booking_created':
      return appFonts.newBookingRequest;
    case 'booking_confirmed':
    case 'booking_accepted':
      return appFonts.bookingConfirmed;
    case 'booking_confirmed_paid':
      return appFonts.paymentConfirmed;
    case 'booking_cancelled':
      return appFonts.bookingCancelled;
    case 'booking_completed':
      return appFonts.serviceCompleted;
    case 'booking_in_progress':
      return appFonts.serviceStarted;
    default:
      return event
              ?.split('_')
              .map((word) => word.isEmpty
                  ? ''
                  : '${word[0].toUpperCase()}${word.substring(1)}')
              .join(' ') ??
          '';
  }
}

String getBookingEventDescription(
  BuildContext context, {
  required String? event,
  required Map<String, dynamic>? metadata,
  required String bookingId,
  required String userName,
  required String userPhone,
  required String serviceManName,
  required String serviceTitles,
}) {
  if (event == null) return '';

  switch (event) {
    case 'booking_placed':
    case 'booking_created':
      final phoneText = userPhone.isNotEmpty ? ' ($userPhone)' : '';
      return language(context, appFonts.newBookingPlacedBy)
          .replaceAll('{bookingId}', bookingId)
          .replaceAll('{userName}', userName)
          .replaceAll('{phone}', phoneText)
          .replaceAll('{services}', serviceTitles);

    case 'booking_confirmed':
    case 'booking_accepted':
      return language(context, appFonts.bookingConfirmedReady)
          .replaceAll('{bookingId}', bookingId)
          .replaceAll('{services}', serviceTitles);

    case 'booking_confirmed_paid':
      return language(context, appFonts.paymentConfirmedFor)
          .replaceAll('{bookingId}', bookingId);

    case 'booking_cancelled':
      final cancelledBy = metadata?['cancelled_by'] == 'user'
          ? userName
          : language(context, appFonts.provider);
      return language(context, appFonts.bookingCancelledBy)
          .replaceAll('{bookingId}', bookingId)
          .replaceAll('{cancelledBy}', cancelledBy)
          .replaceAll('{services}', serviceTitles);

    case 'booking_completed':
      return language(context, appFonts.serviceCompletedBy)
          .replaceAll('{bookingId}', bookingId)
          .replaceAll('{services}', serviceTitles)
          .replaceAll('{servicemanName}', serviceManName);

    case 'booking_in_progress':
      return language(context, appFonts.serviceStartedBy)
          .replaceAll('{servicemanName}', serviceManName)
          .replaceAll('{bookingId}', bookingId)
          .replaceAll('{services}', serviceTitles);

    default:
      return '';
  }
}

Color getBookingEventStatusColor(BuildContext context, String? event) {
  if (event == null) return appColor(context).appTheme.darkText;

  switch (event.toLowerCase()) {
    case 'booking_placed':
    case 'booking_created':
      return appColor(context).appTheme.primary;
    case 'booking_confirmed':
    case 'booking_accepted':
    case 'booking_confirmed_paid':
    case 'booking_completed':
      return appColor(context).appTheme.green;
    case 'booking_in_progress':
      return appColor(context).appTheme.assign;
    case 'booking_cancelled':
      return appColor(context).appTheme.red;
    default:
      return appColor(context).appTheme.primary;
  }
}

String getBookingEventIcon(String? event) {
  switch (event) {
    case 'booking_placed':
    case 'booking_created':
      return eSvgAssets.user;
    case 'booking_confirmed':
    case 'booking_accepted':
    case 'booking_in_progress':
      return eSvgAssets.receipt;
    case 'booking_cancelled':
      return eSvgAssets.clock;
    case 'booking_completed':
      return eSvgAssets.wallet;
    default:
      return eSvgAssets.user;
  }
}
