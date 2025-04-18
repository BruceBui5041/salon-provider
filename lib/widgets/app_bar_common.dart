import '../config.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final GestureTapCallback? onTap;
  final List<Widget>? actions;
  const AppBarCommon({super.key, this.title, this.onTap, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leadingWidth: 80,
        title: Text(language(context, title!),
            style: appCss.dmDenseBold18
                .textColor(appColor(context).appTheme.darkText)),
        centerTitle: true,
        leading: CommonArrow(
                arrow:
                    rtl(context) ? eSvgAssets.arrowRight : eSvgAssets.arrowLeft,
                onTap: onTap ?? () => route.pop(context))
            .padding(vertical: Insets.i8),
        actions: actions);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
