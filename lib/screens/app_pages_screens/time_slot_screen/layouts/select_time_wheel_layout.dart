import '../../../../config.dart';

class SelectTimeWheelLayout extends StatelessWidget {
  final ValueChanged<int>? onSelectedItemChanged;
  final ScrollController? controller;
  final int? childCount;
  final Widget Function(BuildContext, int)? builder;
  const SelectTimeWheelLayout({super.key, this.onSelectedItemChanged, this.controller, this.childCount, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Image.asset(eImageAssets.timeBg,
          height: Sizes.s88,
          width: Sizes.s98,
          fit: BoxFit.contain)
          .paddingOnly(bottom: Insets.i16),
      SizedBox(
          height: Sizes.s320,
          width: Sizes.s70,
          child: ListWheelScrollView.useDelegate(
              onSelectedItemChanged: onSelectedItemChanged,
              controller: controller,
              itemExtent: 55,
              perspective: 0.001,
              diameterRatio: 1.1,
              physics: const FixedExtentScrollPhysics(),
              childDelegate: ListWheelChildBuilderDelegate(
                  childCount: childCount,
                  builder:builder!)))
    ]);
  }
}
