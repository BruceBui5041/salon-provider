import 'package:salon_provider/config.dart';

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  const DecoratedTabBar(
      {super.key, required this.tabBar, required this.decoration});

  final TabBar tabBar;
  final BoxDecoration decoration;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(child: Container(decoration: decoration)),
      tabBar
    ]);
  }
}
