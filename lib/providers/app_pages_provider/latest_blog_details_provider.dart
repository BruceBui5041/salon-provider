import '../../config.dart';
import '../../model/blog_model.dart';

class LatestBLogDetailsProvider with ChangeNotifier {
      dynamic data;

      onReady(context){
         data = ModalRoute.of(context)!.settings.arguments;
        notifyListeners();
      }



}
