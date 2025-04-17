import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/response/bank_account_res.dart';
import 'package:salon_provider/model/response/payment_response.dart';
import 'package:salon_provider/widgets/cache_image.dart';

class QrGenerateDialog extends StatelessWidget {
  final BankAccountRes? selectedBank;
  final Payment? payment;
  final String? paymentId;
  final bool isGeneratingQr;
  final Function() onGenerateQr;

  const QrGenerateDialog({
    Key? key,
    required this.selectedBank,
    required this.payment,
    required this.paymentId,
    required this.isGeneratingQr,
    required this.onGenerateQr,
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
            height: 300,
            padding: const EdgeInsets.all(Insets.i20),
            margin: const EdgeInsets.all(Insets.i20),
            decoration: BoxDecoration(
              color: appColor(context).appTheme.fieldCardBg,
              borderRadius: BorderRadius.circular(AppRadius.r8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (payment?.paymentQr?.qrDataUrl != null) ...[
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
                      base64Decode(payment!.paymentQr!.qrDataUrl!),
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (payment?.paymentQr?.accountName != null)
                    Text(
                      "${language(context, appFonts.holderName)}: ${payment!.paymentQr!.accountName}",
                      style: appCss.dmDenseMedium16.textColor(
                        appColor(context).appTheme.darkText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (payment?.paymentQr?.accountNumber != null)
                    Padding(
                      padding: const EdgeInsets.only(top: Insets.i8),
                      child: Text(
                        "${language(context, appFonts.accountNo)}: ${payment!.paymentQr!.accountNumber}",
                        style: appCss.dmDenseRegular14.textColor(
                          appColor(context).appTheme.lightText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ] else ...[
                  if (selectedBank?.logo != null &&
                      selectedBank!.logo!.isNotEmpty)
                    Container(
                      height: Sizes.s80,
                      width: Sizes.s80,
                      padding: const EdgeInsets.all(Insets.i8),
                      margin: const EdgeInsets.only(bottom: Insets.i16),
                      decoration: BoxDecoration(
                        color: appColor(context).appTheme.whiteBg,
                        borderRadius: BorderRadius.circular(AppRadius.r8),
                      ),
                      child: CacheImageWidget(
                        url: selectedBank!.logo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  Text(
                    selectedBank?.name ?? '',
                    style: appCss.dmDenseMedium16.textColor(
                      appColor(context).appTheme.darkText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (selectedBank?.accountNumber != null)
                    Padding(
                      padding: const EdgeInsets.only(top: Insets.i8),
                      child: Text(
                        selectedBank!.accountNumber!,
                        style: appCss.dmDenseRegular14.textColor(
                          appColor(context).appTheme.lightText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Insets.i20),
            child: payment?.paymentQr != null
                ? ButtonCommon(
                    title: language(context, appFonts.done),
                    onTap: () => route.pop(context),
                  )
                : isGeneratingQr
                    ? const Center(child: CircularProgressIndicator())
                    : ButtonCommon(
                        title: language(context, appFonts.generateQr),
                        onTap: onGenerateQr,
                      ),
          ),
        ],
      ),
    );
  }
}
