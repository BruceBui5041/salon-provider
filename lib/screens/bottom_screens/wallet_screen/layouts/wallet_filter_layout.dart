import 'package:flutter/cupertino.dart';
import '../../../../config.dart';
import '../../../../common/enum_value.dart';

class WalletFilterLayout extends StatelessWidget {
  const WalletFilterLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<WalletProvider>(context);
    final statusList = PaymentStatus.values
        .map((status) => status.value.capitalizeFirst())
        .toList();
    statusList.insert(0, "All");

    return SizedBox(
      height: Sizes.s600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(CupertinoIcons.multiply).inkWell(
                onTap: () => route.pop(context),
              ),
            ],
          ).paddingSymmetric(horizontal: Insets.i20),
          Text(
            language(context, appFonts.status),
            style: appCss.dmDenseMedium14.textColor(
              appColor(context).appTheme.lightText,
            ),
          ).paddingOnly(top: Insets.i25, left: Insets.i20, right: Insets.i20),
          const VSpace(Sizes.s15),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: statusList.asMap().entries.map((e) {
                  final isSelected = value.statusIndex == e.key;
                  return Container(
                    margin: const EdgeInsets.only(bottom: Insets.i15),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Insets.i15,
                      vertical: Insets.i12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? appColor(context).appTheme.primary
                          : appColor(context).appTheme.fieldCardBg,
                      borderRadius: BorderRadius.circular(AppRadius.r10),
                      border: Border.all(
                        color: isSelected
                            ? appColor(context).appTheme.primary
                            : appColor(context)
                                .appTheme
                                .lightText
                                .withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          e.value,
                          style: appCss.dmDenseMedium14.textColor(
                            isSelected
                                ? appColor(context).appTheme.whiteColor
                                : appColor(context).appTheme.darkText,
                          ),
                        ),
                      ],
                    ),
                  ).inkWell(onTap: () => value.onStatus(e.key));
                }).toList(),
              ).paddingSymmetric(horizontal: Insets.i20),
            ),
          ),
          BottomSheetButtonCommon(
            textOne: language(context, appFonts.clearAll),
            textTwo: language(context, appFonts.apply),
            applyTap: () => value.onApplyFilter(context),
            clearTap: () => value.onClearFilter(context),
          ).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i20),
        ],
      ),
    ).bottomSheetExtension(context);
  }
}
