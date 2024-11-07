import '../../../../config.dart';

class AssignStatusLayout extends StatelessWidget {
  final String? title,status;
  final bool? isGreen;
  const AssignStatusLayout({super.key, this.title, this.isGreen = false, this.status});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(language(context, "${ language(context, status) ?? language(context, appFonts.status)}:"),
                style: appCss.dmDenseMedium14
                    .textColor( isGreen == true ? appColor(context).appTheme.online : appColor(context).appTheme.red)),
            const HSpace(Sizes.s10),
            Text(language(context, title),
                overflow: TextOverflow.fade,
                style: appCss.dmDenseRegular14.textColor(
                    isGreen == true ? appColor(context).appTheme.online : appColor(context).appTheme.red)).width(Sizes.s250)
          ]).paddingAll(Insets.i15).boxShapeExtension(
        radius: 0,
          color:
          isGreen == true ? appColor(context).appTheme.online.withOpacity(0.1) : appColor(context).appTheme.red.withOpacity(0.1))
    );
  }
}
