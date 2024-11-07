import 'package:fixit_provider/config.dart';

class ServicemenDetailProvider with ChangeNotifier {

  XFile? imageFile;
  bool isIcons = true;

  onReady(context){
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
    if(data != null){
      isIcons = data ?? false;
    }
    notifyListeners();
  }

  // GET IMAGE FROM GALLERY
  Future getImage(context, source) async {
    final ImagePicker picker = ImagePicker();
      route.pop(context);
      imageFile = (await picker.pickImage(source: source))!;
    notifyListeners();
  }

  onImagePick(context) {
    showLayout(context, onTap: (index) {
        if (index == 0) {
          getImage(context, ImageSource.gallery);
        } else {
          getImage(context, ImageSource.camera);
        }
        notifyListeners();
    });
  }

  onServicemenDelete(context,sync){
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.servicemen, appFonts.deleteServicemen, appFonts.areYouSureDeleteServicemen, (){
      route.pop(context);
      value.onResetPass(context, language(context, appFonts.hurrayServicemenDelete),language(context, appFonts.okay),(){
        route.pop(context);
        route.pop(context);
      },title: appFonts.deleteSuccessfully);
      notifyListeners();
    });
    value.notifyListeners();

  }


}