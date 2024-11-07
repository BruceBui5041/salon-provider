import '../../../config.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatHistoryProvider>(
      builder: (context,value,child) {
        return Scaffold(
            appBar: ActionAppBar(title: appFonts.chatHistory, actions: [
              MoreOptionLayout(onSelected: (index)=> value.onTapOption(index,context,this),
                list: appArray.chatHistoryOptionList,)
                  .paddingSymmetric(horizontal: Insets.i20)
            ]),
            body: SingleChildScrollView(
              child: Column(children: [
                Column(
                        children: appArray.chatHistoryList
                            .asMap()
                            .entries
                            .map((e) => ChatHistoryLayout(
                                onTap: ()=> route.pushNamed(context, routeName.chat),
                                data: e.value,
                                index: e.key,
                                list: appArray.chatHistoryList))
                            .toList())
                    .paddingAll(Insets.i15)
                    .boxShapeExtension(color: appColor(context).appTheme.fieldCardBg)
              ]).paddingSymmetric(horizontal: Insets.i20, vertical: Sizes.s15),
            ));
      }
    );
  }
}
