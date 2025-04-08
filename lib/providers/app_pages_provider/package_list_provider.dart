import 'package:salon_provider/config.dart';

class PackageListProvider with ChangeNotifier {
  onToggle(data, val) {
    data["status"] = val;
    notifyListeners();
  }

  onPackageDelete(context, sync, index) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.packageDelete,
        appFonts.deletePackages, appFonts.areYouSureDeletePackage, () {
      route.pop(context);

      value.onResetPass(
          context,
          language(context, appFonts.hurrayPackageDelete),
          language(context, appFonts.okay), () {
        appArray.packageList.removeAt(index);
        Navigator.pop(context);
        notifyListeners();
      });
    });
    value.notifyListeners();
  }
}
