import 'package:salon_provider/config.dart';

class ServiceDetailsProviderOld with ChangeNotifier {
  int selectedIndex = 0;
  String? selectedImage;

  List locationList = [];

  onImageChange(index, value) {
    selectedIndex = index;
    selectedImage = value;

    notifyListeners();
  }

  /*onReady(context){
    final value = Provider.of<SignUpCompanyProvider>(context);

    value.notifyListeners();
   }*/

  onServiceDelete(context, sync) {
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.service,
        appFonts.deleteService, appFonts.areYouSureDeleteService, () {
      route.pop(context);
      value.onResetPass(
          context,
          language(context, appFonts.hurrayServiceDelete),
          language(context, appFonts.okay),
          () => Navigator.pop(context));

      notifyListeners();
    });
    value.notifyListeners();
  }
}
