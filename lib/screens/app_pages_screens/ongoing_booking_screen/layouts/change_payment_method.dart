import 'package:flutter/material.dart';
import '../../../../config.dart';
import '../../../../common/payment_method.dart';

class ChangePaymentMethodSheet extends StatefulWidget {
  final PaymentMethod? initialMethod;
  final Function(PaymentMethod, BuildContext) onContinue;

  const ChangePaymentMethodSheet({
    super.key,
    this.initialMethod,
    required this.onContinue,
  });

  @override
  State<ChangePaymentMethodSheet> createState() =>
      _ChangePaymentMethodSheetState();
}

class _ChangePaymentMethodSheetState extends State<ChangePaymentMethodSheet> {
  late PaymentMethod selectedMethod;

  @override
  void initState() {
    super.initState();
    selectedMethod = widget.initialMethod ?? PaymentMethod.cash;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Insets.i20),
      decoration: BoxDecoration(
        color: appColor(context).appTheme.whiteBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.s25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            language(context, appFonts.selectPaymentMethod),
            style: appCss.dmDenseMedium16.textColor(
              appColor(context).appTheme.primary,
            ),
          ),
          const VSpace(Sizes.s20),
          ...PaymentMethod.values.map((method) {
            final isSelected = selectedMethod == method;
            return Container(
              margin: const EdgeInsets.only(bottom: Insets.i10),
              decoration: BoxDecoration(
                border: isSelected
                    ? Border.all(
                        color: appColor(context).appTheme.primary,
                        width: 2,
                      )
                    : null,
                borderRadius: BorderRadius.circular(AppRadius.r8),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: appColor(context).appTheme.primary,
                  radioTheme: RadioThemeData(
                    fillColor: WidgetStateProperty.resolveWith(
                        (states) => appColor(context).appTheme.primary),
                    overlayColor: WidgetStateProperty.resolveWith((states) =>
                        appColor(context).appTheme.primary.withOpacity(0.1)),
                  ),
                ),
                child: RadioListTile<PaymentMethod>(
                  title: Text(
                    method.value.toUpperCase(),
                    style: appCss.dmDenseRegular14.textColor(
                      appColor(context).appTheme.primary,
                    ),
                  ),
                  value: method,
                  groupValue: selectedMethod,
                  activeColor: appColor(context).appTheme.primary,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: Insets.i15),
                  onChanged: (PaymentMethod? value) {
                    if (value != null) {
                      setState(() => selectedMethod = value);
                    }
                  },
                ),
              ),
            );
          }),
          const VSpace(Sizes.s20),
          ButtonCommon(
            title: language(context, appFonts.continues),
            onTap: () {
              final method = selectedMethod;
              final ctx = context;
              route.pop(context);
              widget.onContinue(method, ctx);
            },
          ),
        ],
      ),
    );
  }
}
