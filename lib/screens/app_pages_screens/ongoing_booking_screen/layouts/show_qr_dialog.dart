import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/widgets/button_common.dart';

class ShowQrDialog extends StatelessWidget {
  final Booking booking;

  const ShowQrDialog({
    Key? key,
    required this.booking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: Insets.i20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(Insets.i20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  language(context, appFonts.generateQr),
                  style: appCss.dmDenseMedium18.textColor(
                    appColor(context).appTheme.darkText,
                  ),
                ),
                IconButton(
                  onPressed: () => route.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: appColor(context).appTheme.darkText,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 400,
            padding: const EdgeInsets.all(Insets.i20),
            margin: const EdgeInsets.all(Insets.i20),
            decoration: BoxDecoration(
              color: appColor(context).appTheme.fieldCardBg,
              borderRadius: BorderRadius.circular(AppRadius.r8),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: Sizes.s200,
                    width: Sizes.s200,
                    padding: const EdgeInsets.all(Insets.i8),
                    margin: const EdgeInsets.only(bottom: Insets.i16),
                    decoration: BoxDecoration(
                      color: appColor(context).appTheme.whiteBg,
                      borderRadius: BorderRadius.circular(AppRadius.r8),
                    ),
                    child: Image.memory(
                      base64Decode(booking.payment!.paymentQr!.qrDataUrl!
                          .replaceFirst(
                              RegExp(r'data:image/[^;]+;base64,'), '')),
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (booking.payment?.paymentQr?.accountName != null)
                    Text(
                      "${language(context, appFonts.holderName)}: ${booking.payment!.paymentQr!.accountName}",
                      style: appCss.dmDenseMedium16.textColor(
                        appColor(context).appTheme.darkText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (booking.payment?.paymentQr?.accountNumber != null)
                    Padding(
                      padding: const EdgeInsets.only(top: Insets.i8),
                      child: Text(
                        "${language(context, appFonts.accountNo)}: ${booking.payment!.paymentQr!.accountNumber}",
                        style: appCss.dmDenseRegular14.textColor(
                          appColor(context).appTheme.lightText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Insets.i20),
            child: ButtonCommon(
              title: language(context, appFonts.done),
              onTap: () => route.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
