import 'package:url_launcher/url_launcher.dart';

import '../../config.dart';
import '../../model/chat_model.dart';


class ChatProvider with ChangeNotifier {

  List <ChatModel> chatList = [];
  final TextEditingController controller = TextEditingController();
  final FocusNode focus = FocusNode();
  final ScrollController scrollController = ScrollController();

  onReady() {
    chatList = appArray.chatList.map((e) => ChatModel.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> makePhoneCall(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }}

  onTapPhone(){
    makePhoneCall(Uri.parse('tel:+91 8200798552'));
    notifyListeners();
  }

  //send message
  setMessage() {

    if (controller.text.isNotEmpty) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
      ChatModel messageModel = ChatModel(
        type: "source",
        message: controller.text,
      );

      chatList.add(messageModel);
      controller.text = "";
      notifyListeners();
    }
  }

  onClearChat(context,sync){
    final value = Provider.of<DeleteDialogProvider>(context, listen: false);

    value.onDeleteDialog(sync, context, eImageAssets.clearChat, appFonts.clearChat, appFonts.areYouClearChat, (){
      route.pop(context);
      value.onResetPass(context, language(context, appFonts.hurrayChatDelete),language(context, appFonts.okay),()=>Navigator.pop(context));

    });
    value.notifyListeners();

  }

}