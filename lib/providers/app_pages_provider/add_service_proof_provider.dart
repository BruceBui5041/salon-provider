import 'package:fixit_provider/config.dart';

class AddServiceProofProvider with ChangeNotifier {

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode titleFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();

  List proofList = [];
  XFile? imageFile;

  onReady() {
    descriptionFocus.addListener(() {
      notifyListeners();
    });
    notifyListeners();
  }

  onSubmit(context) {
    if (descriptionCtrl.text.isNotEmpty && titleCtrl.text.isNotEmpty &&
        proofList.isNotEmpty) {
      route.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Add all fields and image",
              style: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.whiteColor)),
          backgroundColor: appColor(context).appTheme.red,
          behavior: SnackBarBehavior.floating));
    }
  }

  onImageRemove(index) {
    proofList.removeAt(index);
    notifyListeners();
  }

  Future getImage(context, source) async {
    final ImagePicker picker = ImagePicker();
    route.pop(context);
    imageFile = (await picker.pickImage(source: source))!;
    notifyListeners();
  }


  onImagePick(context) {
    showLayout(context, onTap: (index) {
      if (index == 0) {
        getImage(context, ImageSource.gallery).then((value) =>
            proofList.add(imageFile!.path));

        notifyListeners();
      } else {
        getImage(context, ImageSource.camera).then((value) =>
            proofList.add(imageFile!.path));

        notifyListeners();
      }
    });
  }

}