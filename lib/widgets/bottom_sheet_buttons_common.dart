import '../config.dart';

class BottomSheetButtonCommon extends StatelessWidget {
  final GestureTapCallback? clearTap, applyTap;
  final String? textOne, textTwo;
  final Color? buttonOneColor;
  final Color? buttonTwoColor;

  const BottomSheetButtonCommon({
    super.key,
    this.applyTap,
    this.clearTap,
    this.textOne,
    this.textTwo,
    this.buttonOneColor,
    this.buttonTwoColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: textOne != null
            ? ButtonCommon(
                title: textOne,
                onTap: clearTap,
                style: appCss.dmDenseRegular16.textColor(
                  buttonOneColor ?? appColor(context).appTheme.primary,
                ),
                color: appColor(context).appTheme.trans,
                borderColor:
                    buttonOneColor ?? appColor(context).appTheme.primary,
              )
            : const SizedBox(),
      ),
      const HSpace(Sizes.s15),
      Expanded(
        child: textTwo != null
            ? ButtonCommon(
                title: textTwo,
                onTap: applyTap,
                color: buttonTwoColor ?? appColor(context).appTheme.primary)
            : const SizedBox(),
      )
    ]);
  }
}
