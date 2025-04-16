import 'package:salon_provider/model/response/bank_account_res.dart';
import 'package:salon_provider/providers/app_pages_provider/payment_qr_provider.dart';
import 'package:salon_provider/widgets/cache_image.dart';
import '../../../config.dart';
import 'package:flutter/services.dart';

class PaymentQrScreen extends StatelessWidget {
  const PaymentQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentQrProvider>(builder: (context, provider, child) {
      return StatefulWrapper(
        onInit: () => Future.delayed(
            const Duration(milliseconds: 100), () => provider.onReady(context)),
        child: Scaffold(
          appBar: AppBarCommon(
            title: 'Payment QR',
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => provider.refreshBanks(context),
                tooltip: appFonts.refresh,
              ),
            ],
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(Insets.i20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ContainerWithTextLayout(
                        title: appFonts.selectBank,
                      ).paddingOnly(bottom: Insets.i12),
                      _buildBankSelector(context, provider),
                      const SizedBox(height: 24),
                      if (provider.selectedBank != null)
                        _buildSelectedBankCard(context, provider),
                      if (provider.selectedBank == null)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: Insets.i20, top: Insets.i5),
                          child: Text(
                            provider.errorMessage ??
                                'Please select a bank to generate QR code',
                            style: appCss.dmDenseMedium12.textColor(
                              appColor(context).appTheme.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ).paddingOnly(bottom: Insets.i100),
              ),
              Material(
                elevation: 20,
                child: BottomSheetButtonCommon(
                  textOne: language(context, appFonts.cancel),
                  textTwo: language(context, appFonts.generateQr),
                  clearTap: () => route.pop(context),
                  applyTap: () => provider.generateQrCode(context),
                ).paddingAll(Insets.i20).decorated(
                      color: appColor(context).appTheme.whiteBg,
                    ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBankSelector(BuildContext context, PaymentQrProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator())
          .paddingSymmetric(horizontal: Insets.i20);
    } else if (provider.bankAccounts.isEmpty) {
      return Center(
        child: Column(
          children: [
            Text(
              'No banks available',
              style: appCss.dmDenseMedium14,
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              icon: const Icon(Icons.refresh),
              label: Text(appFonts.refresh),
              onPressed: () => provider.refreshBanks(context),
            ),
          ],
        ),
      ).paddingSymmetric(horizontal: Insets.i20);
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: Insets.i20),
        child: DropdownButtonFormField<BankAccountRes>(
          value: provider.selectedBank,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            filled: true,
            fillColor: appColor(context).appTheme.whiteBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.r8),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SvgPicture.asset(
                eSvgAssets.bank,
                colorFilter: ColorFilter.mode(
                  provider.selectedBank == null
                      ? appColor(context).appTheme.lightText
                      : appColor(context).appTheme.darkText,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          hint: Text(
            "-- ${appFonts.selectBank} --",
            style: appCss.dmDenseMedium14.textColor(
              appColor(context).appTheme.lightText,
            ),
          ),
          items: provider.bankAccounts.map((bank) {
            return DropdownMenuItem<BankAccountRes>(
              value: bank,
              child: Row(
                children: [
                  Container(
                    height: Sizes.s40,
                    width: Sizes.s40,
                    decoration: BoxDecoration(
                      color: appColor(context).appTheme.fieldCardBg,
                      borderRadius: BorderRadius.circular(AppRadius.r8),
                    ),
                    child: bank.logo != null && bank.logo!.isNotEmpty
                        ? CacheImageWidget(
                            url: bank.logo,
                            width: Sizes.s40,
                            height: Sizes.s40,
                          )
                        : Icon(
                            Icons.account_balance,
                            size: Sizes.s24,
                            color: appColor(context).appTheme.lightText,
                          ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      bank.name ?? appFonts.bankName,
                      style: appCss.dmDenseMedium14.textColor(
                        appColor(context).appTheme.darkText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (BankAccountRes? bank) => provider.selectBank(bank),
          icon: SvgPicture.asset(
            eSvgAssets.dropDown,
            colorFilter: ColorFilter.mode(
              provider.selectedBank == null
                  ? appColor(context).appTheme.lightText
                  : appColor(context).appTheme.darkText,
              BlendMode.srcIn,
            ),
          ),
          isExpanded: true,
          dropdownColor: appColor(context).appTheme.whiteBg,
        ),
      );
    }
  }

  Widget _buildSelectedBankCard(
      BuildContext context, PaymentQrProvider provider) {
    return Container(
      padding: const EdgeInsets.all(Insets.i16),
      decoration: BoxDecoration(
        color: appColor(context).appTheme.whiteBg,
        borderRadius: BorderRadius.circular(AppRadius.r8),
        boxShadow: [
          BoxShadow(
            color: appColor(context).appTheme.darkText.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            language(context, appFonts.bank),
            style: appCss.dmDenseMedium14
                .textColor(appColor(context).appTheme.darkText),
          ),
          const SizedBox(height: Insets.i16),
          if (provider.selectedBank!.logo != null &&
              provider.selectedBank!.logo!.isNotEmpty)
            Center(
              child: Container(
                height: Sizes.s120,
                width: Sizes.s120,
                padding: const EdgeInsets.all(Insets.i8),
                decoration: BoxDecoration(
                  color: appColor(context).appTheme.fieldCardBg,
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                ),
                child: CacheImageWidget(
                  url: provider.selectedBank!.logo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          if (provider.selectedBank!.logo == null ||
              provider.selectedBank!.logo!.isEmpty)
            Center(
              child: Container(
                height: Sizes.s120,
                width: Sizes.s120,
                decoration: BoxDecoration(
                  color: appColor(context).appTheme.fieldCardBg,
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                ),
                child: Icon(
                  Icons.account_balance,
                  size: Sizes.s60,
                  color: appColor(context).appTheme.lightText,
                ),
              ),
            ),
          const SizedBox(height: Insets.i16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                provider.selectedBank!.name ??
                    language(context, appFonts.bankName),
                style: appCss.dmDenseMedium16
                    .textColor(appColor(context).appTheme.primary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (provider.selectedBank!.code != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    '${language(context, appFonts.ifscCode)}: ${provider.selectedBank!.code}',
                    style: appCss.dmDenseRegular14
                        .textColor(appColor(context).appTheme.lightText),
                  ),
                ),
              if (provider.selectedBank!.accountName != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '${language(context, appFonts.holderName)}: ${provider.selectedBank!.accountName}',
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.darkText),
                  ),
                ),
              if (provider.selectedBank!.accountNumber != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${language(context, appFonts.accountNo)}: ${provider.selectedBank!.accountNumber}',
                          style: appCss.dmDenseMedium14
                              .textColor(appColor(context).appTheme.darkText),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text: provider.selectedBank!.accountNumber!));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text(language(context, appFonts.accountNo)),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: Insets.i20);
  }
}
