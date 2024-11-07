import '../../../config.dart';


class PackagesListScreen extends StatefulWidget {
  const PackagesListScreen({super.key});

  @override
  State<PackagesListScreen> createState() => _PackagesListScreenState();
}

class _PackagesListScreenState extends State<PackagesListScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PackageListProvider,DeleteDialogProvider>(
      builder: (context,value,deleteVal,child) {
        return StatefulWrapper(
          onInit: () {},
          onDispose: ()=> deleteVal.onDispose(),
          child: Scaffold(
            appBar: ActionAppBar(title: appFonts.packages,actions: [
              CommonArrow(arrow: eSvgAssets.add,onTap: () =>
              route.pushNamed(context, routeName.appPackage)).paddingSymmetric(horizontal: Insets.i20)
            ]),
            body: SingleChildScrollView(
              child: Column(
                children: appArray.packageList.asMap().entries.map((e) => PackageLayout(
                  onEdit: ()=> route.pushNamed(context, routeName.appPackage,arg: {
                    'isEdit': true,
                    "data": e.value
                  }),
                    onDelete: () => value.onPackageDelete(context,this,e.key),
                    data: e.value, onToggle: (val) => value.onToggle(e.value, val))).toList()
              ).paddingSymmetric(horizontal: Insets.i20)
            )
          ),
        );
      }
    );
  }
}
