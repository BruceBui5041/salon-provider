import 'package:salon_provider/config.dart';

class LatestBLogDetailsProvider with ChangeNotifier {
  dynamic data;

  onReady(context) {
    data = ModalRoute.of(context)!.settings.arguments;
    notifyListeners();
  }
}
