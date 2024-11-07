import 'package:fixit_provider/config.dart';

import '../../helper/alert_class.dart';

class ChatHistoryProvider with ChangeNotifier {

  onClearChat(context,sync){
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.clearChat, appFonts.clearChat, appFonts.areYouClearChat, (){
      route.pop(context);
      value.onResetPass(context, language(context, appFonts.hurrayChatDelete), language(context, appFonts.okay), ()=> route.pop(context));

    });
    value.notifyListeners();

  }

    onTapOption(index,context,sync){
      if(index == 1){
        onClearChat(context, sync);
        notifyListeners();
      } else {
        scaffoldMessage(context,"${language(context, appFonts.refresh)}...");
      }
    }



}