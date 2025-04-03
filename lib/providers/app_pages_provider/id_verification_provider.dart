import 'package:salon_provider/config.dart';

class IdVerificationProvider extends ChangeNotifier {
  XFile? imageFile;

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
}
