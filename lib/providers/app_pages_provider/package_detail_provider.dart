import 'package:fixit_provider/config.dart';
import 'package:fixit_provider/model/package_detail_model.dart';

class PackageDetailProvider with ChangeNotifier {

     PackageDetailModel? packageModel;

     onReady(){
       packageModel = PackageDetailModel.fromJson(appArray.packageDetailList);
       notifyListeners();
     }

     onPackageDelete(context,sync){
       final value = Provider.of<DeleteDialogProvider>(context, listen: false);

       value.onDeleteDialog(sync, context, eImageAssets.packageDelete, appFonts.deletePackages, appFonts.areYouSureDeletePackage,  (){
         route.pop(context);
         value.onResetPass(context, language(context, appFonts.hurrayPackageDelete), language(context, appFonts.okay), () {
           Navigator.pop(context);
           Navigator.pop(context);
         });
       });
       value.notifyListeners();


     }

}